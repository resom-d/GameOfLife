#include "support/gcc8_c_support.h"
#include "GameOfLifeUI.h"
#include <exec/types.h>
#include <exec/execbase.h>
#include <proto/exec.h>
#include <proto/dos.h>
#include <proto/graphics.h>
#include <graphics/gfxbase.h>
#include <graphics/view.h>
#include <graphics/gfxmacros.h>


#if !defined(GOL)
#define GOL

struct ExecBase *SysBase;
struct DosLibrary *DOSBase;
struct IntuitionBase *IntuitionBase;
struct GfxBase *GfxBase;
struct Library *GadToolsBase = NULL;
volatile struct Custom *custom;

struct _updateListEntry
{
    USHORT X;
    USHORT Y;
    USHORT Status;
};
typedef struct _updateListEntry UpdateListEntry;

BOOL AppRunning = TRUE;
BOOL GameRunning = FALSE;
int OldSelectX =0;
int OldSelectY =0;
BOOL DrawActive = FALSE;
UpdateListEntry *UpdateList;
USHORT UpdateCnt=0;

struct _gameOfLifeCell
{
    UBYTE Status;    
};
typedef struct _gameOfLifeCell GameOfLifeCell;

struct _golMatrix
{
    GameOfLifeCell **Playfield;
    GameOfLifeCell **Playfield_n1;
    USHORT Rows;
    USHORT Columns;
    USHORT ColorAlive;
    USHORT ColorDead;
    USHORT CellSizeH;
    USHORT CellSizeV;
};
typedef struct _golMatrix GolMatrix;
GolMatrix GameMatrix;


/*protos*/
void EventLoop(struct Window *theWindow, struct Menu *theMenu);
void PPG_EventLoop(struct Window *theWindow, struct Menu *theMenu);
int AllocPlayfieldMem(void);
int FreePlayfieldMem(void);
int StartApp(RenderData *rd);
int MainLoop(void);
void CleanUp(void);
void RunSimulation(void);
void DrawCells(RenderData *rd);
void RepaintWindow(RenderData* rd);
void DrawAllCells(RenderData *rd);
void ClearPlayfield(GameOfLifeCell** pf);
void ToggleCellStatus(WORD coordX, WORD coordY);
int SavePlayfield(CONST_STRPTR file, int startX, int startY, int width, int height);
void SetFillPattern(struct RastPort *rport);
struct BitMap* MyAllocBitMap(ULONG width, ULONG height, ULONG depth, struct BitMap* likeBitMap);
void MyFreeBitMap(struct BitMap* bitmap);
void ComputeOutputSize(RenderData* rd);
int PrepareBackbuffer(RenderData* rd);
void RunPPG_Window(RenderData *rd);

#endif /*GOL*/
