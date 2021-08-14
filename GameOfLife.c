#include "GameOfLife.h"
#include "GameOfLifeUI.h"
#include <exec/execbase.h>
//backup

int main()
{
	GameMatrix.ColorAlive = 14;
	GameMatrix.ColorDead = 15;
	GameMatrix.Columns = 50;
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

int AllocatePlayfieldMem()
{
	//Allocate memory for the cell's data
	if ((GameMatrix.Playfield = AllocMem(GameMatrix.Columns * sizeof(GameOfLifeCell *), MEMF_ANY | MEMF_CLEAR)) == NULL)
		return RETURN_FAIL;
	if ((GameMatrix.Playfield_n1 = AllocMem(GameMatrix.Columns * sizeof(GameOfLifeCell *), MEMF_ANY | MEMF_CLEAR)) == NULL)
		return RETURN_FAIL;
	for (int i = 0; i < GameMatrix.Columns; i++)
	{
		if ((GameMatrix.Playfield[i] = AllocMem(GameMatrix.Rows * sizeof(GameOfLifeCell), MEMF_ANY | MEMF_CLEAR)) == NULL)
			return RETURN_FAIL;
		if ((GameMatrix.Playfield_n1[i] = AllocMem(GameMatrix.Rows * sizeof(GameOfLifeCell), MEMF_ANY | MEMF_CLEAR)) == NULL)
			return RETURN_FAIL;
	}
	return RETURN_OK;
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
																			 WA_Width, GameMatrix.CellSizeH * GameMatrix.Columns + GolScreen->WBorLeft + GolScreen->WBorRight + 16,
																			 WA_Height, GameMatrix.CellSizeV * GameMatrix.Rows + GolScreen->WBorTop + GolScreen->WBorBottom + 16,
																			 WA_MaxWidth, 640 - GolScreen->WBorLeft - GolScreen->WBorRight,
																			 WA_MaxHeight, 256 - GolScreen->WBorTop - GolScreen->WBorBottom,
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
							if (AllocatePlayfieldMem() != RETURN_OK)
								return RETURN_FAIL;
							my_VisualInfo = GetVisualInfo(GolMainWindow->WScreen, TAG_END);
							MainMenuStrip = CreateMenus(GolMainMenu, TAG_END);
							LayoutMenus(MainMenuStrip, my_VisualInfo, TAG_END);
							SetMenuStrip(GolMainWindow, MainMenuStrip);

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
			x = (coordX / GameMatrix.CellSizeH) +1;
			y = (coordY / GameMatrix.CellSizeV) +1;

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
				{
					ClearPlayfield(GameMatrix.Playfield);
					ClearPlayfield(GameMatrix.Playfield_n1);
					DrawCells(theWindow, TRUE);
				}
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

void RunSimulation()
{
	GameOfLifeCell **pf = GameMatrix.Playfield;
	GameOfLifeCell **pf_n1 = GameMatrix.Playfield_n1;

	for (int x = 1; x < GameMatrix.Columns - 1; x++)
	{
		for (int y = 1; y < GameMatrix.Rows - 1; y++)
		{
			USHORT neighbours = 0;
			for (int xi = -1; xi <= 1; xi++)
			{
				for (int yj = -1; yj <= 1; yj++)
				{
					if (pf[x + xi][y + yj].Status)
						neighbours++;
				}
			}
			if (pf[x][y].Status) neighbours--; // own status was added above - so -1 for ourselves

			if (pf[x][y].Status)
			{
				if (neighbours < 2 || neighbours > 3)
				{
					pf_n1[x][y].Status = 0;
					pf_n1[x][y].StatusChanged = TRUE;
				}
				else
				{
					pf_n1[x][y].Status = pf[x][y].Status;
					pf_n1[x][y].StatusChanged = FALSE;
				}
			}
			else if(neighbours == 3)
			{
				pf_n1[x][y].Status =1;
				pf_n1[x][y].StatusChanged = TRUE;
			}
			
		}
	}
	for (int col = 0; col < GameMatrix.Columns; col++)
	{
		memcpy(pf[col], pf_n1[col], GameMatrix.Rows * sizeof(GameOfLifeCell));
	}
}

void ClearPlayfield(GameOfLifeCell **pf)
{
	for (int x = 0; x < GameMatrix.Columns; x++)
	{
		memset(pf[x], 0, GameMatrix.Rows * sizeof(GameOfLifeCell));
	}
}

void DrawCells(struct Window *theWindow, BOOL forceFull)
{
	//SetFillPattern(theWindow->RPort);
	for (int y = 1; y < GameMatrix.Rows-1; y++)
	{
		for (int x = 1; x < GameMatrix.Columns-1; x++)
		{
			if (!GameMatrix.Playfield[x][y].StatusChanged && !forceFull)
				continue;

			GameMatrix.Playfield[x][y].StatusChanged = FALSE;

			if (GameMatrix.Playfield[x][y].Status)
				SetAPen(theWindow->RPort, GameMatrix.ColorAlive);
			else
				SetAPen(theWindow->RPort, GameMatrix.ColorDead);

			RectFill(theWindow->RPort,
					 (x-1) * GameMatrix.CellSizeH + 1,
					 (y-1) * GameMatrix.CellSizeV + 1,
					 (x-1) * GameMatrix.CellSizeH + GameMatrix.CellSizeH - 1,
					 (y-1) * GameMatrix.CellSizeV + GameMatrix.CellSizeV - 1);
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
	int x = coordX / GameMatrix.CellSizeH+1;
	int y = coordY / GameMatrix.CellSizeV+1;

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
