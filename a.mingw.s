
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
       4:	263c 0000 32b9 	move.l #12985,d3
       a:	0483 0000 32b9 	subi.l #12985,d3
      10:	e483           	asr.l #2,d3
	for (i = 0; i < count; i++)
      12:	6712           	beq.s 26 <_start+0x26>
      14:	45f9 0000 32b9 	lea 32b9 <__fini_array_end>,a2
      1a:	7400           	moveq #0,d2
		__preinit_array_start[i]();
      1c:	205a           	movea.l (a2)+,a0
      1e:	4e90           	jsr (a0)
	for (i = 0; i < count; i++)
      20:	5282           	addq.l #1,d2
      22:	b483           	cmp.l d3,d2
      24:	66f6           	bne.s 1c <_start+0x1c>

	count = __init_array_end - __init_array_start;
      26:	263c 0000 32b9 	move.l #12985,d3
      2c:	0483 0000 32b9 	subi.l #12985,d3
      32:	e483           	asr.l #2,d3
	for (i = 0; i < count; i++)
      34:	6712           	beq.s 48 <_start+0x48>
      36:	45f9 0000 32b9 	lea 32b9 <__fini_array_end>,a2
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
      4e:	243c 0000 32b9 	move.l #12985,d2
      54:	0482 0000 32b9 	subi.l #12985,d2
      5a:	e482           	asr.l #2,d2
	for (i = count; i > 0; i--)
      5c:	6710           	beq.s 6e <_start+0x6e>
      5e:	45f9 0000 32b9 	lea 32b9 <__fini_array_end>,a2
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
      74:	4fef ff4c      	lea -180(sp),sp
      78:	48e7 3f3e      	movem.l d2-d7/a2-a6,-(sp)
	GameMatrix.ColorAlive = 9;
	GameMatrix.ColorDead = 12;
	GameMatrix.Columns = 40;
	GameMatrix.Rows = 20;
      7c:	23fc 0014 0028 	move.l #1310760,3450 <GameMatrix+0x4>
      82:	0000 3450 
      86:	23fc 0009 000c 	move.l #589836,3454 <GameMatrix+0x8>
      8c:	0000 3454 
      90:	23fc 000b 000b 	move.l #720907,3458 <GameMatrix+0xc>
      96:	0000 3458 
	RETURN_OK;
}

