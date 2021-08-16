#include <libraries/gadtools.h>
#include <proto/gadtools.h>

#ifndef GOLUI
#define GOLUI 1

#define ScreenW 640
#define ScreenH 256
#define ScreenD 4

struct _renderData
{
	struct Screen *Screen;
	struct Window *MainWindow;
	struct tPoint OutputSize;
	struct tPoint BackbufferSize;
	struct RastPort Rastport;
	struct BitMap *Backbuffer;
};
typedef struct _renderData RenderData;
RenderData GOLRenderData;

/* Menus and gadgets */
struct Menu *MainMenuStrip;
struct NewMenu GolMainMenu[] =
	{
		{
			NM_TITLE,
			(STRPTR) "Project",
			0,
			0,
			0,
			0,
		},
		{
			NM_ITEM,
			(STRPTR) "Open...",
			(STRPTR) "O",
			0,
			0,
			0,
		},
		{
			NM_ITEM,
			(STRPTR) "Save",
			(STRPTR) "S",
			0,
			0,
			0,
		},
		{
			NM_ITEM,
			NM_BARLABEL,
			0,
			0,
			0,
			0,
		},
		{
			NM_ITEM,
			(STRPTR) "Game",
			0,
			0,
			0,
			0,
		},
		{
			NM_SUB,
			(STRPTR) "Start",
			(STRPTR)"r",
			0,
			0,
			0,
		},
		{
			NM_SUB,
			(STRPTR) "Stop",
			(STRPTR) "h",
			0,
			0,
			0,
		},
		{
			NM_SUB,
			(STRPTR) "Clear",
			0,
			0,
			0,
			0,
		},
		{
			NM_SUB,
			(STRPTR) "Set Randomly",
			0,
			0,
			0,
			0,
		},
		{
			NM_ITEM,
			NM_BARLABEL,
			0,
			0,
			0,
			0,
		},
		{
			NM_ITEM,
			(STRPTR) "Leave...",
			(STRPTR) "Q",
			0,
			0,
			0,
		},
		{
			NM_TITLE,
			(STRPTR) "Edit",
			0,
			0,
			0,
			0,
		},
		{
			NM_ITEM,
			(STRPTR) "Cut",
			(STRPTR) "X",
			0,
			0,
			0,
		},
		{
			NM_ITEM,
			(STRPTR) "Copy",
			(STRPTR) "C",
			0,
			0,
			0,
		},
		{
			NM_ITEM,
			(STRPTR) "Paste",
			(STRPTR) "V",
			0,
			0,
			0,
		},
		{
			NM_ITEM,
			NM_BARLABEL,
			0,
			0,
			0,
			0,
		},
		{
			NM_ITEM,
			(STRPTR) "Undo",
			(STRPTR) "Z",
			0,
			0,
			0,
		},
		{
			NM_TITLE,
			(STRPTR) "Settings",
			0,
			0,
			0,
			0,
		},
		{
			NM_ITEM,
			(STRPTR) "Gridsize",
			(STRPTR) "g",
			0,
			0,
			0,
		},
		{
			NM_ITEM,
			(STRPTR) "Colors",
			(STRPTR) "p",
			0,
			0,
			0,
		},
		{
			NM_SUB,
			(STRPTR) "Alive",
			0,
			0,
			0,
			0,
		},
		{
			NM_SUB,
			(STRPTR) "Dead",
			0,
			0,
			0,
			0,
		},
		{
			NM_TITLE,
			(STRPTR) "?",
			0,
			0,
			0,
			0,
		},
		{
			NM_ITEM,
			(STRPTR) "Help",
			(STRPTR) "h",
			0,
			0,
			0,
		},
		{
			NM_ITEM,
			(STRPTR) "About",
			0,
			0,
			0,
			0,
		},
		{
			NM_END,
			NULL,
			0,
			0,
			0,
			0,
		},
};

#endif