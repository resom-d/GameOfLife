
a.mingw.elf:     file format elf32-m68k


Disassembly of section .text:

00000000 <_start>:
extern void (*__init_array_start[])() __attribute__((weak));
extern void (*__init_array_end[])() __attribute__((weak));
extern void (*__fini_array_start[])() __attribute__((weak));
extern void (*__fini_array_end[])() __attribute__((weak));

__attribute__((used)) __attribute__((section(".text.unlikely"))) void _start() {
   0:	48e7 3020      	movem.l d2-d3/a2,-(sp)
	// initialize globals, ctors etc.
	unsigned long count;
	unsigned long i;

	count = __preinit_array_end - __preinit_array_start;
   4:	263c 0000 309d 	move.l #12445,d3
   a:	0483 0000 309d 	subi.l #12445,d3
  10:	e483           	asr.l #2,d3
	for (i = 0; i < count; i++)
  12:	6712           	beq.s 26 <_start+0x26>
  14:	45f9 0000 309d 	lea 309d <__fini_array_end>,a2
  1a:	7400           	moveq #0,d2
		__preinit_array_start[i]();
  1c:	205a           	movea.l (a2)+,a0
  1e:	4e90           	jsr (a0)
	for (i = 0; i < count; i++)
  20:	5282           	addq.l #1,d2
  22:	b483           	cmp.l d3,d2
  24:	66f6           	bne.s 1c <_start+0x1c>

	count = __init_array_end - __init_array_start;
  26:	263c 0000 309d 	move.l #12445,d3
  2c:	0483 0000 309d 	subi.l #12445,d3
  32:	e483           	asr.l #2,d3
	for (i = 0; i < count; i++)
  34:	6712           	beq.s 48 <_start+0x48>
  36:	45f9 0000 309d 	lea 309d <__fini_array_end>,a2
  3c:	7400           	moveq #0,d2
		__init_array_start[i]();
  3e:	205a           	movea.l (a2)+,a0
  40:	4e90           	jsr (a0)
	for (i = 0; i < count; i++)
  42:	5282           	addq.l #1,d2
  44:	b483           	cmp.l d3,d2
  46:	66f6           	bne.s 3e <_start+0x3e>

	main();
  48:	4eb9 0000 0074 	jsr 74 <main>

	// call dtors
	count = __fini_array_end - __fini_array_start;
  4e:	243c 0000 309d 	move.l #12445,d2
  54:	0482 0000 309d 	subi.l #12445,d2
  5a:	e482           	asr.l #2,d2
	for (i = count; i > 0; i--)
  5c:	6710           	beq.s 6e <_start+0x6e>
  5e:	45f9 0000 309d 	lea 309d <__fini_array_end>,a2
		__fini_array_start[i - 1]();
  64:	5382           	subq.l #1,d2
  66:	2062           	movea.l -(a2),a0
  68:	4e90           	jsr (a0)
	for (i = count; i > 0; i--)
  6a:	4a82           	tst.l d2
  6c:	66f6           	bne.s 64 <_start+0x64>
}
  6e:	4cdf 040c      	movem.l (sp)+,d2-d3/a2
  72:	4e75           	rts

00000074 <main>:
#include "GameOfLifeUI.h"
#include <exec/execbase.h>
//backup

int main()
{
  74:	4fef ff50      	lea -176(sp),sp
  78:	48e7 3f3e      	movem.l d2-d7/a2-a6,-(sp)
	GameMatrix.ColorAlive = 14;
	GameMatrix.ColorDead = 15;
	GameMatrix.Columns = 50;
	GameMatrix.Rows = 20;
  7c:	23fc 0014 0032 	move.l #1310770,3238 <GameMatrix+0x8>
  82:	0000 3238 
  86:	23fc 000e 000f 	move.l #917519,323c <GameMatrix+0xc>
  8c:	0000 323c 
  90:	23fc 000b 000b 	move.l #720907,3240 <GameMatrix+0x10>
  96:	0000 3240 
	return RETURN_OK;
}

