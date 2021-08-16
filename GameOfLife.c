#include "GameOfLife.h"

int main()
{
	GameMatrix.ColorAlive = 4;
	GameMatrix.ColorDead = 0;
	GameMatrix.Columns = 100;
	GameMatrix.Rows = 40;
	GameMatrix.CellSizeH = 5;
	GameMatrix.CellSizeV = 5;

	if (StartApp(&GOLRenderData) == RETURN_OK)
	{
		MainLoop();
	}
	else
		return RETURN_FAIL;

	RETURN_OK;
}

int MainLoop()
{
	if (AllocPlayfieldMem() != RETURN_OK)
		return RETURN_FAIL;

	if (PrepareBackbuffer(&GOLRenderData) != RETURN_OK)
		return RETURN_FAIL;

	SetRast(GOLRenderData.MainWindow->RPort, 0);
	SetRast(&GOLRenderData.Rastport, 0);

	while (AppRunning)
	{
		EventLoop(GOLRenderData.MainWindow, MainMenuStrip);

		if (GameRunning)
		{
			UpdateCnt = 0;
			RunSimulation();
		}
		if (UpdateCnt > 0)
		{
			DrawCells(&GOLRenderData);
		}
		WaitTOF();
		RepaintWindow(&GOLRenderData);
	}

	CleanUp();

	return RETURN_OK;
}

int StartApp(RenderData *rd)
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
				if ((GOLRenderData.Screen = (struct Screen *)OpenScreenTags(NULL,
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
						if ((GOLRenderData.MainWindow = (struct Window *)OpenWindowTags(NULL,
																						WA_CustomScreen, (ULONG)GOLRenderData.Screen,
																						WA_Left, 0,
																						WA_Top, GOLRenderData.Screen->BarHeight + 1,
																						WA_Width, GameMatrix.CellSizeH * (GameMatrix.Columns - 1) + rd->Screen->WBorLeft + rd->Screen->WBorRight,
																						WA_Height, GameMatrix.CellSizeV * (GameMatrix.Rows - 1) + rd->Screen->WBorTop + rd->Screen->WBorBottom,
																						WA_MaxWidth, ScreenW - rd->Screen->WBorLeft - rd->Screen->WBorRight,
																						WA_MaxHeight, ScreenH - rd->Screen->WBorTop - rd->Screen->WBorBottom,
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
																						WA_IDCMP, IDCMP_CLOSEWINDOW | IDCMP_MOUSEBUTTONS | IDCMP_MOUSEMOVE | IDCMP_MENUPICK | IDCMP_REFRESHWINDOW | IDCMP_NEWSIZE,
																						WA_DetailPen, 4,
																						WA_BlockPen, 8,
																						TAG_END)))
						{
							ComputeOutputSize(&GOLRenderData);
							my_VisualInfo = GetVisualInfo(GOLRenderData.MainWindow->WScreen, TAG_END);
							MainMenuStrip = CreateMenus(GolMainMenu, TAG_END);
							LayoutMenus(MainMenuStrip, my_VisualInfo, TAG_END);
							SetMenuStrip(GOLRenderData.MainWindow, MainMenuStrip);

							return RETURN_OK;
						}
					}
				}
			}
		}
	}

	return RETURN_ERROR;
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
		case IDCMP_NEWSIZE:
			ComputeOutputSize(&GOLRenderData);
			break;
		case IDCMP_REFRESHWINDOW: /* User pressed the close window gadget. */
			SetWindowTitles(GOLRenderData.MainWindow, "Reconfiguring Memory...", -1);
			PrepareBackbuffer(&GOLRenderData);
			
			FreePlayfieldMem();
			GameMatrix.Columns = GOLRenderData.OutputSize.x / GameMatrix.CellSizeH;
			GameMatrix.Rows = GOLRenderData.OutputSize.y / GameMatrix.CellSizeV;
			AllocPlayfieldMem();
			
			SetRast(&GOLRenderData.Rastport, 0);
			DrawAllCells(&GOLRenderData);
			RepaintWindow(&GOLRenderData);
			GameRunning ? SetWindowTitles(GOLRenderData.MainWindow, "Running", -1) : SetWindowTitles(GOLRenderData.MainWindow, "Stopped", -1);
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
					SetRast(GOLRenderData.MainWindow->RPort, 0);
					SetRast(&GOLRenderData.Rastport, 0);
					//DrawAllCells(theWindow->RPort);
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
	FreePlayfieldMem();

	FreeBitMap(GOLRenderData.Backbuffer);

	if (GOLRenderData.MainWindow)
		CloseWindow(GOLRenderData.MainWindow);
	if (GadToolsBase)
		CloseLibrary((struct Library *)GadToolsBase);
	if (GOLRenderData.Screen)
		CloseScreen(GOLRenderData.Screen);
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

