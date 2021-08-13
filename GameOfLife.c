#include "GameOfLife.h"
#include "GameOfLifeUI.h"
#include <exec/execbase.h>
//backup

int main()
{
	GameMatrix.ColorAlive = 9;
	GameMatrix.ColorDead = 12;
	GameMatrix.Columns = 40;
	GameMatrix.Rows = 20;
	GameMatrix.CellSizeH = 11;
	GameMatrix.CellSizeV = 11;

	if (StartApp() == RETURN_OK)
	{
		MainLoop();
	}
	else
		return RETURN_FAIL;

	RETURN_OK;
}

int StartApp()
{
	SysBase = *((struct ExecBase **)4UL);
	custom = (struct Custom *)0xdff000;
	unsigned int pens[] = {~0};

	APTR *my_VisualInfo;

	if ((DOSBase = (struct DosLibrary *)OpenLibrary((CONST_STRPTR) "dos.library", 0)))
	{
		if ((GfxBase = (struct GfxBase *)OpenLibrary((CONST_STRPTR) "graphics.library", 0)))
		{
			if ((IntuitionBase = (struct IntuitionBase *)OpenLibrary((CONST_STRPTR) "intuition.library", 0)))
			{
				if ((GolScreen = (struct Screen *)OpenScreenTags(NULL,
																 SA_Pens, (ULONG)pens,
																 SA_DisplayID, HIRES_KEY,
																 SA_Depth, 4,
																 SA_Title, (ULONG) "Game Of Life - 2021 HvB",
																 SA_Type, CUSTOMSCREEN,
																 SA_DetailPen, 4,
																 SA_BlockPen, 8,
																 TAG_END)))
				{

					if ((GadToolsBase = (struct Library *)OpenLibrary((CONST_STRPTR) "gadtools.library", 0)))
					{
						if ((GolMainWindow = (struct Window *)OpenWindowTags(NULL,
																			 WA_CustomScreen, (ULONG)GolScreen,
																			 WA_Left, 0,
																			 WA_Top, GolScreen->BarHeight + 1,
																			 WA_Width, GameMatrix.CellSizeH * GameMatrix.Columns + GolScreen->WBorLeft + GolScreen->WBorRight,
																			 WA_Height, GameMatrix.CellSizeV * GameMatrix.Rows + GolScreen->WBorTop + GolScreen->WBorBottom,
																			 WA_MaxWidth, GameMatrix.CellSizeH * GameMatrix.Columns + GolScreen->WBorLeft + GolScreen->WBorRight,
																			 WA_MaxHeight, GameMatrix.CellSizeV * GameMatrix.Rows + GolScreen->WBorTop + GolScreen->WBorBottom,
																			 WA_Title, (ULONG) "Stopped",
																			 WA_DepthGadget, TRUE,
																			 WA_CloseGadget, TRUE,
																			 WA_SizeGadget, TRUE,
																			 WA_DragBar, TRUE,
																			 WA_GimmeZeroZero, TRUE,
																			 WA_ReportMouse, TRUE,
																			 WA_NewLookMenus, TRUE,
																			 WA_Activate, TRUE,
																			 WA_ScreenTitle, (ULONG) "Watch them suffer, dude!",
																			 WA_IDCMP, IDCMP_CLOSEWINDOW | IDCMP_MOUSEBUTTONS | IDCMP_MOUSEMOVE | IDCMP_MENUPICK | IDCMP_REFRESHWINDOW,
																			 WA_DetailPen, 0,
																			 WA_BlockPen, 0,
																			 TAG_END)))

						{
							my_VisualInfo = GetVisualInfo(GolMainWindow->WScreen, TAG_END);
							MainMenuStrip = CreateMenus(GolMainMenu, TAG_END);
							LayoutMenus(MainMenuStrip, my_VisualInfo, TAG_END);
							SetMenuStrip(GolMainWindow, MainMenuStrip);
							//Allocate memory for the cell's data
							GameMatrix.Playfield = AllocMem(GameMatrix.Columns * sizeof(GameOfLifeCell *), MEMF_ANY | MEMF_CLEAR);
							for (int i = 0; i < GameMatrix.Columns; i++)
							{
								GameMatrix.Playfield[i] = AllocMem(GameMatrix.Rows * sizeof(GameOfLifeCell), MEMF_ANY | MEMF_CLEAR);
							}

							return RETURN_OK;
						}
					}
				}
			}
		}
	}

	return RETURN_ERROR;
}

