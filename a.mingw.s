
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
       4:	263c 0000 3375 	move.l #13173,d3
       a:	0483 0000 3375 	subi.l #13173,d3
      10:	e483           	asr.l #2,d3
	for (i = 0; i < count; i++)
      12:	6712           	beq.s 26 <_start+0x26>
      14:	45f9 0000 3375 	lea 3375 <__fini_array_end>,a2
      1a:	7400           	moveq #0,d2
		__preinit_array_start[i]();
      1c:	205a           	movea.l (a2)+,a0
      1e:	4e90           	jsr (a0)
	for (i = 0; i < count; i++)
      20:	5282           	addq.l #1,d2
      22:	b483           	cmp.l d3,d2
      24:	66f6           	bne.s 1c <_start+0x1c>

	count = __init_array_end - __init_array_start;
      26:	263c 0000 3375 	move.l #13173,d3
      2c:	0483 0000 3375 	subi.l #13173,d3
      32:	e483           	asr.l #2,d3
	for (i = 0; i < count; i++)
      34:	6712           	beq.s 48 <_start+0x48>
      36:	45f9 0000 3375 	lea 3375 <__fini_array_end>,a2
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
      4e:	243c 0000 3375 	move.l #13173,d2
      54:	0482 0000 3375 	subi.l #13173,d2
      5a:	e482           	asr.l #2,d2
	for (i = count; i > 0; i--)
      5c:	6710           	beq.s 6e <_start+0x6e>
      5e:	45f9 0000 3375 	lea 3375 <__fini_array_end>,a2
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
      74:	4fef ff50      	lea -176(sp),sp
      78:	48e7 3f3e      	movem.l d2-d7/a2-a6,-(sp)
	GameMatrix.ColorAlive = 6;
	GameMatrix.ColorDead = 8;
	GameMatrix.Columns = 55;
	GameMatrix.Rows = 20;
      7c:	23fc 0014 0037 	move.l #1310775,350c <GameMatrix+0x4>
      82:	0000 350c 
      86:	23fc 0006 0008 	move.l #393224,3510 <GameMatrix+0x8>
      8c:	0000 3510 
      90:	23fc 000b 000b 	move.l #720907,3514 <GameMatrix+0xc>
      96:	0000 3514 
	RETURN_OK;
}

