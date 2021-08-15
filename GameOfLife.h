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
#include <proto/intuition.h>
#include <intuition/intuition.h>
#include <intuition/intuitionbase.h>


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
int AllocatePlayfieldMem(void);
int StartApp(void);
int MainLoop(void);
void CleanUp(void);
void RunSimulation(void);
void DrawCells(struct RastPort *rPort, BOOL forceFull);
void DrawAllCells(struct RastPort *rPort);
void ClearPlayfield(GameOfLifeCell** pf);
void ToggleCellStatus(WORD coordX, WORD coordY);
int SavePlayfield(CONST_STRPTR file, int startX, int startY, int width, int height);
void SetFillPattern(struct RastPort *rport);

#endif /*GOL*/
