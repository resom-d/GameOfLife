#include <intuition/intuition.h>
#include <proto/intuition.h>
#include <intuition/intuitionbase.h>
#include <libraries/gadtools.h>
#include <proto/gadtools.h>
#include <intuition/gadgetclass.h> /* contains IDs for gadget attributes */
#include <intuition/icclass.h>     /* contains ICA_MAP, ICA_TARGET       */
#include <utility/tagitem.h>

#ifndef GOLUI
#define GOLUI 1

#define ScreenW 640
#define ScreenH 256
#define ScreenD 4

struct _renderData
{
	struct Screen *Screen;
	struct Window *MainWindow;
	struct Window *PPG_Window;
	struct tPoint OutputSize;
	struct tPoint BackbufferSize;
	struct RastPort Rastport;
	struct BitMap *Backbuffer;
	BOOL PPG_WinOpen;
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


/* Playfield properties gagdget*/

#define PPG_FRAME_ID  1
#define PPG_PROPWIDTH_ID  2
#define PPG_STRGWIDTH_ID  3
#define PPG_PROPHEIGHT_ID  4
#define PPG_STRGHEIGHT_ID  5
#define PPG_PROPCELLWIDTH_ID  6
#define PPG_PROPCELLHEIGHT_ID  7
#define PPG_STRGCELLWIDTH_ID  8
#define PPG_STRGCELLHEIGHT_ID  9
#define PPG_BUTTONOK_ID  10
#define PPG_BUTTONCANCEL_ID 11

struct Gadget *PPG_Frame;
struct Gadget *PPG_Frame;
struct Gadget *PPG_PropWidth;
struct Gadget *PPG_PropHeight;
struct Gadget *PPG_StrgWidth;
struct Gadget *PPG_StrgHeight;
struct Gadget *PPG_PropCellWidth;
struct Gadget *PPG_PropCellHeight;
struct Gadget *PPG_StrgCellWidth;
struct Gadget *PPG_StrgCellHeight;
struct Gadget *PPG_ButtonOk;
struct Gadget *PPG_ButtonCancel;

struct NewGadget PP_Gadgets[11] = {
	{63, 26, 172, 13, (UBYTE *)"", NULL, 1, PLACETEXT_IN, NULL, NULL},
	{63, 26, 172, 13, (UBYTE *)"Ok", NULL, 2, PLACETEXT_IN, NULL, NULL},
	{63, 26, 172, 13, (UBYTE *)"Ok", NULL, 3, PLACETEXT_IN, NULL, NULL},
	{63, 26, 172, 13, (UBYTE *)"Ok", NULL, 4, PLACETEXT_IN, NULL, NULL},
	{63, 26, 172, 13, (UBYTE *)"Ok", NULL, 5, PLACETEXT_IN, NULL, NULL},
	{63, 26, 172, 13, (UBYTE *)"Ok", NULL, 6, PLACETEXT_IN, NULL, NULL},
	{63, 26, 172, 13, (UBYTE *)"Ok", NULL, 7, PLACETEXT_IN, NULL, NULL},
	{63, 26, 172, 13, (UBYTE *)"Ok", NULL, 8, PLACETEXT_IN, NULL, NULL},
	{63, 26, 172, 13, (UBYTE *)"Ok", NULL, 9, PLACETEXT_IN, NULL, NULL},
	{5, 80, 50, 16, (UBYTE *)"Ok", NULL, 10, PLACETEXT_IN, NULL, NULL},
	{63, 26, 172, 13, (UBYTE *)"Cancel", NULL, 10, PLACETEXT_IN, NULL, NULL},
};

struct TagItem StringToSlider[] = {
    {PGA_Top, STRINGA_LongVal},
    {TAG_END, 0}
};

struct TagItem SliderToString[] = {
    {STRINGA_LongVal, PGA_Top},
    {TAG_END, 0}
};


struct Border PPG_Border;

#endif