int AllocPlayfieldMem()
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
	return RETURN_OK;
}

int FreePlayfieldMem()
{
	for (int i = 0; i < GameMatrix.Columns; i++)
	{
		FreeMem(GameMatrix.Playfield[i], GameMatrix.Rows * sizeof(GameOfLifeCell));
		FreeMem(GameMatrix.Playfield_n1[i], GameMatrix.Rows * sizeof(GameOfLifeCell));
	}
	FreeMem(GameMatrix.Playfield, GameMatrix.Columns * sizeof(GameOfLifeCell*));
	FreeMem(GameMatrix.Playfield_n1, GameMatrix.Columns * sizeof(GameOfLifeCell*));
	FreeMem(UpdateList, GameMatrix.Columns * GameMatrix.Rows * sizeof(UpdateListEntry));

	return RETURN_OK;
}

void ClearPlayfield(GameOfLifeCell **pf)
{

	for (int x = 0; x < GameMatrix.Columns; x++)
	{
		memset(pf[x], 0, GameMatrix.Rows * sizeof(GameOfLifeCell));
	}
}

struct BitMap *MyAllocBitMap(ULONG width, ULONG height, ULONG depth, struct BitMap *likeBitMap)
{
	struct BitMap *bitmap;

	/* AllocBitMap() is available since OS3.0 */
	if (GfxBase->LibNode.lib_Version < 39)
	{
		if (depth <= 8)
		{
			/* lets allocate our BitMap */
			bitmap = (struct BitMap *)
				AllocMem(sizeof(struct BitMap), MEMF_ANY | MEMF_CLEAR);
			if (bitmap)
			{
				WORD i;
				InitBitMap(bitmap, depth, width, height);

				/* now allocate all our bitplanes */
				for (i = 0; i < bitmap->Depth; i++)
				{
					bitmap->Planes[i] = AllocRaster(width, height);
					if (!(bitmap->Planes[i]))
					{
						MyFreeBitMap(bitmap);
						bitmap = 0;
						break;
					}
				}
			}
		}
		else
		{
			bitmap = 0;
		}
	}
	else
	{
		bitmap = AllocBitMap(width, height, depth, 0, likeBitMap);
	}

	return bitmap;
}

void MyFreeBitMap(struct BitMap *bitmap)
{
	/* FreeBitMap() is available since OS3.0 */
	if (GfxBase->LibNode.lib_Version < 39)
	{
		ULONG width;
		WORD i;

		/* warning: this assumption is only safe for our own bitmaps */
		width = bitmap->BytesPerRow * 8;

		/* free all the bitplanes... */
		for (i = 0; i < bitmap->Depth; i++)
		{
			if (bitmap->Planes[i])
			{
				FreeRaster(bitmap->Planes[i], width, bitmap->Rows);
				bitmap->Planes[i] = 0;
			}
		}
		/* ... and finally free the bitmap itself */
		FreeMem(bitmap, sizeof(struct BitMap));
	}
	else
	{
		FreeBitMap(bitmap);
	}
}

void ComputeOutputSize(RenderData *rd)
{
	/* our output size is simply the window's size minus its borders */
	rd->OutputSize.x =
		rd->MainWindow->Width - rd->MainWindow->BorderLeft - rd->MainWindow->BorderRight;
	rd->OutputSize.y =
		rd->MainWindow->Height - rd->MainWindow->BorderTop - rd->MainWindow->BorderBottom;
}