int StartApp()
{
	SysBase = *((struct ExecBase **)4UL);
      9a:	2c78 0004      	movea.l 4 <_start+0x4>,a6
      9e:	23ce 0000 343c 	move.l a6,343c <SysBase>
	custom = (struct Custom *)0xdff000;
	unsigned int pens[] = {~0};
      a4:	70ff           	moveq #-1,d0
      a6:	2f40 0038      	move.l d0,56(sp)

	APTR *my_VisualInfo;

	if ((DOSBase = (struct DosLibrary *)OpenLibrary((CONST_STRPTR) "dos.library", 0)))
      aa:	43f9 0000 11d0 	lea 11d0 <PutChar+0x4>,a1
      b0:	7000           	moveq #0,d0
      b2:	4eae fdd8      	jsr -552(a6)
      b6:	23c0 0000 3428 	move.l d0,3428 <DOSBase>
      bc:	6700 05ca      	beq.w 688 <main+0x614>
	{
		if ((GfxBase = (struct GfxBase *)OpenLibrary((CONST_STRPTR) "graphics.library", 0)))
      c0:	2c79 0000 343c 	movea.l 343c <SysBase>,a6
      c6:	43f9 0000 11dc 	lea 11dc <PutChar+0x10>,a1
      cc:	7000           	moveq #0,d0
      ce:	4eae fdd8      	jsr -552(a6)
      d2:	23c0 0000 3434 	move.l d0,3434 <GfxBase>
      d8:	6700 05ae      	beq.w 688 <main+0x614>
		{
			if ((IntuitionBase = (struct IntuitionBase *)OpenLibrary((CONST_STRPTR) "intuition.library", 0)))
      dc:	2c79 0000 343c 	movea.l 343c <SysBase>,a6
      e2:	43f9 0000 11ed 	lea 11ed <PutChar+0x21>,a1
      e8:	7000           	moveq #0,d0
      ea:	4eae fdd8      	jsr -552(a6)
      ee:	2c40           	movea.l d0,a6
      f0:	23c0 0000 3438 	move.l d0,3438 <IntuitionBase>
      f6:	6700 0590      	beq.w 688 <main+0x614>
			{
				if ((GolScreen = (struct Screen *)OpenScreenTags(NULL,
      fa:	2f7c 8000 003a 	move.l #-2147483590,60(sp)
     100:	003c 
     102:	7438           	moveq #56,d2
     104:	d48f           	add.l sp,d2
     106:	2f42 0040      	move.l d2,64(sp)
     10a:	2f7c 8000 0032 	move.l #-2147483598,68(sp)
     110:	0044 
     112:	2f7c 0000 8000 	move.l #32768,72(sp)
     118:	0048 
     11a:	2f7c 8000 0025 	move.l #-2147483611,76(sp)
     120:	004c 
     122:	7004           	moveq #4,d0
     124:	2f40 0050      	move.l d0,80(sp)
     128:	2f7c 8000 0028 	move.l #-2147483608,84(sp)
     12e:	0054 
     130:	2f7c 0000 11ff 	move.l #4607,88(sp)
     136:	0058 
     138:	2f7c 8000 002d 	move.l #-2147483603,92(sp)
     13e:	005c 
     140:	740f           	moveq #15,d2
     142:	2f42 0060      	move.l d2,96(sp)
     146:	2f7c 8000 0026 	move.l #-2147483610,100(sp)
     14c:	0064 
     14e:	2f40 0068      	move.l d0,104(sp)
     152:	2f7c 8000 0027 	move.l #-2147483609,108(sp)
     158:	006c 
     15a:	7008           	moveq #8,d0
     15c:	2f40 0070      	move.l d0,112(sp)
     160:	42af 0074      	clr.l 116(sp)
     164:	91c8           	suba.l a0,a0
     166:	43ef 003c      	lea 60(sp),a1
     16a:	4eae fd9c      	jsr -612(a6)
     16e:	23c0 0000 342c 	move.l d0,342c <GolScreen>
     174:	6700 0512      	beq.w 688 <main+0x614>
																 SA_DetailPen, 4,
																 SA_BlockPen, 8,
																 TAG_END)))
				{

					if ((GadToolsBase = (struct Library *)OpenLibrary((CONST_STRPTR) "gadtools.library", 0)))
     178:	2c79 0000 343c 	movea.l 343c <SysBase>,a6
     17e:	43f9 0000 1217 	lea 1217 <PutChar+0x4b>,a1
     184:	7000           	moveq #0,d0
     186:	4eae fdd8      	jsr -552(a6)
     18a:	23c0 0000 3430 	move.l d0,3430 <GadToolsBase>
     190:	6700 04f6      	beq.w 688 <main+0x614>
					{
						if ((GolMainWindow = (struct Window *)OpenWindowTags(NULL,
     194:	2f7c 8000 0070 	move.l #-2147483536,60(sp)
     19a:	003c 
     19c:	2079 0000 342c 	movea.l 342c <GolScreen>,a0
     1a2:	2f48 0040      	move.l a0,64(sp)
     1a6:	2f7c 8000 0064 	move.l #-2147483548,68(sp)
     1ac:	0044 
     1ae:	42af 0048      	clr.l 72(sp)
     1b2:	2f7c 8000 0065 	move.l #-2147483547,76(sp)
     1b8:	004c 
     1ba:	1028 001e      	move.b 30(a0),d0
     1be:	4880           	ext.w d0
     1c0:	48c0           	ext.l d0
     1c2:	5280           	addq.l #1,d0
     1c4:	2f40 0050      	move.l d0,80(sp)
     1c8:	2f7c 8000 0066 	move.l #-2147483546,84(sp)
     1ce:	0054 
     1d0:	3039 0000 3458 	move.w 3458 <GameMatrix+0xc>,d0
     1d6:	c0f9 0000 3452 	mulu.w 3452 <GameMatrix+0x6>,d0
     1dc:	1228 0024      	move.b 36(a0),d1
     1e0:	4881           	ext.w d1
     1e2:	3641           	movea.w d1,a3
     1e4:	43f3 0800      	lea (0,a3,d0.l),a1
     1e8:	1028 0025      	move.b 37(a0),d0
     1ec:	4880           	ext.w d0
     1ee:	43f1 0000      	lea (0,a1,d0.w),a1
     1f2:	2f49 0058      	move.l a1,88(sp)
     1f6:	2f7c 8000 0067 	move.l #-2147483545,92(sp)
     1fc:	005c 
     1fe:	3039 0000 345a 	move.w 345a <GameMatrix+0xe>,d0
     204:	c0f9 0000 3450 	mulu.w 3450 <GameMatrix+0x4>,d0
     20a:	1228 0023      	move.b 35(a0),d1
     20e:	4881           	ext.w d1
     210:	3401           	move.w d1,d2
     212:	48c2           	ext.l d2
     214:	2640           	movea.l d0,a3
     216:	45f3 2800      	lea (0,a3,d2.l),a2
     21a:	1028 0026      	move.b 38(a0),d0
     21e:	4880           	ext.w d0
     220:	41f2 0000      	lea (0,a2,d0.w),a0
     224:	2f48 0060      	move.l a0,96(sp)
     228:	2f7c 8000 0074 	move.l #-2147483532,100(sp)
     22e:	0064 
     230:	2f49 0068      	move.l a1,104(sp)
     234:	2f7c 8000 0075 	move.l #-2147483531,108(sp)
     23a:	006c 
     23c:	2f48 0070      	move.l a0,112(sp)
     240:	2f7c 8000 006e 	move.l #-2147483538,116(sp)
     246:	0074 
     248:	2f7c 0000 1228 	move.l #4648,120(sp)
     24e:	0078 
     250:	2f7c 8000 0083 	move.l #-2147483517,124(sp)
     256:	007c 
     258:	7001           	moveq #1,d0
     25a:	2f40 0080      	move.l d0,128(sp)
     25e:	2f7c 8000 0084 	move.l #-2147483516,132(sp)
     264:	0084 
     266:	2f40 0088      	move.l d0,136(sp)
     26a:	2f7c 8000 0081 	move.l #-2147483519,140(sp)
     270:	008c 
     272:	2f40 0090      	move.l d0,144(sp)
     276:	2f7c 8000 0082 	move.l #-2147483518,148(sp)
     27c:	0094 
     27e:	2f40 0098      	move.l d0,152(sp)
     282:	2f7c 8000 0091 	move.l #-2147483503,156(sp)
     288:	009c 
     28a:	2f40 00a0      	move.l d0,160(sp)
     28e:	2f7c 8000 0086 	move.l #-2147483514,164(sp)
     294:	00a4 
     296:	2f40 00a8      	move.l d0,168(sp)
     29a:	2f7c 8000 0093 	move.l #-2147483501,172(sp)
     2a0:	00ac 
     2a2:	2f40 00b0      	move.l d0,176(sp)
     2a6:	2f7c 8000 0089 	move.l #-2147483511,180(sp)
     2ac:	00b4 
     2ae:	2f40 00b8      	move.l d0,184(sp)
     2b2:	2f7c 8000 006f 	move.l #-2147483537,188(sp)
     2b8:	00bc 
     2ba:	2f7c 0000 1230 	move.l #4656,192(sp)
     2c0:	00c0 
     2c2:	2f7c 8000 006a 	move.l #-2147483542,196(sp)
     2c8:	00c4 
     2ca:	2f7c 0000 031c 	move.l #796,200(sp)
     2d0:	00c8 
     2d2:	2f7c 8000 0068 	move.l #-2147483544,204(sp)
     2d8:	00cc 
     2da:	42af 00d0      	clr.l 208(sp)
     2de:	2f7c 8000 0069 	move.l #-2147483543,212(sp)
     2e4:	00d4 
     2e6:	42af 00d8      	clr.l 216(sp)
     2ea:	42af 00dc      	clr.l 220(sp)
     2ee:	2c79 0000 3438 	movea.l 3438 <IntuitionBase>,a6
     2f4:	91c8           	suba.l a0,a0
     2f6:	43ef 003c      	lea 60(sp),a1
     2fa:	4eae fda2      	jsr -606(a6)
     2fe:	2040           	movea.l d0,a0
     300:	23c0 0000 3446 	move.l d0,3446 <GolMainWindow>
     306:	6700 0380      	beq.w 688 <main+0x614>
																			 WA_DetailPen, 0,
																			 WA_BlockPen, 0,
																			 TAG_END)))

						{
							my_VisualInfo = GetVisualInfo(GolMainWindow->WScreen, TAG_END);
     30a:	42af 003c      	clr.l 60(sp)
     30e:	2c79 0000 3430 	movea.l 3430 <GadToolsBase>,a6
     314:	2068 002e      	movea.l 46(a0),a0
     318:	43ef 003c      	lea 60(sp),a1
     31c:	4eae ff82      	jsr -126(a6)
     320:	2400           	move.l d0,d2
							MainMenuStrip = CreateMenus(GolMainMenu, TAG_END);
     322:	42af 003c      	clr.l 60(sp)
     326:	2c79 0000 3430 	movea.l 3430 <GadToolsBase>,a6
     32c:	41f9 0000 32bc 	lea 32bc <GolMainMenu>,a0
     332:	43ef 003c      	lea 60(sp),a1
     336:	4eae ffd0      	jsr -48(a6)
     33a:	2040           	movea.l d0,a0
     33c:	23c0 0000 3442 	move.l d0,3442 <MainMenuStrip>
							LayoutMenus(MainMenuStrip, my_VisualInfo, TAG_END);
     342:	42af 003c      	clr.l 60(sp)
     346:	2c79 0000 3430 	movea.l 3430 <GadToolsBase>,a6
     34c:	2242           	movea.l d2,a1
     34e:	45ef 003c      	lea 60(sp),a2
     352:	4eae ffbe      	jsr -66(a6)
							SetMenuStrip(GolMainWindow, MainMenuStrip);
     356:	2c79 0000 3438 	movea.l 3438 <IntuitionBase>,a6
     35c:	2079 0000 3446 	movea.l 3446 <GolMainWindow>,a0
     362:	2279 0000 3442 	movea.l 3442 <MainMenuStrip>,a1
     368:	4eae fef8      	jsr -264(a6)
							//Allocate memory for the cell's data
							GameMatrix.Playfield = AllocMem(GameMatrix.Columns * sizeof(GameOfLifeCell *), MEMF_ANY | MEMF_CLEAR);
     36c:	7000           	moveq #0,d0
     36e:	3039 0000 3452 	move.w 3452 <GameMatrix+0x6>,d0
     374:	2c79 0000 343c 	movea.l 343c <SysBase>,a6
     37a:	e588           	lsl.l #2,d0
     37c:	7201           	moveq #1,d1
     37e:	4841           	swap d1
     380:	4eae ff3a      	jsr -198(a6)
     384:	41f9 0000 344c 	lea 344c <GameMatrix>,a0
     38a:	2080           	move.l d0,(a0)
							for (int i = 0; i < GameMatrix.Columns; i++)
     38c:	4a79 0000 3452 	tst.w 3452 <GameMatrix+0x6>
     392:	6740           	beq.s 3d4 <main+0x360>
     394:	7600           	moveq #0,d3
     396:	7400           	moveq #0,d2
							{
								GameMatrix.Playfield[i] = AllocMem(GameMatrix.Rows * sizeof(GameOfLifeCell), MEMF_ANY | MEMF_CLEAR);
     398:	7801           	moveq #1,d4
     39a:	4844           	swap d4
     39c:	7200           	moveq #0,d1
     39e:	3239 0000 3450 	move.w 3450 <GameMatrix+0x4>,d1
     3a4:	2001           	move.l d1,d0
     3a6:	d081           	add.l d1,d0
     3a8:	d081           	add.l d1,d0
     3aa:	2c79 0000 343c 	movea.l 343c <SysBase>,a6
     3b0:	d080           	add.l d0,d0
     3b2:	2204           	move.l d4,d1
     3b4:	4eae ff3a      	jsr -198(a6)
     3b8:	43f9 0000 344c 	lea 344c <GameMatrix>,a1
     3be:	2051           	movea.l (a1),a0
     3c0:	2180 3800      	move.l d0,(0,a0,d3.l)
							for (int i = 0; i < GameMatrix.Columns; i++)
     3c4:	5282           	addq.l #1,d2
     3c6:	5883           	addq.l #4,d3
     3c8:	7000           	moveq #0,d0
     3ca:	3039 0000 3452 	move.w 3452 <GameMatrix+0x6>,d0
     3d0:	b082           	cmp.l d2,d0
     3d2:	6ec8           	bgt.s 39c <main+0x328>
	return RETURN_ERROR;
}

int MainLoop()
{
	DrawCells(GolMainWindow, TRUE);
     3d4:	2f39 0000 3446 	move.l 3446 <GolMainWindow>,-(sp)
     3da:	4eb9 0000 0d34 	jsr d34 <DrawCells.constprop.1>

	while (AppRunning)
     3e0:	588f           	addq.l #4,sp
     3e2:	4a79 0000 3424 	tst.w 3424 <AppRunning>
     3e8:	6700 01e6      	beq.w 5d0 <main+0x55c>
	{
		EventLoop(GolMainWindow, MainMenuStrip);
     3ec:	2639 0000 3442 	move.l 3442 <MainMenuStrip>,d3
     3f2:	2679 0000 3446 	movea.l 3446 <GolMainWindow>,a3
	SetDrMd(rport, JAM2);
}

void ToggleCellStatus(WORD coordX, WORD coordY)
{
	int x = coordX / GameMatrix.CellSizeH;
     3f8:	49f9 0000 1142 	lea 1142 <__divsi3>,a4
	while ((message = (struct IntuiMessage *)GetMsg(theWindow->UserPort)))
     3fe:	2c79 0000 343c 	movea.l 343c <SysBase>,a6
     404:	206b 0056      	movea.l 86(a3),a0
     408:	4eae fe8c      	jsr -372(a6)
     40c:	2440           	movea.l d0,a2
     40e:	4a80           	tst.l d0
     410:	6700 00ca      	beq.w 4dc <main+0x468>
		msg_class = message->Class;
     414:	242a 0014      	move.l 20(a2),d2
		msg_code = message->Code;
     418:	382a 0018      	move.w 24(a2),d4
		coordX = message->MouseX - theWindow->BorderLeft;
     41c:	3a2a 0020      	move.w 32(a2),d5
     420:	102b 0036      	move.b 54(a3),d0
     424:	3a40           	movea.w d0,a5
		coordY = message->MouseY - theWindow->BorderTop;
     426:	3c2a 0022      	move.w 34(a2),d6
     42a:	1e2b 0037      	move.b 55(a3),d7
		ReplyMsg((struct Message *)message);
     42e:	2c79 0000 343c 	movea.l 343c <SysBase>,a6
     434:	224a           	movea.l a2,a1
     436:	4eae fe86      	jsr -378(a6)
		switch (msg_class)
     43a:	7010           	moveq #16,d0
     43c:	b082           	cmp.l d2,d0
     43e:	67be           	beq.s 3fe <main+0x38a>
     440:	6500 0252      	bcs.w 694 <main+0x620>
     444:	7004           	moveq #4,d0
     446:	b082           	cmp.l d2,d0
     448:	6700 0266      	beq.w 6b0 <main+0x63c>
     44c:	5182           	subq.l #8,d2
     44e:	66ae           	bne.s 3fe <main+0x38a>
			switch (msg_code)
     450:	0c44 0068      	cmpi.w #104,d4
     454:	66a8           	bne.s 3fe <main+0x38a>
		coordX = message->MouseX - theWindow->BorderLeft;
     456:	300d           	move.w a5,d0
     458:	4880           	ext.w d0
     45a:	9a40           	sub.w d0,d5
	int x = coordX / GameMatrix.CellSizeH;
     45c:	7000           	moveq #0,d0
     45e:	3039 0000 3458 	move.w 3458 <GameMatrix+0xc>,d0
     464:	2f00           	move.l d0,-(sp)
     466:	3045           	movea.w d5,a0
     468:	2f08           	move.l a0,-(sp)
     46a:	4e94           	jsr (a4)
     46c:	508f           	addq.l #8,sp
     46e:	2400           	move.l d0,d2
	int y = coordY / GameMatrix.CellSizeV;

	if (!(x < 0 || x > GameMatrix.Columns - 1 || y < 0 || y > GameMatrix.Rows))
     470:	7000           	moveq #0,d0
     472:	3039 0000 3452 	move.w 3452 <GameMatrix+0x6>,d0
     478:	b082           	cmp.l d2,d0
     47a:	6382           	bls.s 3fe <main+0x38a>
		coordY = message->MouseY - theWindow->BorderTop;
     47c:	4887           	ext.w d7
     47e:	9c47           	sub.w d7,d6
	int y = coordY / GameMatrix.CellSizeV;
     480:	7000           	moveq #0,d0
     482:	3039 0000 345a 	move.w 345a <GameMatrix+0xe>,d0
     488:	2f00           	move.l d0,-(sp)
     48a:	3246           	movea.w d6,a1
     48c:	2f09           	move.l a1,-(sp)
     48e:	4e94           	jsr (a4)
     490:	508f           	addq.l #8,sp
	if (!(x < 0 || x > GameMatrix.Columns - 1 || y < 0 || y > GameMatrix.Rows))
     492:	7200           	moveq #0,d1
     494:	3239 0000 3450 	move.w 3450 <GameMatrix+0x4>,d1
     49a:	b280           	cmp.l d0,d1
     49c:	6500 ff60      	bcs.w 3fe <main+0x38a>
	{

		if (GameMatrix.Playfield[x][y].Status)
     4a0:	45f9 0000 344c 	lea 344c <GameMatrix>,a2
     4a6:	2252           	movea.l (a2),a1
     4a8:	d482           	add.l d2,d2
     4aa:	d482           	add.l d2,d2
     4ac:	2040           	movea.l d0,a0
     4ae:	d1c0           	adda.l d0,a0
     4b0:	d1c0           	adda.l d0,a0
     4b2:	d1c8           	adda.l a0,a0
     4b4:	d1f1 2800      	adda.l (0,a1,d2.l),a0
     4b8:	4a50           	tst.w (a0)
     4ba:	6700 085e      	beq.w d1a <main+0xca6>
		{
			GameMatrix.Playfield[x][y].Status = 0;
     4be:	4250           	clr.w (a0)
			GameMatrix.Playfield[x][y].StatusChanged = TRUE;
     4c0:	317c 0001 0002 	move.w #1,2(a0)
	while ((message = (struct IntuiMessage *)GetMsg(theWindow->UserPort)))
     4c6:	2c79 0000 343c 	movea.l 343c <SysBase>,a6
     4cc:	206b 0056      	movea.l 86(a3),a0
     4d0:	4eae fe8c      	jsr -372(a6)
     4d4:	2440           	movea.l d0,a2
     4d6:	4a80           	tst.l d0
     4d8:	6600 ff3a      	bne.w 414 <main+0x3a0>

void RunSimulation()
{
	GameOfLifeCell **pf = GameMatrix.Playfield;

	for (int y = 0; y < GameMatrix.Rows; y++)
     4dc:	3039 0000 3450 	move.w 3450 <GameMatrix+0x4>,d0
		if (GameRunning)
     4e2:	4a79 0000 3440 	tst.w 3440 <GameRunning>
     4e8:	6600 03ca      	bne.w 8b4 <main+0x840>
		DrawCells(GolMainWindow, FALSE);
     4ec:	2479 0000 3446 	movea.l 3446 <GolMainWindow>,a2
	for (int y = 0; y < GameMatrix.Rows; y++)
     4f2:	4a40           	tst.w d0
     4f4:	6700 00d0      	beq.w 5c6 <main+0x552>
	{
		for (int x = 0; x < GameMatrix.Columns; x++)
     4f8:	3439 0000 3452 	move.w 3452 <GameMatrix+0x6>,d2
		for (int x = 0; x < GameMatrix.Columns; x++)
     4fe:	7e00           	moveq #0,d7
     500:	7c00           	moveq #0,d6
     502:	4a42           	tst.w d2
     504:	6700 00c0      	beq.w 5c6 <main+0x552>
     508:	7a00           	moveq #0,d5
     50a:	7800           	moveq #0,d4
			if (!GameMatrix.Playfield[x][y].StatusChanged && !forceFull)
     50c:	43f9 0000 344c 	lea 344c <GameMatrix>,a1
     512:	2051           	movea.l (a1),a0
     514:	2070 5800      	movea.l (0,a0,d5.l),a0
     518:	d1c7           	adda.l d7,a0
     51a:	4a68 0002      	tst.w 2(a0)
     51e:	6700 0082      	beq.w 5a2 <main+0x52e>
			GameMatrix.Playfield[x][y].StatusChanged = FALSE;
     522:	4268 0002      	clr.w 2(a0)
				SetAPen(theWindow->RPort, GameMatrix.ColorAlive);
     526:	226a 0032      	movea.l 50(a2),a1
     52a:	2c79 0000 3434 	movea.l 3434 <GfxBase>,a6
     530:	7000           	moveq #0,d0
			if (GameMatrix.Playfield[x][y].Status)
     532:	4a50           	tst.w (a0)
     534:	6700 0310      	beq.w 846 <main+0x7d2>
				SetAPen(theWindow->RPort, GameMatrix.ColorAlive);
     538:	3039 0000 3454 	move.w 3454 <GameMatrix+0x8>,d0
     53e:	4eae feaa      	jsr -342(a6)
			RectFill(theWindow->RPort,
     542:	226a 0032      	movea.l 50(a2),a1
     546:	7400           	moveq #0,d2
     548:	3439 0000 3458 	move.w 3458 <GameMatrix+0xc>,d2
     54e:	2f04           	move.l d4,-(sp)
     550:	2f02           	move.l d2,-(sp)
     552:	2f49 0036      	move.l a1,54(sp)
     556:	4eb9 0000 10c4 	jsr 10c4 <__mulsi3>
     55c:	508f           	addq.l #8,sp
     55e:	2640           	movea.l d0,a3
     560:	4beb 0001      	lea 1(a3),a5
     564:	7000           	moveq #0,d0
     566:	3039 0000 345a 	move.w 345a <GameMatrix+0xe>,d0
     56c:	2840           	movea.l d0,a4
     56e:	2f06           	move.l d6,-(sp)
     570:	2f0c           	move.l a4,-(sp)
     572:	4eb9 0000 10c4 	jsr 10c4 <__mulsi3>
     578:	508f           	addq.l #8,sp
     57a:	2600           	move.l d0,d3
     57c:	2c79 0000 3434 	movea.l 3434 <GfxBase>,a6
     582:	226f 002e      	movea.l 46(sp),a1
     586:	200d           	move.l a5,d0
     588:	2203           	move.l d3,d1
     58a:	5281           	addq.l #1,d1
     58c:	47f3 28ff      	lea (-1,a3,d2.l),a3
     590:	240b           	move.l a3,d2
     592:	49f4 38ff      	lea (-1,a4,d3.l),a4
     596:	260c           	move.l a4,d3
     598:	4eae fece      	jsr -306(a6)
		for (int x = 0; x < GameMatrix.Columns; x++)
     59c:	3439 0000 3452 	move.w 3452 <GameMatrix+0x6>,d2
     5a2:	5284           	addq.l #1,d4
     5a4:	5885           	addq.l #4,d5
     5a6:	7000           	moveq #0,d0
     5a8:	3002           	move.w d2,d0
     5aa:	b084           	cmp.l d4,d0
     5ac:	6e00 ff5e      	bgt.w 50c <main+0x498>
	for (int y = 0; y < GameMatrix.Rows; y++)
     5b0:	5286           	addq.l #1,d6
     5b2:	7000           	moveq #0,d0
     5b4:	3039 0000 3450 	move.w 3450 <GameMatrix+0x4>,d0
     5ba:	b086           	cmp.l d6,d0
     5bc:	6f08           	ble.s 5c6 <main+0x552>
     5be:	5c87           	addq.l #6,d7
		for (int x = 0; x < GameMatrix.Columns; x++)
     5c0:	4a42           	tst.w d2
     5c2:	6600 ff44      	bne.w 508 <main+0x494>
	while (AppRunning)
     5c6:	4a79 0000 3424 	tst.w 3424 <AppRunning>
     5cc:	6600 fe1e      	bne.w 3ec <main+0x378>
	FreeMem((APTR)GameMatrix.Playfield, GameMatrix.Rows * GameMatrix.Columns * sizeof(GameOfLifeCell));
     5d0:	3239 0000 3450 	move.w 3450 <GameMatrix+0x4>,d1
     5d6:	c2f9 0000 3452 	mulu.w 3452 <GameMatrix+0x6>,d1
     5dc:	2001           	move.l d1,d0
     5de:	d081           	add.l d1,d0
     5e0:	d081           	add.l d1,d0
     5e2:	2c79 0000 343c 	movea.l 343c <SysBase>,a6
     5e8:	45f9 0000 344c 	lea 344c <GameMatrix>,a2
     5ee:	2252           	movea.l (a2),a1
     5f0:	d080           	add.l d0,d0
     5f2:	4eae ff2e      	jsr -210(a6)
	if (GolMainWindow)
     5f6:	2079 0000 3446 	movea.l 3446 <GolMainWindow>,a0
     5fc:	b0fc 0000      	cmpa.w #0,a0
     600:	670a           	beq.s 60c <main+0x598>
		CloseWindow(GolMainWindow);
     602:	2c79 0000 3438 	movea.l 3438 <IntuitionBase>,a6
     608:	4eae ffb8      	jsr -72(a6)
	if (GadToolsBase)
     60c:	2279 0000 3430 	movea.l 3430 <GadToolsBase>,a1
     612:	b2fc 0000      	cmpa.w #0,a1
     616:	670a           	beq.s 622 <main+0x5ae>
		CloseLibrary((struct Library *)GadToolsBase);
     618:	2c79 0000 343c 	movea.l 343c <SysBase>,a6
     61e:	4eae fe62      	jsr -414(a6)
	if (GolScreen)
     622:	2079 0000 342c 	movea.l 342c <GolScreen>,a0
     628:	b0fc 0000      	cmpa.w #0,a0
     62c:	670a           	beq.s 638 <main+0x5c4>
		CloseScreen(GolScreen);
     62e:	2c79 0000 3438 	movea.l 3438 <IntuitionBase>,a6
     634:	4eae ffbe      	jsr -66(a6)
	if (GfxBase)
     638:	2279 0000 3434 	movea.l 3434 <GfxBase>,a1
     63e:	b2fc 0000      	cmpa.w #0,a1
     642:	670a           	beq.s 64e <main+0x5da>
		CloseLibrary((struct Library *)GfxBase);
     644:	2c79 0000 343c 	movea.l 343c <SysBase>,a6
     64a:	4eae fe62      	jsr -414(a6)
	if (IntuitionBase)
     64e:	2279 0000 3438 	movea.l 3438 <IntuitionBase>,a1
     654:	b2fc 0000      	cmpa.w #0,a1
     658:	670a           	beq.s 664 <main+0x5f0>
		CloseLibrary((struct Library *)IntuitionBase);
     65a:	2c79 0000 343c 	movea.l 343c <SysBase>,a6
     660:	4eae fe62      	jsr -414(a6)
	if (DOSBase)
     664:	2279 0000 3428 	movea.l 3428 <DOSBase>,a1
     66a:	b2fc 0000      	cmpa.w #0,a1
     66e:	6700 06b8      	beq.w d28 <main+0xcb4>
		CloseLibrary((struct Library *)DOSBase);
     672:	2c79 0000 343c 	movea.l 343c <SysBase>,a6
     678:	4eae fe62      	jsr -414(a6)
     67c:	7000           	moveq #0,d0
}
     67e:	4cdf 7cfc      	movem.l (sp)+,d2-d7/a2-a6
     682:	4fef 00b4      	lea 180(sp),sp
     686:	4e75           	rts
		return RETURN_FAIL;
     688:	7014           	moveq #20,d0
}
     68a:	4cdf 7cfc      	movem.l (sp)+,d2-d7/a2-a6
     68e:	4fef 00b4      	lea 180(sp),sp
     692:	4e75           	rts
		switch (msg_class)
     694:	0c82 0000 0100 	cmpi.l #256,d2
     69a:	6722           	beq.s 6be <main+0x64a>
     69c:	0c82 0000 0200 	cmpi.l #512,d2
     6a2:	6600 fd5a      	bne.w 3fe <main+0x38a>
			AppRunning = FALSE;
     6a6:	4279 0000 3424 	clr.w 3424 <AppRunning>
			break;
     6ac:	6000 fd50      	bra.w 3fe <main+0x38a>
			DrawCells(theWindow, TRUE);
     6b0:	2f0b           	move.l a3,-(sp)
     6b2:	4eb9 0000 0d34 	jsr d34 <DrawCells.constprop.1>
     6b8:	588f           	addq.l #4,sp
     6ba:	6000 fd42      	bra.w 3fe <main+0x38a>
			menuNumber = message->Code;
     6be:	342a 0018      	move.w 24(a2),d2
			while ((menuNumber != MENUNULL) && (AppRunning))
     6c2:	0c42 ffff      	cmpi.w #-1,d2
     6c6:	6700 fd36      	beq.w 3fe <main+0x38a>
     6ca:	4a79 0000 3424 	tst.w 3424 <AppRunning>
     6d0:	6700 fd2c      	beq.w 3fe <main+0x38a>
				item = ItemAddress(theMenu, menuNumber);
     6d4:	2c79 0000 3438 	movea.l 3438 <IntuitionBase>,a6
     6da:	2043           	movea.l d3,a0
     6dc:	3002           	move.w d2,d0
     6de:	4eae ff70      	jsr -144(a6)
     6e2:	2a40           	movea.l d0,a5
				menuNum = MENUNUM(menuNumber);
     6e4:	3002           	move.w d2,d0
     6e6:	0240 001f      	andi.w #31,d0
				if ((menuNum == 0) && (itemNum == 5))
     6ea:	6642           	bne.s 72e <main+0x6ba>
				itemNum = ITEMNUM(menuNumber);
     6ec:	3002           	move.w d2,d0
     6ee:	ea48           	lsr.w #5,d0
     6f0:	0240 003f      	andi.w #63,d0
				if ((menuNum == 0) && (itemNum == 5))
     6f4:	0c40 0005      	cmpi.w #5,d0
     6f8:	6742           	beq.s 73c <main+0x6c8>
				if ((menuNum == 0) && (itemNum == 3) && (subNum == 2))
     6fa:	0c40 0003      	cmpi.w #3,d0
     6fe:	662e           	bne.s 72e <main+0x6ba>
				subNum = SUBNUM(menuNumber);
     700:	700b           	moveq #11,d0
     702:	e06a           	lsr.w d0,d2
				if ((menuNum == 0) && (itemNum == 3) && (subNum == 2))
     704:	0c42 0002      	cmpi.w #2,d2
     708:	6700 0090      	beq.w 79a <main+0x726>
				if ((menuNum == 0) && (itemNum == 3) && (subNum == 0))
     70c:	4a42           	tst.w d2
     70e:	6658           	bne.s 768 <main+0x6f4>
					SetWindowTitles(theWindow, (STRPTR) "Running", (STRPTR)-1);
     710:	2c79 0000 3438 	movea.l 3438 <IntuitionBase>,a6
     716:	204b           	movea.l a3,a0
     718:	43f9 0000 1249 	lea 1249 <PutChar+0x7d>,a1
     71e:	347c ffff      	movea.w #-1,a2
     722:	4eae feec      	jsr -276(a6)
					GameRunning = TRUE;
     726:	33fc 0001 0000 	move.w #1,3440 <GameRunning>
     72c:	3440 
				menuNumber = item->NextSelect;
     72e:	342d 0020      	move.w 32(a5),d2
			while ((menuNumber != MENUNULL) && (AppRunning))
     732:	0c42 ffff      	cmpi.w #-1,d2
     736:	6692           	bne.s 6ca <main+0x656>
     738:	6000 fcc4      	bra.w 3fe <main+0x38a>
					AppRunning = FALSE;
     73c:	4279 0000 3424 	clr.w 3424 <AppRunning>
					SetWindowTitles(theWindow, (STRPTR) "Running", (STRPTR)-1);
     742:	2c79 0000 3438 	movea.l 3438 <IntuitionBase>,a6
     748:	204b           	movea.l a3,a0
     74a:	43f9 0000 1249 	lea 1249 <PutChar+0x7d>,a1
     750:	347c ffff      	movea.w #-1,a2
     754:	4eae feec      	jsr -276(a6)
				menuNumber = item->NextSelect;
     758:	342d 0020      	move.w 32(a5),d2
			while ((menuNumber != MENUNULL) && (AppRunning))
     75c:	0c42 ffff      	cmpi.w #-1,d2
     760:	6600 ff68      	bne.w 6ca <main+0x656>
     764:	6000 fc98      	bra.w 3fe <main+0x38a>
				if ((menuNum == 0) && (itemNum == 3) && (subNum == 1))
     768:	0c42 0001      	cmpi.w #1,d2
     76c:	66c0           	bne.s 72e <main+0x6ba>
					SetWindowTitles(theWindow, (STRPTR) "Stopped", (STRPTR)-1);
     76e:	2c79 0000 3438 	movea.l 3438 <IntuitionBase>,a6
     774:	204b           	movea.l a3,a0
     776:	43f9 0000 1228 	lea 1228 <PutChar+0x5c>,a1
     77c:	347c ffff      	movea.w #-1,a2
     780:	4eae feec      	jsr -276(a6)
					GameRunning = FALSE;
     784:	4279 0000 3440 	clr.w 3440 <GameRunning>
				menuNumber = item->NextSelect;
     78a:	342d 0020      	move.w 32(a5),d2
			while ((menuNumber != MENUNULL) && (AppRunning))
     78e:	0c42 ffff      	cmpi.w #-1,d2
     792:	6600 ff36      	bne.w 6ca <main+0x656>
     796:	6000 fc66      	bra.w 3fe <main+0x38a>
	for (int x = 0; x < GameMatrix.Columns; x++)
     79a:	3239 0000 3452 	move.w 3452 <GameMatrix+0x6>,d1
     7a0:	678c           	beq.s 72e <main+0x6ba>
		for (int y = 0; y < GameMatrix.Rows; y++)
     7a2:	3439 0000 3450 	move.w 3450 <GameMatrix+0x4>,d2
			GameMatrix.Playfield[x][y].Neighbours = 0;
     7a8:	41f9 0000 344c 	lea 344c <GameMatrix>,a0
     7ae:	2250           	movea.l (a0),a1
     7b0:	673c           	beq.s 7ee <main+0x77a>
     7b2:	0281 0000 ffff 	andi.l #65535,d1
     7b8:	d281           	add.l d1,d1
     7ba:	d281           	add.l d1,d1
     7bc:	d289           	add.l a1,d1
     7be:	0282 0000 ffff 	andi.l #65535,d2
     7c4:	2002           	move.l d2,d0
     7c6:	d082           	add.l d2,d0
     7c8:	d082           	add.l d2,d0
     7ca:	d080           	add.l d0,d0
		for (int y = 0; y < GameMatrix.Rows; y++)
     7cc:	2059           	movea.l (a1)+,a0
     7ce:	2408           	move.l a0,d2
     7d0:	d480           	add.l d0,d2
			GameMatrix.Playfield[x][y].Neighbours = 0;
     7d2:	4268 0004      	clr.w 4(a0)
			GameMatrix.Playfield[x][y].Status = 0;
     7d6:	4250           	clr.w (a0)
			GameMatrix.Playfield[x][y].StatusChanged = TRUE;
     7d8:	317c 0001 0002 	move.w #1,2(a0)
		for (int y = 0; y < GameMatrix.Rows; y++)
     7de:	5c88           	addq.l #6,a0
     7e0:	b1c2           	cmpa.l d2,a0
     7e2:	66ee           	bne.s 7d2 <main+0x75e>
	for (int x = 0; x < GameMatrix.Columns; x++)
     7e4:	b3c1           	cmpa.l d1,a1
     7e6:	66e4           	bne.s 7cc <main+0x758>
     7e8:	3239 0000 3452 	move.w 3452 <GameMatrix+0x6>,d1
     7ee:	4a41           	tst.w d1
     7f0:	6700 ff3c      	beq.w 72e <main+0x6ba>
		for (int y = 0; y < GameMatrix.Rows; y++)
     7f4:	3439 0000 3450 	move.w 3450 <GameMatrix+0x4>,d2
			GameMatrix.Playfield[x][y].Neighbours = 0;
     7fa:	41f9 0000 344c 	lea 344c <GameMatrix>,a0
     800:	2250           	movea.l (a0),a1
     802:	6700 ff2a      	beq.w 72e <main+0x6ba>
     806:	0281 0000 ffff 	andi.l #65535,d1
     80c:	d281           	add.l d1,d1
     80e:	d281           	add.l d1,d1
     810:	d289           	add.l a1,d1
     812:	0282 0000 ffff 	andi.l #65535,d2
     818:	2002           	move.l d2,d0
     81a:	d082           	add.l d2,d0
     81c:	d082           	add.l d2,d0
     81e:	d080           	add.l d0,d0
		for (int y = 0; y < GameMatrix.Rows; y++)
     820:	2059           	movea.l (a1)+,a0
     822:	2408           	move.l a0,d2
     824:	d480           	add.l d0,d2
			GameMatrix.Playfield[x][y].Neighbours = 0;
     826:	4268 0004      	clr.w 4(a0)
			GameMatrix.Playfield[x][y].Status = 0;
     82a:	4250           	clr.w (a0)
			GameMatrix.Playfield[x][y].StatusChanged = TRUE;
     82c:	317c 0001 0002 	move.w #1,2(a0)
		for (int y = 0; y < GameMatrix.Rows; y++)
     832:	5c88           	addq.l #6,a0
     834:	b488           	cmp.l a0,d2
     836:	66ee           	bne.s 826 <main+0x7b2>
	for (int x = 0; x < GameMatrix.Columns; x++)
     838:	b289           	cmp.l a1,d1
     83a:	6700 fef2      	beq.w 72e <main+0x6ba>
		for (int y = 0; y < GameMatrix.Rows; y++)
     83e:	2059           	movea.l (a1)+,a0
     840:	2408           	move.l a0,d2
     842:	d480           	add.l d0,d2
     844:	60e0           	bra.s 826 <main+0x7b2>
				SetAPen(theWindow->RPort, GameMatrix.ColorDead);
     846:	3039 0000 3456 	move.w 3456 <GameMatrix+0xa>,d0
     84c:	4eae feaa      	jsr -342(a6)
			RectFill(theWindow->RPort,
     850:	226a 0032      	movea.l 50(a2),a1
     854:	7400           	moveq #0,d2
     856:	3439 0000 3458 	move.w 3458 <GameMatrix+0xc>,d2
     85c:	2f04           	move.l d4,-(sp)
     85e:	2f02           	move.l d2,-(sp)
     860:	2f49 0036      	move.l a1,54(sp)
     864:	4eb9 0000 10c4 	jsr 10c4 <__mulsi3>
     86a:	508f           	addq.l #8,sp
     86c:	2640           	movea.l d0,a3
     86e:	4beb 0001      	lea 1(a3),a5
     872:	7000           	moveq #0,d0
     874:	3039 0000 345a 	move.w 345a <GameMatrix+0xe>,d0
     87a:	2840           	movea.l d0,a4
     87c:	2f06           	move.l d6,-(sp)
     87e:	2f0c           	move.l a4,-(sp)
     880:	4eb9 0000 10c4 	jsr 10c4 <__mulsi3>
     886:	508f           	addq.l #8,sp
     888:	2600           	move.l d0,d3
     88a:	2c79 0000 3434 	movea.l 3434 <GfxBase>,a6
     890:	226f 002e      	movea.l 46(sp),a1
     894:	200d           	move.l a5,d0
     896:	2203           	move.l d3,d1
     898:	5281           	addq.l #1,d1
     89a:	47f3 28ff      	lea (-1,a3,d2.l),a3
     89e:	240b           	move.l a3,d2
     8a0:	49f4 38ff      	lea (-1,a4,d3.l),a4
     8a4:	260c           	move.l a4,d3
     8a6:	4eae fece      	jsr -306(a6)
		for (int x = 0; x < GameMatrix.Columns; x++)
     8aa:	3439 0000 3452 	move.w 3452 <GameMatrix+0x6>,d2
     8b0:	6000 fcf0      	bra.w 5a2 <main+0x52e>
	for (int y = 0; y < GameMatrix.Rows; y++)
     8b4:	7c00           	moveq #0,d6
     8b6:	3c00           	move.w d0,d6
	GameOfLifeCell **pf = GameMatrix.Playfield;
     8b8:	45f9 0000 344c 	lea 344c <GameMatrix>,a2
     8be:	2252           	movea.l (a2),a1
	for (int y = 0; y < GameMatrix.Rows; y++)
     8c0:	6700 fd04      	beq.w 5c6 <main+0x552>
		for (int x = 0; x < GameMatrix.Columns; x++)
     8c4:	3439 0000 3452 	move.w 3452 <GameMatrix+0x6>,d2
     8ca:	7000           	moveq #0,d0
     8cc:	3002           	move.w d2,d0
     8ce:	2c40           	movea.l d0,a6
     8d0:	677e           	beq.s 950 <main+0x8dc>
     8d2:	280e           	move.l a6,d4
     8d4:	5384           	subq.l #1,d4
     8d6:	7a00           	moveq #0,d5
	for (int y = 0; y < GameMatrix.Rows; y++)
     8d8:	7200           	moveq #0,d1
						neighbours++;
					if (pf[x][y + 1].Status)
						neighbours++;
				}
			}
			else if (y > 0 && y < GameMatrix.Rows - 1) // rows between 1st and last
     8da:	2606           	move.l d6,d3
     8dc:	5383           	subq.l #1,d3
     8de:	3f42 0036      	move.w d2,54(sp)
     8e2:	2a46           	movea.l d6,a5
		for (int x = 0; x < GameMatrix.Columns; x++)
     8e4:	2405           	move.l d5,d2
     8e6:	5d82           	subq.l #6,d2
     8e8:	2045           	movea.l d5,a0
     8ea:	5c85           	addq.l #6,d5
     8ec:	4a84           	tst.l d4
     8ee:	6600 01a6      	bne.w a96 <main+0xa22>
			else if (y > 0 && y < GameMatrix.Rows - 1) // rows between 1st and last
     8f2:	7000           	moveq #0,d0
     8f4:	2840           	movea.l d0,a4
     8f6:	d9c0           	adda.l d0,a4
     8f8:	d9cc           	adda.l a4,a4
     8fa:	49f1 c800      	lea (0,a1,a4.l),a4
					if (pf[x][y + 1].Status)
     8fe:	245c           	movea.l (a4)+,a2
			if (y == 0) // 1st row
     900:	4a81           	tst.l d1
     902:	6600 0088      	bne.w 98c <main+0x918>
				if (x == 0) // 1st column
     906:	4a80           	tst.l d0
     908:	6600 012a      	bne.w a34 <main+0x9c0>
					if (pf[x + 1][y].Status)
     90c:	2669 0004      	movea.l 4(a1),a3
     910:	4a53           	tst.w (a3)
     912:	56c6           	sne d6
     914:	4886           	ext.w d6
     916:	4446           	neg.w d6
					if (pf[x + 1][y + 1].Status)
     918:	4a6b 0006      	tst.w 6(a3)
     91c:	6702           	beq.s 920 <main+0x8ac>
						neighbours++;
     91e:	5246           	addq.w #1,d6
					if (pf[x][y + 1].Status)
     920:	2651           	movea.l (a1),a3
     922:	4a6b 0006      	tst.w 6(a3)
     926:	673e           	beq.s 966 <main+0x8f2>
					if (pf[x - 1][y - 1].Status)
						neighbours++;
					if (pf[x - 1][y].Status)
						neighbours++;
					if (pf[x][y - 1].Status)
						neighbours++;
     928:	5246           	addq.w #1,d6
				}
			}

			if ((pf[x][y].Status==0 && neighbours == 3))
     92a:	d5c8           	adda.l a0,a2
     92c:	3e12           	move.w (a2),d7
     92e:	663c           	bne.s 96c <main+0x8f8>
     930:	0c46 0003      	cmpi.w #3,d6
     934:	660a           	bne.s 940 <main+0x8cc>
			{
				pf[x][y].Status = 1;
     936:	34bc 0001      	move.w #1,(a2)
				pf[x][y].StatusChanged = TRUE;
     93a:	357c 0001 0002 	move.w #1,2(a2)
		for (int x = 0; x < GameMatrix.Columns; x++)
     940:	5280           	addq.l #1,d0
     942:	b08e           	cmp.l a6,d0
     944:	6db8           	blt.s 8fe <main+0x88a>
	for (int y = 0; y < GameMatrix.Rows; y++)
     946:	5281           	addq.l #1,d1
     948:	bbc1           	cmpa.l d1,a5
     94a:	6698           	bne.s 8e4 <main+0x870>
     94c:	342f 0036      	move.w 54(sp),d2
		DrawCells(GolMainWindow, FALSE);
     950:	2479 0000 3446 	movea.l 3446 <GolMainWindow>,a2
		for (int x = 0; x < GameMatrix.Columns; x++)
     956:	7e00           	moveq #0,d7
     958:	7c00           	moveq #0,d6
     95a:	6000 fba6      	bra.w 502 <main+0x48e>
			else if (y == GameMatrix.Rows - 1) // last row
     95e:	b283           	cmp.l d3,d1
     960:	6700 00a6      	beq.w a08 <main+0x994>
			USHORT neighbours = 0;
     964:	4246           	clr.w d6
			if ((pf[x][y].Status==0 && neighbours == 3))
     966:	d5c8           	adda.l a0,a2
     968:	3e12           	move.w (a2),d7
     96a:	67d4           	beq.s 940 <main+0x8cc>
				continue;
			}
			if ((pf[x][y].Status==1 && (neighbours < 2 || neighbours > 3)))
     96c:	0c47 0001      	cmpi.w #1,d7
     970:	66ce           	bne.s 940 <main+0x8cc>
     972:	5546           	subq.w #2,d6
     974:	0c46 0001      	cmpi.w #1,d6
     978:	63c6           	bls.s 940 <main+0x8cc>
			{
				pf[x][y].Status = 0;
     97a:	4252           	clr.w (a2)
				pf[x][y].StatusChanged = TRUE;
     97c:	357c 0001 0002 	move.w #1,2(a2)
		for (int x = 0; x < GameMatrix.Columns; x++)
     982:	5280           	addq.l #1,d0
     984:	b08e           	cmp.l a6,d0
     986:	6d00 ff76      	blt.w 8fe <main+0x88a>
     98a:	60ba           	bra.s 946 <main+0x8d2>
			else if (y > 0 && y < GameMatrix.Rows - 1) // rows between 1st and last
     98c:	b283           	cmp.l d3,d1
     98e:	6cce           	bge.s 95e <main+0x8ea>
				if (x == 0)
     990:	4a80           	tst.l d0
     992:	6634           	bne.s 9c8 <main+0x954>
					if (pf[x][y - 1].Status)
     994:	2651           	movea.l (a1),a3
     996:	4a73 2800      	tst.w (0,a3,d2.l)
     99a:	56c6           	sne d6
     99c:	4886           	ext.w d6
     99e:	4446           	neg.w d6
					if (pf[x][y + 1].Status)
     9a0:	4a73 5800      	tst.w (0,a3,d5.l)
     9a4:	6702           	beq.s 9a8 <main+0x934>
						neighbours++;
     9a6:	5246           	addq.w #1,d6
					if (pf[x + 1][y].Status)
     9a8:	2669 0004      	movea.l 4(a1),a3
     9ac:	4a73 8800      	tst.w (0,a3,a0.l)
     9b0:	6652           	bne.s a04 <main+0x990>
					if (pf[x - 1][y + 1].Status)
     9b2:	4a73 5800      	tst.w (0,a3,d5.l)
     9b6:	6702           	beq.s 9ba <main+0x946>
						neighbours++;
     9b8:	5246           	addq.w #1,d6
					if (pf[x - 1][y - 1].Status)
     9ba:	4a73 2800      	tst.w (0,a3,d2.l)
     9be:	6700 ff6a      	beq.w 92a <main+0x8b6>
						neighbours++;
     9c2:	5246           	addq.w #1,d6
     9c4:	6000 ff64      	bra.w 92a <main+0x8b6>
				else if (x > 0 && x < GameMatrix.Columns - 1)
     9c8:	b084           	cmp.l d4,d0
     9ca:	6c00 02b4      	bge.w c80 <main+0xc0c>
					if (pf[x][y + 1].Status)
     9ce:	4a72 5800      	tst.w (0,a2,d5.l)
     9d2:	56c6           	sne d6
     9d4:	4886           	ext.w d6
     9d6:	4446           	neg.w d6
					if (pf[x][y - 1].Status)
     9d8:	4a72 2800      	tst.w (0,a2,d2.l)
     9dc:	6702           	beq.s 9e0 <main+0x96c>
						neighbours++;
     9de:	5246           	addq.w #1,d6
					if (pf[x + 1][y].Status)
     9e0:	2654           	movea.l (a4),a3
     9e2:	4a73 8800      	tst.w (0,a3,a0.l)
     9e6:	6702           	beq.s 9ea <main+0x976>
						neighbours++;
     9e8:	5246           	addq.w #1,d6
					if (pf[x + 1][y - 1].Status)
     9ea:	4a73 2800      	tst.w (0,a3,d2.l)
     9ee:	6702           	beq.s 9f2 <main+0x97e>
						neighbours++;
     9f0:	5246           	addq.w #1,d6
					if (pf[x + 1][y + 1].Status)
     9f2:	4a73 5800      	tst.w (0,a3,d5.l)
     9f6:	6702           	beq.s 9fa <main+0x986>
						neighbours++;
     9f8:	5246           	addq.w #1,d6
					if (pf[x - 1][y].Status)
     9fa:	266c fff8      	movea.l -8(a4),a3
     9fe:	4a73 8800      	tst.w (0,a3,a0.l)
     a02:	67ae           	beq.s 9b2 <main+0x93e>
						neighbours++;
     a04:	5246           	addq.w #1,d6
     a06:	60aa           	bra.s 9b2 <main+0x93e>
				if (x == 0)
     a08:	4a80           	tst.l d0
     a0a:	6600 02e4      	bne.w cf0 <main+0xc7c>
					if (pf[x][y - 1].Status)
     a0e:	2651           	movea.l (a1),a3
     a10:	4a73 2800      	tst.w (0,a3,d2.l)
     a14:	56c6           	sne d6
     a16:	4886           	ext.w d6
     a18:	4446           	neg.w d6
					if (pf[x + 1][y - 1].Status)
     a1a:	2669 0004      	movea.l 4(a1),a3
     a1e:	4a73 2800      	tst.w (0,a3,d2.l)
     a22:	6702           	beq.s a26 <main+0x9b2>
						neighbours++;
     a24:	5246           	addq.w #1,d6
					if (pf[x + 1][y].Status)
     a26:	4a73 8800      	tst.w (0,a3,a0.l)
     a2a:	6700 ff3a      	beq.w 966 <main+0x8f2>
						neighbours++;
     a2e:	5246           	addq.w #1,d6
     a30:	6000 fef8      	bra.w 92a <main+0x8b6>
				else if (x > 0 && x < GameMatrix.Columns - 1) // columns in between 1st and last
     a34:	b880           	cmp.l d0,d4
     a36:	6f32           	ble.s a6a <main+0x9f6>
					if (pf[x + 1][y].Status)
     a38:	2654           	movea.l (a4),a3
     a3a:	4a53           	tst.w (a3)
     a3c:	56c6           	sne d6
     a3e:	4886           	ext.w d6
     a40:	4446           	neg.w d6
					if (pf[x + 1][y + 1].Status)
     a42:	4a6b 0006      	tst.w 6(a3)
     a46:	6702           	beq.s a4a <main+0x9d6>
						neighbours++;
     a48:	5246           	addq.w #1,d6
					if (pf[x][y + 1].Status)
     a4a:	4a6a 0006      	tst.w 6(a2)
     a4e:	6702           	beq.s a52 <main+0x9de>
						neighbours++;
     a50:	5246           	addq.w #1,d6
					if (pf[x - 1][y].Status)
     a52:	266c fff8      	movea.l -8(a4),a3
     a56:	4a53           	tst.w (a3)
     a58:	6702           	beq.s a5c <main+0x9e8>
						neighbours++;
     a5a:	5246           	addq.w #1,d6
					if (pf[x - 1][y + 1].Status)
     a5c:	4a6b 0006      	tst.w 6(a3)
     a60:	6700 fec8      	beq.w 92a <main+0x8b6>
						neighbours++;
     a64:	5246           	addq.w #1,d6
     a66:	6000 fec2      	bra.w 92a <main+0x8b6>
				else if (x == GameMatrix.Columns - 1) // last column
     a6a:	b880           	cmp.l d0,d4
     a6c:	6600 fef6      	bne.w 964 <main+0x8f0>
					if (pf[x - 1][y].Status)
     a70:	266c fff8      	movea.l -8(a4),a3
     a74:	4a53           	tst.w (a3)
     a76:	56c6           	sne d6
     a78:	4886           	ext.w d6
     a7a:	4446           	neg.w d6
					if (pf[x - 1][y + 1].Status)
     a7c:	4a6b 0006      	tst.w 6(a3)
     a80:	6702           	beq.s a84 <main+0xa10>
						neighbours++;
     a82:	5246           	addq.w #1,d6
					if (pf[x][y + 1].Status)
     a84:	266c fffc      	movea.l -4(a4),a3
     a88:	4a6b 0006      	tst.w 6(a3)
     a8c:	6700 fed8      	beq.w 966 <main+0x8f2>
						neighbours++;
     a90:	5246           	addq.w #1,d6
     a92:	6000 fe96      	bra.w 92a <main+0x8b6>
     a96:	2c0e           	move.l a6,d6
     a98:	b88e           	cmp.l a6,d4
     a9a:	6c02           	bge.s a9e <main+0xa2a>
     a9c:	2c04           	move.l d4,d6
     a9e:	2849           	movea.l a1,a4
		for (int x = 0; x < GameMatrix.Columns; x++)
     aa0:	7000           	moveq #0,d0
     aa2:	2f44 0032      	move.l d4,50(sp)
					if (pf[x][y + 1].Status)
     aa6:	245c           	movea.l (a4)+,a2
			if (y == 0) // 1st row
     aa8:	4a81           	tst.l d1
     aaa:	6600 0088      	bne.w b34 <main+0xac0>
				if (x == 0) // 1st column
     aae:	4a80           	tst.l d0
     ab0:	6600 012c      	bne.w bde <main+0xb6a>
					if (pf[x + 1][y].Status)
     ab4:	2669 0004      	movea.l 4(a1),a3
     ab8:	4a53           	tst.w (a3)
     aba:	56c7           	sne d7
     abc:	4887           	ext.w d7
     abe:	4447           	neg.w d7
					if (pf[x + 1][y + 1].Status)
     ac0:	4a6b 0006      	tst.w 6(a3)
     ac4:	6702           	beq.s ac8 <main+0xa54>
						neighbours++;
     ac6:	5247           	addq.w #1,d7
					if (pf[x][y + 1].Status)
     ac8:	2651           	movea.l (a1),a3
     aca:	4a6b 0006      	tst.w 6(a3)
     ace:	673e           	beq.s b0e <main+0xa9a>
						neighbours++;
     ad0:	5247           	addq.w #1,d7
			if ((pf[x][y].Status==0 && neighbours == 3))
     ad2:	d5c8           	adda.l a0,a2
     ad4:	3812           	move.w (a2),d4
     ad6:	663c           	bne.s b14 <main+0xaa0>
     ad8:	0c47 0003      	cmpi.w #3,d7
     adc:	660a           	bne.s ae8 <main+0xa74>
				pf[x][y].Status = 1;
     ade:	34bc 0001      	move.w #1,(a2)
				pf[x][y].StatusChanged = TRUE;
     ae2:	357c 0001 0002 	move.w #1,2(a2)
		for (int x = 0; x < GameMatrix.Columns; x++)
     ae8:	5280           	addq.l #1,d0
     aea:	bc80           	cmp.l d0,d6
     aec:	6eb8           	bgt.s aa6 <main+0xa32>
     aee:	282f 0032      	move.l 50(sp),d4
     af2:	bdc0           	cmpa.l d0,a6
     af4:	6f00 fe50      	ble.w 946 <main+0x8d2>
     af8:	2840           	movea.l d0,a4
     afa:	d9c0           	adda.l d0,a4
     afc:	d9cc           	adda.l a4,a4
     afe:	49f1 c800      	lea (0,a1,a4.l),a4
     b02:	6000 fdfa      	bra.w 8fe <main+0x88a>
			else if (y == GameMatrix.Rows - 1) // last row
     b06:	b283           	cmp.l d3,d1
     b08:	6700 00a8      	beq.w bb2 <main+0xb3e>
			USHORT neighbours = 0;
     b0c:	4247           	clr.w d7
			if ((pf[x][y].Status==0 && neighbours == 3))
     b0e:	d5c8           	adda.l a0,a2
     b10:	3812           	move.w (a2),d4
     b12:	67d4           	beq.s ae8 <main+0xa74>
			if ((pf[x][y].Status==1 && (neighbours < 2 || neighbours > 3)))
     b14:	0c44 0001      	cmpi.w #1,d4
     b18:	66ce           	bne.s ae8 <main+0xa74>
     b1a:	5547           	subq.w #2,d7
     b1c:	0c47 0001      	cmpi.w #1,d7
     b20:	63c6           	bls.s ae8 <main+0xa74>
				pf[x][y].Status = 0;
     b22:	4252           	clr.w (a2)
				pf[x][y].StatusChanged = TRUE;
     b24:	357c 0001 0002 	move.w #1,2(a2)
		for (int x = 0; x < GameMatrix.Columns; x++)
     b2a:	5280           	addq.l #1,d0
     b2c:	bc80           	cmp.l d0,d6
     b2e:	6e00 ff76      	bgt.w aa6 <main+0xa32>
     b32:	60ba           	bra.s aee <main+0xa7a>
			else if (y > 0 && y < GameMatrix.Rows - 1) // rows between 1st and last
     b34:	b283           	cmp.l d3,d1
     b36:	6cce           	bge.s b06 <main+0xa92>
				if (x == 0)
     b38:	4a80           	tst.l d0
     b3a:	6634           	bne.s b70 <main+0xafc>
					if (pf[x][y - 1].Status)
     b3c:	2651           	movea.l (a1),a3
     b3e:	4a73 2800      	tst.w (0,a3,d2.l)
     b42:	56c7           	sne d7
     b44:	4887           	ext.w d7
     b46:	4447           	neg.w d7
					if (pf[x][y + 1].Status)
     b48:	4a73 5800      	tst.w (0,a3,d5.l)
     b4c:	6702           	beq.s b50 <main+0xadc>
						neighbours++;
     b4e:	5247           	addq.w #1,d7
					if (pf[x + 1][y].Status)
     b50:	2669 0004      	movea.l 4(a1),a3
     b54:	4a73 8800      	tst.w (0,a3,a0.l)
     b58:	6654           	bne.s bae <main+0xb3a>
					if (pf[x - 1][y + 1].Status)
     b5a:	4a73 5800      	tst.w (0,a3,d5.l)
     b5e:	6702           	beq.s b62 <main+0xaee>
						neighbours++;
     b60:	5247           	addq.w #1,d7
					if (pf[x - 1][y - 1].Status)
     b62:	4a73 2800      	tst.w (0,a3,d2.l)
     b66:	6700 ff6a      	beq.w ad2 <main+0xa5e>
						neighbours++;
     b6a:	5247           	addq.w #1,d7
     b6c:	6000 ff64      	bra.w ad2 <main+0xa5e>
				else if (x > 0 && x < GameMatrix.Columns - 1)
     b70:	b0af 0032      	cmp.l 50(sp),d0
     b74:	6c00 00ce      	bge.w c44 <main+0xbd0>
					if (pf[x][y + 1].Status)
     b78:	4a72 5800      	tst.w (0,a2,d5.l)
     b7c:	56c7           	sne d7
     b7e:	4887           	ext.w d7
     b80:	4447           	neg.w d7
					if (pf[x][y - 1].Status)
     b82:	4a72 2800      	tst.w (0,a2,d2.l)
     b86:	6702           	beq.s b8a <main+0xb16>
						neighbours++;
     b88:	5247           	addq.w #1,d7
					if (pf[x + 1][y].Status)
     b8a:	2654           	movea.l (a4),a3
     b8c:	4a73 8800      	tst.w (0,a3,a0.l)
     b90:	6702           	beq.s b94 <main+0xb20>
						neighbours++;
     b92:	5247           	addq.w #1,d7
					if (pf[x + 1][y - 1].Status)
     b94:	4a73 2800      	tst.w (0,a3,d2.l)
     b98:	6702           	beq.s b9c <main+0xb28>
						neighbours++;
     b9a:	5247           	addq.w #1,d7
					if (pf[x + 1][y + 1].Status)
     b9c:	4a73 5800      	tst.w (0,a3,d5.l)
     ba0:	6702           	beq.s ba4 <main+0xb30>
						neighbours++;
     ba2:	5247           	addq.w #1,d7
					if (pf[x - 1][y].Status)
     ba4:	266c fff8      	movea.l -8(a4),a3
     ba8:	4a73 8800      	tst.w (0,a3,a0.l)
     bac:	67ac           	beq.s b5a <main+0xae6>
						neighbours++;
     bae:	5247           	addq.w #1,d7
     bb0:	60a8           	bra.s b5a <main+0xae6>
				if (x == 0)
     bb2:	4a80           	tst.l d0
     bb4:	6600 0104      	bne.w cba <main+0xc46>
					if (pf[x][y - 1].Status)
     bb8:	2651           	movea.l (a1),a3
     bba:	4a73 2800      	tst.w (0,a3,d2.l)
     bbe:	56c7           	sne d7
     bc0:	4887           	ext.w d7
     bc2:	4447           	neg.w d7
					if (pf[x + 1][y - 1].Status)
     bc4:	2669 0004      	movea.l 4(a1),a3
     bc8:	4a73 2800      	tst.w (0,a3,d2.l)
     bcc:	6702           	beq.s bd0 <main+0xb5c>
						neighbours++;
     bce:	5247           	addq.w #1,d7
					if (pf[x + 1][y].Status)
     bd0:	4a73 8800      	tst.w (0,a3,a0.l)
     bd4:	6700 ff38      	beq.w b0e <main+0xa9a>
						neighbours++;
     bd8:	5247           	addq.w #1,d7
     bda:	6000 fef6      	bra.w ad2 <main+0xa5e>
				else if (x > 0 && x < GameMatrix.Columns - 1) // columns in between 1st and last
     bde:	b0af 0032      	cmp.l 50(sp),d0
     be2:	6c32           	bge.s c16 <main+0xba2>
					if (pf[x + 1][y].Status)
     be4:	2654           	movea.l (a4),a3
     be6:	4a53           	tst.w (a3)
     be8:	56c7           	sne d7
     bea:	4887           	ext.w d7
     bec:	4447           	neg.w d7
					if (pf[x + 1][y + 1].Status)
     bee:	4a6b 0006      	tst.w 6(a3)
     bf2:	6702           	beq.s bf6 <main+0xb82>
						neighbours++;
     bf4:	5247           	addq.w #1,d7
					if (pf[x][y + 1].Status)
     bf6:	4a6a 0006      	tst.w 6(a2)
     bfa:	6702           	beq.s bfe <main+0xb8a>
						neighbours++;
     bfc:	5247           	addq.w #1,d7
					if (pf[x - 1][y].Status)
     bfe:	266c fff8      	movea.l -8(a4),a3
     c02:	4a53           	tst.w (a3)
     c04:	6702           	beq.s c08 <main+0xb94>
						neighbours++;
     c06:	5247           	addq.w #1,d7
					if (pf[x - 1][y + 1].Status)
     c08:	4a6b 0006      	tst.w 6(a3)
     c0c:	6700 fec4      	beq.w ad2 <main+0xa5e>
						neighbours++;
     c10:	5247           	addq.w #1,d7
     c12:	6000 febe      	bra.w ad2 <main+0xa5e>
				else if (x == GameMatrix.Columns - 1) // last column
     c16:	b0af 0032      	cmp.l 50(sp),d0
     c1a:	6600 fef0      	bne.w b0c <main+0xa98>
					if (pf[x - 1][y].Status)
     c1e:	266c fff8      	movea.l -8(a4),a3
     c22:	4a53           	tst.w (a3)
     c24:	56c7           	sne d7
     c26:	4887           	ext.w d7
     c28:	4447           	neg.w d7
					if (pf[x - 1][y + 1].Status)
     c2a:	4a6b 0006      	tst.w 6(a3)
     c2e:	6702           	beq.s c32 <main+0xbbe>
						neighbours++;
     c30:	5247           	addq.w #1,d7
					if (pf[x][y + 1].Status)
     c32:	266c fffc      	movea.l -4(a4),a3
     c36:	4a6b 0006      	tst.w 6(a3)
     c3a:	6700 fed2      	beq.w b0e <main+0xa9a>
						neighbours++;
     c3e:	5247           	addq.w #1,d7
     c40:	6000 fe90      	bra.w ad2 <main+0xa5e>
				else if (x == GameMatrix.Columns - 1)
     c44:	b0af 0032      	cmp.l 50(sp),d0
     c48:	6600 fec2      	bne.w b0c <main+0xa98>
					if (pf[x - 1][y - 1].Status)
     c4c:	266c fff8      	movea.l -8(a4),a3
     c50:	4a73 2800      	tst.w (0,a3,d2.l)
     c54:	56c7           	sne d7
     c56:	4887           	ext.w d7
     c58:	4447           	neg.w d7
					if (pf[x - 1][y].Status)
     c5a:	4a73 8800      	tst.w (0,a3,a0.l)
     c5e:	6702           	beq.s c62 <main+0xbee>
						neighbours++;
     c60:	5247           	addq.w #1,d7
					if (pf[x - 1][y + 1].Status)
     c62:	4a73 5800      	tst.w (0,a3,d5.l)
     c66:	6702           	beq.s c6a <main+0xbf6>
						neighbours++;
     c68:	5247           	addq.w #1,d7
					if (pf[x][y - 1].Status)
     c6a:	4a72 2800      	tst.w (0,a2,d2.l)
     c6e:	6702           	beq.s c72 <main+0xbfe>
						neighbours++;
     c70:	5247           	addq.w #1,d7
					if (pf[x][y + 1].Status)
     c72:	4a72 5800      	tst.w (0,a2,d5.l)
     c76:	6700 fe5a      	beq.w ad2 <main+0xa5e>
						neighbours++;
     c7a:	5247           	addq.w #1,d7
     c7c:	6000 fe54      	bra.w ad2 <main+0xa5e>
				else if (x == GameMatrix.Columns - 1)
     c80:	b084           	cmp.l d4,d0
     c82:	6600 fce0      	bne.w 964 <main+0x8f0>
					if (pf[x - 1][y - 1].Status)
     c86:	266c fff8      	movea.l -8(a4),a3
     c8a:	4a73 2800      	tst.w (0,a3,d2.l)
     c8e:	56c6           	sne d6
     c90:	4886           	ext.w d6
     c92:	4446           	neg.w d6
					if (pf[x - 1][y].Status)
     c94:	4a73 8800      	tst.w (0,a3,a0.l)
     c98:	6702           	beq.s c9c <main+0xc28>
						neighbours++;
     c9a:	5246           	addq.w #1,d6
					if (pf[x - 1][y + 1].Status)
     c9c:	4a73 5800      	tst.w (0,a3,d5.l)
     ca0:	6702           	beq.s ca4 <main+0xc30>
						neighbours++;
     ca2:	5246           	addq.w #1,d6
					if (pf[x][y - 1].Status)
     ca4:	4a72 2800      	tst.w (0,a2,d2.l)
     ca8:	6702           	beq.s cac <main+0xc38>
						neighbours++;
     caa:	5246           	addq.w #1,d6
					if (pf[x][y + 1].Status)
     cac:	4a72 5800      	tst.w (0,a2,d5.l)
     cb0:	6700 fc78      	beq.w 92a <main+0x8b6>
						neighbours++;
     cb4:	5246           	addq.w #1,d6
     cb6:	6000 fc72      	bra.w 92a <main+0x8b6>
					if (pf[x - 1][y].Status)
     cba:	266c fff8      	movea.l -8(a4),a3
     cbe:	4a73 8800      	tst.w (0,a3,a0.l)
     cc2:	56c7           	sne d7
     cc4:	4887           	ext.w d7
     cc6:	4447           	neg.w d7
					if (pf[x - 1][y - 1].Status)
     cc8:	4a73 2800      	tst.w (0,a3,d2.l)
     ccc:	6702           	beq.s cd0 <main+0xc5c>
						neighbours++;
     cce:	5247           	addq.w #1,d7
					if (pf[x][y - 1].Status)
     cd0:	4a72 2800      	tst.w (0,a2,d2.l)
     cd4:	6702           	beq.s cd8 <main+0xc64>
						neighbours++;
     cd6:	5247           	addq.w #1,d7
					if (pf[x + 1][y - 1].Status)
     cd8:	2654           	movea.l (a4),a3
     cda:	4a73 2800      	tst.w (0,a3,d2.l)
     cde:	6702           	beq.s ce2 <main+0xc6e>
						neighbours++;
     ce0:	5247           	addq.w #1,d7
					if (pf[x + 1][y].Status)
     ce2:	4a73 8800      	tst.w (0,a3,a0.l)
     ce6:	6700 fdea      	beq.w ad2 <main+0xa5e>
						neighbours++;
     cea:	5247           	addq.w #1,d7
     cec:	6000 fde4      	bra.w ad2 <main+0xa5e>
				else if (x == GameMatrix.Columns - 1)
     cf0:	b084           	cmp.l d4,d0
     cf2:	6600 fc70      	bne.w 964 <main+0x8f0>
					if (pf[x - 1][y - 1].Status)
     cf6:	266c fff8      	movea.l -8(a4),a3
     cfa:	4a73 2800      	tst.w (0,a3,d2.l)
     cfe:	56c6           	sne d6
     d00:	4886           	ext.w d6
     d02:	4446           	neg.w d6
					if (pf[x - 1][y].Status)
     d04:	4a73 8800      	tst.w (0,a3,a0.l)
     d08:	6702           	beq.s d0c <main+0xc98>
						neighbours++;
     d0a:	5246           	addq.w #1,d6
					if (pf[x][y - 1].Status)
     d0c:	4a72 2800      	tst.w (0,a2,d2.l)
     d10:	6700 fc54      	beq.w 966 <main+0x8f2>
						neighbours++;
     d14:	5246           	addq.w #1,d6
     d16:	6000 fc12      	bra.w 92a <main+0x8b6>
			GameMatrix.Playfield[x][y].Status = 1;
     d1a:	30bc 0001      	move.w #1,(a0)
			GameMatrix.Playfield[x][y].StatusChanged = TRUE;
     d1e:	317c 0001 0002 	move.w #1,2(a0)
     d24:	6000 f6d8      	bra.w 3fe <main+0x38a>
     d28:	7000           	moveq #0,d0
}
     d2a:	4cdf 7cfc      	movem.l (sp)+,d2-d7/a2-a6
     d2e:	4fef 00b4      	lea 180(sp),sp
     d32:	4e75           	rts

00000d34 <DrawCells.constprop.1>:
void DrawCells(struct Window *theWindow, BOOL forceFull)
     d34:	4fef fff4      	lea -12(sp),sp
     d38:	48e7 3f3e      	movem.l d2-d7/a2-a6,-(sp)
     d3c:	246f 003c      	movea.l 60(sp),a2
	for (int y = 0; y < GameMatrix.Rows; y++)
     d40:	4a79 0000 3450 	tst.w 3450 <GameMatrix+0x4>
     d46:	6700 00d4      	beq.w e1c <DrawCells.constprop.1+0xe8>
		for (int x = 0; x < GameMatrix.Columns; x++)
     d4a:	3039 0000 3452 	move.w 3452 <GameMatrix+0x6>,d0
     d50:	42af 0034      	clr.l 52(sp)
	for (int y = 0; y < GameMatrix.Rows; y++)
     d54:	42af 0030      	clr.l 48(sp)
     d58:	49f9 0000 344c 	lea 344c <GameMatrix>,a4
     d5e:	47f9 0000 10c4 	lea 10c4 <__mulsi3>,a3
		for (int x = 0; x < GameMatrix.Columns; x++)
     d64:	4a40           	tst.w d0
     d66:	6700 00b4      	beq.w e1c <DrawCells.constprop.1+0xe8>
     d6a:	7a00           	moveq #0,d5
     d6c:	7800           	moveq #0,d4
			if (!GameMatrix.Playfield[x][y].StatusChanged && !forceFull)
     d6e:	2054           	movea.l (a4),a0
     d70:	2070 5800      	movea.l (0,a0,d5.l),a0
     d74:	d1ef 0034      	adda.l 52(sp),a0
			GameMatrix.Playfield[x][y].StatusChanged = FALSE;
     d78:	4268 0002      	clr.w 2(a0)
				SetAPen(theWindow->RPort, GameMatrix.ColorAlive);
     d7c:	226a 0032      	movea.l 50(a2),a1
     d80:	2c79 0000 3434 	movea.l 3434 <GfxBase>,a6
     d86:	7000           	moveq #0,d0
			if (GameMatrix.Playfield[x][y].Status)
     d88:	4a50           	tst.w (a0)
     d8a:	6700 009a      	beq.w e26 <DrawCells.constprop.1+0xf2>
				SetAPen(theWindow->RPort, GameMatrix.ColorAlive);
     d8e:	3039 0000 3454 	move.w 3454 <GameMatrix+0x8>,d0
     d94:	4eae feaa      	jsr -342(a6)
			RectFill(theWindow->RPort,
     d98:	226a 0032      	movea.l 50(a2),a1
     d9c:	7400           	moveq #0,d2
     d9e:	3439 0000 3458 	move.w 3458 <GameMatrix+0xc>,d2
     da4:	2f04           	move.l d4,-(sp)
     da6:	2f02           	move.l d2,-(sp)
     da8:	2f49 0034      	move.l a1,52(sp)
     dac:	4e93           	jsr (a3)
     dae:	508f           	addq.l #8,sp
     db0:	2a40           	movea.l d0,a5
     db2:	2c00           	move.l d0,d6
     db4:	5286           	addq.l #1,d6
     db6:	7e00           	moveq #0,d7
     db8:	3e39 0000 345a 	move.w 345a <GameMatrix+0xe>,d7
     dbe:	2f2f 0030      	move.l 48(sp),-(sp)
     dc2:	2f07           	move.l d7,-(sp)
     dc4:	4e93           	jsr (a3)
     dc6:	508f           	addq.l #8,sp
     dc8:	2600           	move.l d0,d3
     dca:	2c79 0000 3434 	movea.l 3434 <GfxBase>,a6
     dd0:	226f 002c      	movea.l 44(sp),a1
     dd4:	2006           	move.l d6,d0
     dd6:	2203           	move.l d3,d1
     dd8:	5281           	addq.l #1,d1
     dda:	4bf5 28ff      	lea (-1,a5,d2.l),a5
     dde:	240d           	move.l a5,d2
     de0:	2047           	movea.l d7,a0
     de2:	41f0 38ff      	lea (-1,a0,d3.l),a0
     de6:	2608           	move.l a0,d3
     de8:	4eae fece      	jsr -306(a6)
		for (int x = 0; x < GameMatrix.Columns; x++)
     dec:	5284           	addq.l #1,d4
     dee:	3039 0000 3452 	move.w 3452 <GameMatrix+0x6>,d0
     df4:	5885           	addq.l #4,d5
     df6:	7200           	moveq #0,d1
     df8:	3200           	move.w d0,d1
     dfa:	b284           	cmp.l d4,d1
     dfc:	6e00 ff70      	bgt.w d6e <DrawCells.constprop.1+0x3a>
	for (int y = 0; y < GameMatrix.Rows; y++)
     e00:	52af 0030      	addq.l #1,48(sp)
     e04:	7200           	moveq #0,d1
     e06:	3239 0000 3450 	move.w 3450 <GameMatrix+0x4>,d1
     e0c:	b2af 0030      	cmp.l 48(sp),d1
     e10:	6f0a           	ble.s e1c <DrawCells.constprop.1+0xe8>
     e12:	5caf 0034      	addq.l #6,52(sp)
		for (int x = 0; x < GameMatrix.Columns; x++)
     e16:	4a40           	tst.w d0
     e18:	6600 ff50      	bne.w d6a <DrawCells.constprop.1+0x36>
}
     e1c:	4cdf 7cfc      	movem.l (sp)+,d2-d7/a2-a6
     e20:	4fef 000c      	lea 12(sp),sp
     e24:	4e75           	rts
				SetAPen(theWindow->RPort, GameMatrix.ColorDead);
     e26:	3039 0000 3456 	move.w 3456 <GameMatrix+0xa>,d0
     e2c:	4eae feaa      	jsr -342(a6)
			RectFill(theWindow->RPort,
     e30:	226a 0032      	movea.l 50(a2),a1
     e34:	7400           	moveq #0,d2
     e36:	3439 0000 3458 	move.w 3458 <GameMatrix+0xc>,d2
     e3c:	2f04           	move.l d4,-(sp)
     e3e:	2f02           	move.l d2,-(sp)
     e40:	2f49 0034      	move.l a1,52(sp)
     e44:	4e93           	jsr (a3)
     e46:	508f           	addq.l #8,sp
     e48:	2a40           	movea.l d0,a5
     e4a:	2c00           	move.l d0,d6
     e4c:	5286           	addq.l #1,d6
     e4e:	7e00           	moveq #0,d7
     e50:	3e39 0000 345a 	move.w 345a <GameMatrix+0xe>,d7
     e56:	2f2f 0030      	move.l 48(sp),-(sp)
     e5a:	2f07           	move.l d7,-(sp)
     e5c:	4e93           	jsr (a3)
     e5e:	508f           	addq.l #8,sp
     e60:	2600           	move.l d0,d3
     e62:	2c79 0000 3434 	movea.l 3434 <GfxBase>,a6
     e68:	226f 002c      	movea.l 44(sp),a1
     e6c:	2006           	move.l d6,d0
     e6e:	2203           	move.l d3,d1
     e70:	5281           	addq.l #1,d1
     e72:	4bf5 28ff      	lea (-1,a5,d2.l),a5
     e76:	240d           	move.l a5,d2
     e78:	2047           	movea.l d7,a0
     e7a:	41f0 38ff      	lea (-1,a0,d3.l),a0
     e7e:	2608           	move.l a0,d3
     e80:	4eae fece      	jsr -306(a6)
		for (int x = 0; x < GameMatrix.Columns; x++)
     e84:	5284           	addq.l #1,d4
     e86:	3039 0000 3452 	move.w 3452 <GameMatrix+0x6>,d0
     e8c:	5885           	addq.l #4,d5
     e8e:	7200           	moveq #0,d1
     e90:	3200           	move.w d0,d1
     e92:	b284           	cmp.l d4,d1
     e94:	6e00 fed8      	bgt.w d6e <DrawCells.constprop.1+0x3a>
     e98:	6000 ff66      	bra.w e00 <DrawCells.constprop.1+0xcc>

00000e9c <strlen>:
{
     e9c:	206f 0004      	movea.l 4(sp),a0
	unsigned long t=0;
     ea0:	7000           	moveq #0,d0
	while(*s++)
     ea2:	4a10           	tst.b (a0)
     ea4:	6708           	beq.s eae <strlen+0x12>
		t++;
     ea6:	5280           	addq.l #1,d0
	while(*s++)
     ea8:	4a30 0800      	tst.b (0,a0,d0.l)
     eac:	66f8           	bne.s ea6 <strlen+0xa>
}
     eae:	4e75           	rts

00000eb0 <memset>:
{
     eb0:	48e7 3f30      	movem.l d2-d7/a2-a3,-(sp)
     eb4:	202f 0024      	move.l 36(sp),d0
     eb8:	282f 0028      	move.l 40(sp),d4
     ebc:	226f 002c      	movea.l 44(sp),a1
	while(len-- > 0)
     ec0:	2a09           	move.l a1,d5
     ec2:	5385           	subq.l #1,d5
     ec4:	b2fc 0000      	cmpa.w #0,a1
     ec8:	6700 00ae      	beq.w f78 <memset+0xc8>
		*ptr++ = val;
     ecc:	1e04           	move.b d4,d7
     ece:	2200           	move.l d0,d1
     ed0:	4481           	neg.l d1
     ed2:	7403           	moveq #3,d2
     ed4:	c282           	and.l d2,d1
     ed6:	7c05           	moveq #5,d6
     ed8:	2440           	movea.l d0,a2
     eda:	bc85           	cmp.l d5,d6
     edc:	646a           	bcc.s f48 <memset+0x98>
     ede:	4a81           	tst.l d1
     ee0:	6724           	beq.s f06 <memset+0x56>
     ee2:	14c4           	move.b d4,(a2)+
	while(len-- > 0)
     ee4:	5385           	subq.l #1,d5
     ee6:	7401           	moveq #1,d2
     ee8:	b481           	cmp.l d1,d2
     eea:	671a           	beq.s f06 <memset+0x56>
		*ptr++ = val;
     eec:	2440           	movea.l d0,a2
     eee:	548a           	addq.l #2,a2
     ef0:	2040           	movea.l d0,a0
     ef2:	1144 0001      	move.b d4,1(a0)
	while(len-- > 0)
     ef6:	5385           	subq.l #1,d5
     ef8:	7403           	moveq #3,d2
     efa:	b481           	cmp.l d1,d2
     efc:	6608           	bne.s f06 <memset+0x56>
		*ptr++ = val;
     efe:	528a           	addq.l #1,a2
     f00:	1144 0002      	move.b d4,2(a0)
	while(len-- > 0)
     f04:	5385           	subq.l #1,d5
     f06:	2609           	move.l a1,d3
     f08:	9681           	sub.l d1,d3
     f0a:	7c00           	moveq #0,d6
     f0c:	1c04           	move.b d4,d6
     f0e:	2406           	move.l d6,d2
     f10:	4842           	swap d2
     f12:	4242           	clr.w d2
     f14:	2042           	movea.l d2,a0
     f16:	2404           	move.l d4,d2
     f18:	e14a           	lsl.w #8,d2
     f1a:	4842           	swap d2
     f1c:	4242           	clr.w d2
     f1e:	e18e           	lsl.l #8,d6
     f20:	2646           	movea.l d6,a3
     f22:	2c08           	move.l a0,d6
     f24:	8486           	or.l d6,d2
     f26:	2c0b           	move.l a3,d6
     f28:	8486           	or.l d6,d2
     f2a:	1407           	move.b d7,d2
     f2c:	2040           	movea.l d0,a0
     f2e:	d1c1           	adda.l d1,a0
     f30:	72fc           	moveq #-4,d1
     f32:	c283           	and.l d3,d1
     f34:	d288           	add.l a0,d1
		*ptr++ = val;
     f36:	20c2           	move.l d2,(a0)+
	while(len-- > 0)
     f38:	b1c1           	cmpa.l d1,a0
     f3a:	66fa           	bne.s f36 <memset+0x86>
     f3c:	72fc           	moveq #-4,d1
     f3e:	c283           	and.l d3,d1
     f40:	d5c1           	adda.l d1,a2
     f42:	9a81           	sub.l d1,d5
     f44:	b283           	cmp.l d3,d1
     f46:	6730           	beq.s f78 <memset+0xc8>
		*ptr++ = val;
     f48:	1484           	move.b d4,(a2)
	while(len-- > 0)
     f4a:	4a85           	tst.l d5
     f4c:	672a           	beq.s f78 <memset+0xc8>
		*ptr++ = val;
     f4e:	1544 0001      	move.b d4,1(a2)
	while(len-- > 0)
     f52:	7201           	moveq #1,d1
     f54:	b285           	cmp.l d5,d1
     f56:	6720           	beq.s f78 <memset+0xc8>
		*ptr++ = val;
     f58:	1544 0002      	move.b d4,2(a2)
	while(len-- > 0)
     f5c:	7402           	moveq #2,d2
     f5e:	b485           	cmp.l d5,d2
     f60:	6716           	beq.s f78 <memset+0xc8>
		*ptr++ = val;
     f62:	1544 0003      	move.b d4,3(a2)
	while(len-- > 0)
     f66:	7c03           	moveq #3,d6
     f68:	bc85           	cmp.l d5,d6
     f6a:	670c           	beq.s f78 <memset+0xc8>
		*ptr++ = val;
     f6c:	1544 0004      	move.b d4,4(a2)
	while(len-- > 0)
     f70:	5985           	subq.l #4,d5
     f72:	6704           	beq.s f78 <memset+0xc8>
		*ptr++ = val;
     f74:	1544 0005      	move.b d4,5(a2)
}
     f78:	4cdf 0cfc      	movem.l (sp)+,d2-d7/a2-a3
     f7c:	4e75           	rts

00000f7e <memcpy>:
{
     f7e:	48e7 3e00      	movem.l d2-d6,-(sp)
     f82:	202f 0018      	move.l 24(sp),d0
     f86:	222f 001c      	move.l 28(sp),d1
     f8a:	262f 0020      	move.l 32(sp),d3
	while(len--)
     f8e:	2803           	move.l d3,d4
     f90:	5384           	subq.l #1,d4
     f92:	4a83           	tst.l d3
     f94:	675e           	beq.s ff4 <memcpy+0x76>
     f96:	2041           	movea.l d1,a0
     f98:	5288           	addq.l #1,a0
     f9a:	2400           	move.l d0,d2
     f9c:	9488           	sub.l a0,d2
     f9e:	7a02           	moveq #2,d5
     fa0:	ba82           	cmp.l d2,d5
     fa2:	55c2           	sc.s d2
     fa4:	4402           	neg.b d2
     fa6:	7c08           	moveq #8,d6
     fa8:	bc84           	cmp.l d4,d6
     faa:	55c5           	sc.s d5
     fac:	4405           	neg.b d5
     fae:	c405           	and.b d5,d2
     fb0:	6748           	beq.s ffa <memcpy+0x7c>
     fb2:	2400           	move.l d0,d2
     fb4:	8481           	or.l d1,d2
     fb6:	7a03           	moveq #3,d5
     fb8:	c485           	and.l d5,d2
     fba:	663e           	bne.s ffa <memcpy+0x7c>
     fbc:	2041           	movea.l d1,a0
     fbe:	2240           	movea.l d0,a1
     fc0:	74fc           	moveq #-4,d2
     fc2:	c483           	and.l d3,d2
     fc4:	d481           	add.l d1,d2
		*d++ = *s++;
     fc6:	22d8           	move.l (a0)+,(a1)+
	while(len--)
     fc8:	b488           	cmp.l a0,d2
     fca:	66fa           	bne.s fc6 <memcpy+0x48>
     fcc:	74fc           	moveq #-4,d2
     fce:	c483           	and.l d3,d2
     fd0:	2040           	movea.l d0,a0
     fd2:	d1c2           	adda.l d2,a0
     fd4:	d282           	add.l d2,d1
     fd6:	9882           	sub.l d2,d4
     fd8:	b483           	cmp.l d3,d2
     fda:	6718           	beq.s ff4 <memcpy+0x76>
		*d++ = *s++;
     fdc:	2241           	movea.l d1,a1
     fde:	1091           	move.b (a1),(a0)
	while(len--)
     fe0:	4a84           	tst.l d4
     fe2:	6710           	beq.s ff4 <memcpy+0x76>
		*d++ = *s++;
     fe4:	1169 0001 0001 	move.b 1(a1),1(a0)
	while(len--)
     fea:	5384           	subq.l #1,d4
     fec:	6706           	beq.s ff4 <memcpy+0x76>
		*d++ = *s++;
     fee:	1169 0002 0002 	move.b 2(a1),2(a0)
}
     ff4:	4cdf 007c      	movem.l (sp)+,d2-d6
     ff8:	4e75           	rts
     ffa:	2240           	movea.l d0,a1
     ffc:	d283           	add.l d3,d1
		*d++ = *s++;
     ffe:	12e8 ffff      	move.b -1(a0),(a1)+
	while(len--)
    1002:	b288           	cmp.l a0,d1
    1004:	67ee           	beq.s ff4 <memcpy+0x76>
    1006:	5288           	addq.l #1,a0
    1008:	60f4           	bra.s ffe <memcpy+0x80>

0000100a <memmove>:
{
    100a:	48e7 3c20      	movem.l d2-d5/a2,-(sp)
    100e:	202f 0018      	move.l 24(sp),d0
    1012:	222f 001c      	move.l 28(sp),d1
    1016:	242f 0020      	move.l 32(sp),d2
		while (len--)
    101a:	2242           	movea.l d2,a1
    101c:	5389           	subq.l #1,a1
	if (d < s) {
    101e:	b280           	cmp.l d0,d1
    1020:	636c           	bls.s 108e <memmove+0x84>
		while (len--)
    1022:	4a82           	tst.l d2
    1024:	6762           	beq.s 1088 <memmove+0x7e>
    1026:	2441           	movea.l d1,a2
    1028:	528a           	addq.l #1,a2
    102a:	2600           	move.l d0,d3
    102c:	968a           	sub.l a2,d3
    102e:	7802           	moveq #2,d4
    1030:	b883           	cmp.l d3,d4
    1032:	55c3           	sc.s d3
    1034:	4403           	neg.b d3
    1036:	7a08           	moveq #8,d5
    1038:	ba89           	cmp.l a1,d5
    103a:	55c4           	sc.s d4
    103c:	4404           	neg.b d4
    103e:	c604           	and.b d4,d3
    1040:	6770           	beq.s 10b2 <memmove+0xa8>
    1042:	2600           	move.l d0,d3
    1044:	8681           	or.l d1,d3
    1046:	7803           	moveq #3,d4
    1048:	c684           	and.l d4,d3
    104a:	6666           	bne.s 10b2 <memmove+0xa8>
    104c:	2041           	movea.l d1,a0
    104e:	2440           	movea.l d0,a2
    1050:	76fc           	moveq #-4,d3
    1052:	c682           	and.l d2,d3
    1054:	d681           	add.l d1,d3
			*d++ = *s++;
    1056:	24d8           	move.l (a0)+,(a2)+
		while (len--)
    1058:	b688           	cmp.l a0,d3
    105a:	66fa           	bne.s 1056 <memmove+0x4c>
    105c:	76fc           	moveq #-4,d3
    105e:	c682           	and.l d2,d3
    1060:	2440           	movea.l d0,a2
    1062:	d5c3           	adda.l d3,a2
    1064:	2041           	movea.l d1,a0
    1066:	d1c3           	adda.l d3,a0
    1068:	93c3           	suba.l d3,a1
    106a:	b682           	cmp.l d2,d3
    106c:	671a           	beq.s 1088 <memmove+0x7e>
			*d++ = *s++;
    106e:	1490           	move.b (a0),(a2)
		while (len--)
    1070:	b2fc 0000      	cmpa.w #0,a1
    1074:	6712           	beq.s 1088 <memmove+0x7e>
			*d++ = *s++;
    1076:	1568 0001 0001 	move.b 1(a0),1(a2)
		while (len--)
    107c:	7a01           	moveq #1,d5
    107e:	ba89           	cmp.l a1,d5
    1080:	6706           	beq.s 1088 <memmove+0x7e>
			*d++ = *s++;
    1082:	1568 0002 0002 	move.b 2(a0),2(a2)
}
    1088:	4cdf 043c      	movem.l (sp)+,d2-d5/a2
    108c:	4e75           	rts
		const char *lasts = s + (len - 1);
    108e:	41f1 1800      	lea (0,a1,d1.l),a0
		char *lastd = d + (len - 1);
    1092:	d3c0           	adda.l d0,a1
		while (len--)
    1094:	4a82           	tst.l d2
    1096:	67f0           	beq.s 1088 <memmove+0x7e>
    1098:	2208           	move.l a0,d1
    109a:	9282           	sub.l d2,d1
			*lastd-- = *lasts--;
    109c:	1290           	move.b (a0),(a1)
		while (len--)
    109e:	5388           	subq.l #1,a0
    10a0:	5389           	subq.l #1,a1
    10a2:	b288           	cmp.l a0,d1
    10a4:	67e2           	beq.s 1088 <memmove+0x7e>
			*lastd-- = *lasts--;
    10a6:	1290           	move.b (a0),(a1)
		while (len--)
    10a8:	5388           	subq.l #1,a0
    10aa:	5389           	subq.l #1,a1
    10ac:	b288           	cmp.l a0,d1
    10ae:	66ec           	bne.s 109c <memmove+0x92>
    10b0:	60d6           	bra.s 1088 <memmove+0x7e>
    10b2:	2240           	movea.l d0,a1
    10b4:	d282           	add.l d2,d1
			*d++ = *s++;
    10b6:	12ea ffff      	move.b -1(a2),(a1)+
		while (len--)
    10ba:	b28a           	cmp.l a2,d1
    10bc:	67ca           	beq.s 1088 <memmove+0x7e>
    10be:	528a           	addq.l #1,a2
    10c0:	60f4           	bra.s 10b6 <memmove+0xac>
    10c2:	4e71           	nop

000010c4 <__mulsi3>:
	.text
	FUNC(__mulsi3)
	.globl	SYM (__mulsi3)
SYM (__mulsi3):
	.cfi_startproc
	movew	sp@(4), d0	/* x0 -> d0 */
    10c4:	302f 0004      	move.w 4(sp),d0
	muluw	sp@(10), d0	/* x0*y1 */
    10c8:	c0ef 000a      	mulu.w 10(sp),d0
	movew	sp@(6), d1	/* x1 -> d1 */
    10cc:	322f 0006      	move.w 6(sp),d1
	muluw	sp@(8), d1	/* x1*y0 */
    10d0:	c2ef 0008      	mulu.w 8(sp),d1
	addw	d1, d0
    10d4:	d041           	add.w d1,d0
	swap	d0
    10d6:	4840           	swap d0
	clrw	d0
    10d8:	4240           	clr.w d0
	movew	sp@(6), d1	/* x1 -> d1 */
    10da:	322f 0006      	move.w 6(sp),d1
	muluw	sp@(10), d1	/* x1*y1 */
    10de:	c2ef 000a      	mulu.w 10(sp),d1
	addl	d1, d0
    10e2:	d081           	add.l d1,d0
	rts
    10e4:	4e75           	rts

000010e6 <__udivsi3>:
	.text
	FUNC(__udivsi3)
	.globl	SYM (__udivsi3)
SYM (__udivsi3):
	.cfi_startproc
	movel	d2, sp@-
    10e6:	2f02           	move.l d2,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	sp@(12), d1	/* d1 = divisor */
    10e8:	222f 000c      	move.l 12(sp),d1
	movel	sp@(8), d0	/* d0 = dividend */
    10ec:	202f 0008      	move.l 8(sp),d0

	cmpl	IMM (0x10000), d1 /* divisor >= 2 ^ 16 ?   */
    10f0:	0c81 0001 0000 	cmpi.l #65536,d1
	jcc	3f		/* then try next algorithm */
    10f6:	6416           	bcc.s 110e <__udivsi3+0x28>
	movel	d0, d2
    10f8:	2400           	move.l d0,d2
	clrw	d2
    10fa:	4242           	clr.w d2
	swap	d2
    10fc:	4842           	swap d2
	divu	d1, d2          /* high quotient in lower word */
    10fe:	84c1           	divu.w d1,d2
	movew	d2, d0		/* save high quotient */
    1100:	3002           	move.w d2,d0
	swap	d0
    1102:	4840           	swap d0
	movew	sp@(10), d2	/* get low dividend + high rest */
    1104:	342f 000a      	move.w 10(sp),d2
	divu	d1, d2		/* low quotient */
    1108:	84c1           	divu.w d1,d2
	movew	d2, d0
    110a:	3002           	move.w d2,d0
	jra	6f
    110c:	6030           	bra.s 113e <__udivsi3+0x58>

3:	movel	d1, d2		/* use d2 as divisor backup */
    110e:	2401           	move.l d1,d2
4:	lsrl	IMM (1), d1	/* shift divisor */
    1110:	e289           	lsr.l #1,d1
	lsrl	IMM (1), d0	/* shift dividend */
    1112:	e288           	lsr.l #1,d0
	cmpl	IMM (0x10000), d1 /* still divisor >= 2 ^ 16 ?  */
    1114:	0c81 0001 0000 	cmpi.l #65536,d1
	jcc	4b
    111a:	64f4           	bcc.s 1110 <__udivsi3+0x2a>
	divu	d1, d0		/* now we have 16-bit divisor */
    111c:	80c1           	divu.w d1,d0
	andl	IMM (0xffff), d0 /* mask out divisor, ignore remainder */
    111e:	0280 0000 ffff 	andi.l #65535,d0

/* Multiply the 16-bit tentative quotient with the 32-bit divisor.  Because of
   the operand ranges, this might give a 33-bit product.  If this product is
   greater than the dividend, the tentative quotient was too large. */
	movel	d2, d1
    1124:	2202           	move.l d2,d1
	mulu	d0, d1		/* low part, 32 bits */
    1126:	c2c0           	mulu.w d0,d1
	swap	d2
    1128:	4842           	swap d2
	mulu	d0, d2		/* high part, at most 17 bits */
    112a:	c4c0           	mulu.w d0,d2
	swap	d2		/* align high part with low part */
    112c:	4842           	swap d2
	tstw	d2		/* high part 17 bits? */
    112e:	4a42           	tst.w d2
	jne	5f		/* if 17 bits, quotient was too large */
    1130:	660a           	bne.s 113c <__udivsi3+0x56>
	addl	d2, d1		/* add parts */
    1132:	d282           	add.l d2,d1
	jcs	5f		/* if sum is 33 bits, quotient was too large */
    1134:	6506           	bcs.s 113c <__udivsi3+0x56>
	cmpl	sp@(8), d1	/* compare the sum with the dividend */
    1136:	b2af 0008      	cmp.l 8(sp),d1
	jls	6f		/* if sum > dividend, quotient was too large */
    113a:	6302           	bls.s 113e <__udivsi3+0x58>
5:	subql	IMM (1), d0	/* adjust quotient */
    113c:	5380           	subq.l #1,d0

6:	movel	sp@+, d2
    113e:	241f           	move.l (sp)+,d2
	.cfi_adjust_cfa_offset -4
	rts
    1140:	4e75           	rts

00001142 <__divsi3>:
	.text
	FUNC(__divsi3)
	.globl	SYM (__divsi3)
SYM (__divsi3):
	.cfi_startproc
	movel	d2, sp@-
    1142:	2f02           	move.l d2,-(sp)
	.cfi_adjust_cfa_offset 4

	moveq	IMM (1), d2	/* sign of result stored in d2 (=1 or =-1) */
    1144:	7401           	moveq #1,d2
	movel	sp@(12), d1	/* d1 = divisor */
    1146:	222f 000c      	move.l 12(sp),d1
	jpl	1f
    114a:	6a04           	bpl.s 1150 <__divsi3+0xe>
	negl	d1
    114c:	4481           	neg.l d1
	negb	d2		/* change sign because divisor <0  */
    114e:	4402           	neg.b d2
1:	movel	sp@(8), d0	/* d0 = dividend */
    1150:	202f 0008      	move.l 8(sp),d0
	jpl	2f
    1154:	6a04           	bpl.s 115a <__divsi3+0x18>
	negl	d0
    1156:	4480           	neg.l d0
	negb	d2
    1158:	4402           	neg.b d2

2:	movel	d1, sp@-
    115a:	2f01           	move.l d1,-(sp)
	movel	d0, sp@-
    115c:	2f00           	move.l d0,-(sp)
	PICCALL	SYM (__udivsi3)	/* divide abs(dividend) by abs(divisor) */
    115e:	6186           	bsr.s 10e6 <__udivsi3>
	addql	IMM (8), sp
    1160:	508f           	addq.l #8,sp

	tstb	d2
    1162:	4a02           	tst.b d2
	jpl	3f
    1164:	6a02           	bpl.s 1168 <__divsi3+0x26>
	negl	d0
    1166:	4480           	neg.l d0

3:	movel	sp@+, d2
    1168:	241f           	move.l (sp)+,d2
	.cfi_adjust_cfa_offset -4
	rts
    116a:	4e75           	rts

0000116c <__modsi3>:
	.text
	FUNC(__modsi3)
	.globl	SYM (__modsi3)
SYM (__modsi3):
	.cfi_startproc
	movel	sp@(8), d1	/* d1 = divisor */
    116c:	222f 0008      	move.l 8(sp),d1
	movel	sp@(4), d0	/* d0 = dividend */
    1170:	202f 0004      	move.l 4(sp),d0
	movel	d1, sp@-
    1174:	2f01           	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    1176:	2f00           	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	PICCALL	SYM (__divsi3)
    1178:	61c8           	bsr.s 1142 <__divsi3>
	addql	IMM (8), sp
    117a:	508f           	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(8), d1	/* d1 = divisor */
    117c:	222f 0008      	move.l 8(sp),d1
	movel	d1, sp@-
    1180:	2f01           	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    1182:	2f00           	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	PICCALL	SYM (__mulsi3)	/* d0 = (a/b)*b */
    1184:	6100 ff3e      	bsr.w 10c4 <__mulsi3>
	addql	IMM (8), sp
    1188:	508f           	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(4), d1	/* d1 = dividend */
    118a:	222f 0004      	move.l 4(sp),d1
	subl	d0, d1		/* d1 = a - (a/b)*b */
    118e:	9280           	sub.l d0,d1
	movel	d1, d0
    1190:	2001           	move.l d1,d0
	rts
    1192:	4e75           	rts

00001194 <__umodsi3>:
	.text
	FUNC(__umodsi3)
	.globl	SYM (__umodsi3)
SYM (__umodsi3):
	.cfi_startproc
	movel	sp@(8), d1	/* d1 = divisor */
    1194:	222f 0008      	move.l 8(sp),d1
	movel	sp@(4), d0	/* d0 = dividend */
    1198:	202f 0004      	move.l 4(sp),d0
	movel	d1, sp@-
    119c:	2f01           	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    119e:	2f00           	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	PICCALL	SYM (__udivsi3)
    11a0:	6100 ff44      	bsr.w 10e6 <__udivsi3>
	addql	IMM (8), sp
    11a4:	508f           	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(8), d1	/* d1 = divisor */
    11a6:	222f 0008      	move.l 8(sp),d1
	movel	d1, sp@-
    11aa:	2f01           	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    11ac:	2f00           	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	PICCALL	SYM (__mulsi3)	/* d0 = (a/b)*b */
    11ae:	6100 ff14      	bsr.w 10c4 <__mulsi3>
	addql	IMM (8), sp
    11b2:	508f           	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(4), d1	/* d1 = dividend */
    11b4:	222f 0004      	move.l 4(sp),d1
	subl	d0, d1		/* d1 = a - (a/b)*b */
    11b8:	9280           	sub.l d0,d1
	movel	d1, d0
    11ba:	2001           	move.l d1,d0
	rts
    11bc:	4e75           	rts

000011be <KPutCharX>:
	FUNC(KPutCharX)
	.globl	SYM (KPutCharX)

SYM(KPutCharX):
	.cfi_startproc
    move.l  a6, -(sp)
    11be:	2f0e           	move.l a6,-(sp)
	.cfi_adjust_cfa_offset 4
    move.l  4.w, a6
    11c0:	2c78 0004      	movea.l 4 <_start+0x4>,a6
    jsr     -0x204(a6)
    11c4:	4eae fdfc      	jsr -516(a6)
    movea.l (sp)+, a6
    11c8:	2c5f           	movea.l (sp)+,a6
	.cfi_adjust_cfa_offset -4
    rts
    11ca:	4e75           	rts

000011cc <PutChar>:
	FUNC(PutChar)
	.globl	SYM (PutChar)

SYM(PutChar):
	.cfi_startproc
	move.b d0, (a3)+
    11cc:	16c0           	move.b d0,(a3)+
	rts
    11ce:	4e75           	rts