int StartApp()
{
	SysBase = *((struct ExecBase **)4UL);
      9a:	2c78 0004      	movea.l 4 <_start+0x4>,a6
      9e:	23ce 0000 34f8 	move.l a6,34f8 <SysBase>
	custom = (struct Custom *)0xdff000;
	unsigned int pens[] = {~0};
      a4:	70ff           	moveq #-1,d0
      a6:	2f40 0034      	move.l d0,52(sp)

	APTR *my_VisualInfo;

	if ((DOSBase = (struct DosLibrary *)OpenLibrary((CONST_STRPTR) "dos.library", 0)))
      aa:	43f9 0000 128c 	lea 128c <PutChar+0x4>,a1
      b0:	7000           	moveq #0,d0
      b2:	4eae fdd8      	jsr -552(a6)
      b6:	23c0 0000 34e4 	move.l d0,34e4 <DOSBase>
      bc:	6700 0618      	beq.w 6d6 <main+0x662>
	{
		if ((GfxBase = (struct GfxBase *)OpenLibrary((CONST_STRPTR) "graphics.library", 0)))
      c0:	2c79 0000 34f8 	movea.l 34f8 <SysBase>,a6
      c6:	43f9 0000 1298 	lea 1298 <PutChar+0x10>,a1
      cc:	7000           	moveq #0,d0
      ce:	4eae fdd8      	jsr -552(a6)
      d2:	23c0 0000 34f0 	move.l d0,34f0 <GfxBase>
      d8:	6700 05fc      	beq.w 6d6 <main+0x662>
		{
			if ((IntuitionBase = (struct IntuitionBase *)OpenLibrary((CONST_STRPTR) "intuition.library", 0)))
      dc:	2c79 0000 34f8 	movea.l 34f8 <SysBase>,a6
      e2:	43f9 0000 12a9 	lea 12a9 <PutChar+0x21>,a1
      e8:	7000           	moveq #0,d0
      ea:	4eae fdd8      	jsr -552(a6)
      ee:	2c40           	movea.l d0,a6
      f0:	23c0 0000 34f4 	move.l d0,34f4 <IntuitionBase>
      f6:	6700 05de      	beq.w 6d6 <main+0x662>
			{
				if ((GolScreen = (struct Screen *)OpenScreenTags(NULL,
      fa:	2f7c 8000 003a 	move.l #-2147483590,56(sp)
     100:	0038 
     102:	7434           	moveq #52,d2
     104:	d48f           	add.l sp,d2
     106:	2f42 003c      	move.l d2,60(sp)
     10a:	2f7c 8000 0032 	move.l #-2147483598,64(sp)
     110:	0040 
     112:	2f7c 0000 8000 	move.l #32768,68(sp)
     118:	0044 
     11a:	2f7c 8000 0025 	move.l #-2147483611,72(sp)
     120:	0048 
     122:	7604           	moveq #4,d3
     124:	2f43 004c      	move.l d3,76(sp)
     128:	2f7c 8000 0028 	move.l #-2147483608,80(sp)
     12e:	0050 
     130:	2f7c 0000 12bb 	move.l #4795,84(sp)
     136:	0054 
     138:	2f7c 8000 002d 	move.l #-2147483603,88(sp)
     13e:	0058 
     140:	700f           	moveq #15,d0
     142:	2f40 005c      	move.l d0,92(sp)
     146:	2f7c 8000 0026 	move.l #-2147483610,96(sp)
     14c:	0060 
     14e:	2f43 0064      	move.l d3,100(sp)
     152:	2f7c 8000 0027 	move.l #-2147483609,104(sp)
     158:	0068 
     15a:	7408           	moveq #8,d2
     15c:	2f42 006c      	move.l d2,108(sp)
     160:	42af 0070      	clr.l 112(sp)
     164:	91c8           	suba.l a0,a0
     166:	43ef 0038      	lea 56(sp),a1
     16a:	4eae fd9c      	jsr -612(a6)
     16e:	23c0 0000 34e8 	move.l d0,34e8 <GolScreen>
     174:	6700 0560      	beq.w 6d6 <main+0x662>
																 SA_DetailPen, 4,
																 SA_BlockPen, 8,
																 TAG_END)))
				{

					if ((GadToolsBase = (struct Library *)OpenLibrary((CONST_STRPTR) "gadtools.library", 0)))
     178:	2c79 0000 34f8 	movea.l 34f8 <SysBase>,a6
     17e:	43f9 0000 12d3 	lea 12d3 <PutChar+0x4b>,a1
     184:	7000           	moveq #0,d0
     186:	4eae fdd8      	jsr -552(a6)
     18a:	23c0 0000 34ec 	move.l d0,34ec <GadToolsBase>
     190:	6700 0544      	beq.w 6d6 <main+0x662>
					{
						if ((GolMainWindow = (struct Window *)OpenWindowTags(NULL,
     194:	2f7c 8000 0070 	move.l #-2147483536,56(sp)
     19a:	0038 
     19c:	2f79 0000 34e8 	move.l 34e8 <GolScreen>,60(sp)
     1a2:	003c 
     1a4:	2f7c 8000 0064 	move.l #-2147483548,64(sp)
     1aa:	0040 
     1ac:	42af 0044      	clr.l 68(sp)
     1b0:	2f7c 8000 0065 	move.l #-2147483547,72(sp)
     1b6:	0048 
     1b8:	761e           	moveq #30,d3
     1ba:	2f43 004c      	move.l d3,76(sp)
     1be:	2f7c 8000 0066 	move.l #-2147483546,80(sp)
     1c4:	0050 
     1c6:	7064           	moveq #100,d0
     1c8:	2f40 0054      	move.l d0,84(sp)
     1cc:	2f7c 8000 0067 	move.l #-2147483545,88(sp)
     1d2:	0058 
     1d4:	2079 0000 3502 	movea.l 3502 <GolMainWindow>,a0
     1da:	3039 0000 3516 	move.w 3516 <GameMatrix+0xe>,d0
     1e0:	c0f9 0000 350c 	mulu.w 350c <GameMatrix+0x4>,d0
     1e6:	1228 0037      	move.b 55(a0),d1
     1ea:	4881           	ext.w d1
     1ec:	3401           	move.w d1,d2
     1ee:	48c2           	ext.l d2
     1f0:	2440           	movea.l d0,a2
     1f2:	43f2 2800      	lea (0,a2,d2.l),a1
     1f6:	1028 0039      	move.b 57(a0),d0
     1fa:	4880           	ext.w d0
     1fc:	43f1 0000      	lea (0,a1,d0.w),a1
     200:	2f49 005c      	move.l a1,92(sp)
     204:	2f7c 8000 0075 	move.l #-2147483531,96(sp)
     20a:	0060 
     20c:	2f7c 0000 0100 	move.l #256,100(sp)
     212:	0064 
     214:	2f7c 8000 0074 	move.l #-2147483532,104(sp)
     21a:	0068 
     21c:	2f7c 0000 0280 	move.l #640,108(sp)
     222:	006c 
     224:	2f7c 8000 006e 	move.l #-2147483538,112(sp)
     22a:	0070 
     22c:	2f7c 0000 12e4 	move.l #4836,116(sp)
     232:	0074 
     234:	2f7c 8000 0083 	move.l #-2147483517,120(sp)
     23a:	0078 
     23c:	7601           	moveq #1,d3
     23e:	2f43 007c      	move.l d3,124(sp)
     242:	2f7c 8000 0084 	move.l #-2147483516,128(sp)
     248:	0080 
     24a:	2f43 0084      	move.l d3,132(sp)
     24e:	2f7c 8000 0081 	move.l #-2147483519,136(sp)
     254:	0088 
     256:	2f43 008c      	move.l d3,140(sp)
     25a:	2f7c 8000 0082 	move.l #-2147483518,144(sp)
     260:	0090 
     262:	2f43 0094      	move.l d3,148(sp)
     266:	2f7c 8000 0091 	move.l #-2147483503,152(sp)
     26c:	0098 
     26e:	2f43 009c      	move.l d3,156(sp)
     272:	2f7c 8000 0086 	move.l #-2147483514,160(sp)
     278:	00a0 
     27a:	2f43 00a4      	move.l d3,164(sp)
     27e:	2f7c 8000 0093 	move.l #-2147483501,168(sp)
     284:	00a8 
     286:	2f43 00ac      	move.l d3,172(sp)
     28a:	2f7c 8000 0089 	move.l #-2147483511,176(sp)
     290:	00b0 
     292:	2f43 00b4      	move.l d3,180(sp)
     296:	2f7c 8000 006f 	move.l #-2147483537,184(sp)
     29c:	00b8 
     29e:	2f7c 0000 12ec 	move.l #4844,188(sp)
     2a4:	00bc 
     2a6:	2f7c 8000 006a 	move.l #-2147483542,192(sp)
     2ac:	00c0 
     2ae:	2f7c 0000 031c 	move.l #796,196(sp)
     2b4:	00c4 
     2b6:	2f7c 8000 0068 	move.l #-2147483544,200(sp)
     2bc:	00c8 
     2be:	42af 00cc      	clr.l 204(sp)
     2c2:	2f7c 8000 0069 	move.l #-2147483543,208(sp)
     2c8:	00d0 
     2ca:	42af 00d4      	clr.l 212(sp)
     2ce:	42af 00d8      	clr.l 216(sp)
     2d2:	2c79 0000 34f4 	movea.l 34f4 <IntuitionBase>,a6
     2d8:	91c8           	suba.l a0,a0
     2da:	43ef 0038      	lea 56(sp),a1
     2de:	4eae fda2      	jsr -606(a6)
     2e2:	2040           	movea.l d0,a0
     2e4:	23c0 0000 3502 	move.l d0,3502 <GolMainWindow>
     2ea:	6700 03ea      	beq.w 6d6 <main+0x662>
																			 WA_DetailPen, 0,
																			 WA_BlockPen, 0,
																			 TAG_END)))

						{
							WindowLimits(GolMainWindow,
     2ee:	3039 0000 3514 	move.w 3514 <GameMatrix+0xc>,d0
     2f4:	c0f9 0000 350e 	mulu.w 350e <GameMatrix+0x6>,d0
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
     316:	3239 0000 3516 	move.w 3516 <GameMatrix+0xe>,d1
     31c:	c2f9 0000 350c 	mulu.w 350c <GameMatrix+0x4>,d1
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
     33e:	2c79 0000 34f4 	movea.l 34f4 <IntuitionBase>,a6
     344:	2400           	move.l d0,d2
     346:	2609           	move.l a1,d3
     348:	4eae fec2      	jsr -318(a6)
										 GameMatrix.CellSizeH * GameMatrix.Columns + GolMainWindow->BorderLeft + GolMainWindow->BorderRight,
										 GameMatrix.CellSizeV * GameMatrix.Rows + GolMainWindow->BorderTop + GolMainWindow->BorderBottom,
										 GameMatrix.CellSizeH * GameMatrix.Columns + GolMainWindow->BorderLeft + GolMainWindow->BorderRight,
										 GameMatrix.CellSizeV * GameMatrix.Rows + GolMainWindow->BorderTop + GolMainWindow->BorderBottom);

							my_VisualInfo = GetVisualInfo(GolMainWindow->WScreen, TAG_END);
     34c:	42af 0038      	clr.l 56(sp)
     350:	2c79 0000 34ec 	movea.l 34ec <GadToolsBase>,a6
     356:	2079 0000 3502 	movea.l 3502 <GolMainWindow>,a0
     35c:	2068 002e      	movea.l 46(a0),a0
     360:	43ef 0038      	lea 56(sp),a1
     364:	4eae ff82      	jsr -126(a6)
     368:	2400           	move.l d0,d2
							MainMenuStrip = CreateMenus(GolMainMenu, TAG_END);
     36a:	42af 0038      	clr.l 56(sp)
     36e:	2c79 0000 34ec 	movea.l 34ec <GadToolsBase>,a6
     374:	41f9 0000 3378 	lea 3378 <GolMainMenu>,a0
     37a:	43ef 0038      	lea 56(sp),a1
     37e:	4eae ffd0      	jsr -48(a6)
     382:	2040           	movea.l d0,a0
     384:	23c0 0000 34fe 	move.l d0,34fe <MainMenuStrip>
							LayoutMenus(MainMenuStrip, my_VisualInfo, TAG_END);
     38a:	42af 0038      	clr.l 56(sp)
     38e:	2c79 0000 34ec 	movea.l 34ec <GadToolsBase>,a6
     394:	2242           	movea.l d2,a1
     396:	45ef 0038      	lea 56(sp),a2
     39a:	4eae ffbe      	jsr -66(a6)
							SetMenuStrip(GolMainWindow, MainMenuStrip);
     39e:	2c79 0000 34f4 	movea.l 34f4 <IntuitionBase>,a6
     3a4:	2079 0000 3502 	movea.l 3502 <GolMainWindow>,a0
     3aa:	2279 0000 34fe 	movea.l 34fe <MainMenuStrip>,a1
     3b0:	4eae fef8      	jsr -264(a6)
							//Allocate memory for the cell's data
							GameMatrix.Playfield = AllocMem(GameMatrix.Columns * sizeof(GameOfLifeCell *), MEMF_ANY | MEMF_CLEAR);
     3b4:	7000           	moveq #0,d0
     3b6:	3039 0000 350e 	move.w 350e <GameMatrix+0x6>,d0
     3bc:	2c79 0000 34f8 	movea.l 34f8 <SysBase>,a6
     3c2:	e588           	lsl.l #2,d0
     3c4:	7201           	moveq #1,d1
     3c6:	4841           	swap d1
     3c8:	4eae ff3a      	jsr -198(a6)
     3cc:	41f9 0000 3508 	lea 3508 <GameMatrix>,a0
     3d2:	2080           	move.l d0,(a0)
							for (int i = 0; i < GameMatrix.Columns; i++)
     3d4:	4a79 0000 350e 	tst.w 350e <GameMatrix+0x6>
     3da:	6740           	beq.s 41c <main+0x3a8>
     3dc:	7600           	moveq #0,d3
     3de:	7400           	moveq #0,d2
							{
								GameMatrix.Playfield[i] = AllocMem(GameMatrix.Rows * sizeof(GameOfLifeCell), MEMF_ANY | MEMF_CLEAR);
     3e0:	7801           	moveq #1,d4
     3e2:	4844           	swap d4
     3e4:	7200           	moveq #0,d1
     3e6:	3239 0000 350c 	move.w 350c <GameMatrix+0x4>,d1
     3ec:	2001           	move.l d1,d0
     3ee:	d081           	add.l d1,d0
     3f0:	d081           	add.l d1,d0
     3f2:	2c79 0000 34f8 	movea.l 34f8 <SysBase>,a6
     3f8:	d080           	add.l d0,d0
     3fa:	2204           	move.l d4,d1
     3fc:	4eae ff3a      	jsr -198(a6)
     400:	43f9 0000 3508 	lea 3508 <GameMatrix>,a1
     406:	2051           	movea.l (a1),a0
     408:	2180 3800      	move.l d0,(0,a0,d3.l)
							for (int i = 0; i < GameMatrix.Columns; i++)
     40c:	5282           	addq.l #1,d2
     40e:	5883           	addq.l #4,d3
     410:	7000           	moveq #0,d0
     412:	3039 0000 350e 	move.w 350e <GameMatrix+0x6>,d0
     418:	b082           	cmp.l d2,d0
     41a:	6ec8           	bgt.s 3e4 <main+0x370>
	return RETURN_ERROR;
}

int MainLoop()
{
	DrawCells(GolMainWindow, TRUE);
     41c:	2f39 0000 3502 	move.l 3502 <GolMainWindow>,-(sp)
     422:	4eb9 0000 0df0 	jsr df0 <DrawCells.constprop.1>

	while (AppRunning)
     428:	588f           	addq.l #4,sp
     42a:	4a79 0000 34e0 	tst.w 34e0 <AppRunning>
     430:	6700 01ec      	beq.w 61e <main+0x5aa>
	{
		EventLoop(GolMainWindow, MainMenuStrip);
     434:	2639 0000 34fe 	move.l 34fe <MainMenuStrip>,d3
     43a:	2679 0000 3502 	movea.l 3502 <GolMainWindow>,a3
	SetDrMd(rport, JAM2);
}

void ToggleCellStatus(WORD coordX, WORD coordY)
{
	int x = coordX / GameMatrix.CellSizeH;
     440:	49f9 0000 11fe 	lea 11fe <__divsi3>,a4
	while ((message = (struct IntuiMessage *)GetMsg(theWindow->UserPort)))
     446:	2c79 0000 34f8 	movea.l 34f8 <SysBase>,a6
     44c:	206b 0056      	movea.l 86(a3),a0
     450:	4eae fe8c      	jsr -372(a6)
     454:	2440           	movea.l d0,a2
     456:	4a80           	tst.l d0
     458:	6700 00ca      	beq.w 524 <main+0x4b0>
		msg_class = message->Class;
     45c:	242a 0014      	move.l 20(a2),d2
		msg_code = message->Code;
     460:	382a 0018      	move.w 24(a2),d4
		coordX = message->MouseX - theWindow->BorderLeft;
     464:	3a2a 0020      	move.w 32(a2),d5
     468:	102b 0036      	move.b 54(a3),d0
     46c:	3a40           	movea.w d0,a5
		coordY = message->MouseY - theWindow->BorderTop;
     46e:	3c2a 0022      	move.w 34(a2),d6
     472:	1e2b 0037      	move.b 55(a3),d7
		ReplyMsg((struct Message *)message);
     476:	2c79 0000 34f8 	movea.l 34f8 <SysBase>,a6
     47c:	224a           	movea.l a2,a1
     47e:	4eae fe86      	jsr -378(a6)
		switch (msg_class)
     482:	7010           	moveq #16,d0
     484:	b082           	cmp.l d2,d0
     486:	67be           	beq.s 446 <main+0x3d2>
     488:	6500 0258      	bcs.w 6e2 <main+0x66e>
     48c:	7004           	moveq #4,d0
     48e:	b082           	cmp.l d2,d0
     490:	6700 026c      	beq.w 6fe <main+0x68a>
     494:	5182           	subq.l #8,d2
     496:	66ae           	bne.s 446 <main+0x3d2>
			switch (msg_code)
     498:	0c44 0068      	cmpi.w #104,d4
     49c:	66a8           	bne.s 446 <main+0x3d2>
		coordX = message->MouseX - theWindow->BorderLeft;
     49e:	300d           	move.w a5,d0
     4a0:	4880           	ext.w d0
     4a2:	9a40           	sub.w d0,d5
	int x = coordX / GameMatrix.CellSizeH;
     4a4:	7000           	moveq #0,d0
     4a6:	3039 0000 3514 	move.w 3514 <GameMatrix+0xc>,d0
     4ac:	2f00           	move.l d0,-(sp)
     4ae:	3045           	movea.w d5,a0
     4b0:	2f08           	move.l a0,-(sp)
     4b2:	4e94           	jsr (a4)
     4b4:	508f           	addq.l #8,sp
     4b6:	2400           	move.l d0,d2
	int y = coordY / GameMatrix.CellSizeV;

	if (!(x < 0 || x > GameMatrix.Columns - 1 || y < 0 || y > GameMatrix.Rows))
     4b8:	7000           	moveq #0,d0
     4ba:	3039 0000 350e 	move.w 350e <GameMatrix+0x6>,d0
     4c0:	b082           	cmp.l d2,d0
     4c2:	6382           	bls.s 446 <main+0x3d2>
		coordY = message->MouseY - theWindow->BorderTop;
     4c4:	4887           	ext.w d7
     4c6:	9c47           	sub.w d7,d6
	int y = coordY / GameMatrix.CellSizeV;
     4c8:	7000           	moveq #0,d0
     4ca:	3039 0000 3516 	move.w 3516 <GameMatrix+0xe>,d0
     4d0:	2f00           	move.l d0,-(sp)
     4d2:	3246           	movea.w d6,a1
     4d4:	2f09           	move.l a1,-(sp)
     4d6:	4e94           	jsr (a4)
     4d8:	508f           	addq.l #8,sp
	if (!(x < 0 || x > GameMatrix.Columns - 1 || y < 0 || y > GameMatrix.Rows))
     4da:	7200           	moveq #0,d1
     4dc:	3239 0000 350c 	move.w 350c <GameMatrix+0x4>,d1
     4e2:	b280           	cmp.l d0,d1
     4e4:	6500 ff60      	bcs.w 446 <main+0x3d2>
	{

		if (GameMatrix.Playfield[x][y].Status)
     4e8:	45f9 0000 3508 	lea 3508 <GameMatrix>,a2
     4ee:	2252           	movea.l (a2),a1
     4f0:	d482           	add.l d2,d2
     4f2:	d482           	add.l d2,d2
     4f4:	2040           	movea.l d0,a0
     4f6:	d1c0           	adda.l d0,a0
     4f8:	d1c0           	adda.l d0,a0
     4fa:	d1c8           	adda.l a0,a0
     4fc:	d1f1 2800      	adda.l (0,a1,d2.l),a0
     500:	4a50           	tst.w (a0)
     502:	6700 08d0      	beq.w dd4 <main+0xd60>
		{
			GameMatrix.Playfield[x][y].Status = 0;
     506:	4250           	clr.w (a0)
			GameMatrix.Playfield[x][y].StatusChanged = TRUE;
     508:	317c 0001 0002 	move.w #1,2(a0)
	while ((message = (struct IntuiMessage *)GetMsg(theWindow->UserPort)))
     50e:	2c79 0000 34f8 	movea.l 34f8 <SysBase>,a6
     514:	206b 0056      	movea.l 86(a3),a0
     518:	4eae fe8c      	jsr -372(a6)
     51c:	2440           	movea.l d0,a2
     51e:	4a80           	tst.l d0
     520:	6600 ff3a      	bne.w 45c <main+0x3e8>
{
	GameOfLifeCell **pf = GameMatrix.Playfield;

	for (int y = 0; y < GameMatrix.Rows; y++)
	{
		for (int x = 0; x < GameMatrix.Columns; x++)
     524:	3039 0000 350e 	move.w 350e <GameMatrix+0x6>,d0
		if (GameRunning)
     52a:	4a79 0000 34fc 	tst.w 34fc <GameRunning>
     530:	6600 0362      	bne.w 894 <main+0x820>
		DrawCells(GolMainWindow, FALSE);
     534:	2479 0000 3502 	movea.l 3502 <GolMainWindow>,a2
	for (int x = 0; x < GameMatrix.Columns; x++)
     53a:	4a40           	tst.w d0
     53c:	6700 00d6      	beq.w 614 <main+0x5a0>
     540:	3f79 0000 350c 	move.w 350c <GameMatrix+0x4>,50(sp)
     546:	0032 
		for (int y = 0; y < GameMatrix.Rows; y++)
     548:	302f 0032      	move.w 50(sp),d0
     54c:	7c00           	moveq #0,d6
	for (int x = 0; x < GameMatrix.Columns; x++)
     54e:	7e00           	moveq #0,d7
		for (int y = 0; y < GameMatrix.Rows; y++)
     550:	4a40           	tst.w d0
     552:	6700 00c0      	beq.w 614 <main+0x5a0>
     556:	7a00           	moveq #0,d5
     558:	7800           	moveq #0,d4
			if (!GameMatrix.Playfield[x][y].StatusChanged && !forceFull)
     55a:	43f9 0000 3508 	lea 3508 <GameMatrix>,a1
     560:	2051           	movea.l (a1),a0
     562:	2070 6800      	movea.l (0,a0,d6.l),a0
     566:	d1c5           	adda.l d5,a0
     568:	4a68 0002      	tst.w 2(a0)
     56c:	6700 0082      	beq.w 5f0 <main+0x57c>
			GameMatrix.Playfield[x][y].StatusChanged = FALSE;
     570:	4268 0002      	clr.w 2(a0)
				SetAPen(theWindow->RPort, GameMatrix.ColorAlive);
     574:	226a 0032      	movea.l 50(a2),a1
     578:	2c79 0000 34f0 	movea.l 34f0 <GfxBase>,a6
     57e:	7000           	moveq #0,d0
			if (GameMatrix.Playfield[x][y].Status)
     580:	4a50           	tst.w (a0)
     582:	6700 0416      	beq.w 99a <main+0x926>
				SetAPen(theWindow->RPort, GameMatrix.ColorAlive);
     586:	3039 0000 3510 	move.w 3510 <GameMatrix+0x8>,d0
     58c:	4eae feaa      	jsr -342(a6)
			RectFill(theWindow->RPort,
     590:	226a 0032      	movea.l 50(a2),a1
     594:	7400           	moveq #0,d2
     596:	3439 0000 3514 	move.w 3514 <GameMatrix+0xc>,d2
     59c:	2f07           	move.l d7,-(sp)
     59e:	2f02           	move.l d2,-(sp)
     5a0:	2f49 0036      	move.l a1,54(sp)
     5a4:	4eb9 0000 1180 	jsr 1180 <__mulsi3>
     5aa:	508f           	addq.l #8,sp
     5ac:	2640           	movea.l d0,a3
     5ae:	4beb 0001      	lea 1(a3),a5
     5b2:	7000           	moveq #0,d0
     5b4:	3039 0000 3516 	move.w 3516 <GameMatrix+0xe>,d0
     5ba:	2840           	movea.l d0,a4
     5bc:	2f04           	move.l d4,-(sp)
     5be:	2f0c           	move.l a4,-(sp)
     5c0:	4eb9 0000 1180 	jsr 1180 <__mulsi3>
     5c6:	508f           	addq.l #8,sp
     5c8:	2600           	move.l d0,d3
     5ca:	2c79 0000 34f0 	movea.l 34f0 <GfxBase>,a6
     5d0:	226f 002e      	movea.l 46(sp),a1
     5d4:	200d           	move.l a5,d0
     5d6:	2203           	move.l d3,d1
     5d8:	5281           	addq.l #1,d1
     5da:	47f3 28ff      	lea (-1,a3,d2.l),a3
     5de:	240b           	move.l a3,d2
     5e0:	49f4 38ff      	lea (-1,a4,d3.l),a4
     5e4:	260c           	move.l a4,d3
     5e6:	4eae fece      	jsr -306(a6)
		for (int y = 0; y < GameMatrix.Rows; y++)
     5ea:	3039 0000 350c 	move.w 350c <GameMatrix+0x4>,d0
     5f0:	5284           	addq.l #1,d4
     5f2:	5c85           	addq.l #6,d5
     5f4:	7200           	moveq #0,d1
     5f6:	3200           	move.w d0,d1
     5f8:	b284           	cmp.l d4,d1
     5fa:	6e00 ff5e      	bgt.w 55a <main+0x4e6>
	for (int x = 0; x < GameMatrix.Columns; x++)
     5fe:	5287           	addq.l #1,d7
     600:	7200           	moveq #0,d1
     602:	3239 0000 350e 	move.w 350e <GameMatrix+0x6>,d1
     608:	be81           	cmp.l d1,d7
     60a:	6c08           	bge.s 614 <main+0x5a0>
     60c:	5886           	addq.l #4,d6
		for (int y = 0; y < GameMatrix.Rows; y++)
     60e:	4a40           	tst.w d0
     610:	6600 ff44      	bne.w 556 <main+0x4e2>
	while (AppRunning)
     614:	4a79 0000 34e0 	tst.w 34e0 <AppRunning>
     61a:	6600 fe18      	bne.w 434 <main+0x3c0>
	FreeMem((APTR)GameMatrix.Playfield, GameMatrix.Rows * GameMatrix.Columns * sizeof(GameOfLifeCell));
     61e:	3239 0000 350c 	move.w 350c <GameMatrix+0x4>,d1
     624:	c2f9 0000 350e 	mulu.w 350e <GameMatrix+0x6>,d1
     62a:	2001           	move.l d1,d0
     62c:	d081           	add.l d1,d0
     62e:	d081           	add.l d1,d0
     630:	2c79 0000 34f8 	movea.l 34f8 <SysBase>,a6
     636:	45f9 0000 3508 	lea 3508 <GameMatrix>,a2
     63c:	2252           	movea.l (a2),a1
     63e:	d080           	add.l d0,d0
     640:	4eae ff2e      	jsr -210(a6)
	if (GolMainWindow)
     644:	2079 0000 3502 	movea.l 3502 <GolMainWindow>,a0
     64a:	b0fc 0000      	cmpa.w #0,a0
     64e:	670a           	beq.s 65a <main+0x5e6>
		CloseWindow(GolMainWindow);
     650:	2c79 0000 34f4 	movea.l 34f4 <IntuitionBase>,a6
     656:	4eae ffb8      	jsr -72(a6)
	if (GadToolsBase)
     65a:	2279 0000 34ec 	movea.l 34ec <GadToolsBase>,a1
     660:	b2fc 0000      	cmpa.w #0,a1
     664:	670a           	beq.s 670 <main+0x5fc>
		CloseLibrary((struct Library *)GadToolsBase);
     666:	2c79 0000 34f8 	movea.l 34f8 <SysBase>,a6
     66c:	4eae fe62      	jsr -414(a6)
	if (GolScreen)
     670:	2079 0000 34e8 	movea.l 34e8 <GolScreen>,a0
     676:	b0fc 0000      	cmpa.w #0,a0
     67a:	670a           	beq.s 686 <main+0x612>
		CloseScreen(GolScreen);
     67c:	2c79 0000 34f4 	movea.l 34f4 <IntuitionBase>,a6
     682:	4eae ffbe      	jsr -66(a6)
	if (GfxBase)
     686:	2279 0000 34f0 	movea.l 34f0 <GfxBase>,a1
     68c:	b2fc 0000      	cmpa.w #0,a1
     690:	670a           	beq.s 69c <main+0x628>
		CloseLibrary((struct Library *)GfxBase);
     692:	2c79 0000 34f8 	movea.l 34f8 <SysBase>,a6
     698:	4eae fe62      	jsr -414(a6)
	if (IntuitionBase)
     69c:	2279 0000 34f4 	movea.l 34f4 <IntuitionBase>,a1
     6a2:	b2fc 0000      	cmpa.w #0,a1
     6a6:	670a           	beq.s 6b2 <main+0x63e>
		CloseLibrary((struct Library *)IntuitionBase);
     6a8:	2c79 0000 34f8 	movea.l 34f8 <SysBase>,a6
     6ae:	4eae fe62      	jsr -414(a6)
	if (DOSBase)
     6b2:	2279 0000 34e4 	movea.l 34e4 <DOSBase>,a1
     6b8:	b2fc 0000      	cmpa.w #0,a1
     6bc:	6700 0724      	beq.w de2 <main+0xd6e>
		CloseLibrary((struct Library *)DOSBase);
     6c0:	2c79 0000 34f8 	movea.l 34f8 <SysBase>,a6
     6c6:	4eae fe62      	jsr -414(a6)
     6ca:	7000           	moveq #0,d0
}
     6cc:	4cdf 7cfc      	movem.l (sp)+,d2-d7/a2-a6
     6d0:	4fef 00b0      	lea 176(sp),sp
     6d4:	4e75           	rts
		return RETURN_FAIL;
     6d6:	7014           	moveq #20,d0
}
     6d8:	4cdf 7cfc      	movem.l (sp)+,d2-d7/a2-a6
     6dc:	4fef 00b0      	lea 176(sp),sp
     6e0:	4e75           	rts
		switch (msg_class)
     6e2:	0c82 0000 0100 	cmpi.l #256,d2
     6e8:	6722           	beq.s 70c <main+0x698>
     6ea:	0c82 0000 0200 	cmpi.l #512,d2
     6f0:	6600 fd54      	bne.w 446 <main+0x3d2>
			AppRunning = FALSE;
     6f4:	4279 0000 34e0 	clr.w 34e0 <AppRunning>
			break;
     6fa:	6000 fd4a      	bra.w 446 <main+0x3d2>
			DrawCells(theWindow, TRUE);
     6fe:	2f0b           	move.l a3,-(sp)
     700:	4eb9 0000 0df0 	jsr df0 <DrawCells.constprop.1>
     706:	588f           	addq.l #4,sp
     708:	6000 fd3c      	bra.w 446 <main+0x3d2>
			menuNumber = message->Code;
     70c:	342a 0018      	move.w 24(a2),d2
			while ((menuNumber != MENUNULL) && (AppRunning))
     710:	0c42 ffff      	cmpi.w #-1,d2
     714:	6700 fd30      	beq.w 446 <main+0x3d2>
     718:	4a79 0000 34e0 	tst.w 34e0 <AppRunning>
     71e:	6700 fd26      	beq.w 446 <main+0x3d2>
				item = ItemAddress(theMenu, menuNumber);
     722:	2c79 0000 34f4 	movea.l 34f4 <IntuitionBase>,a6
     728:	2043           	movea.l d3,a0
     72a:	3002           	move.w d2,d0
     72c:	4eae ff70      	jsr -144(a6)
     730:	2a40           	movea.l d0,a5
				menuNum = MENUNUM(menuNumber);
     732:	3002           	move.w d2,d0
     734:	0240 001f      	andi.w #31,d0
				if ((menuNum == 0) && (itemNum == 5))
     738:	6642           	bne.s 77c <main+0x708>
				itemNum = ITEMNUM(menuNumber);
     73a:	3002           	move.w d2,d0
     73c:	ea48           	lsr.w #5,d0
     73e:	0240 003f      	andi.w #63,d0
				if ((menuNum == 0) && (itemNum == 5))
     742:	0c40 0005      	cmpi.w #5,d0
     746:	6742           	beq.s 78a <main+0x716>
				if ((menuNum == 0) && (itemNum == 3) && (subNum == 2))
     748:	0c40 0003      	cmpi.w #3,d0
     74c:	662e           	bne.s 77c <main+0x708>
				subNum = SUBNUM(menuNumber);
     74e:	700b           	moveq #11,d0
     750:	e06a           	lsr.w d0,d2
				if ((menuNum == 0) && (itemNum == 3) && (subNum == 2))
     752:	0c42 0002      	cmpi.w #2,d2
     756:	6700 0090      	beq.w 7e8 <main+0x774>
				if ((menuNum == 0) && (itemNum == 3) && (subNum == 0))
     75a:	4a42           	tst.w d2
     75c:	6658           	bne.s 7b6 <main+0x742>
					SetWindowTitles(theWindow, (STRPTR) "Running", (STRPTR)-1);
     75e:	2c79 0000 34f4 	movea.l 34f4 <IntuitionBase>,a6
     764:	204b           	movea.l a3,a0
     766:	43f9 0000 1305 	lea 1305 <PutChar+0x7d>,a1
     76c:	347c ffff      	movea.w #-1,a2
     770:	4eae feec      	jsr -276(a6)
					GameRunning = TRUE;
     774:	33fc 0001 0000 	move.w #1,34fc <GameRunning>
     77a:	34fc 
				menuNumber = item->NextSelect;
     77c:	342d 0020      	move.w 32(a5),d2
			while ((menuNumber != MENUNULL) && (AppRunning))
     780:	0c42 ffff      	cmpi.w #-1,d2
     784:	6692           	bne.s 718 <main+0x6a4>
     786:	6000 fcbe      	bra.w 446 <main+0x3d2>
					AppRunning = FALSE;
     78a:	4279 0000 34e0 	clr.w 34e0 <AppRunning>
					SetWindowTitles(theWindow, (STRPTR) "Running", (STRPTR)-1);
     790:	2c79 0000 34f4 	movea.l 34f4 <IntuitionBase>,a6
     796:	204b           	movea.l a3,a0
     798:	43f9 0000 1305 	lea 1305 <PutChar+0x7d>,a1
     79e:	347c ffff      	movea.w #-1,a2
     7a2:	4eae feec      	jsr -276(a6)
				menuNumber = item->NextSelect;
     7a6:	342d 0020      	move.w 32(a5),d2
			while ((menuNumber != MENUNULL) && (AppRunning))
     7aa:	0c42 ffff      	cmpi.w #-1,d2
     7ae:	6600 ff68      	bne.w 718 <main+0x6a4>
     7b2:	6000 fc92      	bra.w 446 <main+0x3d2>
				if ((menuNum == 0) && (itemNum == 3) && (subNum == 1))
     7b6:	0c42 0001      	cmpi.w #1,d2
     7ba:	66c0           	bne.s 77c <main+0x708>
					SetWindowTitles(theWindow, (STRPTR) "Stopped", (STRPTR)-1);
     7bc:	2c79 0000 34f4 	movea.l 34f4 <IntuitionBase>,a6
     7c2:	204b           	movea.l a3,a0
     7c4:	43f9 0000 12e4 	lea 12e4 <PutChar+0x5c>,a1
     7ca:	347c ffff      	movea.w #-1,a2
     7ce:	4eae feec      	jsr -276(a6)
					GameRunning = FALSE;
     7d2:	4279 0000 34fc 	clr.w 34fc <GameRunning>
				menuNumber = item->NextSelect;
     7d8:	342d 0020      	move.w 32(a5),d2
			while ((menuNumber != MENUNULL) && (AppRunning))
     7dc:	0c42 ffff      	cmpi.w #-1,d2
     7e0:	6600 ff36      	bne.w 718 <main+0x6a4>
     7e4:	6000 fc60      	bra.w 446 <main+0x3d2>
	for (int x = 0; x < GameMatrix.Columns; x++)
     7e8:	3239 0000 350e 	move.w 350e <GameMatrix+0x6>,d1
     7ee:	678c           	beq.s 77c <main+0x708>
		for (int y = 0; y < GameMatrix.Rows; y++)
     7f0:	3439 0000 350c 	move.w 350c <GameMatrix+0x4>,d2
			GameMatrix.Playfield[x][y].Neighbours = 0;
     7f6:	41f9 0000 3508 	lea 3508 <GameMatrix>,a0
     7fc:	2250           	movea.l (a0),a1
     7fe:	673c           	beq.s 83c <main+0x7c8>
     800:	0281 0000 ffff 	andi.l #65535,d1
     806:	d281           	add.l d1,d1
     808:	d281           	add.l d1,d1
     80a:	d289           	add.l a1,d1
     80c:	0282 0000 ffff 	andi.l #65535,d2
     812:	2002           	move.l d2,d0
     814:	d082           	add.l d2,d0
     816:	d082           	add.l d2,d0
     818:	d080           	add.l d0,d0
		for (int y = 0; y < GameMatrix.Rows; y++)
     81a:	2059           	movea.l (a1)+,a0
     81c:	2408           	move.l a0,d2
     81e:	d480           	add.l d0,d2
			GameMatrix.Playfield[x][y].Neighbours = 0;
     820:	4268 0004      	clr.w 4(a0)
			GameMatrix.Playfield[x][y].Status = 0;
     824:	4250           	clr.w (a0)
			GameMatrix.Playfield[x][y].StatusChanged = TRUE;
     826:	317c 0001 0002 	move.w #1,2(a0)
		for (int y = 0; y < GameMatrix.Rows; y++)
     82c:	5c88           	addq.l #6,a0
     82e:	b1c2           	cmpa.l d2,a0
     830:	66ee           	bne.s 820 <main+0x7ac>
	for (int x = 0; x < GameMatrix.Columns; x++)
     832:	b289           	cmp.l a1,d1
     834:	66e4           	bne.s 81a <main+0x7a6>
     836:	3239 0000 350e 	move.w 350e <GameMatrix+0x6>,d1
     83c:	4a41           	tst.w d1
     83e:	6700 ff3c      	beq.w 77c <main+0x708>
		for (int y = 0; y < GameMatrix.Rows; y++)
     842:	3439 0000 350c 	move.w 350c <GameMatrix+0x4>,d2
			GameMatrix.Playfield[x][y].Neighbours = 0;
     848:	41f9 0000 3508 	lea 3508 <GameMatrix>,a0
     84e:	2250           	movea.l (a0),a1
     850:	6700 ff2a      	beq.w 77c <main+0x708>
     854:	0281 0000 ffff 	andi.l #65535,d1
     85a:	d281           	add.l d1,d1
     85c:	d281           	add.l d1,d1
     85e:	d289           	add.l a1,d1
     860:	0282 0000 ffff 	andi.l #65535,d2
     866:	2002           	move.l d2,d0
     868:	d082           	add.l d2,d0
     86a:	d082           	add.l d2,d0
     86c:	d080           	add.l d0,d0
		for (int y = 0; y < GameMatrix.Rows; y++)
     86e:	2059           	movea.l (a1)+,a0
     870:	2408           	move.l a0,d2
     872:	d480           	add.l d0,d2
			GameMatrix.Playfield[x][y].Neighbours = 0;
     874:	4268 0004      	clr.w 4(a0)
			GameMatrix.Playfield[x][y].Status = 0;
     878:	4250           	clr.w (a0)
			GameMatrix.Playfield[x][y].StatusChanged = TRUE;
     87a:	317c 0001 0002 	move.w #1,2(a0)
		for (int y = 0; y < GameMatrix.Rows; y++)
     880:	5c88           	addq.l #6,a0
     882:	b488           	cmp.l a0,d2
     884:	66ee           	bne.s 874 <main+0x800>
	for (int x = 0; x < GameMatrix.Columns; x++)
     886:	b3c1           	cmpa.l d1,a1
     888:	6700 fef2      	beq.w 77c <main+0x708>
		for (int y = 0; y < GameMatrix.Rows; y++)
     88c:	2059           	movea.l (a1)+,a0
     88e:	2408           	move.l a0,d2
     890:	d480           	add.l d0,d2
     892:	60e0           	bra.s 874 <main+0x800>
	GameOfLifeCell **pf = GameMatrix.Playfield;
     894:	43f9 0000 3508 	lea 3508 <GameMatrix>,a1
     89a:	2451           	movea.l (a1),a2
	for (int y = 0; y < GameMatrix.Rows; y++)
     89c:	3f79 0000 350c 	move.w 350c <GameMatrix+0x4>,50(sp)
     8a2:	0032 
     8a4:	7e00           	moveq #0,d7
     8a6:	3e2f 0032      	move.w 50(sp),d7
     8aa:	6700 fc88      	beq.w 534 <main+0x4c0>
		for (int x = 0; x < GameMatrix.Columns; x++)
     8ae:	7a00           	moveq #0,d5
     8b0:	3a00           	move.w d0,d5
     8b2:	6700 fc80      	beq.w 534 <main+0x4c0>
     8b6:	2605           	move.l d5,d3
     8b8:	5383           	subq.l #1,d3
     8ba:	7800           	moveq #0,d4
	for (int y = 0; y < GameMatrix.Rows; y++)
     8bc:	91c8           	suba.l a0,a0
						neighbours++;
					if (pf[x][y + 1].Status)
						neighbours++;
				}
			}
			else if (y > 0 && y < GameMatrix.Rows - 1) // rows between 1st and last
     8be:	2407           	move.l d7,d2
     8c0:	5382           	subq.l #1,d2
		for (int x = 0; x < GameMatrix.Columns; x++)
     8c2:	2c04           	move.l d4,d6
     8c4:	5d86           	subq.l #6,d6
     8c6:	2244           	movea.l d4,a1
     8c8:	5c84           	addq.l #6,d4
     8ca:	4a83           	tst.l d3
     8cc:	6600 0250      	bne.w b1e <main+0xaaa>
			else if (y > 0 && y < GameMatrix.Rows - 1) // rows between 1st and last
     8d0:	7000           	moveq #0,d0
     8d2:	2840           	movea.l d0,a4
     8d4:	d9c0           	adda.l d0,a4
     8d6:	d9cc           	adda.l a4,a4
     8d8:	49f2 c800      	lea (0,a2,a4.l),a4
			if (y == 0) // 1st row
     8dc:	b0fc 0000      	cmpa.w #0,a0
     8e0:	6600 0126      	bne.w a08 <main+0x994>
				if (x == 0) // 1st column
     8e4:	4a80           	tst.l d0
     8e6:	6600 017c      	bne.w a64 <main+0x9f0>
					if (pf[x + 1][y].Status)
     8ea:	266a 0004      	movea.l 4(a2),a3
     8ee:	4a53           	tst.w (a3)
     8f0:	56c1           	sne d1
     8f2:	4881           	ext.w d1
     8f4:	4441           	neg.w d1
					if (pf[x + 1][y + 1].Status)
     8f6:	4a6b 0006      	tst.w 6(a3)
     8fa:	6702           	beq.s 8fe <main+0x88a>
						neighbours++;
     8fc:	5241           	addq.w #1,d1
					if (pf[x][y + 1].Status)
     8fe:	2654           	movea.l (a4),a3
					if (pf[x][y + 1].Status)
     900:	2a52           	movea.l (a2),a5
     902:	4a6d 0006      	tst.w 6(a5)
     906:	675a           	beq.s 962 <main+0x8ee>
					if (pf[x - 1][y - 1].Status)
						neighbours++;
					if (pf[x - 1][y].Status)
						neighbours++;
					if (pf[x][y - 1].Status)
						neighbours++;
     908:	5241           	addq.w #1,d1
				}
			}

			if (!pf[x][y].Status && neighbours == 3)
     90a:	d7c9           	adda.l a1,a3
     90c:	4a53           	tst.w (a3)
     90e:	6658           	bne.s 968 <main+0x8f4>
     910:	0c41 0003      	cmpi.w #3,d1
     914:	676e           	beq.s 984 <main+0x910>
		for (int x = 0; x < GameMatrix.Columns; x++)
     916:	5280           	addq.l #1,d0
     918:	588c           	addq.l #4,a4
     91a:	b085           	cmp.l d5,d0
     91c:	6dbe           	blt.s 8dc <main+0x868>
	for (int y = 0; y < GameMatrix.Rows; y++)
     91e:	5288           	addq.l #1,a0
     920:	be88           	cmp.l a0,d7
     922:	669e           	bne.s 8c2 <main+0x84e>
		DrawCells(GolMainWindow, FALSE);
     924:	2479 0000 3502 	movea.l 3502 <GolMainWindow>,a2
		for (int y = 0; y < GameMatrix.Rows; y++)
     92a:	302f 0032      	move.w 50(sp),d0
     92e:	7c00           	moveq #0,d6
	for (int x = 0; x < GameMatrix.Columns; x++)
     930:	7e00           	moveq #0,d7
     932:	6000 fc1c      	bra.w 550 <main+0x4dc>
			else if (y==GameMatrix.Rows-1)// last row
     936:	b1c2           	cmpa.l d2,a0
     938:	6600 0112      	bne.w a4c <main+0x9d8>
				if (x == 0)
     93c:	4a80           	tst.l d0
     93e:	6600 042e      	bne.w d6e <main+0xcfa>
					if (pf[x][y - 1].Status)
     942:	2652           	movea.l (a2),a3
     944:	4a73 6800      	tst.w (0,a3,d6.l)
     948:	56c1           	sne d1
     94a:	4881           	ext.w d1
     94c:	4441           	neg.w d1
					if (pf[x + 1][y - 1].Status)
     94e:	2a6a 0004      	movea.l 4(a2),a5
     952:	4a75 6800      	tst.w (0,a5,d6.l)
     956:	6702           	beq.s 95a <main+0x8e6>
						neighbours++;
     958:	5241           	addq.w #1,d1
					if (pf[x][y + 1].Status)
     95a:	2654           	movea.l (a4),a3
					if (pf[x + 1][y].Status)
     95c:	4a75 9800      	tst.w (0,a5,a1.l)
     960:	66a6           	bne.s 908 <main+0x894>
			if (!pf[x][y].Status && neighbours == 3)
     962:	d7c9           	adda.l a1,a3
     964:	4a53           	tst.w (a3)
     966:	67ae           	beq.s 916 <main+0x8a2>
			{
				pf[x][y].Status = 1;
				pf[x][y].StatusChanged = TRUE;
				continue;
			}
			if (pf[x][y].Status && (neighbours < 2 || neighbours > 3))
     968:	5541           	subq.w #2,d1
     96a:	0c41 0001      	cmpi.w #1,d1
     96e:	63a6           	bls.s 916 <main+0x8a2>
			{
				pf[x][y].Status = 0;
     970:	4253           	clr.w (a3)
				pf[x][y].StatusChanged = TRUE;
     972:	377c 0001 0002 	move.w #1,2(a3)
		for (int x = 0; x < GameMatrix.Columns; x++)
     978:	5280           	addq.l #1,d0
     97a:	588c           	addq.l #4,a4
     97c:	b085           	cmp.l d5,d0
     97e:	6d00 ff5c      	blt.w 8dc <main+0x868>
     982:	609a           	bra.s 91e <main+0x8aa>
				pf[x][y].Status = 1;
     984:	36bc 0001      	move.w #1,(a3)
				pf[x][y].StatusChanged = TRUE;
     988:	377c 0001 0002 	move.w #1,2(a3)
		for (int x = 0; x < GameMatrix.Columns; x++)
     98e:	5280           	addq.l #1,d0
     990:	588c           	addq.l #4,a4
     992:	b085           	cmp.l d5,d0
     994:	6d00 ff46      	blt.w 8dc <main+0x868>
     998:	6084           	bra.s 91e <main+0x8aa>
				SetAPen(theWindow->RPort, GameMatrix.ColorDead);
     99a:	3039 0000 3512 	move.w 3512 <GameMatrix+0xa>,d0
     9a0:	4eae feaa      	jsr -342(a6)
			RectFill(theWindow->RPort,
     9a4:	226a 0032      	movea.l 50(a2),a1
     9a8:	7400           	moveq #0,d2
     9aa:	3439 0000 3514 	move.w 3514 <GameMatrix+0xc>,d2
     9b0:	2f07           	move.l d7,-(sp)
     9b2:	2f02           	move.l d2,-(sp)
     9b4:	2f49 0036      	move.l a1,54(sp)
     9b8:	4eb9 0000 1180 	jsr 1180 <__mulsi3>
     9be:	508f           	addq.l #8,sp
     9c0:	2640           	movea.l d0,a3
     9c2:	4beb 0001      	lea 1(a3),a5
     9c6:	7000           	moveq #0,d0
     9c8:	3039 0000 3516 	move.w 3516 <GameMatrix+0xe>,d0
     9ce:	2840           	movea.l d0,a4
     9d0:	2f04           	move.l d4,-(sp)
     9d2:	2f0c           	move.l a4,-(sp)
     9d4:	4eb9 0000 1180 	jsr 1180 <__mulsi3>
     9da:	508f           	addq.l #8,sp
     9dc:	2600           	move.l d0,d3
     9de:	2c79 0000 34f0 	movea.l 34f0 <GfxBase>,a6
     9e4:	226f 002e      	movea.l 46(sp),a1
     9e8:	200d           	move.l a5,d0
     9ea:	2203           	move.l d3,d1
     9ec:	5281           	addq.l #1,d1
     9ee:	47f3 28ff      	lea (-1,a3,d2.l),a3
     9f2:	240b           	move.l a3,d2
     9f4:	49f4 38ff      	lea (-1,a4,d3.l),a4
     9f8:	260c           	move.l a4,d3
     9fa:	4eae fece      	jsr -306(a6)
		for (int y = 0; y < GameMatrix.Rows; y++)
     9fe:	3039 0000 350c 	move.w 350c <GameMatrix+0x4>,d0
     a04:	6000 fbea      	bra.w 5f0 <main+0x57c>
			else if (y > 0 && y < GameMatrix.Rows - 1) // rows between 1st and last
     a08:	b1c2           	cmpa.l d2,a0
     a0a:	6c00 ff2a      	bge.w 936 <main+0x8c2>
				if (x == 0)
     a0e:	4a80           	tst.l d0
     a10:	6600 00b4      	bne.w ac6 <main+0xa52>
					if (pf[x][y - 1].Status)
     a14:	2652           	movea.l (a2),a3
     a16:	4a73 6800      	tst.w (0,a3,d6.l)
     a1a:	56c1           	sne d1
     a1c:	4881           	ext.w d1
     a1e:	4441           	neg.w d1
					if (pf[x][y + 1].Status)
     a20:	4a73 4800      	tst.w (0,a3,d4.l)
     a24:	6702           	beq.s a28 <main+0x9b4>
						neighbours++;
     a26:	5241           	addq.w #1,d1
					if (pf[x + 1][y].Status)
     a28:	2a6a 0004      	movea.l 4(a2),a5
     a2c:	4a75 9800      	tst.w (0,a5,a1.l)
     a30:	6702           	beq.s a34 <main+0x9c0>
						neighbours++;
     a32:	5241           	addq.w #1,d1
					if (pf[x + 1][y + 1].Status)
     a34:	4a75 4800      	tst.w (0,a5,d4.l)
     a38:	6702           	beq.s a3c <main+0x9c8>
						neighbours++;
     a3a:	5241           	addq.w #1,d1
					if (pf[x][y + 1].Status)
     a3c:	2654           	movea.l (a4),a3
					if (pf[x + 1][y - 1].Status)
     a3e:	4a75 6800      	tst.w (0,a5,d6.l)
     a42:	6700 fec6      	beq.w 90a <main+0x896>
						neighbours++;
     a46:	5241           	addq.w #1,d1
     a48:	6000 fec0      	bra.w 90a <main+0x896>
			if (!pf[x][y].Status && neighbours == 3)
     a4c:	2654           	movea.l (a4),a3
     a4e:	d7c9           	adda.l a1,a3
     a50:	4a53           	tst.w (a3)
     a52:	6600 ff1c      	bne.w 970 <main+0x8fc>
		for (int x = 0; x < GameMatrix.Columns; x++)
     a56:	5280           	addq.l #1,d0
     a58:	588c           	addq.l #4,a4
     a5a:	b085           	cmp.l d5,d0
     a5c:	6d00 fe7e      	blt.w 8dc <main+0x868>
     a60:	6000 febc      	bra.w 91e <main+0x8aa>
				else if (x > 0 && x < GameMatrix.Columns - 1) // columns in between 1st and last
     a64:	b083           	cmp.l d3,d0
     a66:	6c36           	bge.s a9e <main+0xa2a>
					if (pf[x + 1][y].Status)
     a68:	266c 0004      	movea.l 4(a4),a3
     a6c:	4a53           	tst.w (a3)
     a6e:	56c1           	sne d1
     a70:	4881           	ext.w d1
     a72:	4441           	neg.w d1
					if (pf[x + 1][y + 1].Status)
     a74:	4a6b 0006      	tst.w 6(a3)
     a78:	6702           	beq.s a7c <main+0xa08>
						neighbours++;
     a7a:	5241           	addq.w #1,d1
					if (pf[x][y + 1].Status)
     a7c:	2654           	movea.l (a4),a3
     a7e:	4a6b 0006      	tst.w 6(a3)
     a82:	6702           	beq.s a86 <main+0xa12>
						neighbours++;
     a84:	5241           	addq.w #1,d1
					if (pf[x - 1][y].Status)
     a86:	2a6c fffc      	movea.l -4(a4),a5
     a8a:	4a55           	tst.w (a5)
     a8c:	6702           	beq.s a90 <main+0xa1c>
						neighbours++;
     a8e:	5241           	addq.w #1,d1
					if (pf[x - 1][y + 1].Status)
     a90:	4a6d 0006      	tst.w 6(a5)
     a94:	6700 fe74      	beq.w 90a <main+0x896>
						neighbours++;
     a98:	5241           	addq.w #1,d1
     a9a:	6000 fe6e      	bra.w 90a <main+0x896>
				else if (x==GameMatrix.Columns-1) // last column
     a9e:	b083           	cmp.l d3,d0
     aa0:	66aa           	bne.s a4c <main+0x9d8>
					if (pf[x - 1][y].Status)
     aa2:	266c fffc      	movea.l -4(a4),a3
     aa6:	4a53           	tst.w (a3)
     aa8:	56c1           	sne d1
     aaa:	4881           	ext.w d1
     aac:	4441           	neg.w d1
					if (pf[x - 1][y + 1].Status)
     aae:	4a6b 0006      	tst.w 6(a3)
     ab2:	6702           	beq.s ab6 <main+0xa42>
						neighbours++;
     ab4:	5241           	addq.w #1,d1
					if (pf[x][y + 1].Status)
     ab6:	2654           	movea.l (a4),a3
     ab8:	4a6b 0006      	tst.w 6(a3)
     abc:	6700 fea4      	beq.w 962 <main+0x8ee>
						neighbours++;
     ac0:	5241           	addq.w #1,d1
     ac2:	6000 fe46      	bra.w 90a <main+0x896>
				else if (x > 0 && x < GameMatrix.Columns - 1)
     ac6:	b680           	cmp.l d0,d3
     ac8:	6f00 0268      	ble.w d32 <main+0xcbe>
					if (pf[x][y + 1].Status)
     acc:	2654           	movea.l (a4),a3
     ace:	4a73 4800      	tst.w (0,a3,d4.l)
     ad2:	56c1           	sne d1
     ad4:	4881           	ext.w d1
     ad6:	4441           	neg.w d1
					if (pf[x][y - 1].Status)
     ad8:	4a73 6800      	tst.w (0,a3,d6.l)
     adc:	6702           	beq.s ae0 <main+0xa6c>
						neighbours++;
     ade:	5241           	addq.w #1,d1
					if (pf[x + 1][y].Status)
     ae0:	2a6c 0004      	movea.l 4(a4),a5
     ae4:	4a75 9800      	tst.w (0,a5,a1.l)
     ae8:	6702           	beq.s aec <main+0xa78>
						neighbours++;
     aea:	5241           	addq.w #1,d1
					if (pf[x + 1][y - 1].Status)
     aec:	4a75 6800      	tst.w (0,a5,d6.l)
     af0:	6702           	beq.s af4 <main+0xa80>
						neighbours++;
     af2:	5241           	addq.w #1,d1
					if (pf[x + 1][y + 1].Status)
     af4:	4a75 4800      	tst.w (0,a5,d4.l)
     af8:	6702           	beq.s afc <main+0xa88>
						neighbours++;
     afa:	5241           	addq.w #1,d1
					if (pf[x - 1][y].Status)
     afc:	2a6c fffc      	movea.l -4(a4),a5
     b00:	4a75 9800      	tst.w (0,a5,a1.l)
     b04:	6702           	beq.s b08 <main+0xa94>
						neighbours++;
     b06:	5241           	addq.w #1,d1
					if (pf[x - 1][y + 1].Status)
     b08:	4a75 4800      	tst.w (0,a5,d4.l)
     b0c:	6702           	beq.s b10 <main+0xa9c>
						neighbours++;
     b0e:	5241           	addq.w #1,d1
					if (pf[x - 1][y - 1].Status)
     b10:	4a75 6800      	tst.w (0,a5,d6.l)
     b14:	6700 fdf4      	beq.w 90a <main+0x896>
						neighbours++;
     b18:	5241           	addq.w #1,d1
     b1a:	6000 fdee      	bra.w 90a <main+0x896>
     b1e:	2a43           	movea.l d3,a5
     b20:	ba83           	cmp.l d3,d5
     b22:	6c02           	bge.s b26 <main+0xab2>
     b24:	2a45           	movea.l d5,a5
     b26:	284a           	movea.l a2,a4
		for (int x = 0; x < GameMatrix.Columns; x++)
     b28:	7000           	moveq #0,d0
			if (y == 0) // 1st row
     b2a:	b0fc 0000      	cmpa.w #0,a0
     b2e:	6600 00aa      	bne.w bda <main+0xb66>
				if (x == 0) // 1st column
     b32:	4a80           	tst.l d0
     b34:	6600 012e      	bne.w c64 <main+0xbf0>
					if (pf[x + 1][y].Status)
     b38:	266a 0004      	movea.l 4(a2),a3
     b3c:	4a53           	tst.w (a3)
     b3e:	56c1           	sne d1
     b40:	4881           	ext.w d1
     b42:	4441           	neg.w d1
					if (pf[x + 1][y + 1].Status)
     b44:	4a6b 0006      	tst.w 6(a3)
     b48:	6702           	beq.s b4c <main+0xad8>
						neighbours++;
     b4a:	5241           	addq.w #1,d1
					if (pf[x][y + 1].Status)
     b4c:	2c54           	movea.l (a4),a6
					if (pf[x][y + 1].Status)
     b4e:	2652           	movea.l (a2),a3
     b50:	4a6b 0006      	tst.w 6(a3)
     b54:	674c           	beq.s ba2 <main+0xb2e>
						neighbours++;
     b56:	5241           	addq.w #1,d1
			if (!pf[x][y].Status && neighbours == 3)
     b58:	ddc9           	adda.l a1,a6
     b5a:	4a56           	tst.w (a6)
     b5c:	664a           	bne.s ba8 <main+0xb34>
     b5e:	0c41 0003      	cmpi.w #3,d1
     b62:	6760           	beq.s bc4 <main+0xb50>
		for (int x = 0; x < GameMatrix.Columns; x++)
     b64:	5280           	addq.l #1,d0
     b66:	588c           	addq.l #4,a4
     b68:	bbc0           	cmpa.l d0,a5
     b6a:	6ebe           	bgt.s b2a <main+0xab6>
     b6c:	ba80           	cmp.l d0,d5
     b6e:	6f00 fdae      	ble.w 91e <main+0x8aa>
     b72:	2840           	movea.l d0,a4
     b74:	d9c0           	adda.l d0,a4
     b76:	d9cc           	adda.l a4,a4
     b78:	49f2 c800      	lea (0,a2,a4.l),a4
     b7c:	6000 fd5e      	bra.w 8dc <main+0x868>
				else if (x==GameMatrix.Columns-1) // last column
     b80:	b083           	cmp.l d3,d0
     b82:	6600 009c      	bne.w c20 <main+0xbac>
					if (pf[x - 1][y].Status)
     b86:	266c fffc      	movea.l -4(a4),a3
     b8a:	4a53           	tst.w (a3)
     b8c:	56c1           	sne d1
     b8e:	4881           	ext.w d1
     b90:	4441           	neg.w d1
					if (pf[x - 1][y + 1].Status)
     b92:	4a6b 0006      	tst.w 6(a3)
     b96:	6702           	beq.s b9a <main+0xb26>
						neighbours++;
     b98:	5241           	addq.w #1,d1
					if (pf[x][y + 1].Status)
     b9a:	2c54           	movea.l (a4),a6
     b9c:	4a6e 0006      	tst.w 6(a6)
     ba0:	66b4           	bne.s b56 <main+0xae2>
			if (!pf[x][y].Status && neighbours == 3)
     ba2:	ddc9           	adda.l a1,a6
     ba4:	4a56           	tst.w (a6)
     ba6:	67bc           	beq.s b64 <main+0xaf0>
			if (pf[x][y].Status && (neighbours < 2 || neighbours > 3))
     ba8:	5541           	subq.w #2,d1
     baa:	0c41 0001      	cmpi.w #1,d1
     bae:	63b4           	bls.s b64 <main+0xaf0>
				pf[x][y].Status = 0;
     bb0:	4256           	clr.w (a6)
				pf[x][y].StatusChanged = TRUE;
     bb2:	3d7c 0001 0002 	move.w #1,2(a6)
		for (int x = 0; x < GameMatrix.Columns; x++)
     bb8:	5280           	addq.l #1,d0
     bba:	588c           	addq.l #4,a4
     bbc:	bbc0           	cmpa.l d0,a5
     bbe:	6e00 ff6a      	bgt.w b2a <main+0xab6>
     bc2:	60a8           	bra.s b6c <main+0xaf8>
				pf[x][y].Status = 1;
     bc4:	3cbc 0001      	move.w #1,(a6)
				pf[x][y].StatusChanged = TRUE;
     bc8:	3d7c 0001 0002 	move.w #1,2(a6)
		for (int x = 0; x < GameMatrix.Columns; x++)
     bce:	5280           	addq.l #1,d0
     bd0:	588c           	addq.l #4,a4
     bd2:	bbc0           	cmpa.l d0,a5
     bd4:	6e00 ff54      	bgt.w b2a <main+0xab6>
     bd8:	6092           	bra.s b6c <main+0xaf8>
			else if (y > 0 && y < GameMatrix.Rows - 1) // rows between 1st and last
     bda:	b1c2           	cmpa.l d2,a0
     bdc:	6c3e           	bge.s c1c <main+0xba8>
				if (x == 0)
     bde:	4a80           	tst.l d0
     be0:	6600 00be      	bne.w ca0 <main+0xc2c>
					if (pf[x][y - 1].Status)
     be4:	2652           	movea.l (a2),a3
     be6:	4a73 6800      	tst.w (0,a3,d6.l)
     bea:	56c1           	sne d1
     bec:	4881           	ext.w d1
     bee:	4441           	neg.w d1
					if (pf[x][y + 1].Status)
     bf0:	4a73 4800      	tst.w (0,a3,d4.l)
     bf4:	6702           	beq.s bf8 <main+0xb84>
						neighbours++;
     bf6:	5241           	addq.w #1,d1
					if (pf[x + 1][y].Status)
     bf8:	266a 0004      	movea.l 4(a2),a3
     bfc:	4a73 9800      	tst.w (0,a3,a1.l)
     c00:	6702           	beq.s c04 <main+0xb90>
						neighbours++;
     c02:	5241           	addq.w #1,d1
					if (pf[x + 1][y + 1].Status)
     c04:	4a73 4800      	tst.w (0,a3,d4.l)
     c08:	6702           	beq.s c0c <main+0xb98>
						neighbours++;
     c0a:	5241           	addq.w #1,d1
					if (pf[x][y + 1].Status)
     c0c:	2c54           	movea.l (a4),a6
					if (pf[x + 1][y - 1].Status)
     c0e:	4a73 6800      	tst.w (0,a3,d6.l)
     c12:	6700 ff44      	beq.w b58 <main+0xae4>
						neighbours++;
     c16:	5241           	addq.w #1,d1
     c18:	6000 ff3e      	bra.w b58 <main+0xae4>
			else if (y==GameMatrix.Rows-1)// last row
     c1c:	b1c2           	cmpa.l d2,a0
     c1e:	6716           	beq.s c36 <main+0xbc2>
			if (!pf[x][y].Status && neighbours == 3)
     c20:	2c54           	movea.l (a4),a6
     c22:	ddc9           	adda.l a1,a6
     c24:	4a56           	tst.w (a6)
     c26:	6688           	bne.s bb0 <main+0xb3c>
		for (int x = 0; x < GameMatrix.Columns; x++)
     c28:	5280           	addq.l #1,d0
     c2a:	588c           	addq.l #4,a4
     c2c:	bbc0           	cmpa.l d0,a5
     c2e:	6e00 fefa      	bgt.w b2a <main+0xab6>
     c32:	6000 ff38      	bra.w b6c <main+0xaf8>
				if (x == 0)
     c36:	4a80           	tst.l d0
     c38:	6600 0160      	bne.w d9a <main+0xd26>
					if (pf[x][y - 1].Status)
     c3c:	2652           	movea.l (a2),a3
     c3e:	4a73 6800      	tst.w (0,a3,d6.l)
     c42:	56c1           	sne d1
     c44:	4881           	ext.w d1
     c46:	4441           	neg.w d1
					if (pf[x + 1][y - 1].Status)
     c48:	266a 0004      	movea.l 4(a2),a3
     c4c:	4a73 6800      	tst.w (0,a3,d6.l)
     c50:	6702           	beq.s c54 <main+0xbe0>
						neighbours++;
     c52:	5241           	addq.w #1,d1
					if (pf[x][y + 1].Status)
     c54:	2c54           	movea.l (a4),a6
					if (pf[x + 1][y].Status)
     c56:	4a73 9800      	tst.w (0,a3,a1.l)
     c5a:	6700 ff46      	beq.w ba2 <main+0xb2e>
						neighbours++;
     c5e:	5241           	addq.w #1,d1
     c60:	6000 fef6      	bra.w b58 <main+0xae4>
				else if (x > 0 && x < GameMatrix.Columns - 1) // columns in between 1st and last
     c64:	b083           	cmp.l d3,d0
     c66:	6c00 ff18      	bge.w b80 <main+0xb0c>
					if (pf[x + 1][y].Status)
     c6a:	266c 0004      	movea.l 4(a4),a3
     c6e:	4a53           	tst.w (a3)
     c70:	56c1           	sne d1
     c72:	4881           	ext.w d1
     c74:	4441           	neg.w d1
					if (pf[x + 1][y + 1].Status)
     c76:	4a6b 0006      	tst.w 6(a3)
     c7a:	6702           	beq.s c7e <main+0xc0a>
						neighbours++;
     c7c:	5241           	addq.w #1,d1
					if (pf[x][y + 1].Status)
     c7e:	2c54           	movea.l (a4),a6
     c80:	4a6e 0006      	tst.w 6(a6)
     c84:	6702           	beq.s c88 <main+0xc14>
						neighbours++;
     c86:	5241           	addq.w #1,d1
					if (pf[x - 1][y].Status)
     c88:	266c fffc      	movea.l -4(a4),a3
     c8c:	4a53           	tst.w (a3)
     c8e:	6702           	beq.s c92 <main+0xc1e>
						neighbours++;
     c90:	5241           	addq.w #1,d1
					if (pf[x - 1][y + 1].Status)
     c92:	4a6b 0006      	tst.w 6(a3)
     c96:	6700 fec0      	beq.w b58 <main+0xae4>
						neighbours++;
     c9a:	5241           	addq.w #1,d1
     c9c:	6000 feba      	bra.w b58 <main+0xae4>
				else if (x > 0 && x < GameMatrix.Columns - 1)
     ca0:	b083           	cmp.l d3,d0
     ca2:	6c52           	bge.s cf6 <main+0xc82>
					if (pf[x][y + 1].Status)
     ca4:	2c54           	movea.l (a4),a6
     ca6:	4a76 4800      	tst.w (0,a6,d4.l)
     caa:	56c1           	sne d1
     cac:	4881           	ext.w d1
     cae:	4441           	neg.w d1
					if (pf[x][y - 1].Status)
     cb0:	4a76 6800      	tst.w (0,a6,d6.l)
     cb4:	6702           	beq.s cb8 <main+0xc44>
						neighbours++;
     cb6:	5241           	addq.w #1,d1
					if (pf[x + 1][y].Status)
     cb8:	266c 0004      	movea.l 4(a4),a3
     cbc:	4a73 9800      	tst.w (0,a3,a1.l)
     cc0:	6702           	beq.s cc4 <main+0xc50>
						neighbours++;
     cc2:	5241           	addq.w #1,d1
					if (pf[x + 1][y - 1].Status)
     cc4:	4a73 6800      	tst.w (0,a3,d6.l)
     cc8:	6702           	beq.s ccc <main+0xc58>
						neighbours++;
     cca:	5241           	addq.w #1,d1
					if (pf[x + 1][y + 1].Status)
     ccc:	4a73 4800      	tst.w (0,a3,d4.l)
     cd0:	6702           	beq.s cd4 <main+0xc60>
						neighbours++;
     cd2:	5241           	addq.w #1,d1
					if (pf[x - 1][y].Status)
     cd4:	266c fffc      	movea.l -4(a4),a3
     cd8:	4a73 9800      	tst.w (0,a3,a1.l)
     cdc:	6702           	beq.s ce0 <main+0xc6c>
						neighbours++;
     cde:	5241           	addq.w #1,d1
					if (pf[x - 1][y + 1].Status)
     ce0:	4a73 4800      	tst.w (0,a3,d4.l)
     ce4:	6702           	beq.s ce8 <main+0xc74>
						neighbours++;
     ce6:	5241           	addq.w #1,d1
					if (pf[x - 1][y - 1].Status)
     ce8:	4a73 6800      	tst.w (0,a3,d6.l)
     cec:	6700 fe6a      	beq.w b58 <main+0xae4>
						neighbours++;
     cf0:	5241           	addq.w #1,d1
     cf2:	6000 fe64      	bra.w b58 <main+0xae4>
				else if (x==GameMatrix.Columns-1)
     cf6:	b083           	cmp.l d3,d0
     cf8:	6600 ff26      	bne.w c20 <main+0xbac>
					if (pf[x - 1][y - 1].Status)
     cfc:	266c fffc      	movea.l -4(a4),a3
     d00:	4a73 6800      	tst.w (0,a3,d6.l)
     d04:	56c1           	sne d1
     d06:	4881           	ext.w d1
     d08:	4441           	neg.w d1
					if (pf[x - 1][y].Status)
     d0a:	4a73 9800      	tst.w (0,a3,a1.l)
     d0e:	6702           	beq.s d12 <main+0xc9e>
						neighbours++;
     d10:	5241           	addq.w #1,d1
					if (pf[x - 1][y + 1].Status)
     d12:	4a73 4800      	tst.w (0,a3,d4.l)
     d16:	6702           	beq.s d1a <main+0xca6>
						neighbours++;
     d18:	5241           	addq.w #1,d1
					if (pf[x][y - 1].Status)
     d1a:	2c54           	movea.l (a4),a6
     d1c:	4a76 6800      	tst.w (0,a6,d6.l)
     d20:	6702           	beq.s d24 <main+0xcb0>
						neighbours++;
     d22:	5241           	addq.w #1,d1
					if (pf[x][y + 1].Status)
     d24:	4a76 4800      	tst.w (0,a6,d4.l)
     d28:	6700 fe2e      	beq.w b58 <main+0xae4>
						neighbours++;
     d2c:	5241           	addq.w #1,d1
     d2e:	6000 fe28      	bra.w b58 <main+0xae4>
				else if (x==GameMatrix.Columns-1)
     d32:	b680           	cmp.l d0,d3
     d34:	6600 fd16      	bne.w a4c <main+0x9d8>
					if (pf[x - 1][y - 1].Status)
     d38:	266c fffc      	movea.l -4(a4),a3
     d3c:	4a73 6800      	tst.w (0,a3,d6.l)
     d40:	56c1           	sne d1
     d42:	4881           	ext.w d1
     d44:	4441           	neg.w d1
					if (pf[x - 1][y].Status)
     d46:	4a73 9800      	tst.w (0,a3,a1.l)
     d4a:	6702           	beq.s d4e <main+0xcda>
						neighbours++;
     d4c:	5241           	addq.w #1,d1
					if (pf[x - 1][y + 1].Status)
     d4e:	4a73 4800      	tst.w (0,a3,d4.l)
     d52:	6702           	beq.s d56 <main+0xce2>
						neighbours++;
     d54:	5241           	addq.w #1,d1
					if (pf[x][y - 1].Status)
     d56:	2654           	movea.l (a4),a3
     d58:	4a73 6800      	tst.w (0,a3,d6.l)
     d5c:	6702           	beq.s d60 <main+0xcec>
						neighbours++;
     d5e:	5241           	addq.w #1,d1
					if (pf[x][y + 1].Status)
     d60:	4a73 4800      	tst.w (0,a3,d4.l)
     d64:	6700 fba4      	beq.w 90a <main+0x896>
						neighbours++;
     d68:	5241           	addq.w #1,d1
     d6a:	6000 fb9e      	bra.w 90a <main+0x896>
				else if (x==GameMatrix.Columns-1)
     d6e:	b083           	cmp.l d3,d0
     d70:	6600 fcda      	bne.w a4c <main+0x9d8>
					if (pf[x - 1][y - 1].Status)
     d74:	266c fffc      	movea.l -4(a4),a3
     d78:	4a73 6800      	tst.w (0,a3,d6.l)
     d7c:	56c1           	sne d1
     d7e:	4881           	ext.w d1
     d80:	4441           	neg.w d1
					if (pf[x - 1][y].Status)
     d82:	4a73 9800      	tst.w (0,a3,a1.l)
     d86:	6702           	beq.s d8a <main+0xd16>
						neighbours++;
     d88:	5241           	addq.w #1,d1
					if (pf[x][y - 1].Status)
     d8a:	2654           	movea.l (a4),a3
     d8c:	4a73 6800      	tst.w (0,a3,d6.l)
     d90:	6700 fbd0      	beq.w 962 <main+0x8ee>
						neighbours++;
     d94:	5241           	addq.w #1,d1
     d96:	6000 fb72      	bra.w 90a <main+0x896>
					if (pf[x - 1][y].Status)
     d9a:	266c fffc      	movea.l -4(a4),a3
     d9e:	4a73 9800      	tst.w (0,a3,a1.l)
     da2:	56c1           	sne d1
     da4:	4881           	ext.w d1
     da6:	4441           	neg.w d1
					if (pf[x - 1][y - 1].Status)
     da8:	4a73 6800      	tst.w (0,a3,d6.l)
     dac:	6702           	beq.s db0 <main+0xd3c>
						neighbours++;
     dae:	5241           	addq.w #1,d1
					if (pf[x][y - 1].Status)
     db0:	2c54           	movea.l (a4),a6
     db2:	4a76 6800      	tst.w (0,a6,d6.l)
     db6:	6702           	beq.s dba <main+0xd46>
						neighbours++;
     db8:	5241           	addq.w #1,d1
					if (pf[x + 1][y - 1].Status)
     dba:	266c 0004      	movea.l 4(a4),a3
     dbe:	4a73 6800      	tst.w (0,a3,d6.l)
     dc2:	6702           	beq.s dc6 <main+0xd52>
						neighbours++;
     dc4:	5241           	addq.w #1,d1
					if (pf[x + 1][y].Status)
     dc6:	4a73 9800      	tst.w (0,a3,a1.l)
     dca:	6700 fd8c      	beq.w b58 <main+0xae4>
						neighbours++;
     dce:	5241           	addq.w #1,d1
     dd0:	6000 fd86      	bra.w b58 <main+0xae4>
			GameMatrix.Playfield[x][y].Status = 1;
     dd4:	30bc 0001      	move.w #1,(a0)
			GameMatrix.Playfield[x][y].StatusChanged = TRUE;
     dd8:	317c 0001 0002 	move.w #1,2(a0)
     dde:	6000 f666      	bra.w 446 <main+0x3d2>
     de2:	7000           	moveq #0,d0
}
     de4:	4cdf 7cfc      	movem.l (sp)+,d2-d7/a2-a6
     de8:	4fef 00b0      	lea 176(sp),sp
     dec:	4e75           	rts
     dee:	4e71           	nop

00000df0 <DrawCells.constprop.1>:
void DrawCells(struct Window *theWindow, BOOL forceFull)
     df0:	4fef fff4      	lea -12(sp),sp
     df4:	48e7 3f3e      	movem.l d2-d7/a2-a6,-(sp)
     df8:	246f 003c      	movea.l 60(sp),a2
	for (int x = 0; x < GameMatrix.Columns; x++)
     dfc:	4a79 0000 350e 	tst.w 350e <GameMatrix+0x6>
     e02:	6700 00d6      	beq.w eda <DrawCells.constprop.1+0xea>
		for (int y = 0; y < GameMatrix.Rows; y++)
     e06:	3039 0000 350c 	move.w 350c <GameMatrix+0x4>,d0
     e0c:	42af 0034      	clr.l 52(sp)
	for (int x = 0; x < GameMatrix.Columns; x++)
     e10:	42af 0030      	clr.l 48(sp)
     e14:	49f9 0000 3508 	lea 3508 <GameMatrix>,a4
     e1a:	47f9 0000 1180 	lea 1180 <__mulsi3>,a3
		for (int y = 0; y < GameMatrix.Rows; y++)
     e20:	4a40           	tst.w d0
     e22:	6700 00b6      	beq.w eda <DrawCells.constprop.1+0xea>
     e26:	7a00           	moveq #0,d5
     e28:	7800           	moveq #0,d4
			if (!GameMatrix.Playfield[x][y].StatusChanged && !forceFull)
     e2a:	2054           	movea.l (a4),a0
     e2c:	202f 0034      	move.l 52(sp),d0
     e30:	2070 0800      	movea.l (0,a0,d0.l),a0
     e34:	d1c5           	adda.l d5,a0
			GameMatrix.Playfield[x][y].StatusChanged = FALSE;
     e36:	4268 0002      	clr.w 2(a0)
				SetAPen(theWindow->RPort, GameMatrix.ColorAlive);
     e3a:	226a 0032      	movea.l 50(a2),a1
     e3e:	2c79 0000 34f0 	movea.l 34f0 <GfxBase>,a6
     e44:	7000           	moveq #0,d0
			if (GameMatrix.Playfield[x][y].Status)
     e46:	4a50           	tst.w (a0)
     e48:	6700 009a      	beq.w ee4 <DrawCells.constprop.1+0xf4>
				SetAPen(theWindow->RPort, GameMatrix.ColorAlive);
     e4c:	3039 0000 3510 	move.w 3510 <GameMatrix+0x8>,d0
     e52:	4eae feaa      	jsr -342(a6)
			RectFill(theWindow->RPort,
     e56:	226a 0032      	movea.l 50(a2),a1
     e5a:	7400           	moveq #0,d2
     e5c:	3439 0000 3514 	move.w 3514 <GameMatrix+0xc>,d2
     e62:	2f2f 0030      	move.l 48(sp),-(sp)
     e66:	2f02           	move.l d2,-(sp)
     e68:	2f49 0034      	move.l a1,52(sp)
     e6c:	4e93           	jsr (a3)
     e6e:	508f           	addq.l #8,sp
     e70:	2a40           	movea.l d0,a5
     e72:	2e00           	move.l d0,d7
     e74:	5287           	addq.l #1,d7
     e76:	7c00           	moveq #0,d6
     e78:	3c39 0000 3516 	move.w 3516 <GameMatrix+0xe>,d6
     e7e:	2f04           	move.l d4,-(sp)
     e80:	2f06           	move.l d6,-(sp)
     e82:	4e93           	jsr (a3)
     e84:	508f           	addq.l #8,sp
     e86:	2600           	move.l d0,d3
     e88:	2c79 0000 34f0 	movea.l 34f0 <GfxBase>,a6
     e8e:	226f 002c      	movea.l 44(sp),a1
     e92:	2007           	move.l d7,d0
     e94:	2203           	move.l d3,d1
     e96:	5281           	addq.l #1,d1
     e98:	4bf5 28ff      	lea (-1,a5,d2.l),a5
     e9c:	240d           	move.l a5,d2
     e9e:	2046           	movea.l d6,a0
     ea0:	41f0 38ff      	lea (-1,a0,d3.l),a0
     ea4:	2608           	move.l a0,d3
     ea6:	4eae fece      	jsr -306(a6)
		for (int y = 0; y < GameMatrix.Rows; y++)
     eaa:	5284           	addq.l #1,d4
     eac:	3039 0000 350c 	move.w 350c <GameMatrix+0x4>,d0
     eb2:	5c85           	addq.l #6,d5
     eb4:	7200           	moveq #0,d1
     eb6:	3200           	move.w d0,d1
     eb8:	b284           	cmp.l d4,d1
     eba:	6e00 ff6e      	bgt.w e2a <DrawCells.constprop.1+0x3a>
	for (int x = 0; x < GameMatrix.Columns; x++)
     ebe:	52af 0030      	addq.l #1,48(sp)
     ec2:	7200           	moveq #0,d1
     ec4:	3239 0000 350e 	move.w 350e <GameMatrix+0x6>,d1
     eca:	b2af 0030      	cmp.l 48(sp),d1
     ece:	6f0a           	ble.s eda <DrawCells.constprop.1+0xea>
     ed0:	58af 0034      	addq.l #4,52(sp)
		for (int y = 0; y < GameMatrix.Rows; y++)
     ed4:	4a40           	tst.w d0
     ed6:	6600 ff4e      	bne.w e26 <DrawCells.constprop.1+0x36>
}
     eda:	4cdf 7cfc      	movem.l (sp)+,d2-d7/a2-a6
     ede:	4fef 000c      	lea 12(sp),sp
     ee2:	4e75           	rts
				SetAPen(theWindow->RPort, GameMatrix.ColorDead);
     ee4:	3039 0000 3512 	move.w 3512 <GameMatrix+0xa>,d0
     eea:	4eae feaa      	jsr -342(a6)
			RectFill(theWindow->RPort,
     eee:	226a 0032      	movea.l 50(a2),a1
     ef2:	7400           	moveq #0,d2
     ef4:	3439 0000 3514 	move.w 3514 <GameMatrix+0xc>,d2
     efa:	2f2f 0030      	move.l 48(sp),-(sp)
     efe:	2f02           	move.l d2,-(sp)
     f00:	2f49 0034      	move.l a1,52(sp)
     f04:	4e93           	jsr (a3)
     f06:	508f           	addq.l #8,sp
     f08:	2a40           	movea.l d0,a5
     f0a:	2e00           	move.l d0,d7
     f0c:	5287           	addq.l #1,d7
     f0e:	7c00           	moveq #0,d6
     f10:	3c39 0000 3516 	move.w 3516 <GameMatrix+0xe>,d6
     f16:	2f04           	move.l d4,-(sp)
     f18:	2f06           	move.l d6,-(sp)
     f1a:	4e93           	jsr (a3)
     f1c:	508f           	addq.l #8,sp
     f1e:	2600           	move.l d0,d3
     f20:	2c79 0000 34f0 	movea.l 34f0 <GfxBase>,a6
     f26:	226f 002c      	movea.l 44(sp),a1
     f2a:	2007           	move.l d7,d0
     f2c:	2203           	move.l d3,d1
     f2e:	5281           	addq.l #1,d1
     f30:	4bf5 28ff      	lea (-1,a5,d2.l),a5
     f34:	240d           	move.l a5,d2
     f36:	2046           	movea.l d6,a0
     f38:	41f0 38ff      	lea (-1,a0,d3.l),a0
     f3c:	2608           	move.l a0,d3
     f3e:	4eae fece      	jsr -306(a6)
		for (int y = 0; y < GameMatrix.Rows; y++)
     f42:	5284           	addq.l #1,d4
     f44:	3039 0000 350c 	move.w 350c <GameMatrix+0x4>,d0
     f4a:	5c85           	addq.l #6,d5
     f4c:	7200           	moveq #0,d1
     f4e:	3200           	move.w d0,d1
     f50:	b284           	cmp.l d4,d1
     f52:	6e00 fed6      	bgt.w e2a <DrawCells.constprop.1+0x3a>
     f56:	6000 ff66      	bra.w ebe <DrawCells.constprop.1+0xce>

00000f5a <strlen>:
{
     f5a:	206f 0004      	movea.l 4(sp),a0
	unsigned long t=0;
     f5e:	7000           	moveq #0,d0
	while(*s++)
     f60:	4a10           	tst.b (a0)
     f62:	6708           	beq.s f6c <strlen+0x12>
		t++;
     f64:	5280           	addq.l #1,d0
	while(*s++)
     f66:	4a30 0800      	tst.b (0,a0,d0.l)
     f6a:	66f8           	bne.s f64 <strlen+0xa>
}
     f6c:	4e75           	rts

00000f6e <memset>:
{
     f6e:	48e7 3f30      	movem.l d2-d7/a2-a3,-(sp)
     f72:	202f 0024      	move.l 36(sp),d0
     f76:	282f 0028      	move.l 40(sp),d4
     f7a:	226f 002c      	movea.l 44(sp),a1
	while(len-- > 0)
     f7e:	2a09           	move.l a1,d5
     f80:	5385           	subq.l #1,d5
     f82:	b2fc 0000      	cmpa.w #0,a1
     f86:	6700 00ae      	beq.w 1036 <memset+0xc8>
		*ptr++ = val;
     f8a:	1e04           	move.b d4,d7
     f8c:	2200           	move.l d0,d1
     f8e:	4481           	neg.l d1
     f90:	7403           	moveq #3,d2
     f92:	c282           	and.l d2,d1
     f94:	7c05           	moveq #5,d6
     f96:	2440           	movea.l d0,a2
     f98:	bc85           	cmp.l d5,d6
     f9a:	646a           	bcc.s 1006 <memset+0x98>
     f9c:	4a81           	tst.l d1
     f9e:	6724           	beq.s fc4 <memset+0x56>
     fa0:	14c4           	move.b d4,(a2)+
	while(len-- > 0)
     fa2:	5385           	subq.l #1,d5
     fa4:	7401           	moveq #1,d2
     fa6:	b481           	cmp.l d1,d2
     fa8:	671a           	beq.s fc4 <memset+0x56>
		*ptr++ = val;
     faa:	2440           	movea.l d0,a2
     fac:	548a           	addq.l #2,a2
     fae:	2040           	movea.l d0,a0
     fb0:	1144 0001      	move.b d4,1(a0)
	while(len-- > 0)
     fb4:	5385           	subq.l #1,d5
     fb6:	7403           	moveq #3,d2
     fb8:	b481           	cmp.l d1,d2
     fba:	6608           	bne.s fc4 <memset+0x56>
		*ptr++ = val;
     fbc:	528a           	addq.l #1,a2
     fbe:	1144 0002      	move.b d4,2(a0)
	while(len-- > 0)
     fc2:	5385           	subq.l #1,d5
     fc4:	2609           	move.l a1,d3
     fc6:	9681           	sub.l d1,d3
     fc8:	7c00           	moveq #0,d6
     fca:	1c04           	move.b d4,d6
     fcc:	2406           	move.l d6,d2
     fce:	4842           	swap d2
     fd0:	4242           	clr.w d2
     fd2:	2042           	movea.l d2,a0
     fd4:	2404           	move.l d4,d2
     fd6:	e14a           	lsl.w #8,d2
     fd8:	4842           	swap d2
     fda:	4242           	clr.w d2
     fdc:	e18e           	lsl.l #8,d6
     fde:	2646           	movea.l d6,a3
     fe0:	2c08           	move.l a0,d6
     fe2:	8486           	or.l d6,d2
     fe4:	2c0b           	move.l a3,d6
     fe6:	8486           	or.l d6,d2
     fe8:	1407           	move.b d7,d2
     fea:	2040           	movea.l d0,a0
     fec:	d1c1           	adda.l d1,a0
     fee:	72fc           	moveq #-4,d1
     ff0:	c283           	and.l d3,d1
     ff2:	d288           	add.l a0,d1
		*ptr++ = val;
     ff4:	20c2           	move.l d2,(a0)+
	while(len-- > 0)
     ff6:	b1c1           	cmpa.l d1,a0
     ff8:	66fa           	bne.s ff4 <memset+0x86>
     ffa:	72fc           	moveq #-4,d1
     ffc:	c283           	and.l d3,d1
     ffe:	d5c1           	adda.l d1,a2
    1000:	9a81           	sub.l d1,d5
    1002:	b283           	cmp.l d3,d1
    1004:	6730           	beq.s 1036 <memset+0xc8>
		*ptr++ = val;
    1006:	1484           	move.b d4,(a2)
	while(len-- > 0)
    1008:	4a85           	tst.l d5
    100a:	672a           	beq.s 1036 <memset+0xc8>
		*ptr++ = val;
    100c:	1544 0001      	move.b d4,1(a2)
	while(len-- > 0)
    1010:	7201           	moveq #1,d1
    1012:	b285           	cmp.l d5,d1
    1014:	6720           	beq.s 1036 <memset+0xc8>
		*ptr++ = val;
    1016:	1544 0002      	move.b d4,2(a2)
	while(len-- > 0)
    101a:	7402           	moveq #2,d2
    101c:	b485           	cmp.l d5,d2
    101e:	6716           	beq.s 1036 <memset+0xc8>
		*ptr++ = val;
    1020:	1544 0003      	move.b d4,3(a2)
	while(len-- > 0)
    1024:	7c03           	moveq #3,d6
    1026:	bc85           	cmp.l d5,d6
    1028:	670c           	beq.s 1036 <memset+0xc8>
		*ptr++ = val;
    102a:	1544 0004      	move.b d4,4(a2)
	while(len-- > 0)
    102e:	5985           	subq.l #4,d5
    1030:	6704           	beq.s 1036 <memset+0xc8>
		*ptr++ = val;
    1032:	1544 0005      	move.b d4,5(a2)
}
    1036:	4cdf 0cfc      	movem.l (sp)+,d2-d7/a2-a3
    103a:	4e75           	rts

0000103c <memcpy>:
{
    103c:	48e7 3e00      	movem.l d2-d6,-(sp)
    1040:	202f 0018      	move.l 24(sp),d0
    1044:	222f 001c      	move.l 28(sp),d1
    1048:	262f 0020      	move.l 32(sp),d3
	while(len--)
    104c:	2803           	move.l d3,d4
    104e:	5384           	subq.l #1,d4
    1050:	4a83           	tst.l d3
    1052:	675e           	beq.s 10b2 <memcpy+0x76>
    1054:	2041           	movea.l d1,a0
    1056:	5288           	addq.l #1,a0
    1058:	2400           	move.l d0,d2
    105a:	9488           	sub.l a0,d2
    105c:	7a02           	moveq #2,d5
    105e:	ba82           	cmp.l d2,d5
    1060:	55c2           	sc.s d2
    1062:	4402           	neg.b d2
    1064:	7c08           	moveq #8,d6
    1066:	bc84           	cmp.l d4,d6
    1068:	55c5           	sc.s d5
    106a:	4405           	neg.b d5
    106c:	c405           	and.b d5,d2
    106e:	6748           	beq.s 10b8 <memcpy+0x7c>
    1070:	2400           	move.l d0,d2
    1072:	8481           	or.l d1,d2
    1074:	7a03           	moveq #3,d5
    1076:	c485           	and.l d5,d2
    1078:	663e           	bne.s 10b8 <memcpy+0x7c>
    107a:	2041           	movea.l d1,a0
    107c:	2240           	movea.l d0,a1
    107e:	74fc           	moveq #-4,d2
    1080:	c483           	and.l d3,d2
    1082:	d481           	add.l d1,d2
		*d++ = *s++;
    1084:	22d8           	move.l (a0)+,(a1)+
	while(len--)
    1086:	b488           	cmp.l a0,d2
    1088:	66fa           	bne.s 1084 <memcpy+0x48>
    108a:	74fc           	moveq #-4,d2
    108c:	c483           	and.l d3,d2
    108e:	2040           	movea.l d0,a0
    1090:	d1c2           	adda.l d2,a0
    1092:	d282           	add.l d2,d1
    1094:	9882           	sub.l d2,d4
    1096:	b483           	cmp.l d3,d2
    1098:	6718           	beq.s 10b2 <memcpy+0x76>
		*d++ = *s++;
    109a:	2241           	movea.l d1,a1
    109c:	1091           	move.b (a1),(a0)
	while(len--)
    109e:	4a84           	tst.l d4
    10a0:	6710           	beq.s 10b2 <memcpy+0x76>
		*d++ = *s++;
    10a2:	1169 0001 0001 	move.b 1(a1),1(a0)
	while(len--)
    10a8:	5384           	subq.l #1,d4
    10aa:	6706           	beq.s 10b2 <memcpy+0x76>
		*d++ = *s++;
    10ac:	1169 0002 0002 	move.b 2(a1),2(a0)
}
    10b2:	4cdf 007c      	movem.l (sp)+,d2-d6
    10b6:	4e75           	rts
    10b8:	2240           	movea.l d0,a1
    10ba:	d283           	add.l d3,d1
		*d++ = *s++;
    10bc:	12e8 ffff      	move.b -1(a0),(a1)+
	while(len--)
    10c0:	b288           	cmp.l a0,d1
    10c2:	67ee           	beq.s 10b2 <memcpy+0x76>
    10c4:	5288           	addq.l #1,a0
    10c6:	60f4           	bra.s 10bc <memcpy+0x80>

000010c8 <memmove>:
{
    10c8:	48e7 3c20      	movem.l d2-d5/a2,-(sp)
    10cc:	202f 0018      	move.l 24(sp),d0
    10d0:	222f 001c      	move.l 28(sp),d1
    10d4:	242f 0020      	move.l 32(sp),d2
		while (len--)
    10d8:	2242           	movea.l d2,a1
    10da:	5389           	subq.l #1,a1
	if (d < s) {
    10dc:	b280           	cmp.l d0,d1
    10de:	636c           	bls.s 114c <memmove+0x84>
		while (len--)
    10e0:	4a82           	tst.l d2
    10e2:	6762           	beq.s 1146 <memmove+0x7e>
    10e4:	2441           	movea.l d1,a2
    10e6:	528a           	addq.l #1,a2
    10e8:	2600           	move.l d0,d3
    10ea:	968a           	sub.l a2,d3
    10ec:	7802           	moveq #2,d4
    10ee:	b883           	cmp.l d3,d4
    10f0:	55c3           	sc.s d3
    10f2:	4403           	neg.b d3
    10f4:	7a08           	moveq #8,d5
    10f6:	ba89           	cmp.l a1,d5
    10f8:	55c4           	sc.s d4
    10fa:	4404           	neg.b d4
    10fc:	c604           	and.b d4,d3
    10fe:	6770           	beq.s 1170 <memmove+0xa8>
    1100:	2600           	move.l d0,d3
    1102:	8681           	or.l d1,d3
    1104:	7803           	moveq #3,d4
    1106:	c684           	and.l d4,d3
    1108:	6666           	bne.s 1170 <memmove+0xa8>
    110a:	2041           	movea.l d1,a0
    110c:	2440           	movea.l d0,a2
    110e:	76fc           	moveq #-4,d3
    1110:	c682           	and.l d2,d3
    1112:	d681           	add.l d1,d3
			*d++ = *s++;
    1114:	24d8           	move.l (a0)+,(a2)+
		while (len--)
    1116:	b688           	cmp.l a0,d3
    1118:	66fa           	bne.s 1114 <memmove+0x4c>
    111a:	76fc           	moveq #-4,d3
    111c:	c682           	and.l d2,d3
    111e:	2440           	movea.l d0,a2
    1120:	d5c3           	adda.l d3,a2
    1122:	2041           	movea.l d1,a0
    1124:	d1c3           	adda.l d3,a0
    1126:	93c3           	suba.l d3,a1
    1128:	b682           	cmp.l d2,d3
    112a:	671a           	beq.s 1146 <memmove+0x7e>
			*d++ = *s++;
    112c:	1490           	move.b (a0),(a2)
		while (len--)
    112e:	b2fc 0000      	cmpa.w #0,a1
    1132:	6712           	beq.s 1146 <memmove+0x7e>
			*d++ = *s++;
    1134:	1568 0001 0001 	move.b 1(a0),1(a2)
		while (len--)
    113a:	7a01           	moveq #1,d5
    113c:	ba89           	cmp.l a1,d5
    113e:	6706           	beq.s 1146 <memmove+0x7e>
			*d++ = *s++;
    1140:	1568 0002 0002 	move.b 2(a0),2(a2)
}
    1146:	4cdf 043c      	movem.l (sp)+,d2-d5/a2
    114a:	4e75           	rts
		const char *lasts = s + (len - 1);
    114c:	41f1 1800      	lea (0,a1,d1.l),a0
		char *lastd = d + (len - 1);
    1150:	d3c0           	adda.l d0,a1
		while (len--)
    1152:	4a82           	tst.l d2
    1154:	67f0           	beq.s 1146 <memmove+0x7e>
    1156:	2208           	move.l a0,d1
    1158:	9282           	sub.l d2,d1
			*lastd-- = *lasts--;
    115a:	1290           	move.b (a0),(a1)
		while (len--)
    115c:	5388           	subq.l #1,a0
    115e:	5389           	subq.l #1,a1
    1160:	b288           	cmp.l a0,d1
    1162:	67e2           	beq.s 1146 <memmove+0x7e>
			*lastd-- = *lasts--;
    1164:	1290           	move.b (a0),(a1)
		while (len--)
    1166:	5388           	subq.l #1,a0
    1168:	5389           	subq.l #1,a1
    116a:	b288           	cmp.l a0,d1
    116c:	66ec           	bne.s 115a <memmove+0x92>
    116e:	60d6           	bra.s 1146 <memmove+0x7e>
    1170:	2240           	movea.l d0,a1
    1172:	d282           	add.l d2,d1
			*d++ = *s++;
    1174:	12ea ffff      	move.b -1(a2),(a1)+
		while (len--)
    1178:	b28a           	cmp.l a2,d1
    117a:	67ca           	beq.s 1146 <memmove+0x7e>
    117c:	528a           	addq.l #1,a2
    117e:	60f4           	bra.s 1174 <memmove+0xac>

00001180 <__mulsi3>:
	.text
	FUNC(__mulsi3)
	.globl	SYM (__mulsi3)
SYM (__mulsi3):
	.cfi_startproc
	movew	sp@(4), d0	/* x0 -> d0 */
    1180:	302f 0004      	move.w 4(sp),d0
	muluw	sp@(10), d0	/* x0*y1 */
    1184:	c0ef 000a      	mulu.w 10(sp),d0
	movew	sp@(6), d1	/* x1 -> d1 */
    1188:	322f 0006      	move.w 6(sp),d1
	muluw	sp@(8), d1	/* x1*y0 */
    118c:	c2ef 0008      	mulu.w 8(sp),d1
	addw	d1, d0
    1190:	d041           	add.w d1,d0
	swap	d0
    1192:	4840           	swap d0
	clrw	d0
    1194:	4240           	clr.w d0
	movew	sp@(6), d1	/* x1 -> d1 */
    1196:	322f 0006      	move.w 6(sp),d1
	muluw	sp@(10), d1	/* x1*y1 */
    119a:	c2ef 000a      	mulu.w 10(sp),d1
	addl	d1, d0
    119e:	d081           	add.l d1,d0
	rts
    11a0:	4e75           	rts

000011a2 <__udivsi3>:
	.text
	FUNC(__udivsi3)
	.globl	SYM (__udivsi3)
SYM (__udivsi3):
	.cfi_startproc
	movel	d2, sp@-
    11a2:	2f02           	move.l d2,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	sp@(12), d1	/* d1 = divisor */
    11a4:	222f 000c      	move.l 12(sp),d1
	movel	sp@(8), d0	/* d0 = dividend */
    11a8:	202f 0008      	move.l 8(sp),d0

	cmpl	IMM (0x10000), d1 /* divisor >= 2 ^ 16 ?   */
    11ac:	0c81 0001 0000 	cmpi.l #65536,d1
	jcc	3f		/* then try next algorithm */
    11b2:	6416           	bcc.s 11ca <__udivsi3+0x28>
	movel	d0, d2
    11b4:	2400           	move.l d0,d2
	clrw	d2
    11b6:	4242           	clr.w d2
	swap	d2
    11b8:	4842           	swap d2
	divu	d1, d2          /* high quotient in lower word */
    11ba:	84c1           	divu.w d1,d2
	movew	d2, d0		/* save high quotient */
    11bc:	3002           	move.w d2,d0
	swap	d0
    11be:	4840           	swap d0
	movew	sp@(10), d2	/* get low dividend + high rest */
    11c0:	342f 000a      	move.w 10(sp),d2
	divu	d1, d2		/* low quotient */
    11c4:	84c1           	divu.w d1,d2
	movew	d2, d0
    11c6:	3002           	move.w d2,d0
	jra	6f
    11c8:	6030           	bra.s 11fa <__udivsi3+0x58>

3:	movel	d1, d2		/* use d2 as divisor backup */
    11ca:	2401           	move.l d1,d2
4:	lsrl	IMM (1), d1	/* shift divisor */
    11cc:	e289           	lsr.l #1,d1
	lsrl	IMM (1), d0	/* shift dividend */
    11ce:	e288           	lsr.l #1,d0
	cmpl	IMM (0x10000), d1 /* still divisor >= 2 ^ 16 ?  */
    11d0:	0c81 0001 0000 	cmpi.l #65536,d1
	jcc	4b
    11d6:	64f4           	bcc.s 11cc <__udivsi3+0x2a>
	divu	d1, d0		/* now we have 16-bit divisor */
    11d8:	80c1           	divu.w d1,d0
	andl	IMM (0xffff), d0 /* mask out divisor, ignore remainder */
    11da:	0280 0000 ffff 	andi.l #65535,d0

/* Multiply the 16-bit tentative quotient with the 32-bit divisor.  Because of
   the operand ranges, this might give a 33-bit product.  If this product is
   greater than the dividend, the tentative quotient was too large. */
	movel	d2, d1
    11e0:	2202           	move.l d2,d1
	mulu	d0, d1		/* low part, 32 bits */
    11e2:	c2c0           	mulu.w d0,d1
	swap	d2
    11e4:	4842           	swap d2
	mulu	d0, d2		/* high part, at most 17 bits */
    11e6:	c4c0           	mulu.w d0,d2
	swap	d2		/* align high part with low part */
    11e8:	4842           	swap d2
	tstw	d2		/* high part 17 bits? */
    11ea:	4a42           	tst.w d2
	jne	5f		/* if 17 bits, quotient was too large */
    11ec:	660a           	bne.s 11f8 <__udivsi3+0x56>
	addl	d2, d1		/* add parts */
    11ee:	d282           	add.l d2,d1
	jcs	5f		/* if sum is 33 bits, quotient was too large */
    11f0:	6506           	bcs.s 11f8 <__udivsi3+0x56>
	cmpl	sp@(8), d1	/* compare the sum with the dividend */
    11f2:	b2af 0008      	cmp.l 8(sp),d1
	jls	6f		/* if sum > dividend, quotient was too large */
    11f6:	6302           	bls.s 11fa <__udivsi3+0x58>
5:	subql	IMM (1), d0	/* adjust quotient */
    11f8:	5380           	subq.l #1,d0

6:	movel	sp@+, d2
    11fa:	241f           	move.l (sp)+,d2
	.cfi_adjust_cfa_offset -4
	rts
    11fc:	4e75           	rts

000011fe <__divsi3>:
	.text
	FUNC(__divsi3)
	.globl	SYM (__divsi3)
SYM (__divsi3):
	.cfi_startproc
	movel	d2, sp@-
    11fe:	2f02           	move.l d2,-(sp)
	.cfi_adjust_cfa_offset 4

	moveq	IMM (1), d2	/* sign of result stored in d2 (=1 or =-1) */
    1200:	7401           	moveq #1,d2
	movel	sp@(12), d1	/* d1 = divisor */
    1202:	222f 000c      	move.l 12(sp),d1
	jpl	1f
    1206:	6a04           	bpl.s 120c <__divsi3+0xe>
	negl	d1
    1208:	4481           	neg.l d1
	negb	d2		/* change sign because divisor <0  */
    120a:	4402           	neg.b d2
1:	movel	sp@(8), d0	/* d0 = dividend */
    120c:	202f 0008      	move.l 8(sp),d0
	jpl	2f
    1210:	6a04           	bpl.s 1216 <__divsi3+0x18>
	negl	d0
    1212:	4480           	neg.l d0
	negb	d2
    1214:	4402           	neg.b d2

2:	movel	d1, sp@-
    1216:	2f01           	move.l d1,-(sp)
	movel	d0, sp@-
    1218:	2f00           	move.l d0,-(sp)
	PICCALL	SYM (__udivsi3)	/* divide abs(dividend) by abs(divisor) */
    121a:	6186           	bsr.s 11a2 <__udivsi3>
	addql	IMM (8), sp
    121c:	508f           	addq.l #8,sp

	tstb	d2
    121e:	4a02           	tst.b d2
	jpl	3f
    1220:	6a02           	bpl.s 1224 <__divsi3+0x26>
	negl	d0
    1222:	4480           	neg.l d0

3:	movel	sp@+, d2
    1224:	241f           	move.l (sp)+,d2
	.cfi_adjust_cfa_offset -4
	rts
    1226:	4e75           	rts

00001228 <__modsi3>:
	.text
	FUNC(__modsi3)
	.globl	SYM (__modsi3)
SYM (__modsi3):
	.cfi_startproc
	movel	sp@(8), d1	/* d1 = divisor */
    1228:	222f 0008      	move.l 8(sp),d1
	movel	sp@(4), d0	/* d0 = dividend */
    122c:	202f 0004      	move.l 4(sp),d0
	movel	d1, sp@-
    1230:	2f01           	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    1232:	2f00           	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	PICCALL	SYM (__divsi3)
    1234:	61c8           	bsr.s 11fe <__divsi3>
	addql	IMM (8), sp
    1236:	508f           	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(8), d1	/* d1 = divisor */
    1238:	222f 0008      	move.l 8(sp),d1
	movel	d1, sp@-
    123c:	2f01           	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    123e:	2f00           	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	PICCALL	SYM (__mulsi3)	/* d0 = (a/b)*b */
    1240:	6100 ff3e      	bsr.w 1180 <__mulsi3>
	addql	IMM (8), sp
    1244:	508f           	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(4), d1	/* d1 = dividend */
    1246:	222f 0004      	move.l 4(sp),d1
	subl	d0, d1		/* d1 = a - (a/b)*b */
    124a:	9280           	sub.l d0,d1
	movel	d1, d0
    124c:	2001           	move.l d1,d0
	rts
    124e:	4e75           	rts

00001250 <__umodsi3>:
	.text
	FUNC(__umodsi3)
	.globl	SYM (__umodsi3)
SYM (__umodsi3):
	.cfi_startproc
	movel	sp@(8), d1	/* d1 = divisor */
    1250:	222f 0008      	move.l 8(sp),d1
	movel	sp@(4), d0	/* d0 = dividend */
    1254:	202f 0004      	move.l 4(sp),d0
	movel	d1, sp@-
    1258:	2f01           	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    125a:	2f00           	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	PICCALL	SYM (__udivsi3)
    125c:	6100 ff44      	bsr.w 11a2 <__udivsi3>
	addql	IMM (8), sp
    1260:	508f           	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(8), d1	/* d1 = divisor */
    1262:	222f 0008      	move.l 8(sp),d1
	movel	d1, sp@-
    1266:	2f01           	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    1268:	2f00           	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	PICCALL	SYM (__mulsi3)	/* d0 = (a/b)*b */
    126a:	6100 ff14      	bsr.w 1180 <__mulsi3>
	addql	IMM (8), sp
    126e:	508f           	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(4), d1	/* d1 = dividend */
    1270:	222f 0004      	move.l 4(sp),d1
	subl	d0, d1		/* d1 = a - (a/b)*b */
    1274:	9280           	sub.l d0,d1
	movel	d1, d0
    1276:	2001           	move.l d1,d0
	rts
    1278:	4e75           	rts

0000127a <KPutCharX>:
	FUNC(KPutCharX)
	.globl	SYM (KPutCharX)

SYM(KPutCharX):
	.cfi_startproc
    move.l  a6, -(sp)
    127a:	2f0e           	move.l a6,-(sp)
	.cfi_adjust_cfa_offset 4
    move.l  4.w, a6
    127c:	2c78 0004      	movea.l 4 <_start+0x4>,a6
    jsr     -0x204(a6)
    1280:	4eae fdfc      	jsr -516(a6)
    movea.l (sp)+, a6
    1284:	2c5f           	movea.l (sp)+,a6
	.cfi_adjust_cfa_offset -4
    rts
    1286:	4e75           	rts

00001288 <PutChar>:
	FUNC(PutChar)
	.globl	SYM (PutChar)

SYM(PutChar):
	.cfi_startproc
	move.b d0, (a3)+
    1288:	16c0           	move.b d0,(a3)+
	rts
    128a:	4e75           	rts
