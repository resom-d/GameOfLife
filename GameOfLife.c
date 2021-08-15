#include "GameOfLife.h"

int main()
{
	GameMatrix.ColorAlive = 4;
	GameMatrix.ColorDead = 15;
	GameMatrix.Columns = 100;
	GameMatrix.Rows = 40;
	GameMatrix.CellSizeH = 5;
	GameMatrix.CellSizeV = 5;

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
	/*Allocate memory for the cell's data*/
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
	UpdateList = AllocMem(GameMatrix.Columns * GameMatrix.Rows * sizeof(UpdateListEntry), MEMF_ANY | MEMF_CLEAR);
	AlterWinBitmap = AllocBitMap(640,256,BMF_CLEAR|BMF_DISPLAYABLE|BMF_INTERLEAVED,0,NULL);
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
																 SA_FullPalette, TRUE,
																 SA_Title, (ULONG) "Game Of Life - 2021 HvB",
																 SA_Type, CUSTOMSCREEN,
																 SA_DetailPen, 1,
																 SA_BlockPen, 0,
																 TAG_END)))
				{

					if ((GadToolsBase = (struct Library *)OpenLibrary((CONST_STRPTR) "gadtools.library", 0)))
					{
						if ((GolMainWindow = (struct Window *)OpenWindowTags(NULL,
																			 WA_CustomScreen, (ULONG)GolScreen,
																			 WA_Left, 0,
																			 WA_Top, GolScreen->BarHeight + 1,
																			 WA_Width, GameMatrix.CellSizeH * (GameMatrix.Columns - 1) + GolScreen->WBorLeft + GolScreen->WBorRight + 16,
																			 WA_Height, GameMatrix.CellSizeV * (GameMatrix.Rows - 1) + GolScreen->WBorTop + GolScreen->WBorBottom + 16,
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
																			 WA_DetailPen, 4,
																			 WA_BlockPen, 8,
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
	/* InitRastPort(GOlRastport);
	   InitTmpRas(RportTmpRas, (PLANEPTR)RportTmpRasBuffer, ScreenW*ScreenH);
	   GOlRastport->TmpRas = RportTmpRas;
	   InitArea(RPortAreaInfo, RPortFillAreaBuffer,(RPortFillAreaSize*2/5));
	   GOlRastport->AreaInfo = RPortAreaInfo;
	   GOlRastport->BitMap = AlterWinBitmap; 
	   OrgWinBitmap = GolMainWindow->RPort->BitMap; */
	
	DrawAllCells(GolMainWindow->RPort);
	
	while (AppRunning)
	{
		EventLoop(GolMainWindow, MainMenuStrip);

		if (GameRunning)
		{
			UpdateCnt = 0;
			RunSimulation();
		}

		DrawCells(GolMainWindow->RPort, FALSE);
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

	if (!GameRunning)
		UpdateCnt = 0;
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
			DrawAllCells(theWindow->RPort);
			break;
		case IDCMP_MOUSEBUTTONS: /* The status of the mouse buttons has changed. */
			switch (msg_code)
			{
			case SELECTDOWN: /* The left mouse button has been pressed. */
				if (!GameRunning)
				{
					x = (coordX / GameMatrix.CellSizeH) + 1;
					y = (coordY / GameMatrix.CellSizeV) + 1;
					DrawActive = TRUE;
					ToggleCellStatus(coordX, coordY);
					UpdateList[UpdateCnt].X = x;
					UpdateList[UpdateCnt].Y = y;
					UpdateList[UpdateCnt++].Status = GameMatrix.Playfield[x][y].Status;
				}
				break;
			case SELECTUP: /* The left mouse button has been released. */
				DrawActive = FALSE;
				break;
			}
		case IDCMP_MOUSEMOVE: /* The position of the mouse has changed. */
			x = (coordX / GameMatrix.CellSizeH) + 1;
			y = (coordY / GameMatrix.CellSizeV) + 1;
			if (DrawActive && (x != OldSelectX || y != OldSelectY))
			{
				ToggleCellStatus(coordX, coordY);
			}
			OldSelectX = x;
			OldSelectY = y;
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

				if ((menuNum == 0) && (itemNum == 1))
				{
					SavePlayfield((CONST_STRPTR) "test.gold", 1, 1, GameMatrix.Columns - 1, GameMatrix.Rows - 1);
				}

				if ((menuNum == 0) && (itemNum == 3) && (subNum == 2))
				{
					ClearPlayfield(GameMatrix.Playfield);
					ClearPlayfield(GameMatrix.Playfield_n1);
					DrawAllCells(theWindow->RPort);
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
			if (pf[x][y].Status)
				neighbours--; // own status was added above - so -1 for ourselves

			if (pf[x][y].Status)
			{
				if (neighbours < 2 || neighbours > 3)
				{
					pf_n1[x][y].Status = 0;
					UpdateList[UpdateCnt].X = x;
					UpdateList[UpdateCnt].Y = y;
					UpdateList[UpdateCnt].Status = pf_n1[x][y].Status;
					UpdateCnt++;
				}
				else
				{
					pf_n1[x][y].Status = pf[x][y].Status;
				}
			}
			else if (neighbours == 3)
			{
				pf_n1[x][y].Status = 1;
				UpdateList[UpdateCnt].X = x;
				UpdateList[UpdateCnt].Y = y;
				UpdateList[UpdateCnt].Status = pf_n1[x][y].Status;
				UpdateCnt++;
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

void DrawCells(struct RastPort *rPort, BOOL forceFull)
{
	for (int entry = 0; entry < UpdateCnt; entry++)
	{
		int x = UpdateList[entry].X;
		int y = UpdateList[entry].Y;
		int s = UpdateList[entry].Status;

		if (s)
			SetAPen(rPort, GameMatrix.ColorAlive);
		else
			SetAPen(rPort, GameMatrix.ColorDead);

		RectFill(rPort,
				 (x - 1) * GameMatrix.CellSizeH + 1,
				 (y - 1) * GameMatrix.CellSizeV + 1,
				 (x - 1) * GameMatrix.CellSizeH + GameMatrix.CellSizeH - 1,
				 (y - 1) * GameMatrix.CellSizeV + GameMatrix.CellSizeV - 1);
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
	int x = coordX / GameMatrix.CellSizeH + 1;
	int y = coordY / GameMatrix.CellSizeV + 1;

	if (!(x < 0 || x > GameMatrix.Columns - 2 || y < 0 || y > GameMatrix.Rows-2))
	{

		if (GameMatrix.Playfield[x][y].Status)
		{
			GameMatrix.Playfield[x][y].Status = 0;
			UpdateList[UpdateCnt].X = x;
			UpdateList[UpdateCnt].Y = y;
			UpdateList[UpdateCnt].Status = 0;
			UpdateCnt++;
		}
		else
		{
			GameMatrix.Playfield[x][y].Status = 1;
			UpdateList[UpdateCnt].X = x;
			UpdateList[UpdateCnt].Y = y;
			UpdateList[UpdateCnt].Status = 1;
			UpdateCnt++;
		}
	}
}

int SavePlayfield(CONST_STRPTR file, int startX, int startY, int width, int height)
{
	BPTR fh;
	fh=Open(file,MODE_NEWFILE);
	int args[3];
	for (int x = startX; x < (startX + width); x++)
	{
		for (int y = startY; y < (startY + height); y++)
		{
			args[0]=x;
			args[1]=y;
			args[2]=GameMatrix.Playfield[x][y].Status;
			VFPrintf(fh, (CONST_STRPTR) "%d,%d,%d\n", args);
						
		}
	}
	Close(fh);
	
	return RETURN_OK;
}

void DrawAllCells(struct RastPort *rPort)
{
	//SetFillPattern(theWindow->RPort);
	for (int y = 1; y < GameMatrix.Rows - 1; y++)
	{
		for (int x = 1; x < GameMatrix.Columns - 1; x++)
		{
			if (GameMatrix.Playfield[x][y].Status)
				SetAPen(rPort, GameMatrix.ColorAlive);
			else
				SetAPen(rPort, GameMatrix.ColorDead);

			RectFill(rPort,
					 (x - 1) * GameMatrix.CellSizeH + 1,
					 (y -1) * GameMatrix.CellSizeV +1,
					 (x - 1) * GameMatrix.CellSizeH + GameMatrix.CellSizeH - 1,
					 (y-1) * GameMatrix.CellSizeV + GameMatrix.CellSizeV - 1);
		}
	}
}
