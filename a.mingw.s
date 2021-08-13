
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
       4:	263c 0000 3305 	move.l #13061,d3
       a:	0483 0000 3305 	subi.l #13061,d3
      10:	e483           	asr.l #2,d3
	for (i = 0; i < count; i++)
      12:	6712           	beq.s 26 <_start+0x26>
      14:	45f9 0000 3305 	lea 3305 <__fini_array_end>,a2
      1a:	7400           	moveq #0,d2
		__preinit_array_start[i]();
      1c:	205a           	movea.l (a2)+,a0
      1e:	4e90           	jsr (a0)
	for (i = 0; i < count; i++)
      20:	5282           	addq.l #1,d2
      22:	b483           	cmp.l d3,d2
      24:	66f6           	bne.s 1c <_start+0x1c>

	count = __init_array_end - __init_array_start;
      26:	263c 0000 3305 	move.l #13061,d3
      2c:	0483 0000 3305 	subi.l #13061,d3
      32:	e483           	asr.l #2,d3
	for (i = 0; i < count; i++)
      34:	6712           	beq.s 48 <_start+0x48>
      36:	45f9 0000 3305 	lea 3305 <__fini_array_end>,a2
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
      4e:	243c 0000 3305 	move.l #13061,d2
      54:	0482 0000 3305 	subi.l #13061,d2
      5a:	e482           	asr.l #2,d2
	for (i = count; i > 0; i--)
      5c:	6710           	beq.s 6e <_start+0x6e>
      5e:	45f9 0000 3305 	lea 3305 <__fini_array_end>,a2
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
#include "GameOfLife.h"
#include "GameOfLifeUI.h"
//backup

int main()
{
      74:	4fef ff44      	lea -188(sp),sp
      78:	48e7 3f3e      	movem.l d2-d7/a2-a6,-(sp)
	GameMatrix.ColorAlive = 4;
	GameMatrix.ColorDead = 7;
	GameMatrix.Columns = 40;
	GameMatrix.Rows = 20;
      7c:	23fc 0014 0028 	move.l #1310760,349c <GameMatrix+0x4>
      82:	0000 349c 
      86:	23fc 0004 0007 	move.l #262151,34a0 <GameMatrix+0x8>
      8c:	0000 34a0 
      90:	23fc 000b 000b 	move.l #720907,34a4 <GameMatrix+0xc>
      96:	0000 34a4 
	RETURN_OK;
}