int PrepareBackbuffer(RenderData *rd)
{
	int result;

	if (rd->OutputSize.x != rd->BackbufferSize.x || rd->OutputSize.y != rd->BackbufferSize.y)
	{
		/* if output size changed free our current bitmap... */
		if (rd->Backbuffer)
		{
			MyFreeBitMap(rd->Backbuffer);
			rd->Backbuffer = 0;
		}

		/* ... allocate a new one... */
		rd->Backbuffer = MyAllocBitMap(rd->OutputSize.x, rd->OutputSize.y, ScreenD, rd->MainWindow->RPort->BitMap);
		if (rd->Backbuffer)
		{
			/* and on success remember its size */
			rd->BackbufferSize = rd->OutputSize;
		}

		/* link the bitmap into our render port */
		InitRastPort(&rd->Rastport);
		rd->Rastport.BitMap = rd->Backbuffer;
	}

	result = rd->Backbuffer ? RETURN_OK : RETURN_ERROR;

	return result;
}

void DrawCells(RenderData *rd)
{
	for (int entry = 0; entry < UpdateCnt; entry++)
	{
		int x = UpdateList[entry].X;
		int y = UpdateList[entry].Y;
		int s = UpdateList[entry].Status;

		if (s)
			SetAPen(&rd->Rastport, GameMatrix.ColorAlive);
		else
			SetAPen(&rd->Rastport, GameMatrix.ColorDead);

		RectFill(&rd->Rastport,
				 (x - 1) * GameMatrix.CellSizeH + 1,
				 (y - 1) * GameMatrix.CellSizeV + 1,
				 (x - 1) * GameMatrix.CellSizeH + GameMatrix.CellSizeH - 1,
				 (y - 1) * GameMatrix.CellSizeV + GameMatrix.CellSizeV - 1);
	}
}

void DrawAllCells(RenderData *rd)
{
	for (int y = 1; y < GameMatrix.Rows - 1; y++)
	{
		for (int x = 1; x < GameMatrix.Columns - 1; x++)
		{
			if (GameMatrix.Playfield[x][y].Status)
				SetAPen(&rd->Rastport, GameMatrix.ColorAlive);
			else
				SetAPen(&rd->Rastport, GameMatrix.ColorDead);

			RectFill(&rd->Rastport,
					 (x - 1) * GameMatrix.CellSizeH + 1,
					 (y - 1) * GameMatrix.CellSizeV + 1,
					 (x - 1) * GameMatrix.CellSizeH + GameMatrix.CellSizeH - 1,
					 (y - 1) * GameMatrix.CellSizeV + GameMatrix.CellSizeV - 1);
		}
	}
}

void RepaintWindow(RenderData *rd)
{
	/* on repaint we simply blit our backbuffer into our window's RastPort */
	BltBitMapRastPort(rd->Backbuffer,
					  0,
					  0,
					  rd->MainWindow->RPort,
					  0,
					  0,
					  (LONG)rd->OutputSize.x,
					  (LONG)rd->OutputSize.y,
					  (ABNC | ABC));
}

void ToggleCellStatus(WORD coordX, WORD coordY)
{
	int x = coordX / GameMatrix.CellSizeH + 1;
	int y = coordY / GameMatrix.CellSizeV + 1;

	if (!(x < 0 || x > GameMatrix.Columns - 2 || y < 0 || y > GameMatrix.Rows - 2))
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
	fh = Open(file, MODE_NEWFILE);
	int args[3];
	for (int x = startX; x < (startX + width); x++)
	{
		for (int y = startY; y < (startY + height); y++)
		{
			args[0] = x;
			args[1] = y;
			args[2] = GameMatrix.Playfield[x][y].Status;
			VFPrintf(fh, (CONST_STRPTR) "%d,%d,%d\n", args);
		}
	}
	Close(fh);

	return RETURN_OK;
}

