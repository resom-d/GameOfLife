#include "support/gcc8_c_support.h"
#include <proto/exec.h>
#include <exec/types.h>
#include <exec/execbase.h>
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

#define ScreenW 640
#define ScreenH 256
#define ScreenD 4

struct IntuitionIFace *IIntuition;
struct ExecBase *SysBase;
volatile struct Custom *custom;
struct DosLibrary *DOSBase;
struct GfxBase *GfxBase;
struct IntuitionBase *IntuitionBase;
struct Screen *GolScreen;
struct Window *GolMainWindow;
struct Library *GadToolsBase = NULL;
BOOL AppRunning = TRUE;
BOOL GameRunning = FALSE;

struct gameOfLifeCell
{
    USHORT Status;
    BOOL StatusChanged;
    USHORT Neighbours;
};
typedef struct gameOfLifeCell GameOfLifeCell;

struct _golMatrix
{
    GameOfLifeCell **Playfield;
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
int StartApp(void);
int MainLoop(void);
void CleanUp(void);
void DrawCells(struct Window* theWindow, BOOL forceFull);
void ToggleCellStatus(WORD coordX, WORD coordY);
void ClearPlayfield(void);
void RunSimulation(void);
void SetFillPattern(struct RastPort *rport);
#endif // GOL