int StartApp()
{
	SysBase = *((struct ExecBase **)4UL);
      9a:	2c78 0004      	movea.l 4 <_start+0x4>,a6
      9e:	23ce 0000 3488 	move.l a6,3488 <SysBase>
	custom = (struct Custom *)0xdff000;
	unsigned int pens[] = {~0};
      a4:	70ff           	moveq #-1,d0
      a6:	2f40 0040      	move.l d0,64(sp)

	APTR *my_VisualInfo;

	if ((DOSBase = (struct DosLibrary *)OpenLibrary((CONST_STRPTR) "dos.library", 0)))
      aa:	43f9 0000 121c 	lea 121c <PutChar+0x4>,a1
      b0:	7000           	moveq #0,d0
      b2:	4eae fdd8      	jsr -552(a6)
      b6:	23c0 0000 3474 	move.l d0,3474 <DOSBase>
      bc:	6700 0580      	beq.w 63e <main+0x5ca>
	{
		if ((GfxBase = (struct GfxBase *)OpenLibrary((CONST_STRPTR) "graphics.library", 0)))
      c0:	2c79 0000 3488 	movea.l 3488 <SysBase>,a6
      c6:	43f9 0000 1228 	lea 1228 <PutChar+0x10>,a1
      cc:	7000           	moveq #0,d0
      ce:	4eae fdd8      	jsr -552(a6)
      d2:	23c0 0000 3480 	move.l d0,3480 <GfxBase>
      d8:	6700 0564      	beq.w 63e <main+0x5ca>
		{
			if ((IntuitionBase = (struct IntuitionBase *)OpenLibrary((CONST_STRPTR) "intuition.library", 0)))
      dc:	2c79 0000 3488 	movea.l 3488 <SysBase>,a6
      e2:	43f9 0000 1239 	lea 1239 <PutChar+0x21>,a1
      e8:	7000           	moveq #0,d0
      ea:	4eae fdd8      	jsr -552(a6)
      ee:	2c40           	movea.l d0,a6
      f0:	23c0 0000 3484 	move.l d0,3484 <IntuitionBase>
      f6:	6700 0546      	beq.w 63e <main+0x5ca>
			{
				if ((GolScreen = (struct Screen *)OpenScreenTags(NULL,
      fa:	2f7c 8000 003a 	move.l #-2147483590,68(sp)
     100:	0044 
     102:	7440           	moveq #64,d2
     104:	d48f           	add.l sp,d2
     106:	2f42 0048      	move.l d2,72(sp)
     10a:	2f7c 8000 0032 	move.l #-2147483598,76(sp)
     110:	004c 
     112:	2f7c 0000 8000 	move.l #32768,80(sp)
     118:	0050 
     11a:	2f7c 8000 0025 	move.l #-2147483611,84(sp)
     120:	0054 
     122:	7604           	moveq #4,d3
     124:	2f43 0058      	move.l d3,88(sp)
     128:	2f7c 8000 0028 	move.l #-2147483608,92(sp)
     12e:	005c 
     130:	2f7c 0000 124b 	move.l #4683,96(sp)
     136:	0060 
     138:	2f7c 8000 002d 	move.l #-2147483603,100(sp)
     13e:	0064 
     140:	7c0f           	moveq #15,d6
     142:	2f46 0068      	move.l d6,104(sp)
     146:	2f7c 8000 0026 	move.l #-2147483610,108(sp)
     14c:	006c 
     14e:	2f43 0070      	move.l d3,112(sp)
     152:	2f7c 8000 0027 	move.l #-2147483609,116(sp)
     158:	0074 
     15a:	7e08           	moveq #8,d7
     15c:	2f47 0078      	move.l d7,120(sp)
     160:	42af 007c      	clr.l 124(sp)
     164:	91c8           	suba.l a0,a0
     166:	43ef 0044      	lea 68(sp),a1
     16a:	4eae fd9c      	jsr -612(a6)
     16e:	23c0 0000 3478 	move.l d0,3478 <GolScreen>
     174:	6700 04c8      	beq.w 63e <main+0x5ca>
																 SA_DetailPen, 4,
																 SA_BlockPen, 8,
																 TAG_END)))
				{

					if ((GadToolsBase = (struct Library *)OpenLibrary((CONST_STRPTR) "gadtools.library", 0)))
     178:	2c79 0000 3488 	movea.l 3488 <SysBase>,a6
     17e:	43f9 0000 1263 	lea 1263 <PutChar+0x4b>,a1
     184:	7000           	moveq #0,d0
     186:	4eae fdd8      	jsr -552(a6)
     18a:	23c0 0000 347c 	move.l d0,347c <GadToolsBase>
     190:	6700 04ac      	beq.w 63e <main+0x5ca>
					{
						if ((GolMainWindow = (struct Window *)OpenWindowTags(NULL,
     194:	2f7c 8000 0070 	move.l #-2147483536,68(sp)
     19a:	0044 
     19c:	2f79 0000 3478 	move.l 3478 <GolScreen>,72(sp)
     1a2:	0048 
     1a4:	2f7c 8000 0064 	move.l #-2147483548,76(sp)
     1aa:	004c 
     1ac:	42af 0050      	clr.l 80(sp)
     1b0:	2f7c 8000 0065 	move.l #-2147483547,84(sp)
     1b6:	0054 
     1b8:	701e           	moveq #30,d0
     1ba:	2f40 0058      	move.l d0,88(sp)
     1be:	2f7c 8000 0066 	move.l #-2147483546,92(sp)
     1c4:	005c 
     1c6:	7464           	moveq #100,d2
     1c8:	2f42 0060      	move.l d2,96(sp)
     1cc:	2f7c 8000 0067 	move.l #-2147483545,100(sp)
     1d2:	0064 
     1d4:	2079 0000 3492 	movea.l 3492 <GolMainWindow>,a0
     1da:	3039 0000 34a6 	move.w 34a6 <GameMatrix+0xe>,d0
     1e0:	c0f9 0000 349c 	mulu.w 349c <GameMatrix+0x4>,d0
     1e6:	1228 0037      	move.b 55(a0),d1
     1ea:	4881           	ext.w d1
     1ec:	3401           	move.w d1,d2
     1ee:	48c2           	ext.l d2
     1f0:	2440           	movea.l d0,a2
     1f2:	43f2 2800      	lea (0,a2,d2.l),a1
     1f6:	1028 0039      	move.b 57(a0),d0
     1fa:	4880           	ext.w d0
     1fc:	43f1 0000      	lea (0,a1,d0.w),a1
     200:	2f49 0068      	move.l a1,104(sp)
     204:	2f7c 8000 0075 	move.l #-2147483531,108(sp)
     20a:	006c 
     20c:	2f7c 0000 0100 	move.l #256,112(sp)
     212:	0070 
     214:	2f7c 8000 0074 	move.l #-2147483532,116(sp)
     21a:	0074 
     21c:	2f7c 0000 0280 	move.l #640,120(sp)
     222:	0078 
     224:	2f7c 8000 006e 	move.l #-2147483538,124(sp)
     22a:	007c 
     22c:	2f7c 0000 1274 	move.l #4724,128(sp)
     232:	0080 
     234:	2f7c 8000 0083 	move.l #-2147483517,132(sp)
     23a:	0084 
     23c:	7601           	moveq #1,d3
     23e:	2f43 0088      	move.l d3,136(sp)
     242:	2f7c 8000 0084 	move.l #-2147483516,140(sp)
     248:	008c 
     24a:	2f43 0090      	move.l d3,144(sp)
     24e:	2f7c 8000 0081 	move.l #-2147483519,148(sp)
     254:	0094 
     256:	2f43 0098      	move.l d3,152(sp)
     25a:	2f7c 8000 0082 	move.l #-2147483518,156(sp)
     260:	009c 
     262:	2f43 00a0      	move.l d3,160(sp)
     266:	2f7c 8000 0091 	move.l #-2147483503,164(sp)
     26c:	00a4 
     26e:	2f43 00a8      	move.l d3,168(sp)
     272:	2f7c 8000 0086 	move.l #-2147483514,172(sp)
     278:	00ac 
     27a:	2f43 00b0      	move.l d3,176(sp)
     27e:	2f7c 8000 0093 	move.l #-2147483501,180(sp)
     284:	00b4 
     286:	2f43 00b8      	move.l d3,184(sp)
     28a:	2f7c 8000 0089 	move.l #-2147483511,188(sp)
     290:	00bc 
     292:	2f43 00c0      	move.l d3,192(sp)
     296:	2f7c 8000 006f 	move.l #-2147483537,196(sp)
     29c:	00c4 
     29e:	2f7c 0000 127c 	move.l #4732,200(sp)
     2a4:	00c8 
     2a6:	2f7c 8000 006a 	move.l #-2147483542,204(sp)
     2ac:	00cc 
     2ae:	2f7c 0000 031c 	move.l #796,208(sp)
     2b4:	00d0 
     2b6:	2f7c 8000 0068 	move.l #-2147483544,212(sp)
     2bc:	00d4 
     2be:	42af 00d8      	clr.l 216(sp)
     2c2:	2f7c 8000 0069 	move.l #-2147483543,220(sp)
     2c8:	00dc 
     2ca:	42af 00e0      	clr.l 224(sp)
     2ce:	42af 00e4      	clr.l 228(sp)
     2d2:	2c79 0000 3484 	movea.l 3484 <IntuitionBase>,a6
     2d8:	91c8           	suba.l a0,a0
     2da:	43ef 0044      	lea 68(sp),a1
     2de:	4eae fda2      	jsr -606(a6)
     2e2:	2040           	movea.l d0,a0
     2e4:	23c0 0000 3492 	move.l d0,3492 <GolMainWindow>
     2ea:	6700 0352      	beq.w 63e <main+0x5ca>
																			 WA_DetailPen, 0,
																			 WA_BlockPen, 0,
																			 TAG_END)))

						{
							WindowLimits(GolMainWindow,
     2ee:	3039 0000 34a4 	move.w 34a4 <GameMatrix+0xc>,d0
     2f4:	c0f9 0000 349e 	mulu.w 349e <GameMatrix+0x6>,d0
     2fa:	1228 0036      	move.b 54(a0),d1
     2fe:	4881           	ext.w d1
     300:	3401           	move.w d1,d2
     302:	48c2           	ext.l d2
     304:	2440           	movea.l d0,a2
     306:	43f2 2800      	lea (0,a2,d2.l),a1
     30a:	1028 0038      	move.b 56(a0),d0
     30e:	4880           	ext.w d0
     310:	43f1 0000      	lea (0,a1,d0.w),a1
     314:	2009           	move.l a1,d0
     316:	3239 0000 34a6 	move.w 34a6 <GameMatrix+0xe>,d1
     31c:	c2f9 0000 349c 	mulu.w 349c <GameMatrix+0x4>,d1
     322:	1428 0037      	move.b 55(a0),d2
     326:	4882           	ext.w d2
     328:	3602           	move.w d2,d3
     32a:	48c3           	ext.l d3
     32c:	2441           	movea.l d1,a2
     32e:	43f2 3800      	lea (0,a2,d3.l),a1
     332:	1228 0039      	move.b 57(a0),d1
     336:	4881           	ext.w d1
     338:	43f1 1000      	lea (0,a1,d1.w),a1
     33c:	2209           	move.l a1,d1
     33e:	2c79 0000 3484 	movea.l 3484 <IntuitionBase>,a6
     344:	2400           	move.l d0,d2
     346:	2609           	move.l a1,d3
     348:	4eae fec2      	jsr -318(a6)
										 GameMatrix.CellSizeH * GameMatrix.Columns + GolMainWindow->BorderLeft + GolMainWindow->BorderRight,
										 GameMatrix.CellSizeV * GameMatrix.Rows + GolMainWindow->BorderTop + GolMainWindow->BorderBottom,
										 GameMatrix.CellSizeH * GameMatrix.Columns + GolMainWindow->BorderLeft + GolMainWindow->BorderRight,
										 GameMatrix.CellSizeV * GameMatrix.Rows + GolMainWindow->BorderTop + GolMainWindow->BorderBottom);

							my_VisualInfo = GetVisualInfo(GolMainWindow->WScreen, TAG_END);
     34c:	42af 0044      	clr.l 68(sp)
     350:	2c79 0000 347c 	movea.l 347c <GadToolsBase>,a6
     356:	2079 0000 3492 	movea.l 3492 <GolMainWindow>,a0
     35c:	2068 002e      	movea.l 46(a0),a0
     360:	43ef 0044      	lea 68(sp),a1
     364:	4eae ff82      	jsr -126(a6)
     368:	2400           	move.l d0,d2
							MainMenuStrip = CreateMenus(GolMainMenu, TAG_END);
     36a:	42af 0044      	clr.l 68(sp)
     36e:	2c79 0000 347c 	movea.l 347c <GadToolsBase>,a6
     374:	41f9 0000 3308 	lea 3308 <GolMainMenu>,a0
     37a:	43ef 0044      	lea 68(sp),a1
     37e:	4eae ffd0      	jsr -48(a6)
     382:	2040           	movea.l d0,a0
     384:	23c0 0000 348e 	move.l d0,348e <MainMenuStrip>
							LayoutMenus(MainMenuStrip, my_VisualInfo, TAG_END);
     38a:	42af 0044      	clr.l 68(sp)
     38e:	2c79 0000 347c 	movea.l 347c <GadToolsBase>,a6
     394:	2242           	movea.l d2,a1
     396:	45ef 0044      	lea 68(sp),a2
     39a:	4eae ffbe      	jsr -66(a6)
							SetMenuStrip(GolMainWindow, MainMenuStrip);
     39e:	2c79 0000 3484 	movea.l 3484 <IntuitionBase>,a6
     3a4:	2079 0000 3492 	movea.l 3492 <GolMainWindow>,a0
     3aa:	2279 0000 348e 	movea.l 348e <MainMenuStrip>,a1
     3b0:	4eae fef8      	jsr -264(a6)
							//Allocate memory for the cell's data
							GameMatrix.Playfield = AllocMem(GameMatrix.Columns * sizeof(GameOfLifeCell *), MEMF_ANY | MEMF_CLEAR);
     3b4:	7000           	moveq #0,d0
     3b6:	3039 0000 349e 	move.w 349e <GameMatrix+0x6>,d0
     3bc:	2c79 0000 3488 	movea.l 3488 <SysBase>,a6
     3c2:	e588           	lsl.l #2,d0
     3c4:	7201           	moveq #1,d1
     3c6:	4841           	swap d1
     3c8:	4eae ff3a      	jsr -198(a6)
     3cc:	41f9 0000 3498 	lea 3498 <GameMatrix>,a0
     3d2:	2080           	move.l d0,(a0)
							for (int i = 0; i < GameMatrix.Columns; i++)
     3d4:	4a79 0000 349e 	tst.w 349e <GameMatrix+0x6>
     3da:	6740           	beq.s 41c <main+0x3a8>
     3dc:	7600           	moveq #0,d3
     3de:	7400           	moveq #0,d2
							{
								GameMatrix.Playfield[i] = AllocMem(GameMatrix.Rows * sizeof(GameOfLifeCell), MEMF_ANY | MEMF_CLEAR);
     3e0:	7801           	moveq #1,d4
     3e2:	4844           	swap d4
     3e4:	7200           	moveq #0,d1
     3e6:	3239 0000 349c 	move.w 349c <GameMatrix+0x4>,d1
     3ec:	2001           	move.l d1,d0
     3ee:	d081           	add.l d1,d0
     3f0:	d081           	add.l d1,d0
     3f2:	2c79 0000 3488 	movea.l 3488 <SysBase>,a6
     3f8:	d080           	add.l d0,d0
     3fa:	2204           	move.l d4,d1
     3fc:	4eae ff3a      	jsr -198(a6)
     400:	43f9 0000 3498 	lea 3498 <GameMatrix>,a1
     406:	2051           	movea.l (a1),a0
     408:	2180 3800      	move.l d0,(0,a0,d3.l)
							for (int i = 0; i < GameMatrix.Columns; i++)
     40c:	5282           	addq.l #1,d2
     40e:	5883           	addq.l #4,d3
     410:	7000           	moveq #0,d0
     412:	3039 0000 349e 	move.w 349e <GameMatrix+0x6>,d0
     418:	b082           	cmp.l d2,d0
     41a:	6ec8           	bgt.s 3e4 <main+0x370>
		EventLoop(GolMainWindow, MainMenuStrip);

		if (GameRunning)
			RunSimulation();

		DrawCells(GolMainWindow, FALSE);
     41c:	2679 0000 3492 	movea.l 3492 <GolMainWindow>,a3
     422:	2f0b           	move.l a3,-(sp)
     424:	4eb9 0000 0d90 	jsr d90 <DrawCells.constprop.0>
	while (AppRunning)
     42a:	588f           	addq.l #4,sp
     42c:	4a79 0000 3470 	tst.w 3470 <AppRunning>
     432:	6700 088a      	beq.w cbe <main+0xc4a>
		EventLoop(GolMainWindow, MainMenuStrip);
     436:	2f79 0000 348e 	move.l 348e <MainMenuStrip>,52(sp)
     43c:	0034 
	struct MenuItem *item;
	WORD coordX, coordY;
	int x, y;

	/* There may be more than one message, so keep processing messages until there are no more. */
	while ((message = (struct IntuiMessage *)GetMsg(theWindow->UserPort)))
     43e:	2c79 0000 3488 	movea.l 3488 <SysBase>,a6
     444:	206b 0056      	movea.l 86(a3),a0
     448:	4eae fe8c      	jsr -372(a6)
     44c:	2440           	movea.l d0,a2
     44e:	4a80           	tst.l d0
     450:	6700 00ce      	beq.w 520 <main+0x4ac>
	{
		/* Copy the necessary information from the message. */
		msg_class = message->Class;
     454:	242a 0014      	move.l 20(a2),d2
		msg_code = message->Code;
     458:	362a 0018      	move.w 24(a2),d3
		coordX = message->MouseX - theWindow->BorderLeft;
     45c:	382a 0020      	move.w 32(a2),d4
     460:	1a2b 0036      	move.b 54(a3),d5
		coordY = message->MouseY - theWindow->BorderTop;
     464:	3c2a 0022      	move.w 34(a2),d6
     468:	1e2b 0037      	move.b 55(a3),d7

		/* Reply as soon as possible. */
		ReplyMsg((struct Message *)message);
     46c:	2c79 0000 3488 	movea.l 3488 <SysBase>,a6
     472:	224a           	movea.l a2,a1
     474:	4eae fe86      	jsr -378(a6)

		/* Take the proper action in response to the message. */
		switch (msg_class)
     478:	7010           	moveq #16,d0
     47a:	b082           	cmp.l d2,d0
     47c:	67c0           	beq.s 43e <main+0x3ca>
     47e:	6500 01ca      	bcs.w 64a <main+0x5d6>
     482:	7004           	moveq #4,d0
     484:	b082           	cmp.l d2,d0
     486:	6700 01e0      	beq.w 668 <main+0x5f4>
     48a:	5182           	subq.l #8,d2
     48c:	66b0           	bne.s 43e <main+0x3ca>
			break;
		case IDCMP_REFRESHWINDOW: /* User pressed the close window gadget. */
			DrawCells(theWindow, TRUE);
			break;
		case IDCMP_MOUSEBUTTONS: /* The status of the mouse buttons has changed. */
			switch (msg_code)
     48e:	0c43 0068      	cmpi.w #104,d3
     492:	66aa           	bne.s 43e <main+0x3ca>
		coordX = message->MouseX - theWindow->BorderLeft;
     494:	4885           	ext.w d5
     496:	9845           	sub.w d5,d4
	SetDrMd(rport, JAM2);
}

void ToggleCellStatus(WORD coordX, WORD coordY)
{
	int x = coordX / GameMatrix.CellSizeH;
     498:	7000           	moveq #0,d0
     49a:	3039 0000 34a4 	move.w 34a4 <GameMatrix+0xc>,d0
     4a0:	2f00           	move.l d0,-(sp)
     4a2:	3044           	movea.w d4,a0
     4a4:	2f08           	move.l a0,-(sp)
     4a6:	4eb9 0000 118e 	jsr 118e <__divsi3>
     4ac:	508f           	addq.l #8,sp
     4ae:	2400           	move.l d0,d2
	int y = coordY / GameMatrix.CellSizeV;

	if (!(x < 0 || x > GameMatrix.Columns - 1 || y < 0 || y > GameMatrix.Rows))
     4b0:	7000           	moveq #0,d0
     4b2:	3039 0000 349e 	move.w 349e <GameMatrix+0x6>,d0
     4b8:	b082           	cmp.l d2,d0
     4ba:	6382           	bls.s 43e <main+0x3ca>
		coordY = message->MouseY - theWindow->BorderTop;
     4bc:	4887           	ext.w d7
     4be:	9c47           	sub.w d7,d6
	int y = coordY / GameMatrix.CellSizeV;
     4c0:	7000           	moveq #0,d0
     4c2:	3039 0000 34a6 	move.w 34a6 <GameMatrix+0xe>,d0
     4c8:	2f00           	move.l d0,-(sp)
     4ca:	3246           	movea.w d6,a1
     4cc:	2f09           	move.l a1,-(sp)
     4ce:	4eb9 0000 118e 	jsr 118e <__divsi3>
     4d4:	508f           	addq.l #8,sp
	if (!(x < 0 || x > GameMatrix.Columns - 1 || y < 0 || y > GameMatrix.Rows))
     4d6:	7200           	moveq #0,d1
     4d8:	3239 0000 349c 	move.w 349c <GameMatrix+0x4>,d1
     4de:	b280           	cmp.l d0,d1
     4e0:	6500 ff5c      	bcs.w 43e <main+0x3ca>
	{

		if (GameMatrix.Playfield[x][y].Status)
     4e4:	45f9 0000 3498 	lea 3498 <GameMatrix>,a2
     4ea:	2252           	movea.l (a2),a1
     4ec:	d482           	add.l d2,d2
     4ee:	d482           	add.l d2,d2
     4f0:	2040           	movea.l d0,a0
     4f2:	d1c0           	adda.l d0,a0
     4f4:	d1c0           	adda.l d0,a0
     4f6:	d1c8           	adda.l a0,a0
     4f8:	d1f1 2800      	adda.l (0,a1,d2.l),a0
     4fc:	4a50           	tst.w (a0)
     4fe:	6700 0874      	beq.w d74 <main+0xd00>
		{
			GameMatrix.Playfield[x][y].Status = 0;
     502:	4250           	clr.w (a0)
			GameMatrix.Playfield[x][y].StatusChanged = TRUE;
     504:	317c 0001 0002 	move.w #1,2(a0)
	while ((message = (struct IntuiMessage *)GetMsg(theWindow->UserPort)))
     50a:	2c79 0000 3488 	movea.l 3488 <SysBase>,a6
     510:	206b 0056      	movea.l 86(a3),a0
     514:	4eae fe8c      	jsr -372(a6)
     518:	2440           	movea.l d0,a2
     51a:	4a80           	tst.l d0
     51c:	6600 ff36      	bne.w 454 <main+0x3e0>
		if (GameRunning)
     520:	4a79 0000 348c 	tst.w 348c <GameRunning>
     526:	6700 fef4      	beq.w 41c <main+0x3a8>
	}
}

void RunSimulation()
{
	GameOfLifeCell **pf = GameMatrix.Playfield;
     52a:	43f9 0000 3498 	lea 3498 <GameMatrix>,a1
     530:	2851           	movea.l (a1),a4

	for (int y = 0; y < GameMatrix.Rows; y++)
     532:	7000           	moveq #0,d0
     534:	3039 0000 349c 	move.w 349c <GameMatrix+0x4>,d0
     53a:	2f40 003c      	move.l d0,60(sp)
     53e:	6700 fedc      	beq.w 41c <main+0x3a8>
	{
		for (int x = 0; x < GameMatrix.Columns; x++)
     542:	7e00           	moveq #0,d7
     544:	3e39 0000 349e 	move.w 349e <GameMatrix+0x6>,d7
     54a:	4a87           	tst.l d7
     54c:	6700 fece      	beq.w 41c <main+0x3a8>
     550:	2c07           	move.l d7,d6
     552:	5586           	subq.l #2,d6
     554:	7800           	moveq #0,d4
	for (int y = 0; y < GameMatrix.Rows; y++)
     556:	93c9           	suba.l a1,a1
						neighbours++;
					if (pf[x][y + 1].Status)
						neighbours++;
				}
			}
			else if (y > 0 && y < GameMatrix.Rows - 2) // rows between 1st and last
     558:	2c40           	movea.l d0,a6
     55a:	558e           	subq.l #2,a6
     55c:	2a06           	move.l d6,d5
		for (int x = 0; x < GameMatrix.Columns; x++)
     55e:	2604           	move.l d4,d3
     560:	5d83           	subq.l #6,d3
     562:	2404           	move.l d4,d2
     564:	5c84           	addq.l #6,d4
     566:	4a85           	tst.l d5
     568:	6e68           	bgt.s 5d2 <main+0x55e>
			else if (y > 0 && y < GameMatrix.Rows - 2) // rows between 1st and last
     56a:	7000           	moveq #0,d0
     56c:	2640           	movea.l d0,a3
     56e:	d7c0           	adda.l d0,a3
     570:	d7cb           	adda.l a3,a3
     572:	47f4 b800      	lea (0,a4,a3.l),a3
					if (pf[x][y + 1].Status)
     576:	205b           	movea.l (a3)+,a0
			if (y == 0) // 1st row
     578:	b2fc 0000      	cmpa.w #0,a1
     57c:	6600 041a      	bne.w 998 <main+0x924>
				if (x == 0) // 1st column
     580:	4a80           	tst.l d0
     582:	6600 0454      	bne.w 9d8 <main+0x964>
					if (pf[x + 1][y].Status)
     586:	246c 0004      	movea.l 4(a4),a2
     58a:	4a52           	tst.w (a2)
     58c:	56c1           	sne d1
     58e:	4881           	ext.w d1
     590:	4441           	neg.w d1
					if (pf[x + 1][y + 1].Status)
     592:	4a6a 0006      	tst.w 6(a2)
     596:	6702           	beq.s 59a <main+0x526>
						neighbours++;
     598:	5241           	addq.w #1,d1
					if (pf[x][y + 1].Status)
     59a:	2454           	movea.l (a4),a2
     59c:	4a6a 0006      	tst.w 6(a2)
     5a0:	6700 03ba      	beq.w 95c <main+0x8e8>
					if (pf[x - 1][y - 1].Status)
						neighbours++;
					if (pf[x - 1][y].Status)
						neighbours++;
					if (pf[x][y - 1].Status)
						neighbours++;
     5a4:	5241           	addq.w #1,d1
				}
			}

			if (!pf[x][y].Status && neighbours == 3)
     5a6:	d1c2           	adda.l d2,a0
     5a8:	4a50           	tst.w (a0)
     5aa:	6600 03b8      	bne.w 964 <main+0x8f0>
     5ae:	0c41 0003      	cmpi.w #3,d1
     5b2:	6700 03ce      	beq.w 982 <main+0x90e>
		for (int x = 0; x < GameMatrix.Columns; x++)
     5b6:	5280           	addq.l #1,d0
     5b8:	b087           	cmp.l d7,d0
     5ba:	6dba           	blt.s 576 <main+0x502>
	for (int y = 0; y < GameMatrix.Rows; y++)
     5bc:	5289           	addq.l #1,a1
     5be:	b3ef 003c      	cmpa.l 60(sp),a1
     5c2:	6700 fe58      	beq.w 41c <main+0x3a8>
		for (int x = 0; x < GameMatrix.Columns; x++)
     5c6:	2604           	move.l d4,d3
     5c8:	5d83           	subq.l #6,d3
     5ca:	2404           	move.l d4,d2
     5cc:	5c84           	addq.l #6,d4
     5ce:	4a85           	tst.l d5
     5d0:	6f98           	ble.s 56a <main+0x4f6>
     5d2:	2c07           	move.l d7,d6
     5d4:	ba87           	cmp.l d7,d5
     5d6:	6c02           	bge.s 5da <main+0x566>
     5d8:	2c05           	move.l d5,d6
     5da:	264c           	movea.l a4,a3
     5dc:	7000           	moveq #0,d0
     5de:	2f47 002c      	move.l d7,44(sp)
					if (pf[x][y + 1].Status)
     5e2:	205b           	movea.l (a3)+,a0
			if (y == 0) // 1st row
     5e4:	b2fc 0000      	cmpa.w #0,a1
     5e8:	6600 0534      	bne.w b1e <main+0xaaa>
				if (x == 0) // 1st column
     5ec:	4a80           	tst.l d0
     5ee:	6600 0598      	bne.w b88 <main+0xb14>
					if (pf[x + 1][y].Status)
     5f2:	246c 0004      	movea.l 4(a4),a2
     5f6:	4a52           	tst.w (a2)
     5f8:	56c1           	sne d1
     5fa:	4881           	ext.w d1
     5fc:	4441           	neg.w d1
					if (pf[x + 1][y + 1].Status)
     5fe:	4a6a 0006      	tst.w 6(a2)
     602:	6702           	beq.s 606 <main+0x592>
						neighbours++;
     604:	5241           	addq.w #1,d1
					if (pf[x][y + 1].Status)
     606:	2454           	movea.l (a4),a2
     608:	4a6a 0006      	tst.w 6(a2)
     60c:	6700 04d4      	beq.w ae2 <main+0xa6e>
						neighbours++;
     610:	5241           	addq.w #1,d1
			if (!pf[x][y].Status && neighbours == 3)
     612:	d1c2           	adda.l d2,a0
     614:	4a50           	tst.w (a0)
     616:	6600 04d2      	bne.w aea <main+0xa76>
     61a:	0c41 0003      	cmpi.w #3,d1
     61e:	6700 04e8      	beq.w b08 <main+0xa94>
		for (int x = 0; x < GameMatrix.Columns; x++)
     622:	5280           	addq.l #1,d0
     624:	bc80           	cmp.l d0,d6
     626:	6eba           	bgt.s 5e2 <main+0x56e>
     628:	2e2f 002c      	move.l 44(sp),d7
     62c:	be80           	cmp.l d0,d7
     62e:	6f8c           	ble.s 5bc <main+0x548>
     630:	2640           	movea.l d0,a3
     632:	d7c0           	adda.l d0,a3
     634:	d7cb           	adda.l a3,a3
     636:	47f4 b800      	lea (0,a4,a3.l),a3
     63a:	6000 ff3a      	bra.w 576 <main+0x502>
		return RETURN_FAIL;
     63e:	7014           	moveq #20,d0
}
     640:	4cdf 7cfc      	movem.l (sp)+,d2-d7/a2-a6
     644:	4fef 00bc      	lea 188(sp),sp
     648:	4e75           	rts
		switch (msg_class)
     64a:	0c82 0000 0100 	cmpi.l #256,d2
     650:	6700 0158      	beq.w 7aa <main+0x736>
     654:	0c82 0000 0200 	cmpi.l #512,d2
     65a:	6600 fde2      	bne.w 43e <main+0x3ca>
			AppRunning = FALSE;
     65e:	4279 0000 3470 	clr.w 3470 <AppRunning>
			break;
     664:	6000 fdd8      	bra.w 43e <main+0x3ca>
	for (int x = 0; x < GameMatrix.Columns; x++)
     668:	4a79 0000 349e 	tst.w 349e <GameMatrix+0x6>
     66e:	6700 fdce      	beq.w 43e <main+0x3ca>
		for (int y = 0; y < GameMatrix.Rows; y++)
     672:	3039 0000 349c 	move.w 349c <GameMatrix+0x4>,d0
     678:	7e00           	moveq #0,d7
	for (int x = 0; x < GameMatrix.Columns; x++)
     67a:	7c00           	moveq #0,d6
		for (int y = 0; y < GameMatrix.Rows; y++)
     67c:	4a40           	tst.w d0
     67e:	6700 fdbe      	beq.w 43e <main+0x3ca>
     682:	7a00           	moveq #0,d5
     684:	7800           	moveq #0,d4
			if (!GameMatrix.Playfield[x][y].StatusChanged && !forceFull)
     686:	43f9 0000 3498 	lea 3498 <GameMatrix>,a1
     68c:	2051           	movea.l (a1),a0
     68e:	2070 7800      	movea.l (0,a0,d7.l),a0
     692:	d1c5           	adda.l d5,a0
			GameMatrix.Playfield[x][y].StatusChanged = FALSE;
     694:	4268 0002      	clr.w 2(a0)
				SetAPen(theWindow->RPort, 24);
     698:	226b 0032      	movea.l 50(a3),a1
     69c:	2c79 0000 3480 	movea.l 3480 <GfxBase>,a6
			if (GameMatrix.Playfield[x][y].Status)
     6a2:	4a50           	tst.w (a0)
     6a4:	6700 008c      	beq.w 732 <main+0x6be>
				SetAPen(theWindow->RPort, 24);
     6a8:	7018           	moveq #24,d0
     6aa:	4eae feaa      	jsr -342(a6)
			RectFill(theWindow->RPort,
     6ae:	226b 0032      	movea.l 50(a3),a1
     6b2:	7400           	moveq #0,d2
     6b4:	3439 0000 34a4 	move.w 34a4 <GameMatrix+0xc>,d2
     6ba:	2f06           	move.l d6,-(sp)
     6bc:	2f02           	move.l d2,-(sp)
     6be:	2f49 0038      	move.l a1,56(sp)
     6c2:	4eb9 0000 1110 	jsr 1110 <__mulsi3>
     6c8:	508f           	addq.l #8,sp
     6ca:	2440           	movea.l d0,a2
     6cc:	4bea 0001      	lea 1(a2),a5
     6d0:	7000           	moveq #0,d0
     6d2:	3039 0000 34a6 	move.w 34a6 <GameMatrix+0xe>,d0
     6d8:	2840           	movea.l d0,a4
     6da:	2f04           	move.l d4,-(sp)
     6dc:	2f0c           	move.l a4,-(sp)
     6de:	4eb9 0000 1110 	jsr 1110 <__mulsi3>
     6e4:	508f           	addq.l #8,sp
     6e6:	2600           	move.l d0,d3
     6e8:	2c79 0000 3480 	movea.l 3480 <GfxBase>,a6
     6ee:	226f 0030      	movea.l 48(sp),a1
     6f2:	200d           	move.l a5,d0
     6f4:	2203           	move.l d3,d1
     6f6:	5281           	addq.l #1,d1
     6f8:	45f2 28ff      	lea (-1,a2,d2.l),a2
     6fc:	240a           	move.l a2,d2
     6fe:	49f4 38ff      	lea (-1,a4,d3.l),a4
     702:	260c           	move.l a4,d3
     704:	4eae fece      	jsr -306(a6)
		for (int y = 0; y < GameMatrix.Rows; y++)
     708:	5284           	addq.l #1,d4
     70a:	3039 0000 349c 	move.w 349c <GameMatrix+0x4>,d0
     710:	5c85           	addq.l #6,d5
     712:	7200           	moveq #0,d1
     714:	3200           	move.w d0,d1
     716:	b284           	cmp.l d4,d1
     718:	6e00 ff6c      	bgt.w 686 <main+0x612>
	for (int x = 0; x < GameMatrix.Columns; x++)
     71c:	5286           	addq.l #1,d6
     71e:	7200           	moveq #0,d1
     720:	3239 0000 349e 	move.w 349e <GameMatrix+0x6>,d1
     726:	b286           	cmp.l d6,d1
     728:	6f00 fd14      	ble.w 43e <main+0x3ca>
     72c:	5887           	addq.l #4,d7
     72e:	6000 ff4c      	bra.w 67c <main+0x608>
				SetAPen(theWindow->RPort, 16);
     732:	7010           	moveq #16,d0
     734:	4eae feaa      	jsr -342(a6)
			RectFill(theWindow->RPort,
     738:	226b 0032      	movea.l 50(a3),a1
     73c:	7400           	moveq #0,d2
     73e:	3439 0000 34a4 	move.w 34a4 <GameMatrix+0xc>,d2
     744:	2f06           	move.l d6,-(sp)
     746:	2f02           	move.l d2,-(sp)
     748:	2f49 0038      	move.l a1,56(sp)
     74c:	4eb9 0000 1110 	jsr 1110 <__mulsi3>
     752:	508f           	addq.l #8,sp
     754:	2440           	movea.l d0,a2
     756:	4bea 0001      	lea 1(a2),a5
     75a:	7000           	moveq #0,d0
     75c:	3039 0000 34a6 	move.w 34a6 <GameMatrix+0xe>,d0
     762:	2840           	movea.l d0,a4
     764:	2f04           	move.l d4,-(sp)
     766:	2f0c           	move.l a4,-(sp)
     768:	4eb9 0000 1110 	jsr 1110 <__mulsi3>
     76e:	508f           	addq.l #8,sp
     770:	2600           	move.l d0,d3
     772:	2c79 0000 3480 	movea.l 3480 <GfxBase>,a6
     778:	226f 0030      	movea.l 48(sp),a1
     77c:	200d           	move.l a5,d0
     77e:	2203           	move.l d3,d1
     780:	5281           	addq.l #1,d1
     782:	45f2 28ff      	lea (-1,a2,d2.l),a2
     786:	240a           	move.l a2,d2
     788:	49f4 38ff      	lea (-1,a4,d3.l),a4
     78c:	260c           	move.l a4,d3
     78e:	4eae fece      	jsr -306(a6)
		for (int y = 0; y < GameMatrix.Rows; y++)
     792:	5284           	addq.l #1,d4
     794:	3039 0000 349c 	move.w 349c <GameMatrix+0x4>,d0
     79a:	5c85           	addq.l #6,d5
     79c:	7200           	moveq #0,d1
     79e:	3200           	move.w d0,d1
     7a0:	b284           	cmp.l d4,d1
     7a2:	6e00 fee2      	bgt.w 686 <main+0x612>
     7a6:	6000 ff74      	bra.w 71c <main+0x6a8>
			menuNumber = message->Code;
     7aa:	342a 0018      	move.w 24(a2),d2
			while ((menuNumber != MENUNULL) && (AppRunning))
     7ae:	0c42 ffff      	cmpi.w #-1,d2
     7b2:	6700 fc8a      	beq.w 43e <main+0x3ca>
     7b6:	262f 0034      	move.l 52(sp),d3
     7ba:	4a79 0000 3470 	tst.w 3470 <AppRunning>
     7c0:	6700 fc7c      	beq.w 43e <main+0x3ca>
				item = ItemAddress(theMenu, menuNumber);
     7c4:	2c79 0000 3484 	movea.l 3484 <IntuitionBase>,a6
     7ca:	2043           	movea.l d3,a0
     7cc:	3002           	move.w d2,d0
     7ce:	4eae ff70      	jsr -144(a6)
     7d2:	2840           	movea.l d0,a4
				menuNum = MENUNUM(menuNumber);
     7d4:	3002           	move.w d2,d0
     7d6:	0240 001f      	andi.w #31,d0
				if ((menuNum == 0) && (itemNum == 5))
     7da:	6642           	bne.s 81e <main+0x7aa>
				itemNum = ITEMNUM(menuNumber);
     7dc:	3002           	move.w d2,d0
     7de:	ea48           	lsr.w #5,d0
     7e0:	0240 003f      	andi.w #63,d0
				if ((menuNum == 0) && (itemNum == 5))
     7e4:	0c40 0005      	cmpi.w #5,d0
     7e8:	6742           	beq.s 82c <main+0x7b8>
				if ((menuNum == 0) && (itemNum == 3) && (subNum == 2))
     7ea:	0c40 0003      	cmpi.w #3,d0
     7ee:	662e           	bne.s 81e <main+0x7aa>
				subNum = SUBNUM(menuNumber);
     7f0:	700b           	moveq #11,d0
     7f2:	e06a           	lsr.w d0,d2
				if ((menuNum == 0) && (itemNum == 3) && (subNum == 2))
     7f4:	0c42 0002      	cmpi.w #2,d2
     7f8:	6700 0090      	beq.w 88a <main+0x816>
				if ((menuNum == 0) && (itemNum == 3) && (subNum == 0))
     7fc:	4a42           	tst.w d2
     7fe:	6658           	bne.s 858 <main+0x7e4>
					SetWindowTitles(theWindow, (STRPTR) "Running", (STRPTR)-1);
     800:	2c79 0000 3484 	movea.l 3484 <IntuitionBase>,a6
     806:	204b           	movea.l a3,a0
     808:	43f9 0000 1295 	lea 1295 <PutChar+0x7d>,a1
     80e:	347c ffff      	movea.w #-1,a2
     812:	4eae feec      	jsr -276(a6)
					GameRunning = TRUE;
     816:	33fc 0001 0000 	move.w #1,348c <GameRunning>
     81c:	348c 
				menuNumber = item->NextSelect;
     81e:	342c 0020      	move.w 32(a4),d2
			while ((menuNumber != MENUNULL) && (AppRunning))
     822:	0c42 ffff      	cmpi.w #-1,d2
     826:	6692           	bne.s 7ba <main+0x746>
     828:	6000 fc14      	bra.w 43e <main+0x3ca>
					AppRunning = FALSE;
     82c:	4279 0000 3470 	clr.w 3470 <AppRunning>
					SetWindowTitles(theWindow, (STRPTR) "Running", (STRPTR)-1);
     832:	2c79 0000 3484 	movea.l 3484 <IntuitionBase>,a6
     838:	204b           	movea.l a3,a0
     83a:	43f9 0000 1295 	lea 1295 <PutChar+0x7d>,a1
     840:	347c ffff      	movea.w #-1,a2
     844:	4eae feec      	jsr -276(a6)
				menuNumber = item->NextSelect;
     848:	342c 0020      	move.w 32(a4),d2
			while ((menuNumber != MENUNULL) && (AppRunning))
     84c:	0c42 ffff      	cmpi.w #-1,d2
     850:	6600 ff68      	bne.w 7ba <main+0x746>
     854:	6000 fbe8      	bra.w 43e <main+0x3ca>
				if ((menuNum == 0) && (itemNum == 3) && (subNum == 1))
     858:	0c42 0001      	cmpi.w #1,d2
     85c:	66c0           	bne.s 81e <main+0x7aa>
					SetWindowTitles(theWindow, (STRPTR) "Stopped", (STRPTR)-1);
     85e:	2c79 0000 3484 	movea.l 3484 <IntuitionBase>,a6
     864:	204b           	movea.l a3,a0
     866:	43f9 0000 1274 	lea 1274 <PutChar+0x5c>,a1
     86c:	347c ffff      	movea.w #-1,a2
     870:	4eae feec      	jsr -276(a6)
					GameRunning = FALSE;
     874:	4279 0000 348c 	clr.w 348c <GameRunning>
				menuNumber = item->NextSelect;
     87a:	342c 0020      	move.w 32(a4),d2
			while ((menuNumber != MENUNULL) && (AppRunning))
     87e:	0c42 ffff      	cmpi.w #-1,d2
     882:	6600 ff36      	bne.w 7ba <main+0x746>
     886:	6000 fbb6      	bra.w 43e <main+0x3ca>
	for (int x = 0; x < GameMatrix.Columns; x++)
     88a:	3239 0000 349e 	move.w 349e <GameMatrix+0x6>,d1
     890:	678c           	beq.s 81e <main+0x7aa>
		for (int y = 0; y < GameMatrix.Rows; y++)
     892:	3439 0000 349c 	move.w 349c <GameMatrix+0x4>,d2
			GameMatrix.Playfield[x][y].Neighbours = 0;
     898:	41f9 0000 3498 	lea 3498 <GameMatrix>,a0
     89e:	2250           	movea.l (a0),a1
     8a0:	673c           	beq.s 8de <main+0x86a>
     8a2:	0281 0000 ffff 	andi.l #65535,d1
     8a8:	d281           	add.l d1,d1
     8aa:	d281           	add.l d1,d1
     8ac:	d289           	add.l a1,d1
     8ae:	0282 0000 ffff 	andi.l #65535,d2
     8b4:	2002           	move.l d2,d0
     8b6:	d082           	add.l d2,d0
     8b8:	d082           	add.l d2,d0
     8ba:	d080           	add.l d0,d0
		for (int y = 0; y < GameMatrix.Rows; y++)
     8bc:	2059           	movea.l (a1)+,a0
     8be:	2408           	move.l a0,d2
     8c0:	d480           	add.l d0,d2
			GameMatrix.Playfield[x][y].Neighbours = 0;
     8c2:	4268 0004      	clr.w 4(a0)
			GameMatrix.Playfield[x][y].Status = 0;
     8c6:	4250           	clr.w (a0)
			GameMatrix.Playfield[x][y].StatusChanged = TRUE;
     8c8:	317c 0001 0002 	move.w #1,2(a0)
		for (int y = 0; y < GameMatrix.Rows; y++)
     8ce:	5c88           	addq.l #6,a0
     8d0:	b1c2           	cmpa.l d2,a0
     8d2:	66ee           	bne.s 8c2 <main+0x84e>
	for (int x = 0; x < GameMatrix.Columns; x++)
     8d4:	b289           	cmp.l a1,d1
     8d6:	66e4           	bne.s 8bc <main+0x848>
     8d8:	3239 0000 349e 	move.w 349e <GameMatrix+0x6>,d1
     8de:	4a41           	tst.w d1
     8e0:	6700 ff3c      	beq.w 81e <main+0x7aa>
		for (int y = 0; y < GameMatrix.Rows; y++)
     8e4:	3439 0000 349c 	move.w 349c <GameMatrix+0x4>,d2
			GameMatrix.Playfield[x][y].Neighbours = 0;
     8ea:	41f9 0000 3498 	lea 3498 <GameMatrix>,a0
     8f0:	2250           	movea.l (a0),a1
     8f2:	6700 ff2a      	beq.w 81e <main+0x7aa>
     8f6:	0281 0000 ffff 	andi.l #65535,d1
     8fc:	d281           	add.l d1,d1
     8fe:	d281           	add.l d1,d1
     900:	d289           	add.l a1,d1
     902:	0282 0000 ffff 	andi.l #65535,d2
     908:	2002           	move.l d2,d0
     90a:	d082           	add.l d2,d0
     90c:	d082           	add.l d2,d0
     90e:	d080           	add.l d0,d0
		for (int y = 0; y < GameMatrix.Rows; y++)
     910:	2059           	movea.l (a1)+,a0
     912:	2408           	move.l a0,d2
     914:	d480           	add.l d0,d2
			GameMatrix.Playfield[x][y].Neighbours = 0;
     916:	4268 0004      	clr.w 4(a0)
			GameMatrix.Playfield[x][y].Status = 0;
     91a:	4250           	clr.w (a0)
			GameMatrix.Playfield[x][y].StatusChanged = TRUE;
     91c:	317c 0001 0002 	move.w #1,2(a0)
		for (int y = 0; y < GameMatrix.Rows; y++)
     922:	5c88           	addq.l #6,a0
     924:	b488           	cmp.l a0,d2
     926:	66ee           	bne.s 916 <main+0x8a2>
	for (int x = 0; x < GameMatrix.Columns; x++)
     928:	b289           	cmp.l a1,d1
     92a:	6700 fef2      	beq.w 81e <main+0x7aa>
		for (int y = 0; y < GameMatrix.Rows; y++)
     92e:	2059           	movea.l (a1)+,a0
     930:	2408           	move.l a0,d2
     932:	d480           	add.l d0,d2
     934:	60e0           	bra.s 916 <main+0x8a2>
				if (x == 0)
     936:	4a80           	tst.l d0
     938:	6600 00fa      	bne.w a34 <main+0x9c0>
					if (pf[x][y - 1].Status)
     93c:	2454           	movea.l (a4),a2
     93e:	4a72 3800      	tst.w (0,a2,d3.l)
     942:	56c1           	sne d1
     944:	4881           	ext.w d1
     946:	4441           	neg.w d1
					if (pf[x + 1][y - 1].Status)
     948:	246c 0004      	movea.l 4(a4),a2
     94c:	4a72 3800      	tst.w (0,a2,d3.l)
     950:	6702           	beq.s 954 <main+0x8e0>
						neighbours++;
     952:	5241           	addq.w #1,d1
					if (pf[x + 1][y].Status)
     954:	4a72 2800      	tst.w (0,a2,d2.l)
     958:	6600 fc4a      	bne.w 5a4 <main+0x530>
			if (!pf[x][y].Status && neighbours == 3)
     95c:	d1c2           	adda.l d2,a0
     95e:	4a50           	tst.w (a0)
     960:	6700 fc54      	beq.w 5b6 <main+0x542>
			{
				pf[x][y].Status = 1;
				pf[x][y].StatusChanged = TRUE;
				continue;
			}
			if (pf[x][y].Status && (neighbours < 2 || neighbours > 3))
     964:	5541           	subq.w #2,d1
     966:	0c41 0001      	cmpi.w #1,d1
     96a:	6300 fc4a      	bls.w 5b6 <main+0x542>
			{
				pf[x][y].Status = 0;
     96e:	4250           	clr.w (a0)
				pf[x][y].StatusChanged = TRUE;
     970:	317c 0001 0002 	move.w #1,2(a0)
		for (int x = 0; x < GameMatrix.Columns; x++)
     976:	5280           	addq.l #1,d0
     978:	b087           	cmp.l d7,d0
     97a:	6d00 fbfa      	blt.w 576 <main+0x502>
     97e:	6000 fc3c      	bra.w 5bc <main+0x548>
				pf[x][y].Status = 1;
     982:	30bc 0001      	move.w #1,(a0)
				pf[x][y].StatusChanged = TRUE;
     986:	317c 0001 0002 	move.w #1,2(a0)
		for (int x = 0; x < GameMatrix.Columns; x++)
     98c:	5280           	addq.l #1,d0
     98e:	b087           	cmp.l d7,d0
     990:	6d00 fbe4      	blt.w 576 <main+0x502>
     994:	6000 fc26      	bra.w 5bc <main+0x548>
			else if (y > 0 && y < GameMatrix.Rows - 2) // rows between 1st and last
     998:	bdc9           	cmpa.l a1,a6
     99a:	6f9a           	ble.s 936 <main+0x8c2>
				if (x == 0)
     99c:	4a80           	tst.l d0
     99e:	6600 00b8      	bne.w a58 <main+0x9e4>
					if (pf[x][y - 1].Status)
     9a2:	2454           	movea.l (a4),a2
     9a4:	4a72 3800      	tst.w (0,a2,d3.l)
     9a8:	56c1           	sne d1
     9aa:	4881           	ext.w d1
     9ac:	4441           	neg.w d1
					if (pf[x][y + 1].Status)
     9ae:	4a72 4800      	tst.w (0,a2,d4.l)
     9b2:	6702           	beq.s 9b6 <main+0x942>
						neighbours++;
     9b4:	5241           	addq.w #1,d1
					if (pf[x + 1][y].Status)
     9b6:	246c 0004      	movea.l 4(a4),a2
     9ba:	4a72 2800      	tst.w (0,a2,d2.l)
     9be:	6702           	beq.s 9c2 <main+0x94e>
						neighbours++;
     9c0:	5241           	addq.w #1,d1
					if (pf[x + 1][y + 1].Status)
     9c2:	4a72 4800      	tst.w (0,a2,d4.l)
     9c6:	6702           	beq.s 9ca <main+0x956>
						neighbours++;
     9c8:	5241           	addq.w #1,d1
					if (pf[x + 1][y - 1].Status)
     9ca:	4a72 3800      	tst.w (0,a2,d3.l)
     9ce:	6700 fbd6      	beq.w 5a6 <main+0x532>
						neighbours++;
     9d2:	5241           	addq.w #1,d1
     9d4:	6000 fbd0      	bra.w 5a6 <main+0x532>
				else if (x > 0 && x < GameMatrix.Columns - 2) // columns in between 1st and last
     9d8:	b085           	cmp.l d5,d0
     9da:	6c32           	bge.s a0e <main+0x99a>
					if (pf[x + 1][y].Status)
     9dc:	2453           	movea.l (a3),a2
     9de:	4a52           	tst.w (a2)
     9e0:	56c1           	sne d1
     9e2:	4881           	ext.w d1
     9e4:	4441           	neg.w d1
					if (pf[x + 1][y + 1].Status)
     9e6:	4a6a 0006      	tst.w 6(a2)
     9ea:	6702           	beq.s 9ee <main+0x97a>
						neighbours++;
     9ec:	5241           	addq.w #1,d1
					if (pf[x][y + 1].Status)
     9ee:	4a68 0006      	tst.w 6(a0)
     9f2:	6702           	beq.s 9f6 <main+0x982>
						neighbours++;
     9f4:	5241           	addq.w #1,d1
					if (pf[x - 1][y].Status)
     9f6:	246b fff8      	movea.l -8(a3),a2
     9fa:	4a52           	tst.w (a2)
     9fc:	6702           	beq.s a00 <main+0x98c>
						neighbours++;
     9fe:	5241           	addq.w #1,d1
					if (pf[x - 1][y + 1].Status)
     a00:	4a6a 0006      	tst.w 6(a2)
     a04:	6700 fba0      	beq.w 5a6 <main+0x532>
						neighbours++;
     a08:	5241           	addq.w #1,d1
     a0a:	6000 fb9a      	bra.w 5a6 <main+0x532>
					if (pf[x - 1][y].Status)
     a0e:	246b fff8      	movea.l -8(a3),a2
     a12:	4a52           	tst.w (a2)
     a14:	56c1           	sne d1
     a16:	4881           	ext.w d1
     a18:	4441           	neg.w d1
					if (pf[x - 1][y + 1].Status)
     a1a:	4a6a 0006      	tst.w 6(a2)
     a1e:	6702           	beq.s a22 <main+0x9ae>
						neighbours++;
     a20:	5241           	addq.w #1,d1
					if (pf[x][y + 1].Status)
     a22:	246b fffc      	movea.l -4(a3),a2
     a26:	4a6a 0006      	tst.w 6(a2)
     a2a:	6700 ff30      	beq.w 95c <main+0x8e8>
						neighbours++;
     a2e:	5241           	addq.w #1,d1
     a30:	6000 fb74      	bra.w 5a6 <main+0x532>
					if (pf[x - 1][y].Status)
     a34:	246b fff8      	movea.l -8(a3),a2
					if (pf[x - 1][y - 1].Status)
     a38:	4a72 3800      	tst.w (0,a2,d3.l)
     a3c:	56c1           	sne d1
     a3e:	4881           	ext.w d1
     a40:	4441           	neg.w d1
					if (pf[x - 1][y].Status)
     a42:	4a72 2800      	tst.w (0,a2,d2.l)
     a46:	6702           	beq.s a4a <main+0x9d6>
						neighbours++;
     a48:	5241           	addq.w #1,d1
					if (pf[x][y - 1].Status)
     a4a:	4a70 3800      	tst.w (0,a0,d3.l)
     a4e:	6700 ff0c      	beq.w 95c <main+0x8e8>
						neighbours++;
     a52:	5241           	addq.w #1,d1
     a54:	6000 fb50      	bra.w 5a6 <main+0x532>
					if (pf[x - 1][y].Status)
     a58:	246b fff8      	movea.l -8(a3),a2
					if (pf[x - 1][y - 1].Status)
     a5c:	3f72 3800 003a 	move.w (0,a2,d3.l),58(sp)
					if (pf[x - 1][y].Status)
     a62:	3f72 2800 0038 	move.w (0,a2,d2.l),56(sp)
					if (pf[x][y - 1].Status)
     a68:	3a70 3800      	movea.w (0,a0,d3.l),a5
					if (pf[x][y + 1].Status)
     a6c:	3f70 4800 0034 	move.w (0,a0,d4.l),52(sp)
				else if (x > 0 && x < GameMatrix.Columns - 2)
     a72:	b085           	cmp.l d5,d0
     a74:	6c00 0218      	bge.w c8e <main+0xc1a>
					if (pf[x][y + 1].Status)
     a78:	4a6f 0034      	tst.w 52(sp)
     a7c:	56c1           	sne d1
     a7e:	4881           	ext.w d1
     a80:	4441           	neg.w d1
					if (pf[x][y - 1].Status)
     a82:	4246           	clr.w d6
     a84:	bc4d           	cmp.w a5,d6
     a86:	6702           	beq.s a8a <main+0xa16>
						neighbours++;
     a88:	5241           	addq.w #1,d1
					if (pf[x + 1][y].Status)
     a8a:	2a53           	movea.l (a3),a5
     a8c:	4a75 2800      	tst.w (0,a5,d2.l)
     a90:	6702           	beq.s a94 <main+0xa20>
						neighbours++;
     a92:	5241           	addq.w #1,d1
					if (pf[x + 1][y - 1].Status)
     a94:	4a75 3800      	tst.w (0,a5,d3.l)
     a98:	6702           	beq.s a9c <main+0xa28>
						neighbours++;
     a9a:	5241           	addq.w #1,d1
					if (pf[x + 1][y + 1].Status)
     a9c:	4a75 4800      	tst.w (0,a5,d4.l)
     aa0:	6702           	beq.s aa4 <main+0xa30>
						neighbours++;
     aa2:	5241           	addq.w #1,d1
					if (pf[x - 1][y].Status)
     aa4:	4a6f 0038      	tst.w 56(sp)
     aa8:	6702           	beq.s aac <main+0xa38>
						neighbours++;
     aaa:	5241           	addq.w #1,d1
					if (pf[x - 1][y + 1].Status)
     aac:	4a72 4800      	tst.w (0,a2,d4.l)
     ab0:	6702           	beq.s ab4 <main+0xa40>
						neighbours++;
     ab2:	5241           	addq.w #1,d1
					if (pf[x - 1][y - 1].Status)
     ab4:	4a6f 003a      	tst.w 58(sp)
     ab8:	6700 faec      	beq.w 5a6 <main+0x532>
						neighbours++;
     abc:	5241           	addq.w #1,d1
     abe:	6000 fae6      	bra.w 5a6 <main+0x532>
					if (pf[x - 1][y].Status)
     ac2:	246b fff8      	movea.l -8(a3),a2
     ac6:	4a52           	tst.w (a2)
     ac8:	56c1           	sne d1
     aca:	4881           	ext.w d1
     acc:	4441           	neg.w d1
					if (pf[x - 1][y + 1].Status)
     ace:	4a6a 0006      	tst.w 6(a2)
     ad2:	6702           	beq.s ad6 <main+0xa62>
						neighbours++;
     ad4:	5241           	addq.w #1,d1
					if (pf[x][y + 1].Status)
     ad6:	246b fffc      	movea.l -4(a3),a2
     ada:	4a6a 0006      	tst.w 6(a2)
     ade:	6600 fb30      	bne.w 610 <main+0x59c>
			if (!pf[x][y].Status && neighbours == 3)
     ae2:	d1c2           	adda.l d2,a0
     ae4:	4a50           	tst.w (a0)
     ae6:	6700 fb3a      	beq.w 622 <main+0x5ae>
			if (pf[x][y].Status && (neighbours < 2 || neighbours > 3))
     aea:	5541           	subq.w #2,d1
     aec:	0c41 0001      	cmpi.w #1,d1
     af0:	6300 fb30      	bls.w 622 <main+0x5ae>
				pf[x][y].Status = 0;
     af4:	4250           	clr.w (a0)
				pf[x][y].StatusChanged = TRUE;
     af6:	317c 0001 0002 	move.w #1,2(a0)
		for (int x = 0; x < GameMatrix.Columns; x++)
     afc:	5280           	addq.l #1,d0
     afe:	bc80           	cmp.l d0,d6
     b00:	6e00 fae0      	bgt.w 5e2 <main+0x56e>
     b04:	6000 fb22      	bra.w 628 <main+0x5b4>
				pf[x][y].Status = 1;
     b08:	30bc 0001      	move.w #1,(a0)
				pf[x][y].StatusChanged = TRUE;
     b0c:	317c 0001 0002 	move.w #1,2(a0)
		for (int x = 0; x < GameMatrix.Columns; x++)
     b12:	5280           	addq.l #1,d0
     b14:	bc80           	cmp.l d0,d6
     b16:	6e00 faca      	bgt.w 5e2 <main+0x56e>
     b1a:	6000 fb0c      	bra.w 628 <main+0x5b4>
			else if (y > 0 && y < GameMatrix.Rows - 2) // rows between 1st and last
     b1e:	bdc9           	cmpa.l a1,a6
     b20:	6f3c           	ble.s b5e <main+0xaea>
				if (x == 0)
     b22:	4a80           	tst.l d0
     b24:	6600 00d0      	bne.w bf6 <main+0xb82>
					if (pf[x][y - 1].Status)
     b28:	2454           	movea.l (a4),a2
     b2a:	4a72 3800      	tst.w (0,a2,d3.l)
     b2e:	56c1           	sne d1
     b30:	4881           	ext.w d1
     b32:	4441           	neg.w d1
					if (pf[x][y + 1].Status)
     b34:	4a72 4800      	tst.w (0,a2,d4.l)
     b38:	6702           	beq.s b3c <main+0xac8>
						neighbours++;
     b3a:	5241           	addq.w #1,d1
					if (pf[x + 1][y].Status)
     b3c:	246c 0004      	movea.l 4(a4),a2
     b40:	4a72 2800      	tst.w (0,a2,d2.l)
     b44:	6702           	beq.s b48 <main+0xad4>
						neighbours++;
     b46:	5241           	addq.w #1,d1
					if (pf[x + 1][y + 1].Status)
     b48:	4a72 4800      	tst.w (0,a2,d4.l)
     b4c:	6702           	beq.s b50 <main+0xadc>
						neighbours++;
     b4e:	5241           	addq.w #1,d1
					if (pf[x + 1][y - 1].Status)
     b50:	4a72 3800      	tst.w (0,a2,d3.l)
     b54:	6700 fabc      	beq.w 612 <main+0x59e>
						neighbours++;
     b58:	5241           	addq.w #1,d1
     b5a:	6000 fab6      	bra.w 612 <main+0x59e>
				if (x == 0)
     b5e:	4a80           	tst.l d0
     b60:	665e           	bne.s bc0 <main+0xb4c>
					if (pf[x][y - 1].Status)
     b62:	2454           	movea.l (a4),a2
     b64:	4a72 3800      	tst.w (0,a2,d3.l)
     b68:	56c1           	sne d1
     b6a:	4881           	ext.w d1
     b6c:	4441           	neg.w d1
					if (pf[x + 1][y - 1].Status)
     b6e:	246c 0004      	movea.l 4(a4),a2
     b72:	4a72 3800      	tst.w (0,a2,d3.l)
     b76:	6702           	beq.s b7a <main+0xb06>
						neighbours++;
     b78:	5241           	addq.w #1,d1
					if (pf[x + 1][y].Status)
     b7a:	4a72 2800      	tst.w (0,a2,d2.l)
     b7e:	6700 ff62      	beq.w ae2 <main+0xa6e>
						neighbours++;
     b82:	5241           	addq.w #1,d1
     b84:	6000 fa8c      	bra.w 612 <main+0x59e>
				else if (x > 0 && x < GameMatrix.Columns - 2) // columns in between 1st and last
     b88:	b085           	cmp.l d5,d0
     b8a:	6c00 ff36      	bge.w ac2 <main+0xa4e>
					if (pf[x + 1][y].Status)
     b8e:	2453           	movea.l (a3),a2
     b90:	4a52           	tst.w (a2)
     b92:	56c1           	sne d1
     b94:	4881           	ext.w d1
     b96:	4441           	neg.w d1
					if (pf[x + 1][y + 1].Status)
     b98:	4a6a 0006      	tst.w 6(a2)
     b9c:	6702           	beq.s ba0 <main+0xb2c>
						neighbours++;
     b9e:	5241           	addq.w #1,d1
					if (pf[x][y + 1].Status)
     ba0:	4a68 0006      	tst.w 6(a0)
     ba4:	6702           	beq.s ba8 <main+0xb34>
						neighbours++;
     ba6:	5241           	addq.w #1,d1
					if (pf[x - 1][y].Status)
     ba8:	246b fff8      	movea.l -8(a3),a2
     bac:	4a52           	tst.w (a2)
     bae:	6702           	beq.s bb2 <main+0xb3e>
						neighbours++;
     bb0:	5241           	addq.w #1,d1
					if (pf[x - 1][y + 1].Status)
     bb2:	4a6a 0006      	tst.w 6(a2)
     bb6:	6700 fa5a      	beq.w 612 <main+0x59e>
						neighbours++;
     bba:	5241           	addq.w #1,d1
     bbc:	6000 fa54      	bra.w 612 <main+0x59e>
					if (pf[x - 1][y].Status)
     bc0:	246b fff8      	movea.l -8(a3),a2
					if (pf[x - 1][y].Status)
     bc4:	4a72 2800      	tst.w (0,a2,d2.l)
     bc8:	56c1           	sne d1
     bca:	4881           	ext.w d1
     bcc:	4441           	neg.w d1
					if (pf[x - 1][y - 1].Status)
     bce:	4a72 3800      	tst.w (0,a2,d3.l)
     bd2:	6702           	beq.s bd6 <main+0xb62>
						neighbours++;
     bd4:	5241           	addq.w #1,d1
					if (pf[x][y - 1].Status)
     bd6:	4a70 3800      	tst.w (0,a0,d3.l)
     bda:	6702           	beq.s bde <main+0xb6a>
						neighbours++;
     bdc:	5241           	addq.w #1,d1
					if (pf[x + 1][y - 1].Status)
     bde:	2453           	movea.l (a3),a2
     be0:	4a72 3800      	tst.w (0,a2,d3.l)
     be4:	6702           	beq.s be8 <main+0xb74>
						neighbours++;
     be6:	5241           	addq.w #1,d1
					if (pf[x + 1][y].Status)
     be8:	4a72 2800      	tst.w (0,a2,d2.l)
     bec:	6700 fa24      	beq.w 612 <main+0x59e>
						neighbours++;
     bf0:	5241           	addq.w #1,d1
     bf2:	6000 fa1e      	bra.w 612 <main+0x59e>
					if (pf[x - 1][y].Status)
     bf6:	246b fff8      	movea.l -8(a3),a2
					if (pf[x - 1][y - 1].Status)
     bfa:	3f72 3800 0034 	move.w (0,a2,d3.l),52(sp)
					if (pf[x - 1][y].Status)
     c00:	3f72 2800 0038 	move.w (0,a2,d2.l),56(sp)
					if (pf[x][y - 1].Status)
     c06:	3a70 3800      	movea.w (0,a0,d3.l),a5
					if (pf[x][y + 1].Status)
     c0a:	3f70 4800 003a 	move.w (0,a0,d4.l),58(sp)
				else if (x > 0 && x < GameMatrix.Columns - 2)
     c10:	b085           	cmp.l d5,d0
     c12:	6c4a           	bge.s c5e <main+0xbea>
					if (pf[x][y + 1].Status)
     c14:	4a6f 003a      	tst.w 58(sp)
     c18:	56c1           	sne d1
     c1a:	4881           	ext.w d1
     c1c:	4441           	neg.w d1
					if (pf[x][y - 1].Status)
     c1e:	4247           	clr.w d7
     c20:	be4d           	cmp.w a5,d7
     c22:	6702           	beq.s c26 <main+0xbb2>
						neighbours++;
     c24:	5241           	addq.w #1,d1
					if (pf[x + 1][y].Status)
     c26:	2a53           	movea.l (a3),a5
     c28:	4a75 2800      	tst.w (0,a5,d2.l)
     c2c:	6702           	beq.s c30 <main+0xbbc>
						neighbours++;
     c2e:	5241           	addq.w #1,d1
					if (pf[x + 1][y - 1].Status)
     c30:	4a75 3800      	tst.w (0,a5,d3.l)
     c34:	6702           	beq.s c38 <main+0xbc4>
						neighbours++;
     c36:	5241           	addq.w #1,d1
					if (pf[x + 1][y + 1].Status)
     c38:	4a75 4800      	tst.w (0,a5,d4.l)
     c3c:	6702           	beq.s c40 <main+0xbcc>
						neighbours++;
     c3e:	5241           	addq.w #1,d1
					if (pf[x - 1][y].Status)
     c40:	4a6f 0038      	tst.w 56(sp)
     c44:	6702           	beq.s c48 <main+0xbd4>
						neighbours++;
     c46:	5241           	addq.w #1,d1
					if (pf[x - 1][y + 1].Status)
     c48:	4a72 4800      	tst.w (0,a2,d4.l)
     c4c:	6702           	beq.s c50 <main+0xbdc>
						neighbours++;
     c4e:	5241           	addq.w #1,d1
					if (pf[x - 1][y - 1].Status)
     c50:	4a6f 0034      	tst.w 52(sp)
     c54:	6700 f9bc      	beq.w 612 <main+0x59e>
						neighbours++;
     c58:	5241           	addq.w #1,d1
     c5a:	6000 f9b6      	bra.w 612 <main+0x59e>
					if (pf[x - 1][y - 1].Status)
     c5e:	4a6f 0034      	tst.w 52(sp)
     c62:	56c1           	sne d1
     c64:	4881           	ext.w d1
     c66:	4441           	neg.w d1
					if (pf[x - 1][y].Status)
     c68:	4a6f 0038      	tst.w 56(sp)
     c6c:	6702           	beq.s c70 <main+0xbfc>
						neighbours++;
     c6e:	5241           	addq.w #1,d1
					if (pf[x - 1][y + 1].Status)
     c70:	4a72 4800      	tst.w (0,a2,d4.l)
     c74:	6702           	beq.s c78 <main+0xc04>
						neighbours++;
     c76:	5241           	addq.w #1,d1
					if (pf[x][y - 1].Status)
     c78:	4247           	clr.w d7
     c7a:	be4d           	cmp.w a5,d7
     c7c:	6702           	beq.s c80 <main+0xc0c>
						neighbours++;
     c7e:	5241           	addq.w #1,d1
					if (pf[x][y + 1].Status)
     c80:	4a6f 003a      	tst.w 58(sp)
     c84:	6700 f98c      	beq.w 612 <main+0x59e>
						neighbours++;
     c88:	5241           	addq.w #1,d1
     c8a:	6000 f986      	bra.w 612 <main+0x59e>
					if (pf[x - 1][y - 1].Status)
     c8e:	4a6f 003a      	tst.w 58(sp)
     c92:	56c1           	sne d1
     c94:	4881           	ext.w d1
     c96:	4441           	neg.w d1
					if (pf[x - 1][y].Status)
     c98:	4a6f 0038      	tst.w 56(sp)
     c9c:	6702           	beq.s ca0 <main+0xc2c>
						neighbours++;
     c9e:	5241           	addq.w #1,d1
					if (pf[x - 1][y + 1].Status)
     ca0:	4a72 4800      	tst.w (0,a2,d4.l)
     ca4:	6702           	beq.s ca8 <main+0xc34>
						neighbours++;
     ca6:	5241           	addq.w #1,d1
					if (pf[x][y - 1].Status)
     ca8:	4246           	clr.w d6
     caa:	bc4d           	cmp.w a5,d6
     cac:	6702           	beq.s cb0 <main+0xc3c>
						neighbours++;
     cae:	5241           	addq.w #1,d1
					if (pf[x][y + 1].Status)
     cb0:	4a6f 0034      	tst.w 52(sp)
     cb4:	6700 f8f0      	beq.w 5a6 <main+0x532>
						neighbours++;
     cb8:	5241           	addq.w #1,d1
     cba:	6000 f8ea      	bra.w 5a6 <main+0x532>
	FreeMem((APTR)GameMatrix.Playfield, GameMatrix.Columns * GameMatrix.Rows * sizeof(GameOfLifeCell));
     cbe:	3239 0000 349e 	move.w 349e <GameMatrix+0x6>,d1
     cc4:	c2f9 0000 349c 	mulu.w 349c <GameMatrix+0x4>,d1
     cca:	2001           	move.l d1,d0
     ccc:	d081           	add.l d1,d0
     cce:	d081           	add.l d1,d0
     cd0:	2c79 0000 3488 	movea.l 3488 <SysBase>,a6
     cd6:	45f9 0000 3498 	lea 3498 <GameMatrix>,a2
     cdc:	2252           	movea.l (a2),a1
     cde:	d080           	add.l d0,d0
     ce0:	4eae ff2e      	jsr -210(a6)
	if (GolMainWindow)
     ce4:	2079 0000 3492 	movea.l 3492 <GolMainWindow>,a0
     cea:	b0fc 0000      	cmpa.w #0,a0
     cee:	670a           	beq.s cfa <main+0xc86>
		CloseWindow(GolMainWindow);
     cf0:	2c79 0000 3484 	movea.l 3484 <IntuitionBase>,a6
     cf6:	4eae ffb8      	jsr -72(a6)
	if (GadToolsBase)
     cfa:	2279 0000 347c 	movea.l 347c <GadToolsBase>,a1
     d00:	b2fc 0000      	cmpa.w #0,a1
     d04:	670a           	beq.s d10 <main+0xc9c>
		CloseLibrary((struct Library *)GadToolsBase);
     d06:	2c79 0000 3488 	movea.l 3488 <SysBase>,a6
     d0c:	4eae fe62      	jsr -414(a6)
	if (GolScreen)
     d10:	2079 0000 3478 	movea.l 3478 <GolScreen>,a0
     d16:	b0fc 0000      	cmpa.w #0,a0
     d1a:	670a           	beq.s d26 <main+0xcb2>
		CloseScreen(GolScreen);
     d1c:	2c79 0000 3484 	movea.l 3484 <IntuitionBase>,a6
     d22:	4eae ffbe      	jsr -66(a6)
	if (GfxBase)
     d26:	2279 0000 3480 	movea.l 3480 <GfxBase>,a1
     d2c:	b2fc 0000      	cmpa.w #0,a1
     d30:	670a           	beq.s d3c <main+0xcc8>
		CloseLibrary((struct Library *)GfxBase);
     d32:	2c79 0000 3488 	movea.l 3488 <SysBase>,a6
     d38:	4eae fe62      	jsr -414(a6)
	if (IntuitionBase)
     d3c:	2279 0000 3484 	movea.l 3484 <IntuitionBase>,a1
     d42:	b2fc 0000      	cmpa.w #0,a1
     d46:	670a           	beq.s d52 <main+0xcde>
		CloseLibrary((struct Library *)IntuitionBase);
     d48:	2c79 0000 3488 	movea.l 3488 <SysBase>,a6
     d4e:	4eae fe62      	jsr -414(a6)
	if (DOSBase)
     d52:	2279 0000 3474 	movea.l 3474 <DOSBase>,a1
     d58:	b2fc 0000      	cmpa.w #0,a1
     d5c:	6724           	beq.s d82 <main+0xd0e>
		CloseLibrary((struct Library *)DOSBase);
     d5e:	2c79 0000 3488 	movea.l 3488 <SysBase>,a6
     d64:	4eae fe62      	jsr -414(a6)
     d68:	7000           	moveq #0,d0
}
     d6a:	4cdf 7cfc      	movem.l (sp)+,d2-d7/a2-a6
     d6e:	4fef 00bc      	lea 188(sp),sp
     d72:	4e75           	rts
			GameMatrix.Playfield[x][y].Status = 1;
     d74:	30bc 0001      	move.w #1,(a0)
			GameMatrix.Playfield[x][y].StatusChanged = TRUE;
     d78:	317c 0001 0002 	move.w #1,2(a0)
     d7e:	6000 f6be      	bra.w 43e <main+0x3ca>
     d82:	7000           	moveq #0,d0
}
     d84:	4cdf 7cfc      	movem.l (sp)+,d2-d7/a2-a6
     d88:	4fef 00bc      	lea 188(sp),sp
     d8c:	4e75           	rts
     d8e:	4e71           	nop

00000d90 <DrawCells.constprop.0>:
void DrawCells(struct Window *theWindow, BOOL forceFull)
     d90:	4fef fff4      	lea -12(sp),sp
     d94:	48e7 3f3e      	movem.l d2-d7/a2-a6,-(sp)
     d98:	246f 003c      	movea.l 60(sp),a2
	for (int x = 0; x < GameMatrix.Columns; x++)
     d9c:	4a79 0000 349e 	tst.w 349e <GameMatrix+0x6>
     da2:	6700 00d6      	beq.w e7a <DrawCells.constprop.0+0xea>
		for (int y = 0; y < GameMatrix.Rows; y++)
     da6:	3239 0000 349c 	move.w 349c <GameMatrix+0x4>,d1
     dac:	42af 0030      	clr.l 48(sp)
	for (int x = 0; x < GameMatrix.Columns; x++)
     db0:	42af 0034      	clr.l 52(sp)
     db4:	49f9 0000 3498 	lea 3498 <GameMatrix>,a4
			RectFill(theWindow->RPort,
     dba:	47f9 0000 1110 	lea 1110 <__mulsi3>,a3
		for (int y = 0; y < GameMatrix.Rows; y++)
     dc0:	4a41           	tst.w d1
     dc2:	6700 00b6      	beq.w e7a <DrawCells.constprop.0+0xea>
     dc6:	7a00           	moveq #0,d5
     dc8:	7800           	moveq #0,d4
			if (!GameMatrix.Playfield[x][y].StatusChanged && !forceFull)
     dca:	2054           	movea.l (a4),a0
     dcc:	202f 0030      	move.l 48(sp),d0
     dd0:	2070 0800      	movea.l (0,a0,d0.l),a0
     dd4:	d1c5           	adda.l d5,a0
     dd6:	4a68 0002      	tst.w 2(a0)
     dda:	6774           	beq.s e50 <DrawCells.constprop.0+0xc0>
			GameMatrix.Playfield[x][y].StatusChanged = FALSE;
     ddc:	4268 0002      	clr.w 2(a0)
				SetAPen(theWindow->RPort, 24);
     de0:	226a 0032      	movea.l 50(a2),a1
     de4:	2c79 0000 3480 	movea.l 3480 <GfxBase>,a6
			if (GameMatrix.Playfield[x][y].Status)
     dea:	4a50           	tst.w (a0)
     dec:	6700 0096      	beq.w e84 <DrawCells.constprop.0+0xf4>
				SetAPen(theWindow->RPort, 24);
     df0:	7018           	moveq #24,d0
     df2:	4eae feaa      	jsr -342(a6)
			RectFill(theWindow->RPort,
     df6:	226a 0032      	movea.l 50(a2),a1
     dfa:	7400           	moveq #0,d2
     dfc:	3439 0000 34a4 	move.w 34a4 <GameMatrix+0xc>,d2
     e02:	2f2f 0034      	move.l 52(sp),-(sp)
     e06:	2f02           	move.l d2,-(sp)
     e08:	2f49 0034      	move.l a1,52(sp)
     e0c:	4e93           	jsr (a3)
     e0e:	508f           	addq.l #8,sp
     e10:	2a40           	movea.l d0,a5
     e12:	2c00           	move.l d0,d6
     e14:	5286           	addq.l #1,d6
     e16:	7e00           	moveq #0,d7
     e18:	3e39 0000 34a6 	move.w 34a6 <GameMatrix+0xe>,d7
     e1e:	2f04           	move.l d4,-(sp)
     e20:	2f07           	move.l d7,-(sp)
     e22:	4e93           	jsr (a3)
     e24:	508f           	addq.l #8,sp
     e26:	2600           	move.l d0,d3
     e28:	2c79 0000 3480 	movea.l 3480 <GfxBase>,a6
     e2e:	226f 002c      	movea.l 44(sp),a1
     e32:	2006           	move.l d6,d0
     e34:	2203           	move.l d3,d1
     e36:	5281           	addq.l #1,d1
     e38:	4bf5 28ff      	lea (-1,a5,d2.l),a5
     e3c:	240d           	move.l a5,d2
     e3e:	2047           	movea.l d7,a0
     e40:	41f0 38ff      	lea (-1,a0,d3.l),a0
     e44:	2608           	move.l a0,d3
     e46:	4eae fece      	jsr -306(a6)
		for (int y = 0; y < GameMatrix.Rows; y++)
     e4a:	3239 0000 349c 	move.w 349c <GameMatrix+0x4>,d1
     e50:	5284           	addq.l #1,d4
     e52:	5c85           	addq.l #6,d5
     e54:	7000           	moveq #0,d0
     e56:	3001           	move.w d1,d0
     e58:	b084           	cmp.l d4,d0
     e5a:	6e00 ff6e      	bgt.w dca <DrawCells.constprop.0+0x3a>
	for (int x = 0; x < GameMatrix.Columns; x++)
     e5e:	52af 0034      	addq.l #1,52(sp)
     e62:	7000           	moveq #0,d0
     e64:	3039 0000 349e 	move.w 349e <GameMatrix+0x6>,d0
     e6a:	b0af 0034      	cmp.l 52(sp),d0
     e6e:	6f0a           	ble.s e7a <DrawCells.constprop.0+0xea>
     e70:	58af 0030      	addq.l #4,48(sp)
		for (int y = 0; y < GameMatrix.Rows; y++)
     e74:	4a41           	tst.w d1
     e76:	6600 ff4e      	bne.w dc6 <DrawCells.constprop.0+0x36>
}
     e7a:	4cdf 7cfc      	movem.l (sp)+,d2-d7/a2-a6
     e7e:	4fef 000c      	lea 12(sp),sp
     e82:	4e75           	rts
				SetAPen(theWindow->RPort, 16);
     e84:	7010           	moveq #16,d0
     e86:	4eae feaa      	jsr -342(a6)
			RectFill(theWindow->RPort,
     e8a:	226a 0032      	movea.l 50(a2),a1
     e8e:	7400           	moveq #0,d2
     e90:	3439 0000 34a4 	move.w 34a4 <GameMatrix+0xc>,d2
     e96:	2f2f 0034      	move.l 52(sp),-(sp)
     e9a:	2f02           	move.l d2,-(sp)
     e9c:	2f49 0034      	move.l a1,52(sp)
     ea0:	4e93           	jsr (a3)
     ea2:	508f           	addq.l #8,sp
     ea4:	2a40           	movea.l d0,a5
     ea6:	2c00           	move.l d0,d6
     ea8:	5286           	addq.l #1,d6
     eaa:	7e00           	moveq #0,d7
     eac:	3e39 0000 34a6 	move.w 34a6 <GameMatrix+0xe>,d7
     eb2:	2f04           	move.l d4,-(sp)
     eb4:	2f07           	move.l d7,-(sp)
     eb6:	4e93           	jsr (a3)
     eb8:	508f           	addq.l #8,sp
     eba:	2600           	move.l d0,d3
     ebc:	2c79 0000 3480 	movea.l 3480 <GfxBase>,a6
     ec2:	226f 002c      	movea.l 44(sp),a1
     ec6:	2006           	move.l d6,d0
     ec8:	2203           	move.l d3,d1
     eca:	5281           	addq.l #1,d1
     ecc:	4bf5 28ff      	lea (-1,a5,d2.l),a5
     ed0:	240d           	move.l a5,d2
     ed2:	2047           	movea.l d7,a0
     ed4:	41f0 38ff      	lea (-1,a0,d3.l),a0
     ed8:	2608           	move.l a0,d3
     eda:	4eae fece      	jsr -306(a6)
		for (int y = 0; y < GameMatrix.Rows; y++)
     ede:	3239 0000 349c 	move.w 349c <GameMatrix+0x4>,d1
     ee4:	6000 ff6a      	bra.w e50 <DrawCells.constprop.0+0xc0>

00000ee8 <strlen>:
{
     ee8:	206f 0004      	movea.l 4(sp),a0
	unsigned long t=0;
     eec:	7000           	moveq #0,d0
	while(*s++)
     eee:	4a10           	tst.b (a0)
     ef0:	6708           	beq.s efa <strlen+0x12>
		t++;
     ef2:	5280           	addq.l #1,d0
	while(*s++)
     ef4:	4a30 0800      	tst.b (0,a0,d0.l)
     ef8:	66f8           	bne.s ef2 <strlen+0xa>
}
     efa:	4e75           	rts

00000efc <memset>:
{
     efc:	48e7 3f30      	movem.l d2-d7/a2-a3,-(sp)
     f00:	202f 0024      	move.l 36(sp),d0
     f04:	282f 0028      	move.l 40(sp),d4
     f08:	226f 002c      	movea.l 44(sp),a1
	while(len-- > 0)
     f0c:	2a09           	move.l a1,d5
     f0e:	5385           	subq.l #1,d5
     f10:	b2fc 0000      	cmpa.w #0,a1
     f14:	6700 00ae      	beq.w fc4 <memset+0xc8>
		*ptr++ = val;
     f18:	1e04           	move.b d4,d7
     f1a:	2200           	move.l d0,d1
     f1c:	4481           	neg.l d1
     f1e:	7403           	moveq #3,d2
     f20:	c282           	and.l d2,d1
     f22:	7c05           	moveq #5,d6
     f24:	2440           	movea.l d0,a2
     f26:	bc85           	cmp.l d5,d6
     f28:	646a           	bcc.s f94 <memset+0x98>
     f2a:	4a81           	tst.l d1
     f2c:	6724           	beq.s f52 <memset+0x56>
     f2e:	14c4           	move.b d4,(a2)+
	while(len-- > 0)
     f30:	5385           	subq.l #1,d5
     f32:	7401           	moveq #1,d2
     f34:	b481           	cmp.l d1,d2
     f36:	671a           	beq.s f52 <memset+0x56>
		*ptr++ = val;
     f38:	2440           	movea.l d0,a2
     f3a:	548a           	addq.l #2,a2
     f3c:	2040           	movea.l d0,a0
     f3e:	1144 0001      	move.b d4,1(a0)
	while(len-- > 0)
     f42:	5385           	subq.l #1,d5
     f44:	7403           	moveq #3,d2
     f46:	b481           	cmp.l d1,d2
     f48:	6608           	bne.s f52 <memset+0x56>
		*ptr++ = val;
     f4a:	528a           	addq.l #1,a2
     f4c:	1144 0002      	move.b d4,2(a0)
	while(len-- > 0)
     f50:	5385           	subq.l #1,d5
     f52:	2609           	move.l a1,d3
     f54:	9681           	sub.l d1,d3
     f56:	7c00           	moveq #0,d6
     f58:	1c04           	move.b d4,d6
     f5a:	2406           	move.l d6,d2
     f5c:	4842           	swap d2
     f5e:	4242           	clr.w d2
     f60:	2042           	movea.l d2,a0
     f62:	2404           	move.l d4,d2
     f64:	e14a           	lsl.w #8,d2
     f66:	4842           	swap d2
     f68:	4242           	clr.w d2
     f6a:	e18e           	lsl.l #8,d6
     f6c:	2646           	movea.l d6,a3
     f6e:	2c08           	move.l a0,d6
     f70:	8486           	or.l d6,d2
     f72:	2c0b           	move.l a3,d6
     f74:	8486           	or.l d6,d2
     f76:	1407           	move.b d7,d2
     f78:	2040           	movea.l d0,a0
     f7a:	d1c1           	adda.l d1,a0
     f7c:	72fc           	moveq #-4,d1
     f7e:	c283           	and.l d3,d1
     f80:	d288           	add.l a0,d1
		*ptr++ = val;
     f82:	20c2           	move.l d2,(a0)+
	while(len-- > 0)
     f84:	b1c1           	cmpa.l d1,a0
     f86:	66fa           	bne.s f82 <memset+0x86>
     f88:	72fc           	moveq #-4,d1
     f8a:	c283           	and.l d3,d1
     f8c:	d5c1           	adda.l d1,a2
     f8e:	9a81           	sub.l d1,d5
     f90:	b283           	cmp.l d3,d1
     f92:	6730           	beq.s fc4 <memset+0xc8>
		*ptr++ = val;
     f94:	1484           	move.b d4,(a2)
	while(len-- > 0)
     f96:	4a85           	tst.l d5
     f98:	672a           	beq.s fc4 <memset+0xc8>
		*ptr++ = val;
     f9a:	1544 0001      	move.b d4,1(a2)
	while(len-- > 0)
     f9e:	7201           	moveq #1,d1
     fa0:	b285           	cmp.l d5,d1
     fa2:	6720           	beq.s fc4 <memset+0xc8>
		*ptr++ = val;
     fa4:	1544 0002      	move.b d4,2(a2)
	while(len-- > 0)
     fa8:	7402           	moveq #2,d2
     faa:	b485           	cmp.l d5,d2
     fac:	6716           	beq.s fc4 <memset+0xc8>
		*ptr++ = val;
     fae:	1544 0003      	move.b d4,3(a2)
	while(len-- > 0)
     fb2:	7c03           	moveq #3,d6
     fb4:	bc85           	cmp.l d5,d6
     fb6:	670c           	beq.s fc4 <memset+0xc8>
		*ptr++ = val;
     fb8:	1544 0004      	move.b d4,4(a2)
	while(len-- > 0)
     fbc:	5985           	subq.l #4,d5
     fbe:	6704           	beq.s fc4 <memset+0xc8>
		*ptr++ = val;
     fc0:	1544 0005      	move.b d4,5(a2)
}
     fc4:	4cdf 0cfc      	movem.l (sp)+,d2-d7/a2-a3
     fc8:	4e75           	rts

00000fca <memcpy>:
{
     fca:	48e7 3e00      	movem.l d2-d6,-(sp)
     fce:	202f 0018      	move.l 24(sp),d0
     fd2:	222f 001c      	move.l 28(sp),d1
     fd6:	262f 0020      	move.l 32(sp),d3
	while(len--)
     fda:	2803           	move.l d3,d4
     fdc:	5384           	subq.l #1,d4
     fde:	4a83           	tst.l d3
     fe0:	675e           	beq.s 1040 <memcpy+0x76>
     fe2:	2041           	movea.l d1,a0
     fe4:	5288           	addq.l #1,a0
     fe6:	2400           	move.l d0,d2
     fe8:	9488           	sub.l a0,d2
     fea:	7a02           	moveq #2,d5
     fec:	ba82           	cmp.l d2,d5
     fee:	55c2           	sc.s d2
     ff0:	4402           	neg.b d2
     ff2:	7c08           	moveq #8,d6
     ff4:	bc84           	cmp.l d4,d6
     ff6:	55c5           	sc.s d5
     ff8:	4405           	neg.b d5
     ffa:	c405           	and.b d5,d2
     ffc:	6748           	beq.s 1046 <memcpy+0x7c>
     ffe:	2400           	move.l d0,d2
    1000:	8481           	or.l d1,d2
    1002:	7a03           	moveq #3,d5
    1004:	c485           	and.l d5,d2
    1006:	663e           	bne.s 1046 <memcpy+0x7c>
    1008:	2041           	movea.l d1,a0
    100a:	2240           	movea.l d0,a1
    100c:	74fc           	moveq #-4,d2
    100e:	c483           	and.l d3,d2
    1010:	d481           	add.l d1,d2
		*d++ = *s++;
    1012:	22d8           	move.l (a0)+,(a1)+
	while(len--)
    1014:	b488           	cmp.l a0,d2
    1016:	66fa           	bne.s 1012 <memcpy+0x48>
    1018:	74fc           	moveq #-4,d2
    101a:	c483           	and.l d3,d2
    101c:	2040           	movea.l d0,a0
    101e:	d1c2           	adda.l d2,a0
    1020:	d282           	add.l d2,d1
    1022:	9882           	sub.l d2,d4
    1024:	b483           	cmp.l d3,d2
    1026:	6718           	beq.s 1040 <memcpy+0x76>
		*d++ = *s++;
    1028:	2241           	movea.l d1,a1
    102a:	1091           	move.b (a1),(a0)
	while(len--)
    102c:	4a84           	tst.l d4
    102e:	6710           	beq.s 1040 <memcpy+0x76>
		*d++ = *s++;
    1030:	1169 0001 0001 	move.b 1(a1),1(a0)
	while(len--)
    1036:	5384           	subq.l #1,d4
    1038:	6706           	beq.s 1040 <memcpy+0x76>
		*d++ = *s++;
    103a:	1169 0002 0002 	move.b 2(a1),2(a0)
}
    1040:	4cdf 007c      	movem.l (sp)+,d2-d6
    1044:	4e75           	rts
    1046:	2240           	movea.l d0,a1
    1048:	d283           	add.l d3,d1
		*d++ = *s++;
    104a:	12e8 ffff      	move.b -1(a0),(a1)+
	while(len--)
    104e:	b288           	cmp.l a0,d1
    1050:	67ee           	beq.s 1040 <memcpy+0x76>
    1052:	5288           	addq.l #1,a0
    1054:	60f4           	bra.s 104a <memcpy+0x80>

00001056 <memmove>:
{
    1056:	48e7 3c20      	movem.l d2-d5/a2,-(sp)
    105a:	202f 0018      	move.l 24(sp),d0
    105e:	222f 001c      	move.l 28(sp),d1
    1062:	242f 0020      	move.l 32(sp),d2
		while (len--)
    1066:	2242           	movea.l d2,a1
    1068:	5389           	subq.l #1,a1
	if (d < s) {
    106a:	b280           	cmp.l d0,d1
    106c:	636c           	bls.s 10da <memmove+0x84>
		while (len--)
    106e:	4a82           	tst.l d2
    1070:	6762           	beq.s 10d4 <memmove+0x7e>
    1072:	2441           	movea.l d1,a2
    1074:	528a           	addq.l #1,a2
    1076:	2600           	move.l d0,d3
    1078:	968a           	sub.l a2,d3
    107a:	7802           	moveq #2,d4
    107c:	b883           	cmp.l d3,d4
    107e:	55c3           	sc.s d3
    1080:	4403           	neg.b d3
    1082:	7a08           	moveq #8,d5
    1084:	ba89           	cmp.l a1,d5
    1086:	55c4           	sc.s d4
    1088:	4404           	neg.b d4
    108a:	c604           	and.b d4,d3
    108c:	6770           	beq.s 10fe <memmove+0xa8>
    108e:	2600           	move.l d0,d3
    1090:	8681           	or.l d1,d3
    1092:	7803           	moveq #3,d4
    1094:	c684           	and.l d4,d3
    1096:	6666           	bne.s 10fe <memmove+0xa8>
    1098:	2041           	movea.l d1,a0
    109a:	2440           	movea.l d0,a2
    109c:	76fc           	moveq #-4,d3
    109e:	c682           	and.l d2,d3
    10a0:	d681           	add.l d1,d3
			*d++ = *s++;
    10a2:	24d8           	move.l (a0)+,(a2)+
		while (len--)
    10a4:	b688           	cmp.l a0,d3
    10a6:	66fa           	bne.s 10a2 <memmove+0x4c>
    10a8:	76fc           	moveq #-4,d3
    10aa:	c682           	and.l d2,d3
    10ac:	2440           	movea.l d0,a2
    10ae:	d5c3           	adda.l d3,a2
    10b0:	2041           	movea.l d1,a0
    10b2:	d1c3           	adda.l d3,a0
    10b4:	93c3           	suba.l d3,a1
    10b6:	b682           	cmp.l d2,d3
    10b8:	671a           	beq.s 10d4 <memmove+0x7e>
			*d++ = *s++;
    10ba:	1490           	move.b (a0),(a2)
		while (len--)
    10bc:	b2fc 0000      	cmpa.w #0,a1
    10c0:	6712           	beq.s 10d4 <memmove+0x7e>
			*d++ = *s++;
    10c2:	1568 0001 0001 	move.b 1(a0),1(a2)
		while (len--)
    10c8:	7a01           	moveq #1,d5
    10ca:	ba89           	cmp.l a1,d5
    10cc:	6706           	beq.s 10d4 <memmove+0x7e>
			*d++ = *s++;
    10ce:	1568 0002 0002 	move.b 2(a0),2(a2)
}
    10d4:	4cdf 043c      	movem.l (sp)+,d2-d5/a2
    10d8:	4e75           	rts
		const char *lasts = s + (len - 1);
    10da:	41f1 1800      	lea (0,a1,d1.l),a0
		char *lastd = d + (len - 1);
    10de:	d3c0           	adda.l d0,a1
		while (len--)
    10e0:	4a82           	tst.l d2
    10e2:	67f0           	beq.s 10d4 <memmove+0x7e>
    10e4:	2208           	move.l a0,d1
    10e6:	9282           	sub.l d2,d1
			*lastd-- = *lasts--;
    10e8:	1290           	move.b (a0),(a1)
		while (len--)
    10ea:	5388           	subq.l #1,a0
    10ec:	5389           	subq.l #1,a1
    10ee:	b288           	cmp.l a0,d1
    10f0:	67e2           	beq.s 10d4 <memmove+0x7e>
			*lastd-- = *lasts--;
    10f2:	1290           	move.b (a0),(a1)
		while (len--)
    10f4:	5388           	subq.l #1,a0
    10f6:	5389           	subq.l #1,a1
    10f8:	b288           	cmp.l a0,d1
    10fa:	66ec           	bne.s 10e8 <memmove+0x92>
    10fc:	60d6           	bra.s 10d4 <memmove+0x7e>
    10fe:	2240           	movea.l d0,a1
    1100:	d282           	add.l d2,d1
			*d++ = *s++;
    1102:	12ea ffff      	move.b -1(a2),(a1)+
		while (len--)
    1106:	b28a           	cmp.l a2,d1
    1108:	67ca           	beq.s 10d4 <memmove+0x7e>
    110a:	528a           	addq.l #1,a2
    110c:	60f4           	bra.s 1102 <memmove+0xac>
    110e:	4e71           	nop

00001110 <__mulsi3>:
	.text
	FUNC(__mulsi3)
	.globl	SYM (__mulsi3)
SYM (__mulsi3):
	.cfi_startproc
	movew	sp@(4), d0	/* x0 -> d0 */
    1110:	302f 0004      	move.w 4(sp),d0
	muluw	sp@(10), d0	/* x0*y1 */
    1114:	c0ef 000a      	mulu.w 10(sp),d0
	movew	sp@(6), d1	/* x1 -> d1 */
    1118:	322f 0006      	move.w 6(sp),d1
	muluw	sp@(8), d1	/* x1*y0 */
    111c:	c2ef 0008      	mulu.w 8(sp),d1
	addw	d1, d0
    1120:	d041           	add.w d1,d0
	swap	d0
    1122:	4840           	swap d0
	clrw	d0
    1124:	4240           	clr.w d0
	movew	sp@(6), d1	/* x1 -> d1 */
    1126:	322f 0006      	move.w 6(sp),d1
	muluw	sp@(10), d1	/* x1*y1 */
    112a:	c2ef 000a      	mulu.w 10(sp),d1
	addl	d1, d0
    112e:	d081           	add.l d1,d0
	rts
    1130:	4e75           	rts

00001132 <__udivsi3>:
	.text
	FUNC(__udivsi3)
	.globl	SYM (__udivsi3)
SYM (__udivsi3):
	.cfi_startproc
	movel	d2, sp@-
    1132:	2f02           	move.l d2,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	sp@(12), d1	/* d1 = divisor */
    1134:	222f 000c      	move.l 12(sp),d1
	movel	sp@(8), d0	/* d0 = dividend */
    1138:	202f 0008      	move.l 8(sp),d0

	cmpl	IMM (0x10000), d1 /* divisor >= 2 ^ 16 ?   */
    113c:	0c81 0001 0000 	cmpi.l #65536,d1
	jcc	3f		/* then try next algorithm */
    1142:	6416           	bcc.s 115a <__udivsi3+0x28>
	movel	d0, d2
    1144:	2400           	move.l d0,d2
	clrw	d2
    1146:	4242           	clr.w d2
	swap	d2
    1148:	4842           	swap d2
	divu	d1, d2          /* high quotient in lower word */
    114a:	84c1           	divu.w d1,d2
	movew	d2, d0		/* save high quotient */
    114c:	3002           	move.w d2,d0
	swap	d0
    114e:	4840           	swap d0
	movew	sp@(10), d2	/* get low dividend + high rest */
    1150:	342f 000a      	move.w 10(sp),d2
	divu	d1, d2		/* low quotient */
    1154:	84c1           	divu.w d1,d2
	movew	d2, d0
    1156:	3002           	move.w d2,d0
	jra	6f
    1158:	6030           	bra.s 118a <__udivsi3+0x58>

3:	movel	d1, d2		/* use d2 as divisor backup */
    115a:	2401           	move.l d1,d2
4:	lsrl	IMM (1), d1	/* shift divisor */
    115c:	e289           	lsr.l #1,d1
	lsrl	IMM (1), d0	/* shift dividend */
    115e:	e288           	lsr.l #1,d0
	cmpl	IMM (0x10000), d1 /* still divisor >= 2 ^ 16 ?  */
    1160:	0c81 0001 0000 	cmpi.l #65536,d1
	jcc	4b
    1166:	64f4           	bcc.s 115c <__udivsi3+0x2a>
	divu	d1, d0		/* now we have 16-bit divisor */
    1168:	80c1           	divu.w d1,d0
	andl	IMM (0xffff), d0 /* mask out divisor, ignore remainder */
    116a:	0280 0000 ffff 	andi.l #65535,d0

/* Multiply the 16-bit tentative quotient with the 32-bit divisor.  Because of
   the operand ranges, this might give a 33-bit product.  If this product is
   greater than the dividend, the tentative quotient was too large. */
	movel	d2, d1
    1170:	2202           	move.l d2,d1
	mulu	d0, d1		/* low part, 32 bits */
    1172:	c2c0           	mulu.w d0,d1
	swap	d2
    1174:	4842           	swap d2
	mulu	d0, d2		/* high part, at most 17 bits */
    1176:	c4c0           	mulu.w d0,d2
	swap	d2		/* align high part with low part */
    1178:	4842           	swap d2
	tstw	d2		/* high part 17 bits? */
    117a:	4a42           	tst.w d2
	jne	5f		/* if 17 bits, quotient was too large */
    117c:	660a           	bne.s 1188 <__udivsi3+0x56>
	addl	d2, d1		/* add parts */
    117e:	d282           	add.l d2,d1
	jcs	5f		/* if sum is 33 bits, quotient was too large */
    1180:	6506           	bcs.s 1188 <__udivsi3+0x56>
	cmpl	sp@(8), d1	/* compare the sum with the dividend */
    1182:	b2af 0008      	cmp.l 8(sp),d1
	jls	6f		/* if sum > dividend, quotient was too large */
    1186:	6302           	bls.s 118a <__udivsi3+0x58>
5:	subql	IMM (1), d0	/* adjust quotient */
    1188:	5380           	subq.l #1,d0

6:	movel	sp@+, d2
    118a:	241f           	move.l (sp)+,d2
	.cfi_adjust_cfa_offset -4
	rts
    118c:	4e75           	rts

0000118e <__divsi3>:
	.text
	FUNC(__divsi3)
	.globl	SYM (__divsi3)
SYM (__divsi3):
	.cfi_startproc
	movel	d2, sp@-
    118e:	2f02           	move.l d2,-(sp)
	.cfi_adjust_cfa_offset 4

	moveq	IMM (1), d2	/* sign of result stored in d2 (=1 or =-1) */
    1190:	7401           	moveq #1,d2
	movel	sp@(12), d1	/* d1 = divisor */
    1192:	222f 000c      	move.l 12(sp),d1
	jpl	1f
    1196:	6a04           	bpl.s 119c <__divsi3+0xe>
	negl	d1
    1198:	4481           	neg.l d1
	negb	d2		/* change sign because divisor <0  */
    119a:	4402           	neg.b d2
1:	movel	sp@(8), d0	/* d0 = dividend */
    119c:	202f 0008      	move.l 8(sp),d0
	jpl	2f
    11a0:	6a04           	bpl.s 11a6 <__divsi3+0x18>
	negl	d0
    11a2:	4480           	neg.l d0
	negb	d2
    11a4:	4402           	neg.b d2

2:	movel	d1, sp@-
    11a6:	2f01           	move.l d1,-(sp)
	movel	d0, sp@-
    11a8:	2f00           	move.l d0,-(sp)
	PICCALL	SYM (__udivsi3)	/* divide abs(dividend) by abs(divisor) */
    11aa:	6186           	bsr.s 1132 <__udivsi3>
	addql	IMM (8), sp
    11ac:	508f           	addq.l #8,sp

	tstb	d2
    11ae:	4a02           	tst.b d2
	jpl	3f
    11b0:	6a02           	bpl.s 11b4 <__divsi3+0x26>
	negl	d0
    11b2:	4480           	neg.l d0

3:	movel	sp@+, d2
    11b4:	241f           	move.l (sp)+,d2
	.cfi_adjust_cfa_offset -4
	rts
    11b6:	4e75           	rts

000011b8 <__modsi3>:
	.text
	FUNC(__modsi3)
	.globl	SYM (__modsi3)
SYM (__modsi3):
	.cfi_startproc
	movel	sp@(8), d1	/* d1 = divisor */
    11b8:	222f 0008      	move.l 8(sp),d1
	movel	sp@(4), d0	/* d0 = dividend */
    11bc:	202f 0004      	move.l 4(sp),d0
	movel	d1, sp@-
    11c0:	2f01           	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    11c2:	2f00           	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	PICCALL	SYM (__divsi3)
    11c4:	61c8           	bsr.s 118e <__divsi3>
	addql	IMM (8), sp
    11c6:	508f           	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(8), d1	/* d1 = divisor */
    11c8:	222f 0008      	move.l 8(sp),d1
	movel	d1, sp@-
    11cc:	2f01           	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    11ce:	2f00           	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	PICCALL	SYM (__mulsi3)	/* d0 = (a/b)*b */
    11d0:	6100 ff3e      	bsr.w 1110 <__mulsi3>
	addql	IMM (8), sp
    11d4:	508f           	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(4), d1	/* d1 = dividend */
    11d6:	222f 0004      	move.l 4(sp),d1
	subl	d0, d1		/* d1 = a - (a/b)*b */
    11da:	9280           	sub.l d0,d1
	movel	d1, d0
    11dc:	2001           	move.l d1,d0
	rts
    11de:	4e75           	rts

000011e0 <__umodsi3>:
	.text
	FUNC(__umodsi3)
	.globl	SYM (__umodsi3)
SYM (__umodsi3):
	.cfi_startproc
	movel	sp@(8), d1	/* d1 = divisor */
    11e0:	222f 0008      	move.l 8(sp),d1
	movel	sp@(4), d0	/* d0 = dividend */
    11e4:	202f 0004      	move.l 4(sp),d0
	movel	d1, sp@-
    11e8:	2f01           	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    11ea:	2f00           	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	PICCALL	SYM (__udivsi3)
    11ec:	6100 ff44      	bsr.w 1132 <__udivsi3>
	addql	IMM (8), sp
    11f0:	508f           	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(8), d1	/* d1 = divisor */
    11f2:	222f 0008      	move.l 8(sp),d1
	movel	d1, sp@-
    11f6:	2f01           	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    11f8:	2f00           	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	PICCALL	SYM (__mulsi3)	/* d0 = (a/b)*b */
    11fa:	6100 ff14      	bsr.w 1110 <__mulsi3>
	addql	IMM (8), sp
    11fe:	508f           	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(4), d1	/* d1 = dividend */
    1200:	222f 0004      	move.l 4(sp),d1
	subl	d0, d1		/* d1 = a - (a/b)*b */
    1204:	9280           	sub.l d0,d1
	movel	d1, d0
    1206:	2001           	move.l d1,d0
	rts
    1208:	4e75           	rts

0000120a <KPutCharX>:
	FUNC(KPutCharX)
	.globl	SYM (KPutCharX)

SYM(KPutCharX):
	.cfi_startproc
    move.l  a6, -(sp)
    120a:	2f0e           	move.l a6,-(sp)
	.cfi_adjust_cfa_offset 4
    move.l  4.w, a6
    120c:	2c78 0004      	movea.l 4 <_start+0x4>,a6
    jsr     -0x204(a6)
    1210:	4eae fdfc      	jsr -516(a6)
    movea.l (sp)+, a6
    1214:	2c5f           	movea.l (sp)+,a6
	.cfi_adjust_cfa_offset -4
    rts
    1216:	4e75           	rts

00001218 <PutChar>:
	FUNC(PutChar)
	.globl	SYM (PutChar)

SYM(PutChar):
	.cfi_startproc
	move.b d0, (a3)+
    1218:	16c0           	move.b d0,(a3)+
	rts
    121a:	4e75           	rts