int MainLoop()
{
	DrawCells(GolMainWindow, TRUE);

	while (AppRunning)
	{
		EventLoop(GolMainWindow, MainMenuStrip);

		if (GameRunning)
			RunSimulation();

		DrawCells(GolMainWindow, FALSE);
	}
	CleanUp();
	return RETURN_OK;
}

void EventLoop(struct Window *theWindow, struct Menu *theMenu)
{
	struct IntuiMessage *message;
	UWORD msg_code;
	ULONG msg_class;
	USHORT menuNumber;
	USHORT menuNum;
	USHORT itemNum;
	USHORT subNum;
	struct MenuItem *item;
	WORD coordX, coordY;
	int x, y;

	/* There may be more than one message, so keep processing messages until there are no more. */
	while ((message = (struct IntuiMessage *)GetMsg(theWindow->UserPort)))
	{
		/* Copy the necessary information from the message. */
		msg_class = message->Class;
		msg_code = message->Code;
		coordX = message->MouseX - theWindow->BorderLeft;
		coordY = message->MouseY - theWindow->BorderTop;

		/* Reply as soon as possible. */
		ReplyMsg((struct Message *)message);

		/* Take the proper action in response to the message. */
		switch (msg_class)
		{
		case IDCMP_CLOSEWINDOW: /* User pressed the close window gadget. */
			AppRunning = FALSE;
			break;
		case IDCMP_REFRESHWINDOW: /* User pressed the close window gadget. */
			DrawCells(theWindow, TRUE);
			break;
		case IDCMP_MOUSEBUTTONS: /* The status of the mouse buttons has changed. */
			switch (msg_code)
			{
			case SELECTDOWN: /* The left mouse button has been pressed. */
				ToggleCellStatus(coordX, coordY);
				break;
			case SELECTUP: /* The left mouse button has been released. */
				break;
			}
		case IDCMP_MOUSEMOVE: /* The position of the mouse has changed. */
			x = coordX / GameMatrix.CellSizeH;
			y = coordY / GameMatrix.CellSizeV;

			if (!(x < 0 || x > GameMatrix.Columns - 1 || y < 0 || y > GameMatrix.Rows))
			{
				//SetWindowTitles(theWindow, -1, -1);
			}
			break;

		case IDCMP_MENUPICK:
			menuNumber = message->Code;
			while ((menuNumber != MENUNULL) && (AppRunning))
			{
				item = ItemAddress(theMenu, menuNumber);

				/* process the item here! */
				menuNum = MENUNUM(menuNumber);
				itemNum = ITEMNUM(menuNumber);
				subNum = SUBNUM(menuNumber);

				/* stop if quit is selected. */
				if ((menuNum == 0) && (itemNum == 5))
				{
					AppRunning = FALSE;
					SetWindowTitles(theWindow, (STRPTR) "Running", (STRPTR)-1);
				}

				if ((menuNum == 0) && (itemNum == 3) && (subNum == 2))
					ClearPlayfield();

				if ((menuNum == 0) && (itemNum == 3) && (subNum == 0))
				{
					SetWindowTitles(theWindow, (STRPTR) "Running", (STRPTR)-1);
					GameRunning = TRUE;
				}

				if ((menuNum == 0) && (itemNum == 3) && (subNum == 1))
				{
					SetWindowTitles(theWindow, (STRPTR) "Stopped", (STRPTR)-1);
					GameRunning = FALSE;
				}

				if ((menuNum == 0) && (itemNum == 3) && (subNum == 2))
					ClearPlayfield();

				menuNumber = item->NextSelect;
			}
			break;
		default:
			break;
		}
	}
}