int StartApp()
{
	SysBase = *((struct ExecBase **)4UL);
  9a:	2c78 0004      	movea.l 4 <_start+0x4>,a6
  9e:	23ce 0000 3220 	move.l a6,3220 <SysBase>
	custom = (struct Custom *)0xdff000;
	unsigned int pens[] = {~0};
  a4:	70ff           	moveq #-1,d0
  a6:	2f40 0034      	move.l d0,52(sp)

	APTR *my_VisualInfo;

	if ((DOSBase = (struct DosLibrary *)OpenLibrary((CONST_STRPTR) "dos.library", 0)))
  aa:	43f9 0000 0fb4 	lea fb4 <PutChar+0x4>,a1
  b0:	7000           	moveq #0,d0
  b2:	4eae fdd8      	jsr -552(a6)
  b6:	23c0 0000 320c 	move.l d0,320c <DOSBase>
  bc:	6700 058e      	beq.w 64c <main+0x5d8>
	{
		if ((GfxBase = (struct GfxBase *)OpenLibrary((CONST_STRPTR) "graphics.library", 0)))
  c0:	2c79 0000 3220 	movea.l 3220 <SysBase>,a6
  c6:	43f9 0000 0fc0 	lea fc0 <PutChar+0x10>,a1
  cc:	7000           	moveq #0,d0
  ce:	4eae fdd8      	jsr -552(a6)
  d2:	23c0 0000 3218 	move.l d0,3218 <GfxBase>
  d8:	6700 0572      	beq.w 64c <main+0x5d8>
		{
			if ((IntuitionBase = (struct IntuitionBase *)OpenLibrary((CONST_STRPTR) "intuition.library", 0)))
  dc:	2c79 0000 3220 	movea.l 3220 <SysBase>,a6
  e2:	43f9 0000 0fd1 	lea fd1 <PutChar+0x21>,a1
  e8:	7000           	moveq #0,d0
  ea:	4eae fdd8      	jsr -552(a6)
  ee:	2c40           	movea.l d0,a6
  f0:	23c0 0000 321c 	move.l d0,321c <IntuitionBase>
  f6:	6700 0554      	beq.w 64c <main+0x5d8>
			{
				if ((GolScreen = (struct Screen *)OpenScreenTags(NULL,
  fa:	2f7c 8000 003a 	move.l #-2147483590,56(sp)
 100:	0038 
 102:	7034           	moveq #52,d0
 104:	d08f           	add.l sp,d0
 106:	2f40 003c      	move.l d0,60(sp)
 10a:	2f7c 8000 0032 	move.l #-2147483598,64(sp)
 110:	0040 
 112:	2f7c 0000 8000 	move.l #32768,68(sp)
 118:	0044 
 11a:	2f7c 8000 0025 	move.l #-2147483611,72(sp)
 120:	0048 
 122:	7004           	moveq #4,d0
 124:	2f40 004c      	move.l d0,76(sp)
 128:	2f7c 8000 0028 	move.l #-2147483608,80(sp)
 12e:	0050 
 130:	2f7c 0000 0fe3 	move.l #4067,84(sp)
 136:	0054 
 138:	2f7c 8000 002d 	move.l #-2147483603,88(sp)
 13e:	0058 
 140:	700f           	moveq #15,d0
 142:	2f40 005c      	move.l d0,92(sp)
 146:	2f7c 8000 0026 	move.l #-2147483610,96(sp)
 14c:	0060 
 14e:	7004           	moveq #4,d0
 150:	2f40 0064      	move.l d0,100(sp)
 154:	2f7c 8000 0027 	move.l #-2147483609,104(sp)
 15a:	0068 
 15c:	7008           	moveq #8,d0
 15e:	2f40 006c      	move.l d0,108(sp)
 162:	42af 0070      	clr.l 112(sp)
 166:	91c8           	suba.l a0,a0
 168:	43ef 0038      	lea 56(sp),a1
 16c:	4eae fd9c      	jsr -612(a6)
 170:	23c0 0000 3210 	move.l d0,3210 <GolScreen>
 176:	6700 04d4      	beq.w 64c <main+0x5d8>
																 SA_DetailPen, 4,
																 SA_BlockPen, 8,
																 TAG_END)))
				{

					if ((GadToolsBase = (struct Library *)OpenLibrary((CONST_STRPTR) "gadtools.library", 0)))
 17a:	2c79 0000 3220 	movea.l 3220 <SysBase>,a6
 180:	43f9 0000 0ffb 	lea ffb <PutChar+0x4b>,a1
 186:	7000           	moveq #0,d0
 188:	4eae fdd8      	jsr -552(a6)
 18c:	23c0 0000 3214 	move.l d0,3214 <GadToolsBase>
 192:	6700 04b8      	beq.w 64c <main+0x5d8>
					{
						if ((GolMainWindow = (struct Window *)OpenWindowTags(NULL,
 196:	2f7c 8000 0070 	move.l #-2147483536,56(sp)
 19c:	0038 
 19e:	2079 0000 3210 	movea.l 3210 <GolScreen>,a0
 1a4:	2f48 003c      	move.l a0,60(sp)
 1a8:	2f7c 8000 0064 	move.l #-2147483548,64(sp)
 1ae:	0040 
 1b0:	42af 0044      	clr.l 68(sp)
 1b4:	2f7c 8000 0065 	move.l #-2147483547,72(sp)
 1ba:	0048 
 1bc:	1028 001e      	move.b 30(a0),d0
 1c0:	4880           	ext.w d0
 1c2:	48c0           	ext.l d0
 1c4:	5280           	addq.l #1,d0
 1c6:	2f40 004c      	move.l d0,76(sp)
 1ca:	2f7c 8000 0066 	move.l #-2147483546,80(sp)
 1d0:	0050 
 1d2:	1028 0024      	move.b 36(a0),d0
 1d6:	4880           	ext.w d0
 1d8:	3640           	movea.w d0,a3
 1da:	1028 0025      	move.b 37(a0),d0
 1de:	4880           	ext.w d0
 1e0:	3440           	movea.w d0,a2
 1e2:	3039 0000 3240 	move.w 3240 <GameMatrix+0x10>,d0
 1e8:	c0f9 0000 323a 	mulu.w 323a <GameMatrix+0xa>,d0
 1ee:	d08b           	add.l a3,d0
 1f0:	43f2 0810      	lea (16,a2,d0.l),a1
 1f4:	2f49 0054      	move.l a1,84(sp)
 1f8:	2f7c 8000 0067 	move.l #-2147483545,88(sp)
 1fe:	0058 
 200:	1028 0023      	move.b 35(a0),d0
 204:	4880           	ext.w d0
 206:	3240           	movea.w d0,a1
 208:	1028 0026      	move.b 38(a0),d0
 20c:	4880           	ext.w d0
 20e:	3040           	movea.w d0,a0
 210:	3039 0000 3242 	move.w 3242 <GameMatrix+0x12>,d0
 216:	c0f9 0000 3238 	mulu.w 3238 <GameMatrix+0x8>,d0
 21c:	d089           	add.l a1,d0
 21e:	49f0 0810      	lea (16,a0,d0.l),a4
 222:	2f4c 005c      	move.l a4,92(sp)
 226:	2f7c 8000 0074 	move.l #-2147483532,96(sp)
 22c:	0060 
 22e:	203c 0000 0280 	move.l #640,d0
 234:	908b           	sub.l a3,d0
 236:	908a           	sub.l a2,d0
 238:	2f40 0064      	move.l d0,100(sp)
 23c:	2f7c 8000 0075 	move.l #-2147483531,104(sp)
 242:	0068 
 244:	203c 0000 0100 	move.l #256,d0
 24a:	9089           	sub.l a1,d0
 24c:	9088           	sub.l a0,d0
 24e:	2f40 006c      	move.l d0,108(sp)
 252:	2f7c 8000 006e 	move.l #-2147483538,112(sp)
 258:	0070 
 25a:	2f7c 0000 100c 	move.l #4108,116(sp)
 260:	0074 
 262:	2f7c 8000 0083 	move.l #-2147483517,120(sp)
 268:	0078 
 26a:	7001           	moveq #1,d0
 26c:	2f40 007c      	move.l d0,124(sp)
 270:	2f7c 8000 0084 	move.l #-2147483516,128(sp)
 276:	0080 
 278:	2f40 0084      	move.l d0,132(sp)
 27c:	2f7c 8000 0081 	move.l #-2147483519,136(sp)
 282:	0088 
 284:	2f40 008c      	move.l d0,140(sp)
 288:	2f7c 8000 0082 	move.l #-2147483518,144(sp)
 28e:	0090 
 290:	2f40 0094      	move.l d0,148(sp)
 294:	2f7c 8000 0091 	move.l #-2147483503,152(sp)
 29a:	0098 
 29c:	2f40 009c      	move.l d0,156(sp)
 2a0:	2f7c 8000 0086 	move.l #-2147483514,160(sp)
 2a6:	00a0 
 2a8:	2f40 00a4      	move.l d0,164(sp)
 2ac:	2f7c 8000 0093 	move.l #-2147483501,168(sp)
 2b2:	00a8 
 2b4:	2f40 00ac      	move.l d0,172(sp)
 2b8:	2f7c 8000 0089 	move.l #-2147483511,176(sp)
 2be:	00b0 
 2c0:	2f40 00b4      	move.l d0,180(sp)
 2c4:	2f7c 8000 006f 	move.l #-2147483537,184(sp)
 2ca:	00b8 
 2cc:	2f7c 0000 1014 	move.l #4116,188(sp)
 2d2:	00bc 
 2d4:	2f7c 8000 006a 	move.l #-2147483542,192(sp)
 2da:	00c0 
 2dc:	2f7c 0000 031c 	move.l #796,196(sp)
 2e2:	00c4 
 2e4:	2f7c 8000 0068 	move.l #-2147483544,200(sp)
 2ea:	00c8 
 2ec:	42af 00cc      	clr.l 204(sp)
 2f0:	2f7c 8000 0069 	move.l #-2147483543,208(sp)
 2f6:	00d0 
 2f8:	42af 00d4      	clr.l 212(sp)
 2fc:	42af 00d8      	clr.l 216(sp)
 300:	2c79 0000 321c 	movea.l 321c <IntuitionBase>,a6
 306:	91c8           	suba.l a0,a0
 308:	43ef 0038      	lea 56(sp),a1
 30c:	4eae fda2      	jsr -606(a6)
 310:	23c0 0000 322a 	move.l d0,322a <GolMainWindow>
 316:	6700 0334      	beq.w 64c <main+0x5d8>
	if ((GameMatrix.Playfield = AllocMem(GameMatrix.Columns * sizeof(GameOfLifeCell *), MEMF_ANY | MEMF_CLEAR)) == NULL)
 31a:	7000           	moveq #0,d0
 31c:	3039 0000 323a 	move.w 323a <GameMatrix+0xa>,d0
 322:	2c79 0000 3220 	movea.l 3220 <SysBase>,a6
 328:	e588           	lsl.l #2,d0
 32a:	7201           	moveq #1,d1
 32c:	4841           	swap d1
 32e:	4eae ff3a      	jsr -198(a6)
 332:	41f9 0000 3230 	lea 3230 <GameMatrix>,a0
 338:	2080           	move.l d0,(a0)
 33a:	6700 0310      	beq.w 64c <main+0x5d8>
	if ((GameMatrix.Playfield_n1 = AllocMem(GameMatrix.Columns * sizeof(GameOfLifeCell *), MEMF_ANY | MEMF_CLEAR)) == NULL)
 33e:	7000           	moveq #0,d0
 340:	3039 0000 323a 	move.w 323a <GameMatrix+0xa>,d0
 346:	2c79 0000 3220 	movea.l 3220 <SysBase>,a6
 34c:	e588           	lsl.l #2,d0
 34e:	7201           	moveq #1,d1
 350:	4841           	swap d1
 352:	4eae ff3a      	jsr -198(a6)
 356:	23c0 0000 3234 	move.l d0,3234 <GameMatrix+0x4>
 35c:	6700 02ee      	beq.w 64c <main+0x5d8>
	for (int i = 0; i < GameMatrix.Columns; i++)
 360:	4a79 0000 323a 	tst.w 323a <GameMatrix+0xa>
 366:	6762           	beq.s 3ca <main+0x356>
 368:	7400           	moveq #0,d2
 36a:	7600           	moveq #0,d3
		if ((GameMatrix.Playfield[i] = AllocMem(GameMatrix.Rows * sizeof(GameOfLifeCell), MEMF_ANY | MEMF_CLEAR)) == NULL)
 36c:	7801           	moveq #1,d4
 36e:	4844           	swap d4
 370:	7000           	moveq #0,d0
 372:	3039 0000 3238 	move.w 3238 <GameMatrix+0x8>,d0
 378:	2c79 0000 3220 	movea.l 3220 <SysBase>,a6
 37e:	e588           	lsl.l #2,d0
 380:	2204           	move.l d4,d1
 382:	4eae ff3a      	jsr -198(a6)
 386:	43f9 0000 3230 	lea 3230 <GameMatrix>,a1
 38c:	2051           	movea.l (a1),a0
 38e:	2180 2800      	move.l d0,(0,a0,d2.l)
 392:	6700 02b8      	beq.w 64c <main+0x5d8>
		if ((GameMatrix.Playfield_n1[i] = AllocMem(GameMatrix.Rows * sizeof(GameOfLifeCell), MEMF_ANY | MEMF_CLEAR)) == NULL)
 396:	7000           	moveq #0,d0
 398:	3039 0000 3238 	move.w 3238 <GameMatrix+0x8>,d0
 39e:	2c79 0000 3220 	movea.l 3220 <SysBase>,a6
 3a4:	e588           	lsl.l #2,d0
 3a6:	2204           	move.l d4,d1
 3a8:	4eae ff3a      	jsr -198(a6)
 3ac:	2079 0000 3234 	movea.l 3234 <GameMatrix+0x4>,a0
 3b2:	2180 2800      	move.l d0,(0,a0,d2.l)
 3b6:	6700 0294      	beq.w 64c <main+0x5d8>
	for (int i = 0; i < GameMatrix.Columns; i++)
 3ba:	5283           	addq.l #1,d3
 3bc:	5882           	addq.l #4,d2
 3be:	7000           	moveq #0,d0
 3c0:	3039 0000 323a 	move.w 323a <GameMatrix+0xa>,d0
 3c6:	b083           	cmp.l d3,d0
 3c8:	6ea6           	bgt.s 370 <main+0x2fc>
																			 TAG_END)))

						{
							if (AllocatePlayfieldMem() != RETURN_OK)
								return RETURN_FAIL;
							my_VisualInfo = GetVisualInfo(GolMainWindow->WScreen, TAG_END);
 3ca:	42af 0038      	clr.l 56(sp)
 3ce:	2c79 0000 3214 	movea.l 3214 <GadToolsBase>,a6
 3d4:	2079 0000 322a 	movea.l 322a <GolMainWindow>,a0
 3da:	2068 002e      	movea.l 46(a0),a0
 3de:	43ef 0038      	lea 56(sp),a1
 3e2:	4eae ff82      	jsr -126(a6)
 3e6:	2400           	move.l d0,d2
							MainMenuStrip = CreateMenus(GolMainMenu, TAG_END);
 3e8:	42af 0038      	clr.l 56(sp)
 3ec:	2c79 0000 3214 	movea.l 3214 <GadToolsBase>,a6
 3f2:	41f9 0000 30a0 	lea 30a0 <GolMainMenu>,a0
 3f8:	43ef 0038      	lea 56(sp),a1
 3fc:	4eae ffd0      	jsr -48(a6)
 400:	2040           	movea.l d0,a0
 402:	23c0 0000 3226 	move.l d0,3226 <MainMenuStrip>
							LayoutMenus(MainMenuStrip, my_VisualInfo, TAG_END);
 408:	42af 0038      	clr.l 56(sp)
 40c:	2c79 0000 3214 	movea.l 3214 <GadToolsBase>,a6
 412:	2242           	movea.l d2,a1
 414:	45ef 0038      	lea 56(sp),a2
 418:	4eae ffbe      	jsr -66(a6)
							SetMenuStrip(GolMainWindow, MainMenuStrip);
 41c:	2c79 0000 321c 	movea.l 321c <IntuitionBase>,a6
 422:	2079 0000 322a 	movea.l 322a <GolMainWindow>,a0
 428:	2279 0000 3226 	movea.l 3226 <MainMenuStrip>,a1
 42e:	4eae fef8      	jsr -264(a6)
	return RETURN_ERROR;
}

int MainLoop()
{
	DrawCells(GolMainWindow, TRUE);
 432:	2f39 0000 322a 	move.l 322a <GolMainWindow>,-(sp)
 438:	4eb9 0000 0a44 	jsr a44 <DrawCells.constprop.1>

	while (AppRunning)
 43e:	588f           	addq.l #4,sp
 440:	4a79 0000 3208 	tst.w 3208 <AppRunning>
 446:	6700 0530      	beq.w 978 <main+0x904>
	{
		EventLoop(GolMainWindow, MainMenuStrip);
 44a:	2e39 0000 3226 	move.l 3226 <MainMenuStrip>,d7
 450:	2679 0000 322a 	movea.l 322a <GolMainWindow>,a3
					ClearPlayfield(GameMatrix.Playfield_n1);
					DrawCells(theWindow, TRUE);
				}
				if ((menuNum == 0) && (itemNum == 3) && (subNum == 0))
				{
					SetWindowTitles(theWindow, (STRPTR) "Running", (STRPTR)-1);
 456:	49f9 0000 102d 	lea 102d <PutChar+0x7d>,a4
	while ((message = (struct IntuiMessage *)GetMsg(theWindow->UserPort)))
 45c:	2c79 0000 3220 	movea.l 3220 <SysBase>,a6
 462:	206b 0056      	movea.l 86(a3),a0
 466:	4eae fe8c      	jsr -372(a6)
 46a:	2440           	movea.l d0,a2
 46c:	4a80           	tst.l d0
 46e:	6700 00dc      	beq.w 54c <main+0x4d8>
		msg_class = message->Class;
 472:	242a 0014      	move.l 20(a2),d2
		msg_code = message->Code;
 476:	362a 0018      	move.w 24(a2),d3
		coordX = message->MouseX - theWindow->BorderLeft;
 47a:	382a 0020      	move.w 32(a2),d4
 47e:	102b 0036      	move.b 54(a3),d0
 482:	3a40           	movea.w d0,a5
		coordY = message->MouseY - theWindow->BorderTop;
 484:	3a2a 0022      	move.w 34(a2),d5
 488:	1c2b 0037      	move.b 55(a3),d6
		ReplyMsg((struct Message *)message);
 48c:	2c79 0000 3220 	movea.l 3220 <SysBase>,a6
 492:	224a           	movea.l a2,a1
 494:	4eae fe86      	jsr -378(a6)
		switch (msg_class)
 498:	7010           	moveq #16,d0
 49a:	b082           	cmp.l d2,d0
 49c:	67be           	beq.s 45c <main+0x3e8>
 49e:	6500 01b8      	bcs.w 658 <main+0x5e4>
 4a2:	7004           	moveq #4,d0
 4a4:	b082           	cmp.l d2,d0
 4a6:	6700 01cc      	beq.w 674 <main+0x600>
 4aa:	5182           	subq.l #8,d2
 4ac:	66ae           	bne.s 45c <main+0x3e8>
			switch (msg_code)
 4ae:	0c43 0068      	cmpi.w #104,d3
 4b2:	66a8           	bne.s 45c <main+0x3e8>
		coordX = message->MouseX - theWindow->BorderLeft;
 4b4:	300d           	move.w a5,d0
 4b6:	4880           	ext.w d0
 4b8:	9840           	sub.w d0,d4
	SetDrMd(rport, JAM2);
}

void ToggleCellStatus(WORD coordX, WORD coordY)
{
	int x = coordX / GameMatrix.CellSizeH+1;
 4ba:	7000           	moveq #0,d0
 4bc:	3039 0000 3240 	move.w 3240 <GameMatrix+0x10>,d0
 4c2:	2f00           	move.l d0,-(sp)
 4c4:	3044           	movea.w d4,a0
 4c6:	2f08           	move.l a0,-(sp)
 4c8:	4eb9 0000 0f26 	jsr f26 <__divsi3>
 4ce:	508f           	addq.l #8,sp
 4d0:	2400           	move.l d0,d2
 4d2:	5282           	addq.l #1,d2
	int y = coordY / GameMatrix.CellSizeV+1;

	if (!(x < 0 || x > GameMatrix.Columns - 1 || y < 0 || y > GameMatrix.Rows))
 4d4:	6b86           	bmi.s 45c <main+0x3e8>
 4d6:	7000           	moveq #0,d0
 4d8:	3039 0000 323a 	move.w 323a <GameMatrix+0xa>,d0
 4de:	b082           	cmp.l d2,d0
 4e0:	6f00 ff7a      	ble.w 45c <main+0x3e8>
		coordY = message->MouseY - theWindow->BorderTop;
 4e4:	4886           	ext.w d6
 4e6:	9a46           	sub.w d6,d5
	int y = coordY / GameMatrix.CellSizeV+1;
 4e8:	7000           	moveq #0,d0
 4ea:	3039 0000 3242 	move.w 3242 <GameMatrix+0x12>,d0
 4f0:	2f00           	move.l d0,-(sp)
 4f2:	3245           	movea.w d5,a1
 4f4:	2f09           	move.l a1,-(sp)
 4f6:	4eb9 0000 0f26 	jsr f26 <__divsi3>
 4fc:	508f           	addq.l #8,sp
 4fe:	5280           	addq.l #1,d0
	if (!(x < 0 || x > GameMatrix.Columns - 1 || y < 0 || y > GameMatrix.Rows))
 500:	6b00 ff5a      	bmi.w 45c <main+0x3e8>
 504:	7200           	moveq #0,d1
 506:	3239 0000 3238 	move.w 3238 <GameMatrix+0x8>,d1
 50c:	b280           	cmp.l d0,d1
 50e:	6d00 ff4c      	blt.w 45c <main+0x3e8>
	{

		if (GameMatrix.Playfield[x][y].Status)
 512:	41f9 0000 3230 	lea 3230 <GameMatrix>,a0
 518:	2250           	movea.l (a0),a1
 51a:	d482           	add.l d2,d2
 51c:	d482           	add.l d2,d2
 51e:	d080           	add.l d0,d0
 520:	d080           	add.l d0,d0
 522:	2071 2800      	movea.l (0,a1,d2.l),a0
 526:	d1c0           	adda.l d0,a0
 528:	4a10           	tst.b (a0)
 52a:	6700 04fc      	beq.w a28 <main+0x9b4>
		{
			GameMatrix.Playfield[x][y].Status = 0;
 52e:	4210           	clr.b (a0)
			GameMatrix.Playfield[x][y].StatusChanged = TRUE;
 530:	317c 0001 0002 	move.w #1,2(a0)
	while ((message = (struct IntuiMessage *)GetMsg(theWindow->UserPort)))
 536:	2c79 0000 3220 	movea.l 3220 <SysBase>,a6
 53c:	206b 0056      	movea.l 86(a3),a0
 540:	4eae fe8c      	jsr -372(a6)
 544:	2440           	movea.l d0,a2
 546:	4a80           	tst.l d0
 548:	6600 ff28      	bne.w 472 <main+0x3fe>
		memcpy(pf[col], pf_n1[col], GameMatrix.Rows * sizeof(GameOfLifeCell));
 54c:	3839 0000 3238 	move.w 3238 <GameMatrix+0x8>,d4
		if (GameRunning)
 552:	4a79 0000 3224 	tst.w 3224 <GameRunning>
 558:	6600 0274      	bne.w 7ce <main+0x75a>
		DrawCells(GolMainWindow, FALSE);
 55c:	2679 0000 322a 	movea.l 322a <GolMainWindow>,a3
	for (int y = 1; y < GameMatrix.Rows-1; y++)
 562:	0c44 0002      	cmpi.w #2,d4
 566:	6300 fed8      	bls.w 440 <main+0x3cc>
		for (int x = 1; x < GameMatrix.Columns-1; x++)
 56a:	3239 0000 323a 	move.w 323a <GameMatrix+0xa>,d1
 570:	7a04           	moveq #4,d5
	for (int y = 1; y < GameMatrix.Rows-1; y++)
 572:	7c01           	moveq #1,d6
		for (int x = 1; x < GameMatrix.Columns-1; x++)
 574:	0c41 0002      	cmpi.w #2,d1
 578:	6300 fec6      	bls.w 440 <main+0x3cc>
 57c:	7804           	moveq #4,d4
 57e:	347c 0001      	movea.w #1,a2
			RectFill(theWindow->RPort,
 582:	2006           	move.l d6,d0
 584:	5380           	subq.l #1,d0
 586:	2f40 0030      	move.l d0,48(sp)
			if (!GameMatrix.Playfield[x][y].StatusChanged && !forceFull)
 58a:	43f9 0000 3230 	lea 3230 <GameMatrix>,a1
 590:	2051           	movea.l (a1),a0
 592:	2070 4800      	movea.l (0,a0,d4.l),a0
 596:	d1c5           	adda.l d5,a0
 598:	4a68 0002      	tst.w 2(a0)
 59c:	6700 0086      	beq.w 624 <main+0x5b0>
			GameMatrix.Playfield[x][y].StatusChanged = FALSE;
 5a0:	4268 0002      	clr.w 2(a0)
				SetAPen(theWindow->RPort, GameMatrix.ColorAlive);
 5a4:	226b 0032      	movea.l 50(a3),a1
 5a8:	2c79 0000 3218 	movea.l 3218 <GfxBase>,a6
 5ae:	7000           	moveq #0,d0
			if (GameMatrix.Playfield[x][y].Status)
 5b0:	4a10           	tst.b (a0)
 5b2:	6700 0330      	beq.w 8e4 <main+0x870>
				SetAPen(theWindow->RPort, GameMatrix.ColorAlive);
 5b6:	3039 0000 323c 	move.w 323c <GameMatrix+0xc>,d0
 5bc:	4eae feaa      	jsr -342(a6)
			RectFill(theWindow->RPort,
 5c0:	226b 0032      	movea.l 50(a3),a1
 5c4:	7400           	moveq #0,d2
 5c6:	3439 0000 3240 	move.w 3240 <GameMatrix+0x10>,d2
 5cc:	2f02           	move.l d2,-(sp)
 5ce:	486a ffff      	pea -1(a2)
 5d2:	2f49 0034      	move.l a1,52(sp)
 5d6:	4eb9 0000 0ea8 	jsr ea8 <__mulsi3>
 5dc:	508f           	addq.l #8,sp
 5de:	2840           	movea.l d0,a4
 5e0:	4bec 0001      	lea 1(a4),a5
 5e4:	7e00           	moveq #0,d7
 5e6:	3e39 0000 3242 	move.w 3242 <GameMatrix+0x12>,d7
 5ec:	2f07           	move.l d7,-(sp)
 5ee:	2f2f 0034      	move.l 52(sp),-(sp)
 5f2:	4eb9 0000 0ea8 	jsr ea8 <__mulsi3>
 5f8:	508f           	addq.l #8,sp
 5fa:	2600           	move.l d0,d3
 5fc:	2c79 0000 3218 	movea.l 3218 <GfxBase>,a6
 602:	226f 002c      	movea.l 44(sp),a1
 606:	200d           	move.l a5,d0
 608:	2203           	move.l d3,d1
 60a:	5281           	addq.l #1,d1
 60c:	49f4 28ff      	lea (-1,a4,d2.l),a4
 610:	240c           	move.l a4,d2
 612:	2847           	movea.l d7,a4
 614:	49f4 38ff      	lea (-1,a4,d3.l),a4
 618:	260c           	move.l a4,d3
 61a:	4eae fece      	jsr -306(a6)
		for (int x = 1; x < GameMatrix.Columns-1; x++)
 61e:	3239 0000 323a 	move.w 323a <GameMatrix+0xa>,d1
 624:	528a           	addq.l #1,a2
 626:	5884           	addq.l #4,d4
 628:	7000           	moveq #0,d0
 62a:	3001           	move.w d1,d0
 62c:	5380           	subq.l #1,d0
 62e:	b08a           	cmp.l a2,d0
 630:	6e00 ff58      	bgt.w 58a <main+0x516>
	for (int y = 1; y < GameMatrix.Rows-1; y++)
 634:	5286           	addq.l #1,d6
 636:	7000           	moveq #0,d0
 638:	3039 0000 3238 	move.w 3238 <GameMatrix+0x8>,d0
 63e:	5380           	subq.l #1,d0
 640:	b086           	cmp.l d6,d0
 642:	6f00 fdfc      	ble.w 440 <main+0x3cc>
 646:	5885           	addq.l #4,d5
 648:	6000 ff2a      	bra.w 574 <main+0x500>
		return RETURN_FAIL;
 64c:	7014           	moveq #20,d0
}
 64e:	4cdf 7cfc      	movem.l (sp)+,d2-d7/a2-a6
 652:	4fef 00b0      	lea 176(sp),sp
 656:	4e75           	rts
		switch (msg_class)
 658:	0c82 0000 0100 	cmpi.l #256,d2
 65e:	6722           	beq.s 682 <main+0x60e>
 660:	0c82 0000 0200 	cmpi.l #512,d2
 666:	6600 fdf4      	bne.w 45c <main+0x3e8>
			AppRunning = FALSE;
 66a:	4279 0000 3208 	clr.w 3208 <AppRunning>
			break;
 670:	6000 fdea      	bra.w 45c <main+0x3e8>
			DrawCells(theWindow, TRUE);
 674:	2f0b           	move.l a3,-(sp)
 676:	4eb9 0000 0a44 	jsr a44 <DrawCells.constprop.1>
 67c:	588f           	addq.l #4,sp
 67e:	6000 fddc      	bra.w 45c <main+0x3e8>
			menuNumber = message->Code;
 682:	342a 0018      	move.w 24(a2),d2
			while ((menuNumber != MENUNULL) && (AppRunning))
 686:	0c42 ffff      	cmpi.w #-1,d2
 68a:	6700 fdd0      	beq.w 45c <main+0x3e8>
 68e:	4a79 0000 3208 	tst.w 3208 <AppRunning>
 694:	6700 fdc6      	beq.w 45c <main+0x3e8>
				item = ItemAddress(theMenu, menuNumber);
 698:	2c79 0000 321c 	movea.l 321c <IntuitionBase>,a6
 69e:	2047           	movea.l d7,a0
 6a0:	3002           	move.w d2,d0
 6a2:	4eae ff70      	jsr -144(a6)
 6a6:	2a40           	movea.l d0,a5
				menuNum = MENUNUM(menuNumber);
 6a8:	3002           	move.w d2,d0
 6aa:	0240 001f      	andi.w #31,d0
				if ((menuNum == 0) && (itemNum == 5))
 6ae:	663e           	bne.s 6ee <main+0x67a>
				itemNum = ITEMNUM(menuNumber);
 6b0:	3002           	move.w d2,d0
 6b2:	ea48           	lsr.w #5,d0
 6b4:	0240 003f      	andi.w #63,d0
				if ((menuNum == 0) && (itemNum == 5))
 6b8:	0c40 0005      	cmpi.w #5,d0
 6bc:	673e           	beq.s 6fc <main+0x688>
				if ((menuNum == 0) && (itemNum == 3) && (subNum == 2))
 6be:	0c40 0003      	cmpi.w #3,d0
 6c2:	662a           	bne.s 6ee <main+0x67a>
				subNum = SUBNUM(menuNumber);
 6c4:	700b           	moveq #11,d0
 6c6:	e06a           	lsr.w d0,d2
				if ((menuNum == 0) && (itemNum == 3) && (subNum == 2))
 6c8:	0c42 0002      	cmpi.w #2,d2
 6cc:	6700 0088      	beq.w 756 <main+0x6e2>
				if ((menuNum == 0) && (itemNum == 3) && (subNum == 0))
 6d0:	4a42           	tst.w d2
 6d2:	6650           	bne.s 724 <main+0x6b0>
					SetWindowTitles(theWindow, (STRPTR) "Running", (STRPTR)-1);
 6d4:	2c79 0000 321c 	movea.l 321c <IntuitionBase>,a6
 6da:	204b           	movea.l a3,a0
 6dc:	224c           	movea.l a4,a1
 6de:	347c ffff      	movea.w #-1,a2
 6e2:	4eae feec      	jsr -276(a6)
					GameRunning = TRUE;
 6e6:	33fc 0001 0000 	move.w #1,3224 <GameRunning>
 6ec:	3224 
				menuNumber = item->NextSelect;
 6ee:	342d 0020      	move.w 32(a5),d2
			while ((menuNumber != MENUNULL) && (AppRunning))
 6f2:	0c42 ffff      	cmpi.w #-1,d2
 6f6:	6696           	bne.s 68e <main+0x61a>
 6f8:	6000 fd62      	bra.w 45c <main+0x3e8>
					AppRunning = FALSE;
 6fc:	4279 0000 3208 	clr.w 3208 <AppRunning>
					SetWindowTitles(theWindow, (STRPTR) "Running", (STRPTR)-1);
 702:	2c79 0000 321c 	movea.l 321c <IntuitionBase>,a6
 708:	204b           	movea.l a3,a0
 70a:	224c           	movea.l a4,a1
 70c:	347c ffff      	movea.w #-1,a2
 710:	4eae feec      	jsr -276(a6)
				menuNumber = item->NextSelect;
 714:	342d 0020      	move.w 32(a5),d2
			while ((menuNumber != MENUNULL) && (AppRunning))
 718:	0c42 ffff      	cmpi.w #-1,d2
 71c:	6600 ff70      	bne.w 68e <main+0x61a>
 720:	6000 fd3a      	bra.w 45c <main+0x3e8>
				if ((menuNum == 0) && (itemNum == 3) && (subNum == 1))
 724:	0c42 0001      	cmpi.w #1,d2
 728:	66c4           	bne.s 6ee <main+0x67a>
					SetWindowTitles(theWindow, (STRPTR) "Stopped", (STRPTR)-1);
 72a:	2c79 0000 321c 	movea.l 321c <IntuitionBase>,a6
 730:	204b           	movea.l a3,a0
 732:	43f9 0000 100c 	lea 100c <PutChar+0x5c>,a1
 738:	347c ffff      	movea.w #-1,a2
 73c:	4eae feec      	jsr -276(a6)
					GameRunning = FALSE;
 740:	4279 0000 3224 	clr.w 3224 <GameRunning>
				menuNumber = item->NextSelect;
 746:	342d 0020      	move.w 32(a5),d2
			while ((menuNumber != MENUNULL) && (AppRunning))
 74a:	0c42 ffff      	cmpi.w #-1,d2
 74e:	6600 ff3e      	bne.w 68e <main+0x61a>
 752:	6000 fd08      	bra.w 45c <main+0x3e8>
					ClearPlayfield(GameMatrix.Playfield);
 756:	41f9 0000 3230 	lea 3230 <GameMatrix>,a0
 75c:	2450           	movea.l (a0),a2
	for (int x = 0; x < GameMatrix.Columns; x++)
 75e:	3639 0000 323a 	move.w 323a <GameMatrix+0xa>,d3
 764:	674e           	beq.s 7b4 <main+0x740>
		memset(pf[x], 0, GameMatrix.Rows * sizeof(GameOfLifeCell));
 766:	7400           	moveq #0,d2
 768:	3439 0000 3238 	move.w 3238 <GameMatrix+0x8>,d2
 76e:	d482           	add.l d2,d2
 770:	d482           	add.l d2,d2
 772:	0283 0000 ffff 	andi.l #65535,d3
 778:	d683           	add.l d3,d3
 77a:	d683           	add.l d3,d3
 77c:	280a           	move.l a2,d4
 77e:	d883           	add.l d3,d4
 780:	201a           	move.l (a2)+,d0
 782:	2f02           	move.l d2,-(sp)
 784:	42a7           	clr.l -(sp)
 786:	2f00           	move.l d0,-(sp)
 788:	4eb9 0000 0c96 	jsr c96 <memset>
	for (int x = 0; x < GameMatrix.Columns; x++)
 78e:	4fef 000c      	lea 12(sp),sp
 792:	b5c4           	cmpa.l d4,a2
 794:	66ea           	bne.s 780 <main+0x70c>
 796:	2479 0000 3234 	movea.l 3234 <GameMatrix+0x4>,a2
 79c:	d68a           	add.l a2,d3
		memset(pf[x], 0, GameMatrix.Rows * sizeof(GameOfLifeCell));
 79e:	201a           	move.l (a2)+,d0
 7a0:	2f02           	move.l d2,-(sp)
 7a2:	42a7           	clr.l -(sp)
 7a4:	2f00           	move.l d0,-(sp)
 7a6:	4eb9 0000 0c96 	jsr c96 <memset>
	for (int x = 0; x < GameMatrix.Columns; x++)
 7ac:	4fef 000c      	lea 12(sp),sp
 7b0:	b5c3           	cmpa.l d3,a2
 7b2:	66ea           	bne.s 79e <main+0x72a>
					DrawCells(theWindow, TRUE);
 7b4:	2f0b           	move.l a3,-(sp)
 7b6:	4eb9 0000 0a44 	jsr a44 <DrawCells.constprop.1>
 7bc:	588f           	addq.l #4,sp
				menuNumber = item->NextSelect;
 7be:	342d 0020      	move.w 32(a5),d2
			while ((menuNumber != MENUNULL) && (AppRunning))
 7c2:	0c42 ffff      	cmpi.w #-1,d2
 7c6:	6600 fec6      	bne.w 68e <main+0x61a>
 7ca:	6000 fc90      	bra.w 45c <main+0x3e8>
	GameOfLifeCell **pf = GameMatrix.Playfield;
 7ce:	43f9 0000 3230 	lea 3230 <GameMatrix>,a1
 7d4:	2c51           	movea.l (a1),a6
	GameOfLifeCell **pf_n1 = GameMatrix.Playfield_n1;
 7d6:	2f79 0000 3234 	move.l 3234 <GameMatrix+0x4>,48(sp)
 7dc:	0030 
	for (int x = 1; x < GameMatrix.Columns - 1; x++)
 7de:	7a00           	moveq #0,d5
 7e0:	3a39 0000 323a 	move.w 323a <GameMatrix+0xa>,d5
 7e6:	7002           	moveq #2,d0
 7e8:	b085           	cmp.l d5,d0
 7ea:	6c00 00ac      	bge.w 898 <main+0x824>
 7ee:	0c44 0002      	cmpi.w #2,d4
 7f2:	6300 00a4      	bls.w 898 <main+0x824>
 7f6:	2a4e           	movea.l a6,a5
 7f8:	286f 0030      	movea.l 48(sp),a4
 7fc:	588c           	addq.l #4,a4
 7fe:	2005           	move.l d5,d0
 800:	d085           	add.l d5,d0
 802:	d080           	add.l d0,d0
 804:	41f6 08f8      	lea (-8,a6,d0.l),a0
 808:	2e08           	move.l a0,d7
 80a:	7c00           	moveq #0,d6
 80c:	3c04           	move.w d4,d6
 80e:	dc86           	add.l d6,d6
 810:	dc86           	add.l d6,d6
 812:	5186           	subq.l #8,d6
					if (pf[x + xi][y + yj].Status)
 814:	205d           	movea.l (a5)+,a0
 816:	246d 0004      	movea.l 4(a5),a2
 81a:	2255           	movea.l (a5),a1
 81c:	2408           	move.l a0,d2
 81e:	d486           	add.l d6,d2
 820:	7604           	moveq #4,d3
 822:	9688           	sub.l a0,d3
 824:	4a10           	tst.b (a0)
 826:	56c0           	sne d0
 828:	4880           	ext.w d0
 82a:	4440           	neg.w d0
 82c:	47f0 3800      	lea (0,a0,d3.l),a3
 830:	4a28 0004      	tst.b 4(a0)
 834:	6702           	beq.s 838 <main+0x7c4>
						neighbours++;
 836:	5240           	addq.w #1,d0
					if (pf[x + xi][y + yj].Status)
 838:	4a28 0008      	tst.b 8(a0)
 83c:	6702           	beq.s 840 <main+0x7cc>
						neighbours++;
 83e:	5240           	addq.w #1,d0
					if (pf[x + xi][y + yj].Status)
 840:	4a11           	tst.b (a1)
 842:	6702           	beq.s 846 <main+0x7d2>
						neighbours++;
 844:	5240           	addq.w #1,d0
					if (pf[x + xi][y + yj].Status)
 846:	1229 0004      	move.b 4(a1),d1
 84a:	6702           	beq.s 84e <main+0x7da>
						neighbours++;
 84c:	5240           	addq.w #1,d0
					if (pf[x + xi][y + yj].Status)
 84e:	4a29 0008      	tst.b 8(a1)
 852:	6702           	beq.s 856 <main+0x7e2>
						neighbours++;
 854:	5240           	addq.w #1,d0
					if (pf[x + xi][y + yj].Status)
 856:	4a12           	tst.b (a2)
 858:	6702           	beq.s 85c <main+0x7e8>
						neighbours++;
 85a:	5240           	addq.w #1,d0
					if (pf[x + xi][y + yj].Status)
 85c:	4a2a 0004      	tst.b 4(a2)
 860:	6702           	beq.s 864 <main+0x7f0>
						neighbours++;
 862:	5240           	addq.w #1,d0
					if (pf[x + xi][y + yj].Status)
 864:	4a2a 0008      	tst.b 8(a2)
 868:	6702           	beq.s 86c <main+0x7f8>
						neighbours++;
 86a:	5240           	addq.w #1,d0
			if (pf[x][y].Status) neighbours--; // own status was added above - so -1 for ourselves
 86c:	4a01           	tst.b d1
 86e:	6700 00e6      	beq.w 956 <main+0x8e2>
					pf_n1[x][y].Status = 0;
 872:	d7d4           	adda.l (a4),a3
				if (neighbours < 2 || neighbours > 3)
 874:	5740           	subq.w #3,d0
 876:	0c40 0001      	cmpi.w #1,d0
 87a:	6300 00f2      	bls.w 96e <main+0x8fa>
					pf_n1[x][y].Status = 0;
 87e:	4213           	clr.b (a3)
					pf_n1[x][y].StatusChanged = TRUE;
 880:	377c 0001 0002 	move.w #1,2(a3)
		for (int y = 1; y < GameMatrix.Rows - 1; y++)
 886:	5888           	addq.l #4,a0
 888:	588a           	addq.l #4,a2
 88a:	5889           	addq.l #4,a1
 88c:	b488           	cmp.l a0,d2
 88e:	6694           	bne.s 824 <main+0x7b0>
	for (int x = 1; x < GameMatrix.Columns - 1; x++)
 890:	588c           	addq.l #4,a4
 892:	be8d           	cmp.l a5,d7
 894:	6600 ff7e      	bne.w 814 <main+0x7a0>
	for (int col = 0; col < GameMatrix.Columns; col++)
 898:	4a85           	tst.l d5
 89a:	6700 fcc0      	beq.w 55c <main+0x4e8>
		memcpy(pf[col], pf_n1[col], GameMatrix.Rows * sizeof(GameOfLifeCell));
 89e:	7600           	moveq #0,d3
 8a0:	3604           	move.w d4,d3
 8a2:	d683           	add.l d3,d3
 8a4:	d683           	add.l d3,d3
 8a6:	246f 0030      	movea.l 48(sp),a2
 8aa:	da85           	add.l d5,d5
 8ac:	da85           	add.l d5,d5
 8ae:	da8a           	add.l a2,d5
 8b0:	47f9 0000 0d64 	lea d64 <memcpy>,a3
 8b6:	221a           	move.l (a2)+,d1
 8b8:	201e           	move.l (a6)+,d0
 8ba:	2f03           	move.l d3,-(sp)
 8bc:	2f01           	move.l d1,-(sp)
 8be:	2f00           	move.l d0,-(sp)
 8c0:	4e93           	jsr (a3)
	for (int col = 0; col < GameMatrix.Columns; col++)
 8c2:	4fef 000c      	lea 12(sp),sp
 8c6:	ba8a           	cmp.l a2,d5
 8c8:	6700 fc92      	beq.w 55c <main+0x4e8>
		memcpy(pf[col], pf_n1[col], GameMatrix.Rows * sizeof(GameOfLifeCell));
 8cc:	221a           	move.l (a2)+,d1
 8ce:	201e           	move.l (a6)+,d0
 8d0:	2f03           	move.l d3,-(sp)
 8d2:	2f01           	move.l d1,-(sp)
 8d4:	2f00           	move.l d0,-(sp)
 8d6:	4e93           	jsr (a3)
	for (int col = 0; col < GameMatrix.Columns; col++)
 8d8:	4fef 000c      	lea 12(sp),sp
 8dc:	ba8a           	cmp.l a2,d5
 8de:	66d6           	bne.s 8b6 <main+0x842>
 8e0:	6000 fc7a      	bra.w 55c <main+0x4e8>
				SetAPen(theWindow->RPort, GameMatrix.ColorDead);
 8e4:	3039 0000 323e 	move.w 323e <GameMatrix+0xe>,d0
 8ea:	4eae feaa      	jsr -342(a6)
			RectFill(theWindow->RPort,
 8ee:	226b 0032      	movea.l 50(a3),a1
 8f2:	7400           	moveq #0,d2
 8f4:	3439 0000 3240 	move.w 3240 <GameMatrix+0x10>,d2
 8fa:	2f02           	move.l d2,-(sp)
 8fc:	486a ffff      	pea -1(a2)
 900:	2f49 0034      	move.l a1,52(sp)
 904:	4eb9 0000 0ea8 	jsr ea8 <__mulsi3>
 90a:	508f           	addq.l #8,sp
 90c:	2840           	movea.l d0,a4
 90e:	4bec 0001      	lea 1(a4),a5
 912:	7e00           	moveq #0,d7
 914:	3e39 0000 3242 	move.w 3242 <GameMatrix+0x12>,d7
 91a:	2f07           	move.l d7,-(sp)
 91c:	2f2f 0034      	move.l 52(sp),-(sp)
 920:	4eb9 0000 0ea8 	jsr ea8 <__mulsi3>
 926:	508f           	addq.l #8,sp
 928:	2600           	move.l d0,d3
 92a:	2c79 0000 3218 	movea.l 3218 <GfxBase>,a6
 930:	226f 002c      	movea.l 44(sp),a1
 934:	200d           	move.l a5,d0
 936:	2203           	move.l d3,d1
 938:	5281           	addq.l #1,d1
 93a:	49f4 28ff      	lea (-1,a4,d2.l),a4
 93e:	240c           	move.l a4,d2
 940:	2847           	movea.l d7,a4
 942:	49f4 38ff      	lea (-1,a4,d3.l),a4
 946:	260c           	move.l a4,d3
 948:	4eae fece      	jsr -306(a6)
		for (int x = 1; x < GameMatrix.Columns-1; x++)
 94c:	3239 0000 323a 	move.w 323a <GameMatrix+0xa>,d1
 952:	6000 fcd0      	bra.w 624 <main+0x5b0>
			else if(neighbours == 3)
 956:	0c40 0003      	cmpi.w #3,d0
 95a:	6600 ff2a      	bne.w 886 <main+0x812>
				pf_n1[x][y].Status =1;
 95e:	d7d4           	adda.l (a4),a3
 960:	16bc 0001      	move.b #1,(a3)
				pf_n1[x][y].StatusChanged = TRUE;
 964:	377c 0001 0002 	move.w #1,2(a3)
 96a:	6000 ff1a      	bra.w 886 <main+0x812>
					pf_n1[x][y].Status = pf[x][y].Status;
 96e:	1681           	move.b d1,(a3)
					pf_n1[x][y].StatusChanged = FALSE;
 970:	426b 0002      	clr.w 2(a3)
 974:	6000 ff10      	bra.w 886 <main+0x812>
	FreeMem((APTR)GameMatrix.Playfield, GameMatrix.Rows * GameMatrix.Columns * sizeof(GameOfLifeCell));
 978:	3039 0000 3238 	move.w 3238 <GameMatrix+0x8>,d0
 97e:	c0f9 0000 323a 	mulu.w 323a <GameMatrix+0xa>,d0
 984:	2c79 0000 3220 	movea.l 3220 <SysBase>,a6
 98a:	41f9 0000 3230 	lea 3230 <GameMatrix>,a0
 990:	2250           	movea.l (a0),a1
 992:	e588           	lsl.l #2,d0
 994:	4eae ff2e      	jsr -210(a6)
	if (GolMainWindow)
 998:	2079 0000 322a 	movea.l 322a <GolMainWindow>,a0
 99e:	b0fc 0000      	cmpa.w #0,a0
 9a2:	670a           	beq.s 9ae <main+0x93a>
		CloseWindow(GolMainWindow);
 9a4:	2c79 0000 321c 	movea.l 321c <IntuitionBase>,a6
 9aa:	4eae ffb8      	jsr -72(a6)
	if (GadToolsBase)
 9ae:	2279 0000 3214 	movea.l 3214 <GadToolsBase>,a1
 9b4:	b2fc 0000      	cmpa.w #0,a1
 9b8:	670a           	beq.s 9c4 <main+0x950>
		CloseLibrary((struct Library *)GadToolsBase);
 9ba:	2c79 0000 3220 	movea.l 3220 <SysBase>,a6
 9c0:	4eae fe62      	jsr -414(a6)
	if (GolScreen)
 9c4:	2079 0000 3210 	movea.l 3210 <GolScreen>,a0
 9ca:	b0fc 0000      	cmpa.w #0,a0
 9ce:	670a           	beq.s 9da <main+0x966>
		CloseScreen(GolScreen);
 9d0:	2c79 0000 321c 	movea.l 321c <IntuitionBase>,a6
 9d6:	4eae ffbe      	jsr -66(a6)
	if (GfxBase)
 9da:	2279 0000 3218 	movea.l 3218 <GfxBase>,a1
 9e0:	b2fc 0000      	cmpa.w #0,a1
 9e4:	670a           	beq.s 9f0 <main+0x97c>
		CloseLibrary((struct Library *)GfxBase);
 9e6:	2c79 0000 3220 	movea.l 3220 <SysBase>,a6
 9ec:	4eae fe62      	jsr -414(a6)
	if (IntuitionBase)
 9f0:	2279 0000 321c 	movea.l 321c <IntuitionBase>,a1
 9f6:	b2fc 0000      	cmpa.w #0,a1
 9fa:	670a           	beq.s a06 <main+0x992>
		CloseLibrary((struct Library *)IntuitionBase);
 9fc:	2c79 0000 3220 	movea.l 3220 <SysBase>,a6
 a02:	4eae fe62      	jsr -414(a6)
	if (DOSBase)
 a06:	2279 0000 320c 	movea.l 320c <DOSBase>,a1
 a0c:	b2fc 0000      	cmpa.w #0,a1
 a10:	6724           	beq.s a36 <main+0x9c2>
		CloseLibrary((struct Library *)DOSBase);
 a12:	2c79 0000 3220 	movea.l 3220 <SysBase>,a6
 a18:	4eae fe62      	jsr -414(a6)
 a1c:	7000           	moveq #0,d0
}
 a1e:	4cdf 7cfc      	movem.l (sp)+,d2-d7/a2-a6
 a22:	4fef 00b0      	lea 176(sp),sp
 a26:	4e75           	rts
		}
		else
		{
			GameMatrix.Playfield[x][y].Status = 1;
 a28:	10bc 0001      	move.b #1,(a0)
			GameMatrix.Playfield[x][y].StatusChanged = TRUE;
 a2c:	317c 0001 0002 	move.w #1,2(a0)
 a32:	6000 fa28      	bra.w 45c <main+0x3e8>
 a36:	7000           	moveq #0,d0
}
 a38:	4cdf 7cfc      	movem.l (sp)+,d2-d7/a2-a6
 a3c:	4fef 00b0      	lea 176(sp),sp
 a40:	4e75           	rts
 a42:	4e71           	nop

00000a44 <DrawCells.constprop.1>:
void DrawCells(struct Window *theWindow, BOOL forceFull)
 a44:	4fef fff0      	lea -16(sp),sp
 a48:	48e7 3f3e      	movem.l d2-d7/a2-a6,-(sp)
 a4c:	266f 0040      	movea.l 64(sp),a3
	for (int y = 1; y < GameMatrix.Rows-1; y++)
 a50:	0c79 0002 0000 	cmpi.w #2,3238 <GameMatrix+0x8>
 a56:	3238 
 a58:	6300 00f0      	bls.w b4a <DrawCells.constprop.1+0x106>
		for (int x = 1; x < GameMatrix.Columns-1; x++)
 a5c:	3239 0000 323a 	move.w 323a <GameMatrix+0xa>,d1
 a62:	7004           	moveq #4,d0
 a64:	2f40 0030      	move.l d0,48(sp)
	for (int y = 1; y < GameMatrix.Rows-1; y++)
 a68:	7001           	moveq #1,d0
 a6a:	2f40 0038      	move.l d0,56(sp)
 a6e:	4bf9 0000 3230 	lea 3230 <GameMatrix>,a5
 a74:	49f9 0000 0ea8 	lea ea8 <__mulsi3>,a4
		for (int x = 1; x < GameMatrix.Columns-1; x++)
 a7a:	0c41 0002      	cmpi.w #2,d1
 a7e:	6300 00ca      	bls.w b4a <DrawCells.constprop.1+0x106>
 a82:	202f 0038      	move.l 56(sp),d0
 a86:	5380           	subq.l #1,d0
 a88:	2f40 0034      	move.l d0,52(sp)
 a8c:	7804           	moveq #4,d4
 a8e:	347c 0001      	movea.w #1,a2
			if (!GameMatrix.Playfield[x][y].StatusChanged && !forceFull)
 a92:	2055           	movea.l (a5),a0
 a94:	2070 4800      	movea.l (0,a0,d4.l),a0
 a98:	d1ef 0030      	adda.l 48(sp),a0
			GameMatrix.Playfield[x][y].StatusChanged = FALSE;
 a9c:	4268 0002      	clr.w 2(a0)
				SetAPen(theWindow->RPort, GameMatrix.ColorAlive);
 aa0:	226b 0032      	movea.l 50(a3),a1
 aa4:	2c79 0000 3218 	movea.l 3218 <GfxBase>,a6
 aaa:	7000           	moveq #0,d0
			if (GameMatrix.Playfield[x][y].Status)
 aac:	4a10           	tst.b (a0)
 aae:	6700 00a4      	beq.w b54 <DrawCells.constprop.1+0x110>
				SetAPen(theWindow->RPort, GameMatrix.ColorAlive);
 ab2:	3039 0000 323c 	move.w 323c <GameMatrix+0xc>,d0
 ab8:	4eae feaa      	jsr -342(a6)
			RectFill(theWindow->RPort,
 abc:	226b 0032      	movea.l 50(a3),a1
 ac0:	7a00           	moveq #0,d5
 ac2:	3a39 0000 3240 	move.w 3240 <GameMatrix+0x10>,d5
 ac8:	2f05           	move.l d5,-(sp)
 aca:	486a ffff      	pea -1(a2)
 ace:	2f49 0034      	move.l a1,52(sp)
 ad2:	4e94           	jsr (a4)
 ad4:	508f           	addq.l #8,sp
 ad6:	2400           	move.l d0,d2
 ad8:	2c00           	move.l d0,d6
 ada:	5286           	addq.l #1,d6
 adc:	7e00           	moveq #0,d7
 ade:	3e39 0000 3242 	move.w 3242 <GameMatrix+0x12>,d7
 ae4:	2f2f 0034      	move.l 52(sp),-(sp)
 ae8:	2f07           	move.l d7,-(sp)
 aea:	4e94           	jsr (a4)
 aec:	508f           	addq.l #8,sp
 aee:	2600           	move.l d0,d3
 af0:	2c79 0000 3218 	movea.l 3218 <GfxBase>,a6
 af6:	226f 002c      	movea.l 44(sp),a1
 afa:	2006           	move.l d6,d0
 afc:	2203           	move.l d3,d1
 afe:	5281           	addq.l #1,d1
 b00:	2045           	movea.l d5,a0
 b02:	41f0 28ff      	lea (-1,a0,d2.l),a0
 b06:	2408           	move.l a0,d2
 b08:	2047           	movea.l d7,a0
 b0a:	41f0 38ff      	lea (-1,a0,d3.l),a0
 b0e:	2608           	move.l a0,d3
 b10:	4eae fece      	jsr -306(a6)
		for (int x = 1; x < GameMatrix.Columns-1; x++)
 b14:	528a           	addq.l #1,a2
 b16:	3239 0000 323a 	move.w 323a <GameMatrix+0xa>,d1
 b1c:	5884           	addq.l #4,d4
 b1e:	7000           	moveq #0,d0
 b20:	3001           	move.w d1,d0
 b22:	5380           	subq.l #1,d0
 b24:	b08a           	cmp.l a2,d0
 b26:	6e00 ff6a      	bgt.w a92 <DrawCells.constprop.1+0x4e>
	for (int y = 1; y < GameMatrix.Rows-1; y++)
 b2a:	52af 0038      	addq.l #1,56(sp)
 b2e:	7000           	moveq #0,d0
 b30:	3039 0000 3238 	move.w 3238 <GameMatrix+0x8>,d0
 b36:	5380           	subq.l #1,d0
 b38:	b0af 0038      	cmp.l 56(sp),d0
 b3c:	6f0c           	ble.s b4a <DrawCells.constprop.1+0x106>
 b3e:	58af 0030      	addq.l #4,48(sp)
		for (int x = 1; x < GameMatrix.Columns-1; x++)
 b42:	0c41 0002      	cmpi.w #2,d1
 b46:	6200 ff3a      	bhi.w a82 <DrawCells.constprop.1+0x3e>
}
 b4a:	4cdf 7cfc      	movem.l (sp)+,d2-d7/a2-a6
 b4e:	4fef 0010      	lea 16(sp),sp
 b52:	4e75           	rts
				SetAPen(theWindow->RPort, GameMatrix.ColorDead);
 b54:	3039 0000 323e 	move.w 323e <GameMatrix+0xe>,d0
 b5a:	4eae feaa      	jsr -342(a6)
			RectFill(theWindow->RPort,
 b5e:	226b 0032      	movea.l 50(a3),a1
 b62:	7a00           	moveq #0,d5
 b64:	3a39 0000 3240 	move.w 3240 <GameMatrix+0x10>,d5
 b6a:	2f05           	move.l d5,-(sp)
 b6c:	486a ffff      	pea -1(a2)
 b70:	2f49 0034      	move.l a1,52(sp)
 b74:	4e94           	jsr (a4)
 b76:	508f           	addq.l #8,sp
 b78:	2400           	move.l d0,d2
 b7a:	2c00           	move.l d0,d6
 b7c:	5286           	addq.l #1,d6
 b7e:	7e00           	moveq #0,d7
 b80:	3e39 0000 3242 	move.w 3242 <GameMatrix+0x12>,d7
 b86:	2f2f 0034      	move.l 52(sp),-(sp)
 b8a:	2f07           	move.l d7,-(sp)
 b8c:	4e94           	jsr (a4)
 b8e:	508f           	addq.l #8,sp
 b90:	2600           	move.l d0,d3
 b92:	2c79 0000 3218 	movea.l 3218 <GfxBase>,a6
 b98:	226f 002c      	movea.l 44(sp),a1
 b9c:	2006           	move.l d6,d0
 b9e:	2203           	move.l d3,d1
 ba0:	5281           	addq.l #1,d1
 ba2:	2045           	movea.l d5,a0
 ba4:	41f0 28ff      	lea (-1,a0,d2.l),a0
 ba8:	2408           	move.l a0,d2
 baa:	2047           	movea.l d7,a0
 bac:	41f0 38ff      	lea (-1,a0,d3.l),a0
 bb0:	2608           	move.l a0,d3
 bb2:	4eae fece      	jsr -306(a6)
		for (int x = 1; x < GameMatrix.Columns-1; x++)
 bb6:	528a           	addq.l #1,a2
 bb8:	3239 0000 323a 	move.w 323a <GameMatrix+0xa>,d1
 bbe:	5884           	addq.l #4,d4
 bc0:	7000           	moveq #0,d0
 bc2:	3001           	move.w d1,d0
 bc4:	5380           	subq.l #1,d0
 bc6:	b08a           	cmp.l a2,d0
 bc8:	6e00 fec8      	bgt.w a92 <DrawCells.constprop.1+0x4e>
 bcc:	6000 ff5c      	bra.w b2a <DrawCells.constprop.1+0xe6>

00000bd0 <memset.constprop.0>:
	void* memset(void *dest, int val, unsigned long len)
 bd0:	2f0a           	move.l a2,-(sp)
 bd2:	2f02           	move.l d2,-(sp)
 bd4:	202f 000c      	move.l 12(sp),d0
 bd8:	206f 0014      	movea.l 20(sp),a0
	while(len-- > 0)
 bdc:	43e8 ffff      	lea -1(a0),a1
 be0:	b0fc 0000      	cmpa.w #0,a0
 be4:	6700 0096      	beq.w c7c <memset.constprop.0+0xac>
 be8:	2200           	move.l d0,d1
 bea:	4481           	neg.l d1
 bec:	7403           	moveq #3,d2
 bee:	c282           	and.l d2,d1
 bf0:	7405           	moveq #5,d2
		*ptr++ = val;
 bf2:	2440           	movea.l d0,a2
 bf4:	b489           	cmp.l a1,d2
 bf6:	6450           	bcc.s c48 <memset.constprop.0+0x78>
 bf8:	4a81           	tst.l d1
 bfa:	672c           	beq.s c28 <memset.constprop.0+0x58>
 bfc:	421a           	clr.b (a2)+
	while(len-- > 0)
 bfe:	43e8 fffe      	lea -2(a0),a1
 c02:	7401           	moveq #1,d2
 c04:	b481           	cmp.l d1,d2
 c06:	6720           	beq.s c28 <memset.constprop.0+0x58>
		*ptr++ = val;
 c08:	2440           	movea.l d0,a2
 c0a:	548a           	addq.l #2,a2
 c0c:	2240           	movea.l d0,a1
 c0e:	4229 0001      	clr.b 1(a1)
	while(len-- > 0)
 c12:	43e8 fffd      	lea -3(a0),a1
 c16:	7403           	moveq #3,d2
 c18:	b481           	cmp.l d1,d2
 c1a:	660c           	bne.s c28 <memset.constprop.0+0x58>
		*ptr++ = val;
 c1c:	528a           	addq.l #1,a2
 c1e:	2240           	movea.l d0,a1
 c20:	4229 0002      	clr.b 2(a1)
	while(len-- > 0)
 c24:	43e8 fffc      	lea -4(a0),a1
 c28:	2408           	move.l a0,d2
 c2a:	9481           	sub.l d1,d2
 c2c:	2040           	movea.l d0,a0
 c2e:	d1c1           	adda.l d1,a0
 c30:	72fc           	moveq #-4,d1
 c32:	c282           	and.l d2,d1
 c34:	d288           	add.l a0,d1
		*ptr++ = val;
 c36:	4298           	clr.l (a0)+
 c38:	b1c1           	cmpa.l d1,a0
 c3a:	66fa           	bne.s c36 <memset.constprop.0+0x66>
 c3c:	72fc           	moveq #-4,d1
 c3e:	c282           	and.l d2,d1
 c40:	d5c1           	adda.l d1,a2
 c42:	93c1           	suba.l d1,a1
 c44:	b282           	cmp.l d2,d1
 c46:	6734           	beq.s c7c <memset.constprop.0+0xac>
 c48:	4212           	clr.b (a2)
	while(len-- > 0)
 c4a:	b2fc 0000      	cmpa.w #0,a1
 c4e:	672c           	beq.s c7c <memset.constprop.0+0xac>
		*ptr++ = val;
 c50:	422a 0001      	clr.b 1(a2)
	while(len-- > 0)
 c54:	7201           	moveq #1,d1
 c56:	b289           	cmp.l a1,d1
 c58:	6722           	beq.s c7c <memset.constprop.0+0xac>
		*ptr++ = val;
 c5a:	422a 0002      	clr.b 2(a2)
	while(len-- > 0)
 c5e:	7402           	moveq #2,d2
 c60:	b489           	cmp.l a1,d2
 c62:	6718           	beq.s c7c <memset.constprop.0+0xac>
		*ptr++ = val;
 c64:	422a 0003      	clr.b 3(a2)
	while(len-- > 0)
 c68:	7203           	moveq #3,d1
 c6a:	b289           	cmp.l a1,d1
 c6c:	670e           	beq.s c7c <memset.constprop.0+0xac>
		*ptr++ = val;
 c6e:	422a 0004      	clr.b 4(a2)
	while(len-- > 0)
 c72:	7404           	moveq #4,d2
 c74:	b489           	cmp.l a1,d2
 c76:	6704           	beq.s c7c <memset.constprop.0+0xac>
		*ptr++ = val;
 c78:	422a 0005      	clr.b 5(a2)
}
 c7c:	241f           	move.l (sp)+,d2
 c7e:	245f           	movea.l (sp)+,a2
 c80:	4e75           	rts

00000c82 <strlen>:
{
 c82:	206f 0004      	movea.l 4(sp),a0
	unsigned long t=0;
 c86:	7000           	moveq #0,d0
	while(*s++)
 c88:	4a10           	tst.b (a0)
 c8a:	6708           	beq.s c94 <strlen+0x12>
		t++;
 c8c:	5280           	addq.l #1,d0
	while(*s++)
 c8e:	4a30 0800      	tst.b (0,a0,d0.l)
 c92:	66f8           	bne.s c8c <strlen+0xa>
}
 c94:	4e75           	rts

00000c96 <memset>:
{
 c96:	48e7 3f30      	movem.l d2-d7/a2-a3,-(sp)
 c9a:	202f 0024      	move.l 36(sp),d0
 c9e:	282f 0028      	move.l 40(sp),d4
 ca2:	226f 002c      	movea.l 44(sp),a1
	while(len-- > 0)
 ca6:	2a09           	move.l a1,d5
 ca8:	5385           	subq.l #1,d5
 caa:	b2fc 0000      	cmpa.w #0,a1
 cae:	6700 00ae      	beq.w d5e <memset+0xc8>
		*ptr++ = val;
 cb2:	1e04           	move.b d4,d7
 cb4:	2200           	move.l d0,d1
 cb6:	4481           	neg.l d1
 cb8:	7403           	moveq #3,d2
 cba:	c282           	and.l d2,d1
 cbc:	7c05           	moveq #5,d6
 cbe:	2440           	movea.l d0,a2
 cc0:	bc85           	cmp.l d5,d6
 cc2:	646a           	bcc.s d2e <memset+0x98>
 cc4:	4a81           	tst.l d1
 cc6:	6724           	beq.s cec <memset+0x56>
 cc8:	14c4           	move.b d4,(a2)+
	while(len-- > 0)
 cca:	5385           	subq.l #1,d5
 ccc:	7401           	moveq #1,d2
 cce:	b481           	cmp.l d1,d2
 cd0:	671a           	beq.s cec <memset+0x56>
		*ptr++ = val;
 cd2:	2440           	movea.l d0,a2
 cd4:	548a           	addq.l #2,a2
 cd6:	2040           	movea.l d0,a0
 cd8:	1144 0001      	move.b d4,1(a0)
	while(len-- > 0)
 cdc:	5385           	subq.l #1,d5
 cde:	7403           	moveq #3,d2
 ce0:	b481           	cmp.l d1,d2
 ce2:	6608           	bne.s cec <memset+0x56>
		*ptr++ = val;
 ce4:	528a           	addq.l #1,a2
 ce6:	1144 0002      	move.b d4,2(a0)
	while(len-- > 0)
 cea:	5385           	subq.l #1,d5
 cec:	2609           	move.l a1,d3
 cee:	9681           	sub.l d1,d3
 cf0:	7c00           	moveq #0,d6
 cf2:	1c04           	move.b d4,d6
 cf4:	2406           	move.l d6,d2
 cf6:	4842           	swap d2
 cf8:	4242           	clr.w d2
 cfa:	2042           	movea.l d2,a0
 cfc:	2404           	move.l d4,d2
 cfe:	e14a           	lsl.w #8,d2
 d00:	4842           	swap d2
 d02:	4242           	clr.w d2
 d04:	e18e           	lsl.l #8,d6
 d06:	2646           	movea.l d6,a3
 d08:	2c08           	move.l a0,d6
 d0a:	8486           	or.l d6,d2
 d0c:	2c0b           	move.l a3,d6
 d0e:	8486           	or.l d6,d2
 d10:	1407           	move.b d7,d2
 d12:	2040           	movea.l d0,a0
 d14:	d1c1           	adda.l d1,a0
 d16:	72fc           	moveq #-4,d1
 d18:	c283           	and.l d3,d1
 d1a:	d288           	add.l a0,d1
		*ptr++ = val;
 d1c:	20c2           	move.l d2,(a0)+
	while(len-- > 0)
 d1e:	b1c1           	cmpa.l d1,a0
 d20:	66fa           	bne.s d1c <memset+0x86>
 d22:	72fc           	moveq #-4,d1
 d24:	c283           	and.l d3,d1
 d26:	d5c1           	adda.l d1,a2
 d28:	9a81           	sub.l d1,d5
 d2a:	b283           	cmp.l d3,d1
 d2c:	6730           	beq.s d5e <memset+0xc8>
		*ptr++ = val;
 d2e:	1484           	move.b d4,(a2)
	while(len-- > 0)
 d30:	4a85           	tst.l d5
 d32:	672a           	beq.s d5e <memset+0xc8>
		*ptr++ = val;
 d34:	1544 0001      	move.b d4,1(a2)
	while(len-- > 0)
 d38:	7201           	moveq #1,d1
 d3a:	b285           	cmp.l d5,d1
 d3c:	6720           	beq.s d5e <memset+0xc8>
		*ptr++ = val;
 d3e:	1544 0002      	move.b d4,2(a2)
	while(len-- > 0)
 d42:	7402           	moveq #2,d2
 d44:	b485           	cmp.l d5,d2
 d46:	6716           	beq.s d5e <memset+0xc8>
		*ptr++ = val;
 d48:	1544 0003      	move.b d4,3(a2)
	while(len-- > 0)
 d4c:	7c03           	moveq #3,d6
 d4e:	bc85           	cmp.l d5,d6
 d50:	670c           	beq.s d5e <memset+0xc8>
		*ptr++ = val;
 d52:	1544 0004      	move.b d4,4(a2)
	while(len-- > 0)
 d56:	5985           	subq.l #4,d5
 d58:	6704           	beq.s d5e <memset+0xc8>
		*ptr++ = val;
 d5a:	1544 0005      	move.b d4,5(a2)
}
 d5e:	4cdf 0cfc      	movem.l (sp)+,d2-d7/a2-a3
 d62:	4e75           	rts

00000d64 <memcpy>:
{
 d64:	48e7 3e00      	movem.l d2-d6,-(sp)
 d68:	202f 0018      	move.l 24(sp),d0
 d6c:	222f 001c      	move.l 28(sp),d1
 d70:	262f 0020      	move.l 32(sp),d3
	while(len--)
 d74:	2803           	move.l d3,d4
 d76:	5384           	subq.l #1,d4
 d78:	4a83           	tst.l d3
 d7a:	675e           	beq.s dda <memcpy+0x76>
 d7c:	2041           	movea.l d1,a0
 d7e:	5288           	addq.l #1,a0
 d80:	2400           	move.l d0,d2
 d82:	9488           	sub.l a0,d2
 d84:	7a02           	moveq #2,d5
 d86:	ba82           	cmp.l d2,d5
 d88:	55c2           	sc.s d2
 d8a:	4402           	neg.b d2
 d8c:	7c08           	moveq #8,d6
 d8e:	bc84           	cmp.l d4,d6
 d90:	55c5           	sc.s d5
 d92:	4405           	neg.b d5
 d94:	c405           	and.b d5,d2
 d96:	6748           	beq.s de0 <memcpy+0x7c>
 d98:	2400           	move.l d0,d2
 d9a:	8481           	or.l d1,d2
 d9c:	7a03           	moveq #3,d5
 d9e:	c485           	and.l d5,d2
 da0:	663e           	bne.s de0 <memcpy+0x7c>
 da2:	2041           	movea.l d1,a0
 da4:	2240           	movea.l d0,a1
 da6:	74fc           	moveq #-4,d2
 da8:	c483           	and.l d3,d2
 daa:	d481           	add.l d1,d2
		*d++ = *s++;
 dac:	22d8           	move.l (a0)+,(a1)+
	while(len--)
 dae:	b488           	cmp.l a0,d2
 db0:	66fa           	bne.s dac <memcpy+0x48>
 db2:	74fc           	moveq #-4,d2
 db4:	c483           	and.l d3,d2
 db6:	2040           	movea.l d0,a0
 db8:	d1c2           	adda.l d2,a0
 dba:	d282           	add.l d2,d1
 dbc:	9882           	sub.l d2,d4
 dbe:	b483           	cmp.l d3,d2
 dc0:	6718           	beq.s dda <memcpy+0x76>
		*d++ = *s++;
 dc2:	2241           	movea.l d1,a1
 dc4:	1091           	move.b (a1),(a0)
	while(len--)
 dc6:	4a84           	tst.l d4
 dc8:	6710           	beq.s dda <memcpy+0x76>
		*d++ = *s++;
 dca:	1169 0001 0001 	move.b 1(a1),1(a0)
	while(len--)
 dd0:	5384           	subq.l #1,d4
 dd2:	6706           	beq.s dda <memcpy+0x76>
		*d++ = *s++;
 dd4:	1169 0002 0002 	move.b 2(a1),2(a0)
}
 dda:	4cdf 007c      	movem.l (sp)+,d2-d6
 dde:	4e75           	rts
 de0:	2240           	movea.l d0,a1
 de2:	d283           	add.l d3,d1
		*d++ = *s++;
 de4:	12e8 ffff      	move.b -1(a0),(a1)+
	while(len--)
 de8:	b288           	cmp.l a0,d1
 dea:	67ee           	beq.s dda <memcpy+0x76>
 dec:	5288           	addq.l #1,a0
 dee:	60f4           	bra.s de4 <memcpy+0x80>

00000df0 <memmove>:
{
 df0:	48e7 3c20      	movem.l d2-d5/a2,-(sp)
 df4:	202f 0018      	move.l 24(sp),d0
 df8:	222f 001c      	move.l 28(sp),d1
 dfc:	242f 0020      	move.l 32(sp),d2
		while (len--)
 e00:	2242           	movea.l d2,a1
 e02:	5389           	subq.l #1,a1
	if (d < s) {
 e04:	b280           	cmp.l d0,d1
 e06:	636c           	bls.s e74 <memmove+0x84>
		while (len--)
 e08:	4a82           	tst.l d2
 e0a:	6762           	beq.s e6e <memmove+0x7e>
 e0c:	2441           	movea.l d1,a2
 e0e:	528a           	addq.l #1,a2
 e10:	2600           	move.l d0,d3
 e12:	968a           	sub.l a2,d3
 e14:	7802           	moveq #2,d4
 e16:	b883           	cmp.l d3,d4
 e18:	55c3           	sc.s d3
 e1a:	4403           	neg.b d3
 e1c:	7a08           	moveq #8,d5
 e1e:	ba89           	cmp.l a1,d5
 e20:	55c4           	sc.s d4
 e22:	4404           	neg.b d4
 e24:	c604           	and.b d4,d3
 e26:	6770           	beq.s e98 <memmove+0xa8>
 e28:	2600           	move.l d0,d3
 e2a:	8681           	or.l d1,d3
 e2c:	7803           	moveq #3,d4
 e2e:	c684           	and.l d4,d3
 e30:	6666           	bne.s e98 <memmove+0xa8>
 e32:	2041           	movea.l d1,a0
 e34:	2440           	movea.l d0,a2
 e36:	76fc           	moveq #-4,d3
 e38:	c682           	and.l d2,d3
 e3a:	d681           	add.l d1,d3
			*d++ = *s++;
 e3c:	24d8           	move.l (a0)+,(a2)+
		while (len--)
 e3e:	b688           	cmp.l a0,d3
 e40:	66fa           	bne.s e3c <memmove+0x4c>
 e42:	76fc           	moveq #-4,d3
 e44:	c682           	and.l d2,d3
 e46:	2440           	movea.l d0,a2
 e48:	d5c3           	adda.l d3,a2
 e4a:	2041           	movea.l d1,a0
 e4c:	d1c3           	adda.l d3,a0
 e4e:	93c3           	suba.l d3,a1
 e50:	b682           	cmp.l d2,d3
 e52:	671a           	beq.s e6e <memmove+0x7e>
			*d++ = *s++;
 e54:	1490           	move.b (a0),(a2)
		while (len--)
 e56:	b2fc 0000      	cmpa.w #0,a1
 e5a:	6712           	beq.s e6e <memmove+0x7e>
			*d++ = *s++;
 e5c:	1568 0001 0001 	move.b 1(a0),1(a2)
		while (len--)
 e62:	7a01           	moveq #1,d5
 e64:	ba89           	cmp.l a1,d5
 e66:	6706           	beq.s e6e <memmove+0x7e>
			*d++ = *s++;
 e68:	1568 0002 0002 	move.b 2(a0),2(a2)
}
 e6e:	4cdf 043c      	movem.l (sp)+,d2-d5/a2
 e72:	4e75           	rts
		const char *lasts = s + (len - 1);
 e74:	41f1 1800      	lea (0,a1,d1.l),a0
		char *lastd = d + (len - 1);
 e78:	d3c0           	adda.l d0,a1
		while (len--)
 e7a:	4a82           	tst.l d2
 e7c:	67f0           	beq.s e6e <memmove+0x7e>
 e7e:	2208           	move.l a0,d1
 e80:	9282           	sub.l d2,d1
			*lastd-- = *lasts--;
 e82:	1290           	move.b (a0),(a1)
		while (len--)
 e84:	5388           	subq.l #1,a0
 e86:	5389           	subq.l #1,a1
 e88:	b288           	cmp.l a0,d1
 e8a:	67e2           	beq.s e6e <memmove+0x7e>
			*lastd-- = *lasts--;
 e8c:	1290           	move.b (a0),(a1)
		while (len--)
 e8e:	5388           	subq.l #1,a0
 e90:	5389           	subq.l #1,a1
 e92:	b288           	cmp.l a0,d1
 e94:	66ec           	bne.s e82 <memmove+0x92>
 e96:	60d6           	bra.s e6e <memmove+0x7e>
 e98:	2240           	movea.l d0,a1
 e9a:	d282           	add.l d2,d1
			*d++ = *s++;
 e9c:	12ea ffff      	move.b -1(a2),(a1)+
		while (len--)
 ea0:	b28a           	cmp.l a2,d1
 ea2:	67ca           	beq.s e6e <memmove+0x7e>
 ea4:	528a           	addq.l #1,a2
 ea6:	60f4           	bra.s e9c <memmove+0xac>

00000ea8 <__mulsi3>:
	.text
	FUNC(__mulsi3)
	.globl	SYM (__mulsi3)
SYM (__mulsi3):
	.cfi_startproc
	movew	sp@(4), d0	/* x0 -> d0 */
 ea8:	302f 0004      	move.w 4(sp),d0
	muluw	sp@(10), d0	/* x0*y1 */
 eac:	c0ef 000a      	mulu.w 10(sp),d0
	movew	sp@(6), d1	/* x1 -> d1 */
 eb0:	322f 0006      	move.w 6(sp),d1
	muluw	sp@(8), d1	/* x1*y0 */
 eb4:	c2ef 0008      	mulu.w 8(sp),d1
	addw	d1, d0
 eb8:	d041           	add.w d1,d0
	swap	d0
 eba:	4840           	swap d0
	clrw	d0
 ebc:	4240           	clr.w d0
	movew	sp@(6), d1	/* x1 -> d1 */
 ebe:	322f 0006      	move.w 6(sp),d1
	muluw	sp@(10), d1	/* x1*y1 */
 ec2:	c2ef 000a      	mulu.w 10(sp),d1
	addl	d1, d0
 ec6:	d081           	add.l d1,d0
	rts
 ec8:	4e75           	rts

00000eca <__udivsi3>:
	.text
	FUNC(__udivsi3)
	.globl	SYM (__udivsi3)
SYM (__udivsi3):
	.cfi_startproc
	movel	d2, sp@-
 eca:	2f02           	move.l d2,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	sp@(12), d1	/* d1 = divisor */
 ecc:	222f 000c      	move.l 12(sp),d1
	movel	sp@(8), d0	/* d0 = dividend */
 ed0:	202f 0008      	move.l 8(sp),d0

	cmpl	IMM (0x10000), d1 /* divisor >= 2 ^ 16 ?   */
 ed4:	0c81 0001 0000 	cmpi.l #65536,d1
	jcc	3f		/* then try next algorithm */
 eda:	6416           	bcc.s ef2 <__udivsi3+0x28>
	movel	d0, d2
 edc:	2400           	move.l d0,d2
	clrw	d2
 ede:	4242           	clr.w d2
	swap	d2
 ee0:	4842           	swap d2
	divu	d1, d2          /* high quotient in lower word */
 ee2:	84c1           	divu.w d1,d2
	movew	d2, d0		/* save high quotient */
 ee4:	3002           	move.w d2,d0
	swap	d0
 ee6:	4840           	swap d0
	movew	sp@(10), d2	/* get low dividend + high rest */
 ee8:	342f 000a      	move.w 10(sp),d2
	divu	d1, d2		/* low quotient */
 eec:	84c1           	divu.w d1,d2
	movew	d2, d0
 eee:	3002           	move.w d2,d0
	jra	6f
 ef0:	6030           	bra.s f22 <__udivsi3+0x58>

3:	movel	d1, d2		/* use d2 as divisor backup */
 ef2:	2401           	move.l d1,d2
4:	lsrl	IMM (1), d1	/* shift divisor */
 ef4:	e289           	lsr.l #1,d1
	lsrl	IMM (1), d0	/* shift dividend */
 ef6:	e288           	lsr.l #1,d0
	cmpl	IMM (0x10000), d1 /* still divisor >= 2 ^ 16 ?  */
 ef8:	0c81 0001 0000 	cmpi.l #65536,d1
	jcc	4b
 efe:	64f4           	bcc.s ef4 <__udivsi3+0x2a>
	divu	d1, d0		/* now we have 16-bit divisor */
 f00:	80c1           	divu.w d1,d0
	andl	IMM (0xffff), d0 /* mask out divisor, ignore remainder */
 f02:	0280 0000 ffff 	andi.l #65535,d0

/* Multiply the 16-bit tentative quotient with the 32-bit divisor.  Because of
   the operand ranges, this might give a 33-bit product.  If this product is
   greater than the dividend, the tentative quotient was too large. */
	movel	d2, d1
 f08:	2202           	move.l d2,d1
	mulu	d0, d1		/* low part, 32 bits */
 f0a:	c2c0           	mulu.w d0,d1
	swap	d2
 f0c:	4842           	swap d2
	mulu	d0, d2		/* high part, at most 17 bits */
 f0e:	c4c0           	mulu.w d0,d2
	swap	d2		/* align high part with low part */
 f10:	4842           	swap d2
	tstw	d2		/* high part 17 bits? */
 f12:	4a42           	tst.w d2
	jne	5f		/* if 17 bits, quotient was too large */
 f14:	660a           	bne.s f20 <__udivsi3+0x56>
	addl	d2, d1		/* add parts */
 f16:	d282           	add.l d2,d1
	jcs	5f		/* if sum is 33 bits, quotient was too large */
 f18:	6506           	bcs.s f20 <__udivsi3+0x56>
	cmpl	sp@(8), d1	/* compare the sum with the dividend */
 f1a:	b2af 0008      	cmp.l 8(sp),d1
	jls	6f		/* if sum > dividend, quotient was too large */
 f1e:	6302           	bls.s f22 <__udivsi3+0x58>
5:	subql	IMM (1), d0	/* adjust quotient */
 f20:	5380           	subq.l #1,d0

6:	movel	sp@+, d2
 f22:	241f           	move.l (sp)+,d2
	.cfi_adjust_cfa_offset -4
	rts
 f24:	4e75           	rts

00000f26 <__divsi3>:
	.text
	FUNC(__divsi3)
	.globl	SYM (__divsi3)
SYM (__divsi3):
	.cfi_startproc
	movel	d2, sp@-
 f26:	2f02           	move.l d2,-(sp)
	.cfi_adjust_cfa_offset 4

	moveq	IMM (1), d2	/* sign of result stored in d2 (=1 or =-1) */
 f28:	7401           	moveq #1,d2
	movel	sp@(12), d1	/* d1 = divisor */
 f2a:	222f 000c      	move.l 12(sp),d1
	jpl	1f
 f2e:	6a04           	bpl.s f34 <__divsi3+0xe>
	negl	d1
 f30:	4481           	neg.l d1
	negb	d2		/* change sign because divisor <0  */
 f32:	4402           	neg.b d2
1:	movel	sp@(8), d0	/* d0 = dividend */
 f34:	202f 0008      	move.l 8(sp),d0
	jpl	2f
 f38:	6a04           	bpl.s f3e <__divsi3+0x18>
	negl	d0
 f3a:	4480           	neg.l d0
	negb	d2
 f3c:	4402           	neg.b d2

2:	movel	d1, sp@-
 f3e:	2f01           	move.l d1,-(sp)
	movel	d0, sp@-
 f40:	2f00           	move.l d0,-(sp)
	PICCALL	SYM (__udivsi3)	/* divide abs(dividend) by abs(divisor) */
 f42:	6186           	bsr.s eca <__udivsi3>
	addql	IMM (8), sp
 f44:	508f           	addq.l #8,sp

	tstb	d2
 f46:	4a02           	tst.b d2
	jpl	3f
 f48:	6a02           	bpl.s f4c <__divsi3+0x26>
	negl	d0
 f4a:	4480           	neg.l d0

3:	movel	sp@+, d2
 f4c:	241f           	move.l (sp)+,d2
	.cfi_adjust_cfa_offset -4
	rts
 f4e:	4e75           	rts

00000f50 <__modsi3>:
	.text
	FUNC(__modsi3)
	.globl	SYM (__modsi3)
SYM (__modsi3):
	.cfi_startproc
	movel	sp@(8), d1	/* d1 = divisor */
 f50:	222f 0008      	move.l 8(sp),d1
	movel	sp@(4), d0	/* d0 = dividend */
 f54:	202f 0004      	move.l 4(sp),d0
	movel	d1, sp@-
 f58:	2f01           	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
 f5a:	2f00           	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	PICCALL	SYM (__divsi3)
 f5c:	61c8           	bsr.s f26 <__divsi3>
	addql	IMM (8), sp
 f5e:	508f           	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(8), d1	/* d1 = divisor */
 f60:	222f 0008      	move.l 8(sp),d1
	movel	d1, sp@-
 f64:	2f01           	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
 f66:	2f00           	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	PICCALL	SYM (__mulsi3)	/* d0 = (a/b)*b */
 f68:	6100 ff3e      	bsr.w ea8 <__mulsi3>
	addql	IMM (8), sp
 f6c:	508f           	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(4), d1	/* d1 = dividend */
 f6e:	222f 0004      	move.l 4(sp),d1
	subl	d0, d1		/* d1 = a - (a/b)*b */
 f72:	9280           	sub.l d0,d1
	movel	d1, d0
 f74:	2001           	move.l d1,d0
	rts
 f76:	4e75           	rts

00000f78 <__umodsi3>:
	.text
	FUNC(__umodsi3)
	.globl	SYM (__umodsi3)
SYM (__umodsi3):
	.cfi_startproc
	movel	sp@(8), d1	/* d1 = divisor */
 f78:	222f 0008      	move.l 8(sp),d1
	movel	sp@(4), d0	/* d0 = dividend */
 f7c:	202f 0004      	move.l 4(sp),d0
	movel	d1, sp@-
 f80:	2f01           	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
 f82:	2f00           	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	PICCALL	SYM (__udivsi3)
 f84:	6100 ff44      	bsr.w eca <__udivsi3>
	addql	IMM (8), sp
 f88:	508f           	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(8), d1	/* d1 = divisor */
 f8a:	222f 0008      	move.l 8(sp),d1
	movel	d1, sp@-
 f8e:	2f01           	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
 f90:	2f00           	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	PICCALL	SYM (__mulsi3)	/* d0 = (a/b)*b */
 f92:	6100 ff14      	bsr.w ea8 <__mulsi3>
	addql	IMM (8), sp
 f96:	508f           	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(4), d1	/* d1 = dividend */
 f98:	222f 0004      	move.l 4(sp),d1
	subl	d0, d1		/* d1 = a - (a/b)*b */
 f9c:	9280           	sub.l d0,d1
	movel	d1, d0
 f9e:	2001           	move.l d1,d0
	rts
 fa0:	4e75           	rts

00000fa2 <KPutCharX>:
	FUNC(KPutCharX)
	.globl	SYM (KPutCharX)

SYM(KPutCharX):
	.cfi_startproc
    move.l  a6, -(sp)
 fa2:	2f0e           	move.l a6,-(sp)
	.cfi_adjust_cfa_offset 4
    move.l  4.w, a6
 fa4:	2c78 0004      	movea.l 4 <_start+0x4>,a6
    jsr     -0x204(a6)
 fa8:	4eae fdfc      	jsr -516(a6)
    movea.l (sp)+, a6
 fac:	2c5f           	movea.l (sp)+,a6
	.cfi_adjust_cfa_offset -4
    rts
 fae:	4e75           	rts

00000fb0 <PutChar>:
	FUNC(PutChar)
	.globl	SYM (PutChar)

SYM(PutChar):
	.cfi_startproc
	move.b d0, (a3)+
 fb0:	16c0           	move.b d0,(a3)+
	rts
 fb2:	4e75           	rts
