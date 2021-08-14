#include "support/gcc8_c_support.h"
#include <exec/types.h>
#include <proto/exec.h>
#include <proto/dos.h>
#include <proto/graphics.h>
#include <graphics/gfxbase.h>
#include <graphics/view.h>
#include <graphics/gfxmacros.h>
#include <intuition/intuition.h>
#include <proto/intuition.h>
#include <libraries/gadtools.h>


#if !defined(GOL)
#define GOL

struct Screen *GolScreen;
struct Window *GolMainWindow;
struct ExecBase *SysBase;
struct DosLibrary *DOSBase;
struct IntuitionBase *IntuitionBase;
struct GfxBase *GfxBase;
struct Library *GadToolsBase = NULL;
volatile struct Custom *custom;

BOOL AppRunning = TRUE;
BOOL GameRunning = FALSE;
#define ScreenW 640
#define ScreenH 256
#define ScreenD 4

struct _gameOfLifeCell
{
    UBYTE Status;
    BOOL StatusChanged;
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


//protos
void EventLoop(struct Window *theWindow, struct Menu *theMenu);
int AllocatePlayfieldMem(void);
int StartApp(void);
int MainLoop(void);
void CleanUp(void);
void RunSimulation(void);
void DrawCells(struct Window* theWindow, BOOL forceFull);
void ClearPlayfield(GameOfLifeCell** pf);
void ToggleCellStatus(WORD coordX, WORD coordY);
void SetFillPattern(struct RastPort *rport);

#endif // GOL