void CleanUp()
{
	FreeMem((APTR)GameMatrix.Playfield, GameMatrix.Rows * GameMatrix.Columns * sizeof(GameOfLifeCell));

	if (GolMainWindow)
		CloseWindow(GolMainWindow);
	if (GadToolsBase)
		CloseLibrary((struct Library *)GadToolsBase);
	if (GolScreen)
		CloseScreen(GolScreen);
	if (GfxBase)
		CloseLibrary((struct Library *)GfxBase);
	if (IntuitionBase)
		CloseLibrary((struct Library *)IntuitionBase);
	if (DOSBase)
		CloseLibrary((struct Library *)DOSBase);
}

void DrawCells(struct Window *theWindow, BOOL forceFull)
{
	//SetFillPattern(theWindow->RPort);
	for (int y = 0; y < GameMatrix.Rows; y++)
	{
		for (int x = 0; x < GameMatrix.Columns; x++)
		{
			if (!GameMatrix.Playfield[x][y].StatusChanged && !forceFull)
				continue;

			GameMatrix.Playfield[x][y].StatusChanged = FALSE;

			if (GameMatrix.Playfield[x][y].Status)
				SetAPen(theWindow->RPort, GameMatrix.ColorAlive);
			else
				SetAPen(theWindow->RPort, GameMatrix.ColorDead);

			RectFill(theWindow->RPort,
					 x * GameMatrix.CellSizeH + 1,
					 y * GameMatrix.CellSizeV + 1,
					 x * GameMatrix.CellSizeH + GameMatrix.CellSizeH - 1,
					 y * GameMatrix.CellSizeV + GameMatrix.CellSizeV - 1);
		}
	}
}

void SetFillPattern(struct RastPort *rport)
{
	int areaPattern[4][8] =
		{
			/* plane 0 pattern */
			{
				0x0000, 0x0000,
				0xffff, 0xffff,
				0x0000, 0x0000,
				0xffff, 0xffff},
			/* plane 1 pattern */
			{
				0x0000, 0x0000,
				0x0000, 0x0000,
				0xffff, 0xffff,
				0xffff, 0xffff},
			/* plane 2 pattern */
			{
				0xff00, 0xff00,
				0xff00, 0xff00,
				0xff00, 0xff00,
				0xff00, 0xff00},
			/* plane 3 pattern */
			{
				0xff00, 0xff00,
				0xff00, 0xff00,
				0xff00, 0xff00,
				0xff00, 0xff00}};

	SetAfPt(rport, (UWORD *)areaPattern, -4);

	/* when doing this, it is best to set three other parameters as follows: */
	SetAPen(rport, -1);
	SetBPen(rport, 0);
	SetDrMd(rport, JAM2);
}

void ToggleCellStatus(WORD coordX, WORD coordY)
{
	int x = coordX / GameMatrix.CellSizeH;
	int y = coordY / GameMatrix.CellSizeV;

	if (!(x < 0 || x > GameMatrix.Columns - 1 || y < 0 || y > GameMatrix.Rows))
	{

		if (GameMatrix.Playfield[x][y].Status)
		{
			GameMatrix.Playfield[x][y].Status = 0;
			GameMatrix.Playfield[x][y].StatusChanged = TRUE;
		}
		else
		{
			GameMatrix.Playfield[x][y].Status = 1;
			GameMatrix.Playfield[x][y].StatusChanged = TRUE;
		}
	}
}

void ClearPlayfield()
{
	for (int x = 0; x < GameMatrix.Columns; x++)
	{
		for (int y = 0; y < GameMatrix.Rows; y++)
		{
			GameMatrix.Playfield[x][y].Neighbours = 0;
			GameMatrix.Playfield[x][y].Status = 0;
			GameMatrix.Playfield[x][y].StatusChanged = TRUE;
		}
	}
}

