#include <libraries/gadtools.h>
#include <proto/gadtools.h>

#ifndef GOLUI
#define GOLUI 1

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
			0,
			0,
			0,
			0,
		},
		{
			NM_SUB,
			(STRPTR) "Stop",
			0,
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
			NM_END,
			NULL,
			0,
			0,
			0,
			0,
		},
};

#endif