void RunSimulation()
{
	GameOfLifeCell **pf = GameMatrix.Playfield;

	for (int y = 0; y < GameMatrix.Rows; y++)
	{
		for (int x = 0; x < GameMatrix.Columns; x++)
		{
			USHORT neighbours = 0;
			if (y == 0) // 1st row
			{
				if (x == 0) // 1st column
				{
					if (pf[x + 1][y].Status)
						neighbours++;
					if (pf[x + 1][y + 1].Status)
						neighbours++;
					if (pf[x][y + 1].Status)
						neighbours++;
				}
				else if (x > 0 && x < GameMatrix.Columns - 1) // columns in between 1st and last
				{
					if (pf[x + 1][y].Status)
						neighbours++;
					if (pf[x + 1][y + 1].Status)
						neighbours++;
					if (pf[x][y + 1].Status)
						neighbours++;
					if (pf[x - 1][y].Status)
						neighbours++;
					if (pf[x - 1][y + 1].Status)
						neighbours++;
				}
				else if (x == GameMatrix.Columns - 1) // last column
				{
					if (pf[x - 1][y].Status)
						neighbours++;
					if (pf[x - 1][y + 1].Status)
						neighbours++;
					if (pf[x][y + 1].Status)
						neighbours++;
				}
			}
			else if (y > 0 && y < GameMatrix.Rows - 1) // rows between 1st and last
			{
				if (x == 0)
				{
					if (pf[x][y - 1].Status)
						neighbours++;
					if (pf[x][y + 1].Status)
						neighbours++;
					if (pf[x + 1][y].Status)
						neighbours++;
					if (pf[x + 1][y + 1].Status)
						neighbours++;
					if (pf[x + 1][y - 1].Status)
						neighbours++;
				}
				else if (x > 0 && x < GameMatrix.Columns - 1)
				{
					if (pf[x][y + 1].Status)
						neighbours++;
					if (pf[x][y - 1].Status)
						neighbours++;
					if (pf[x + 1][y].Status)
						neighbours++;
					if (pf[x + 1][y - 1].Status)
						neighbours++;
					if (pf[x + 1][y + 1].Status)
						neighbours++;
					if (pf[x - 1][y].Status)
						neighbours++;
					if (pf[x - 1][y + 1].Status)
						neighbours++;
					if (pf[x - 1][y - 1].Status)
						neighbours++;
				}
				else if (x == GameMatrix.Columns - 1)
				{
					if (pf[x - 1][y - 1].Status)
						neighbours++;
					if (pf[x - 1][y].Status)
						neighbours++;
					if (pf[x - 1][y + 1].Status)
						neighbours++;
					if (pf[x][y - 1].Status)
						neighbours++;
					if (pf[x][y + 1].Status)
						neighbours++;
				}
			}
			else if (y == GameMatrix.Rows - 1) // last row
			{
				if (x == 0)
				{
					if (pf[x][y - 1].Status)
						neighbours++;
					if (pf[x + 1][y - 1].Status)
						neighbours++;
					if (pf[x + 1][y].Status)
						neighbours++;
				}
				else if (x > 0 && x < GameMatrix.Columns - 1)
				{
					if (pf[x - 1][y].Status)
						neighbours++;
					if (pf[x - 1][y - 1].Status)
						neighbours++;
					if (pf[x][y - 1].Status)
						neighbours++;
					if (pf[x + 1][y - 1].Status)
						neighbours++;
					if (pf[x + 1][y].Status)
						neighbours++;
				}
				else if (x == GameMatrix.Columns - 1)
				{
					if (pf[x - 1][y - 1].Status)
						neighbours++;
					if (pf[x - 1][y].Status)
						neighbours++;
					if (pf[x][y - 1].Status)
						neighbours++;
				}
			}

			if ((pf[x][y].Status==0 && neighbours == 3))
			{
				pf[x][y].Status = 1;
				pf[x][y].StatusChanged = TRUE;
				continue;
			}
			if ((pf[x][y].Status==1 && (neighbours < 2 || neighbours > 3)))
			{
				pf[x][y].Status = 0;
				pf[x][y].StatusChanged = TRUE;
			}
		}
	}
}
