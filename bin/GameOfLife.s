
bin/GameOfLife.elf:     file format elf32-m68k


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
       4:	263c 0000 44f0 	move.l #17648,d3
       a:	0483 0000 44f0 	subi.l #17648,d3
      10:	e483           	asr.l #2,d3
	for (i = 0; i < count; i++)
      12:	6712           	beq.s 26 <_start+0x26>
      14:	45f9 0000 44f0 	lea 44f0 <SliderToString>,a2
      1a:	7400           	moveq #0,d2
		__preinit_array_start[i]();
      1c:	205a           	movea.l (a2)+,a0
      1e:	4e90           	jsr (a0)
	for (i = 0; i < count; i++)
      20:	5282           	addq.l #1,d2
      22:	b483           	cmp.l d3,d2
      24:	66f6           	bne.s 1c <_start+0x1c>

	count = __init_array_end - __init_array_start;
      26:	263c 0000 44f0 	move.l #17648,d3
      2c:	0483 0000 44f0 	subi.l #17648,d3
      32:	e483           	asr.l #2,d3
	for (i = 0; i < count; i++)
      34:	6712           	beq.s 48 <_start+0x48>
      36:	45f9 0000 44f0 	lea 44f0 <SliderToString>,a2
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
      4e:	243c 0000 44f0 	move.l #17648,d2
      54:	0482 0000 44f0 	subi.l #17648,d2
      5a:	e482           	asr.l #2,d2
	for (i = count; i > 0; i--)
      5c:	6710           	beq.s 6e <_start+0x6e>
      5e:	45f9 0000 44f0 	lea 44f0 <SliderToString>,a2
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

int main()
{
      74:	4fef ff40      	lea -192(sp),sp
      78:	48e7 3f3e      	movem.l d2-d7/a2-a6,-(sp)
	GameMatrix.ColorAlive = 4;
	GameMatrix.ColorDead = 0;
	GameMatrix.Columns = 100;
	GameMatrix.Rows = 40;
      7c:	23fc 0028 0064 	move.l #2621540,47fc <GameMatrix+0x8>
      82:	0000 47fc 
      86:	23fc 0004 0000 	move.l #262144,4800 <GameMatrix+0xc>
      8c:	0000 4800 
      90:	23fc 0005 0005 	move.l #327685,4804 <GameMatrix+0x10>
      96:	0000 4804 
	return RETURN_OK;
}

int StartApp(RenderData *rd)
{
	SysBase = *((struct ExecBase **)4UL);
      9a:	2c78 0004      	movea.l 4 <_start+0x4>,a6
      9e:	23ce 0000 475e 	move.l a6,475e <SysBase>
	custom = (struct Custom *)0xdff000;
	unsigned int pens[] = {~0};
      a4:	70ff           	moveq #-1,d0
      a6:	2f40 0044      	move.l d0,68(sp)
	APTR *my_VisualInfo;

	if ((DOSBase = (struct DosLibrary *)OpenLibrary((CONST_STRPTR) "dos.library", 0)))
      aa:	43f9 0000 23a2 	lea 23a2 <PutChar+0x6e>,a1
      b0:	7000           	moveq #0,d0
      b2:	4eae fdd8      	jsr -552(a6)
      b6:	23c0 0000 475a 	move.l d0,475a <DOSBase>
      bc:	6700 05e2      	beq.w 6a0 <main+0x62c>
	{
		if ((GfxBase = (struct GfxBase *)OpenLibrary((CONST_STRPTR) "graphics.library", 0)))
      c0:	2c79 0000 475e 	movea.l 475e <SysBase>,a6
      c6:	43f9 0000 23ae 	lea 23ae <PutChar+0x7a>,a1
      cc:	7000           	moveq #0,d0
      ce:	4eae fdd8      	jsr -552(a6)
      d2:	23c0 0000 4772 	move.l d0,4772 <GfxBase>
      d8:	6700 05c6      	beq.w 6a0 <main+0x62c>
		{
			if ((IntuitionBase = (struct IntuitionBase *)OpenLibrary((CONST_STRPTR) "intuition.library", 0)))
      dc:	2c79 0000 475e 	movea.l 475e <SysBase>,a6
      e2:	43f9 0000 23bf 	lea 23bf <PutChar+0x8b>,a1
      e8:	7000           	moveq #0,d0
      ea:	4eae fdd8      	jsr -552(a6)
      ee:	2c40           	movea.l d0,a6
      f0:	23c0 0000 4766 	move.l d0,4766 <IntuitionBase>
      f6:	6700 05a8      	beq.w 6a0 <main+0x62c>
			{
				if ((GOLRenderData.Screen = (struct Screen *)OpenScreenTags(NULL,
      fa:	2f7c 8000 003a 	move.l #-2147483590,72(sp)
     100:	0048 
     102:	7044           	moveq #68,d0
     104:	d08f           	add.l sp,d0
     106:	2f40 004c      	move.l d0,76(sp)
     10a:	2f7c 8000 0032 	move.l #-2147483598,80(sp)
     110:	0050 
     112:	2f7c 0000 8000 	move.l #32768,84(sp)
     118:	0054 
     11a:	2f7c 8000 0025 	move.l #-2147483611,88(sp)
     120:	0058 
     122:	7204           	moveq #4,d1
     124:	2f41 005c      	move.l d1,92(sp)
     128:	2f7c 8000 003b 	move.l #-2147483589,96(sp)
     12e:	0060 
     130:	7001           	moveq #1,d0
     132:	2f40 0064      	move.l d0,100(sp)
     136:	2f7c 8000 0028 	move.l #-2147483608,104(sp)
     13c:	0068 
     13e:	2f7c 0000 23d1 	move.l #9169,108(sp)
     144:	006c 
     146:	2f7c 8000 002d 	move.l #-2147483603,112(sp)
     14c:	0070 
     14e:	720f           	moveq #15,d1
     150:	2f41 0074      	move.l d1,116(sp)
     154:	2f7c 8000 0026 	move.l #-2147483610,120(sp)
     15a:	0078 
     15c:	2f40 007c      	move.l d0,124(sp)
     160:	2f7c 8000 0027 	move.l #-2147483609,128(sp)
     166:	0080 
     168:	42af 0084      	clr.l 132(sp)
     16c:	42af 0088      	clr.l 136(sp)
     170:	91c8           	suba.l a0,a0
     172:	43ef 0048      	lea 72(sp),a1
     176:	4eae fd9c      	jsr -612(a6)
     17a:	41f9 0000 4776 	lea 4776 <GOLRenderData>,a0
     180:	2080           	move.l d0,(a0)
     182:	6700 051c      	beq.w 6a0 <main+0x62c>
																			SA_Type, CUSTOMSCREEN,
																			SA_DetailPen, 1,
																			SA_BlockPen, 0,
																			TAG_END)))
				{
					if ((GadToolsBase = (struct Library *)OpenLibrary((CONST_STRPTR) "gadtools.library", 0)))
     186:	2c79 0000 475e 	movea.l 475e <SysBase>,a6
     18c:	43f9 0000 23e9 	lea 23e9 <PutChar+0xb5>,a1
     192:	7000           	moveq #0,d0
     194:	4eae fdd8      	jsr -552(a6)
     198:	23c0 0000 4762 	move.l d0,4762 <GadToolsBase>
     19e:	6700 0500      	beq.w 6a0 <main+0x62c>
					{
						if ((GOLRenderData.MainWindow = (struct Window *)OpenWindowTags(NULL,
     1a2:	2f7c 8000 0070 	move.l #-2147483536,72(sp)
     1a8:	0048 
     1aa:	43f9 0000 4776 	lea 4776 <GOLRenderData>,a1
     1b0:	2051           	movea.l (a1),a0
     1b2:	2f48 004c      	move.l a0,76(sp)
     1b6:	2f7c 8000 0064 	move.l #-2147483548,80(sp)
     1bc:	0050 
     1be:	42af 0054      	clr.l 84(sp)
     1c2:	2f7c 8000 0065 	move.l #-2147483547,88(sp)
     1c8:	0058 
     1ca:	1028 001e      	move.b 30(a0),d0
     1ce:	4880           	ext.w d0
     1d0:	48c0           	ext.l d0
     1d2:	5280           	addq.l #1,d0
     1d4:	2f40 005c      	move.l d0,92(sp)
     1d8:	2f7c 8000 0066 	move.l #-2147483546,96(sp)
     1de:	0060 
     1e0:	1028 0024      	move.b 36(a0),d0
     1e4:	4880           	ext.w d0
     1e6:	3640           	movea.w d0,a3
     1e8:	1028 0025      	move.b 37(a0),d0
     1ec:	4880           	ext.w d0
     1ee:	3440           	movea.w d0,a2
     1f0:	3039 0000 4804 	move.w 4804 <GameMatrix+0x10>,d0
     1f6:	c0f9 0000 47fe 	mulu.w 47fe <GameMatrix+0xa>,d0
     1fc:	d08b           	add.l a3,d0
     1fe:	d08a           	add.l a2,d0
     200:	2f40 0064      	move.l d0,100(sp)
     204:	2f7c 8000 0067 	move.l #-2147483545,104(sp)
     20a:	0068 
     20c:	1028 0026      	move.b 38(a0),d0
     210:	4880           	ext.w d0
     212:	3240           	movea.w d0,a1
     214:	1028 0023      	move.b 35(a0),d0
     218:	4880           	ext.w d0
     21a:	3040           	movea.w d0,a0
     21c:	3039 0000 4806 	move.w 4806 <GameMatrix+0x12>,d0
     222:	c0f9 0000 47fc 	mulu.w 47fc <GameMatrix+0x8>,d0
     228:	d089           	add.l a1,d0
     22a:	d088           	add.l a0,d0
     22c:	2f40 006c      	move.l d0,108(sp)
     230:	2f7c 8000 0074 	move.l #-2147483532,112(sp)
     236:	0070 
     238:	203c 0000 0280 	move.l #640,d0
     23e:	908b           	sub.l a3,d0
     240:	908a           	sub.l a2,d0
     242:	2f40 0074      	move.l d0,116(sp)
     246:	2f7c 8000 0075 	move.l #-2147483531,120(sp)
     24c:	0078 
     24e:	203c 0000 0100 	move.l #256,d0
     254:	9088           	sub.l a0,d0
     256:	9089           	sub.l a1,d0
     258:	2f40 007c      	move.l d0,124(sp)
     25c:	2f7c 8000 006e 	move.l #-2147483538,128(sp)
     262:	0080 
     264:	2f7c 0000 23fa 	move.l #9210,132(sp)
     26a:	0084 
     26c:	2f7c 8000 0083 	move.l #-2147483517,136(sp)
     272:	0088 
     274:	7001           	moveq #1,d0
     276:	2f40 008c      	move.l d0,140(sp)
     27a:	2f7c 8000 0084 	move.l #-2147483516,144(sp)
     280:	0090 
     282:	2f40 0094      	move.l d0,148(sp)
     286:	2f7c 8000 0081 	move.l #-2147483519,152(sp)
     28c:	0098 
     28e:	2f40 009c      	move.l d0,156(sp)
     292:	2f7c 8000 0082 	move.l #-2147483518,160(sp)
     298:	00a0 
     29a:	2f40 00a4      	move.l d0,164(sp)
     29e:	2f7c 8000 0091 	move.l #-2147483503,168(sp)
     2a4:	00a8 
     2a6:	2f40 00ac      	move.l d0,172(sp)
     2aa:	2f7c 8000 0086 	move.l #-2147483514,176(sp)
     2b0:	00b0 
     2b2:	2f40 00b4      	move.l d0,180(sp)
     2b6:	2f7c 8000 0093 	move.l #-2147483501,184(sp)
     2bc:	00b8 
     2be:	2f40 00bc      	move.l d0,188(sp)
     2c2:	2f7c 8000 0089 	move.l #-2147483511,192(sp)
     2c8:	00c0 
     2ca:	2f40 00c4      	move.l d0,196(sp)
     2ce:	2f7c 8000 006f 	move.l #-2147483537,200(sp)
     2d4:	00c8 
     2d6:	2f7c 0000 2402 	move.l #9218,204(sp)
     2dc:	00cc 
     2de:	2f7c 8000 006a 	move.l #-2147483542,208(sp)
     2e4:	00d0 
     2e6:	2f7c 0000 031e 	move.l #798,212(sp)
     2ec:	00d4 
     2ee:	2f7c 8000 0068 	move.l #-2147483544,216(sp)
     2f4:	00d8 
     2f6:	7204           	moveq #4,d1
     2f8:	2f41 00dc      	move.l d1,220(sp)
     2fc:	2f7c 8000 0069 	move.l #-2147483543,224(sp)
     302:	00e0 
     304:	7008           	moveq #8,d0
     306:	2f40 00e4      	move.l d0,228(sp)
     30a:	42af 00e8      	clr.l 232(sp)
     30e:	2c79 0000 4766 	movea.l 4766 <IntuitionBase>,a6
     314:	91c8           	suba.l a0,a0
     316:	43ef 0048      	lea 72(sp),a1
     31a:	4eae fda2      	jsr -606(a6)
     31e:	2040           	movea.l d0,a0
     320:	23c0 0000 477a 	move.l d0,477a <GOLRenderData+0x4>
     326:	6700 0378      	beq.w 6a0 <main+0x62c>

void ComputeOutputSize(RenderData *rd)
{
	/* our output size is simply the window's size minus its borders */
	rd->OutputSize.x =
		rd->MainWindow->Width - rd->MainWindow->BorderLeft - rd->MainWindow->BorderRight;
     32a:	1028 0036      	move.b 54(a0),d0
     32e:	4880           	ext.w d0
     330:	1228 0038      	move.b 56(a0),d1
     334:	4881           	ext.w d1
     336:	d041           	add.w d1,d0
     338:	3228 0008      	move.w 8(a0),d1
     33c:	9240           	sub.w d0,d1
     33e:	33c1 0000 4782 	move.w d1,4782 <GOLRenderData+0xc>
	rd->OutputSize.y =
		rd->MainWindow->Height - rd->MainWindow->BorderTop - rd->MainWindow->BorderBottom;
     344:	1028 0037      	move.b 55(a0),d0
     348:	4880           	ext.w d0
     34a:	1228 0039      	move.b 57(a0),d1
     34e:	4881           	ext.w d1
     350:	d041           	add.w d1,d0
     352:	3268 000a      	movea.w 10(a0),a1
     356:	92c0           	suba.w d0,a1
     358:	33c9 0000 4784 	move.w a1,4784 <GOLRenderData+0xe>
							my_VisualInfo = GetVisualInfo(GOLRenderData.MainWindow->WScreen, TAG_END);
     35e:	42af 0048      	clr.l 72(sp)
     362:	2c79 0000 4762 	movea.l 4762 <GadToolsBase>,a6
     368:	2068 002e      	movea.l 46(a0),a0
     36c:	43ef 0048      	lea 72(sp),a1
     370:	4eae ff82      	jsr -126(a6)
     374:	2400           	move.l d0,d2
							MainMenuStrip = CreateMenus(GolMainMenu, TAG_END);
     376:	42af 0048      	clr.l 72(sp)
     37a:	2c79 0000 4762 	movea.l 4762 <GadToolsBase>,a6
     380:	41f9 0000 4510 	lea 4510 <GolMainMenu>,a0
     386:	43ef 0048      	lea 72(sp),a1
     38a:	4eae ffd0      	jsr -48(a6)
     38e:	2040           	movea.l d0,a0
     390:	23c0 0000 476e 	move.l d0,476e <MainMenuStrip>
							LayoutMenus(MainMenuStrip, my_VisualInfo, TAG_END);
     396:	42af 0048      	clr.l 72(sp)
     39a:	2c79 0000 4762 	movea.l 4762 <GadToolsBase>,a6
     3a0:	2242           	movea.l d2,a1
     3a2:	45ef 0048      	lea 72(sp),a2
     3a6:	4eae ffbe      	jsr -66(a6)
							SetMenuStrip(GOLRenderData.MainWindow, MainMenuStrip);
     3aa:	2c79 0000 4766 	movea.l 4766 <IntuitionBase>,a6
     3b0:	2079 0000 477a 	movea.l 477a <GOLRenderData+0x4>,a0
     3b6:	2279 0000 476e 	movea.l 476e <MainMenuStrip>,a1
     3bc:	4eae fef8      	jsr -264(a6)
	if (AllocPlayfieldMem() != RETURN_OK)
     3c0:	4eb9 0000 0f98 	jsr f98 <AllocPlayfieldMem>
     3c6:	4a80           	tst.l d0
     3c8:	6600 0b8e      	bne.w f58 <main+0xee4>
	if (PrepareBackbuffer(&GOLRenderData) != RETURN_OK)
     3cc:	4eb9 0000 1b8e 	jsr 1b8e <PrepareBackbuffer.constprop.0>
     3d2:	2f40 0040      	move.l d0,64(sp)
     3d6:	6600 0b80      	bne.w f58 <main+0xee4>
	SetRast(GOLRenderData.MainWindow->RPort, 0);
     3da:	2c79 0000 4772 	movea.l 4772 <GfxBase>,a6
     3e0:	2079 0000 477a 	movea.l 477a <GOLRenderData+0x4>,a0
     3e6:	2268 0032      	movea.l 50(a0),a1
     3ea:	4eae ff16      	jsr -234(a6)
	SetRast(&GOLRenderData.Rastport, 0);
     3ee:	2c79 0000 4772 	movea.l 4772 <GfxBase>,a6
     3f4:	43f9 0000 478a 	lea 478a <GOLRenderData+0x14>,a1
     3fa:	7000           	moveq #0,d0
     3fc:	4eae ff16      	jsr -234(a6)
	while (AppRunning)
     400:	4a79 0000 4718 	tst.w 4718 <AppRunning>
     406:	6700 01d6      	beq.w 5de <main+0x56a>
					ClearPlayfield(GameMatrix.Playfield);
     40a:	2e3c 0000 47f4 	move.l #18420,d7
		EventLoop(GOLRenderData.MainWindow, MainMenuStrip);
     410:	2f79 0000 476e 	move.l 476e <MainMenuStrip>,60(sp)
     416:	003c 
     418:	2f79 0000 477a 	move.l 477a <GOLRenderData+0x4>,48(sp)
     41e:	0030 
	if (!GameRunning)
     420:	4a79 0000 476c 	tst.w 476c <GameRunning>
     426:	6606           	bne.s 42e <main+0x3ba>
		UpdateCnt = 0;
     428:	4279 0000 476a 	clr.w 476a <UpdateCnt>
	while ((message = (struct IntuiMessage *)GetMsg(theWindow->UserPort)) && (AppRunning))
     42e:	2c79 0000 475e 	movea.l 475e <SysBase>,a6
     434:	266f 0030      	movea.l 48(sp),a3
     438:	206b 0056      	movea.l 86(a3),a0
     43c:	4eae fe8c      	jsr -372(a6)
     440:	2440           	movea.l d0,a2
     442:	4a80           	tst.l d0
     444:	6700 00c6      	beq.w 50c <main+0x498>
     448:	4a79 0000 4718 	tst.w 4718 <AppRunning>
     44e:	6700 00bc      	beq.w 50c <main+0x498>
		msg_class = message->Class;
     452:	242a 0014      	move.l 20(a2),d2
		msg_code = message->Code;
     456:	382a 0018      	move.w 24(a2),d4
		coordX = message->MouseX - theWindow->BorderLeft;
     45a:	266f 0030      	movea.l 48(sp),a3
     45e:	102b 0036      	move.b 54(a3),d0
     462:	4880           	ext.w d0
     464:	362a 0020      	move.w 32(a2),d3
     468:	9640           	sub.w d0,d3
		coordY = message->MouseY - theWindow->BorderTop;
     46a:	102b 0037      	move.b 55(a3),d0
     46e:	4880           	ext.w d0
     470:	3a2a 0022      	move.w 34(a2),d5
     474:	9a40           	sub.w d0,d5
		ReplyMsg((struct Message *)message);
     476:	2c79 0000 475e 	movea.l 475e <SysBase>,a6
     47c:	224a           	movea.l a2,a1
     47e:	4eae fe86      	jsr -378(a6)
		switch (msg_class)
     482:	7010           	moveq #16,d0
     484:	b082           	cmp.l d2,d0
     486:	6700 028e      	beq.w 716 <main+0x6a2>
     48a:	6500 026c      	bcs.w 6f8 <main+0x684>
     48e:	7204           	moveq #4,d1
     490:	b282           	cmp.l d2,d1
     492:	6700 02ec      	beq.w 780 <main+0x70c>
     496:	7008           	moveq #8,d0
     498:	b082           	cmp.l d2,d0
     49a:	6600 0218      	bne.w 6b4 <main+0x640>
			y = (coordY / GameMatrix.CellSizeV) + 1;
     49e:	3445           	movea.w d5,a2
			x = (coordX / GameMatrix.CellSizeH) + 1;
     4a0:	3843           	movea.w d3,a4
			y = (coordY / GameMatrix.CellSizeV) + 1;
     4a2:	7000           	moveq #0,d0
     4a4:	3039 0000 4806 	move.w 4806 <GameMatrix+0x12>,d0
     4aa:	47f9 0000 22aa 	lea 22aa <__divsi3>,a3
     4b0:	2f00           	move.l d0,-(sp)
     4b2:	2f0a           	move.l a2,-(sp)
     4b4:	4e93           	jsr (a3)
     4b6:	508f           	addq.l #8,sp
     4b8:	2a00           	move.l d0,d5
     4ba:	5285           	addq.l #1,d5
			x = (coordX / GameMatrix.CellSizeH) + 1;
     4bc:	7000           	moveq #0,d0
     4be:	3039 0000 4804 	move.w 4804 <GameMatrix+0x10>,d0
     4c4:	2f00           	move.l d0,-(sp)
     4c6:	2f0c           	move.l a4,-(sp)
     4c8:	4e93           	jsr (a3)
     4ca:	508f           	addq.l #8,sp
     4cc:	2400           	move.l d0,d2
     4ce:	5282           	addq.l #1,d2
     4d0:	0c44 0068      	cmpi.w #104,d4
     4d4:	6700 06a8      	beq.w b7e <main+0xb0a>
     4d8:	0c44 00e8      	cmpi.w #232,d4
     4dc:	6600 026a      	bne.w 748 <main+0x6d4>
				DrawActive = FALSE;
     4e0:	4279 0000 4754 	clr.w 4754 <DrawActive>
			OldSelectX = x;
     4e6:	23c2 0000 4750 	move.l d2,4750 <OldSelectX>
			OldSelectY = y;
     4ec:	23c5 0000 474c 	move.l d5,474c <OldSelectY>
	while ((message = (struct IntuiMessage *)GetMsg(theWindow->UserPort)) && (AppRunning))
     4f2:	2c79 0000 475e 	movea.l 475e <SysBase>,a6
     4f8:	266f 0030      	movea.l 48(sp),a3
     4fc:	206b 0056      	movea.l 86(a3),a0
     500:	4eae fe8c      	jsr -372(a6)
     504:	2440           	movea.l d0,a2
     506:	4a80           	tst.l d0
     508:	6600 ff3e      	bne.w 448 <main+0x3d4>
		if (GOLRenderData.PPG_Window)
     50c:	2679 0000 477e 	movea.l 477e <GOLRenderData+0x8>,a3
     512:	b6fc 0000      	cmpa.w #0,a3
     516:	6766           	beq.s 57e <main+0x50a>
	while ((message = (struct IntuiMessage *)GetMsg(theWindow->UserPort)) && GOLRenderData.PPG_WinOpen)
     518:	2c79 0000 475e 	movea.l 475e <SysBase>,a6
     51e:	206b 0056      	movea.l 86(a3),a0
     522:	4eae fe8c      	jsr -372(a6)
     526:	2440           	movea.l d0,a2
     528:	4a80           	tst.l d0
     52a:	6752           	beq.s 57e <main+0x50a>
     52c:	4a79 0000 47f2 	tst.w 47f2 <GOLRenderData+0x7c>
     532:	674a           	beq.s 57e <main+0x50a>
		msg_class = message->Class;
     534:	242a 0014      	move.l 20(a2),d2
		ReplyMsg((struct Message *)message);
     538:	2c79 0000 475e 	movea.l 475e <SysBase>,a6
     53e:	224a           	movea.l a2,a1
     540:	4eae fe86      	jsr -378(a6)
		switch (msg_class)
     544:	0c82 0000 0100 	cmpi.l #256,d2
     54a:	6700 07c6      	beq.w d12 <main+0xc9e>
     54e:	0c82 0000 0200 	cmpi.l #512,d2
     554:	66c2           	bne.s 518 <main+0x4a4>
			CloseWindow(theWindow);
     556:	2c79 0000 4766 	movea.l 4766 <IntuitionBase>,a6
     55c:	204b           	movea.l a3,a0
     55e:	4eae ffb8      	jsr -72(a6)
			GOLRenderData.PPG_WinOpen = FALSE;
     562:	4279 0000 47f2 	clr.w 47f2 <GOLRenderData+0x7c>
			theWindow = 0;
     568:	97cb           	suba.l a3,a3
	while ((message = (struct IntuiMessage *)GetMsg(theWindow->UserPort)) && GOLRenderData.PPG_WinOpen)
     56a:	2c79 0000 475e 	movea.l 475e <SysBase>,a6
     570:	206b 0056      	movea.l 86(a3),a0
     574:	4eae fe8c      	jsr -372(a6)
     578:	2440           	movea.l d0,a2
     57a:	4a80           	tst.l d0
     57c:	66ae           	bne.s 52c <main+0x4b8>
		if (GameRunning)
     57e:	4a79 0000 476c 	tst.w 476c <GameRunning>
     584:	6600 084c      	bne.w dd2 <main+0xd5e>
		if (UpdateCnt > 0)
     588:	3639 0000 476a 	move.w 476a <UpdateCnt>,d3
     58e:	4a43           	tst.w d3
     590:	6600 064c      	bne.w bde <main+0xb6a>
		WaitTOF();
     594:	2c79 0000 4772 	movea.l 4772 <GfxBase>,a6
     59a:	4eae fef2      	jsr -270(a6)
}

void RepaintWindow(RenderData *rd)
{
	/* on repaint we simply blit our backbuffer into our window's RastPort */
	BltBitMapRastPort(rd->Backbuffer,
     59e:	2c79 0000 4772 	movea.l 4772 <GfxBase>,a6
     5a4:	2079 0000 47ee 	movea.l 47ee <GOLRenderData+0x78>,a0
     5aa:	7000           	moveq #0,d0
     5ac:	7200           	moveq #0,d1
     5ae:	2279 0000 477a 	movea.l 477a <GOLRenderData+0x4>,a1
     5b4:	2269 0032      	movea.l 50(a1),a1
     5b8:	7400           	moveq #0,d2
     5ba:	7600           	moveq #0,d3
     5bc:	3839 0000 4782 	move.w 4782 <GOLRenderData+0xc>,d4
     5c2:	48c4           	ext.l d4
     5c4:	3a39 0000 4784 	move.w 4784 <GOLRenderData+0xe>,d5
     5ca:	48c5           	ext.l d5
     5cc:	7c3f           	moveq #63,d6
     5ce:	4606           	not.b d6
     5d0:	4eae fda2      	jsr -606(a6)
	while (AppRunning)
     5d4:	4a79 0000 4718 	tst.w 4718 <AppRunning>
     5da:	6600 fe34      	bne.w 410 <main+0x39c>
	FreePlayfieldMem();
     5de:	4eb9 0000 1efe 	jsr 1efe <FreePlayfieldMem.isra.0>
	FreeBitMap(GOLRenderData.Backbuffer);
     5e4:	2c79 0000 4772 	movea.l 4772 <GfxBase>,a6
     5ea:	2079 0000 47ee 	movea.l 47ee <GOLRenderData+0x78>,a0
     5f0:	4eae fc64      	jsr -924(a6)
	if (GOLRenderData.PPG_Window)
     5f4:	2079 0000 477e 	movea.l 477e <GOLRenderData+0x8>,a0
     5fa:	b0fc 0000      	cmpa.w #0,a0
     5fe:	670a           	beq.s 60a <main+0x596>
		CloseWindow(GOLRenderData.PPG_Window);
     600:	2c79 0000 4766 	movea.l 4766 <IntuitionBase>,a6
     606:	4eae ffb8      	jsr -72(a6)
	if (GOLRenderData.MainWindow)
     60a:	2079 0000 477a 	movea.l 477a <GOLRenderData+0x4>,a0
     610:	b0fc 0000      	cmpa.w #0,a0
     614:	670a           	beq.s 620 <main+0x5ac>
		CloseWindow(GOLRenderData.MainWindow);
     616:	2c79 0000 4766 	movea.l 4766 <IntuitionBase>,a6
     61c:	4eae ffb8      	jsr -72(a6)
	if (GadToolsBase)
     620:	2279 0000 4762 	movea.l 4762 <GadToolsBase>,a1
     626:	b2fc 0000      	cmpa.w #0,a1
     62a:	670a           	beq.s 636 <main+0x5c2>
		CloseLibrary((struct Library *)GadToolsBase);
     62c:	2c79 0000 475e 	movea.l 475e <SysBase>,a6
     632:	4eae fe62      	jsr -414(a6)
	if (GOLRenderData.Screen)
     636:	43f9 0000 4776 	lea 4776 <GOLRenderData>,a1
     63c:	2051           	movea.l (a1),a0
     63e:	b0fc 0000      	cmpa.w #0,a0
     642:	670a           	beq.s 64e <main+0x5da>
		CloseScreen(GOLRenderData.Screen);
     644:	2c79 0000 4766 	movea.l 4766 <IntuitionBase>,a6
     64a:	4eae ffbe      	jsr -66(a6)
	if (GfxBase)
     64e:	2279 0000 4772 	movea.l 4772 <GfxBase>,a1
     654:	b2fc 0000      	cmpa.w #0,a1
     658:	670a           	beq.s 664 <main+0x5f0>
		CloseLibrary((struct Library *)GfxBase);
     65a:	2c79 0000 475e 	movea.l 475e <SysBase>,a6
     660:	4eae fe62      	jsr -414(a6)
	if (IntuitionBase)
     664:	2279 0000 4766 	movea.l 4766 <IntuitionBase>,a1
     66a:	b2fc 0000      	cmpa.w #0,a1
     66e:	670a           	beq.s 67a <main+0x606>
		CloseLibrary((struct Library *)IntuitionBase);
     670:	2c79 0000 475e 	movea.l 475e <SysBase>,a6
     676:	4eae fe62      	jsr -414(a6)
	if (DOSBase)
     67a:	2279 0000 475a 	movea.l 475a <DOSBase>,a1
     680:	b2fc 0000      	cmpa.w #0,a1
     684:	6700 08d2      	beq.w f58 <main+0xee4>
		CloseLibrary((struct Library *)DOSBase);
     688:	2c79 0000 475e 	movea.l 475e <SysBase>,a6
     68e:	4eae fe62      	jsr -414(a6)
}
     692:	202f 0040      	move.l 64(sp),d0
     696:	4cdf 7cfc      	movem.l (sp)+,d2-d7/a2-a6
     69a:	4fef 00c0      	lea 192(sp),sp
     69e:	4e75           	rts
		return RETURN_FAIL;
     6a0:	7214           	moveq #20,d1
     6a2:	2f41 0040      	move.l d1,64(sp)
}
     6a6:	202f 0040      	move.l 64(sp),d0
     6aa:	4cdf 7cfc      	movem.l (sp)+,d2-d7/a2-a6
     6ae:	4fef 00c0      	lea 192(sp),sp
     6b2:	4e75           	rts
		switch (msg_class)
     6b4:	5582           	subq.l #2,d2
     6b6:	6600 fd76      	bne.w 42e <main+0x3ba>
		rd->MainWindow->Width - rd->MainWindow->BorderLeft - rd->MainWindow->BorderRight;
     6ba:	2079 0000 477a 	movea.l 477a <GOLRenderData+0x4>,a0
     6c0:	1028 0036      	move.b 54(a0),d0
     6c4:	4880           	ext.w d0
     6c6:	1228 0038      	move.b 56(a0),d1
     6ca:	4881           	ext.w d1
     6cc:	d041           	add.w d1,d0
     6ce:	3268 0008      	movea.w 8(a0),a1
     6d2:	92c0           	suba.w d0,a1
     6d4:	33c9 0000 4782 	move.w a1,4782 <GOLRenderData+0xc>
		rd->MainWindow->Height - rd->MainWindow->BorderTop - rd->MainWindow->BorderBottom;
     6da:	1028 0037      	move.b 55(a0),d0
     6de:	4880           	ext.w d0
     6e0:	1228 0039      	move.b 57(a0),d1
     6e4:	4881           	ext.w d1
     6e6:	d041           	add.w d1,d0
     6e8:	3068 000a      	movea.w 10(a0),a0
     6ec:	90c0           	suba.w d0,a0
     6ee:	33c8 0000 4784 	move.w a0,4784 <GOLRenderData+0xe>
     6f4:	6000 fd38      	bra.w 42e <main+0x3ba>
		switch (msg_class)
     6f8:	0c82 0000 0100 	cmpi.l #256,d2
     6fe:	6700 02ac      	beq.w 9ac <main+0x938>
     702:	0c82 0000 0200 	cmpi.l #512,d2
     708:	6600 fd24      	bne.w 42e <main+0x3ba>
			AppRunning = FALSE;
     70c:	4279 0000 4718 	clr.w 4718 <AppRunning>
			break;
     712:	6000 fd1a      	bra.w 42e <main+0x3ba>
			y = (coordY / GameMatrix.CellSizeV) + 1;
     716:	3445           	movea.w d5,a2
			x = (coordX / GameMatrix.CellSizeH) + 1;
     718:	3843           	movea.w d3,a4
			y = (coordY / GameMatrix.CellSizeV) + 1;
     71a:	7000           	moveq #0,d0
     71c:	3039 0000 4806 	move.w 4806 <GameMatrix+0x12>,d0
     722:	47f9 0000 22aa 	lea 22aa <__divsi3>,a3
     728:	2f00           	move.l d0,-(sp)
     72a:	2f0a           	move.l a2,-(sp)
     72c:	4e93           	jsr (a3)
     72e:	508f           	addq.l #8,sp
     730:	2a00           	move.l d0,d5
     732:	5285           	addq.l #1,d5
			x = (coordX / GameMatrix.CellSizeH) + 1;
     734:	7000           	moveq #0,d0
     736:	3039 0000 4804 	move.w 4804 <GameMatrix+0x10>,d0
     73c:	2f00           	move.l d0,-(sp)
     73e:	2f0c           	move.l a4,-(sp)
     740:	4e93           	jsr (a3)
     742:	508f           	addq.l #8,sp
     744:	2400           	move.l d0,d2
     746:	5282           	addq.l #1,d2
			if (DrawActive && (x != OldSelectX || y != OldSelectY))
     748:	4a79 0000 4754 	tst.w 4754 <DrawActive>
     74e:	6700 fd96      	beq.w 4e6 <main+0x472>
     752:	b4b9 0000 4750 	cmp.l 4750 <OldSelectX>,d2
     758:	660a           	bne.s 764 <main+0x6f0>
     75a:	bab9 0000 474c 	cmp.l 474c <OldSelectY>,d5
     760:	6700 fd84      	beq.w 4e6 <main+0x472>
				ToggleCellStatus(coordX, coordY);
     764:	2f0a           	move.l a2,-(sp)
     766:	2f0c           	move.l a4,-(sp)
     768:	4eb9 0000 10b6 	jsr 10b6 <ToggleCellStatus>
     76e:	508f           	addq.l #8,sp
			OldSelectX = x;
     770:	23c2 0000 4750 	move.l d2,4750 <OldSelectX>
			OldSelectY = y;
     776:	23c5 0000 474c 	move.l d5,474c <OldSelectY>
			break;
     77c:	6000 fd74      	bra.w 4f2 <main+0x47e>
			SetWindowTitles(GOLRenderData.MainWindow, (STRPTR) "Reconfiguring Memory...", (STRPTR)-1);
     780:	2c79 0000 4766 	movea.l 4766 <IntuitionBase>,a6
     786:	2079 0000 477a 	movea.l 477a <GOLRenderData+0x4>,a0
     78c:	43f9 0000 241b 	lea 241b <PutChar+0xe7>,a1
     792:	347c ffff      	movea.w #-1,a2
     796:	4eae feec      	jsr -276(a6)
			PrepareBackbuffer(&GOLRenderData);
     79a:	4eb9 0000 1b8e 	jsr 1b8e <PrepareBackbuffer.constprop.0>
			FreePlayfieldMem();
     7a0:	4eb9 0000 1efe 	jsr 1efe <FreePlayfieldMem.isra.0>
			GameMatrix.Columns = GOLRenderData.OutputSize.x / GameMatrix.CellSizeH + 2;
     7a6:	7000           	moveq #0,d0
     7a8:	3039 0000 4804 	move.w 4804 <GameMatrix+0x10>,d0
     7ae:	45f9 0000 22aa 	lea 22aa <__divsi3>,a2
     7b4:	2f00           	move.l d0,-(sp)
     7b6:	3679 0000 4782 	movea.w 4782 <GOLRenderData+0xc>,a3
     7bc:	2f0b           	move.l a3,-(sp)
     7be:	4e92           	jsr (a2)
     7c0:	508f           	addq.l #8,sp
     7c2:	5440           	addq.w #2,d0
     7c4:	33c0 0000 47fe 	move.w d0,47fe <GameMatrix+0xa>
			GameMatrix.Rows = GOLRenderData.OutputSize.y / GameMatrix.CellSizeV + 2;
     7ca:	7000           	moveq #0,d0
     7cc:	3039 0000 4806 	move.w 4806 <GameMatrix+0x12>,d0
     7d2:	2f00           	move.l d0,-(sp)
     7d4:	3079 0000 4784 	movea.w 4784 <GOLRenderData+0xe>,a0
     7da:	2f08           	move.l a0,-(sp)
     7dc:	4e92           	jsr (a2)
     7de:	508f           	addq.l #8,sp
     7e0:	5440           	addq.w #2,d0
     7e2:	33c0 0000 47fc 	move.w d0,47fc <GameMatrix+0x8>
			AllocPlayfieldMem();
     7e8:	4eb9 0000 0f98 	jsr f98 <AllocPlayfieldMem>
			SetRast(&GOLRenderData.Rastport, 0);
     7ee:	2c79 0000 4772 	movea.l 4772 <GfxBase>,a6
     7f4:	43f9 0000 478a 	lea 478a <GOLRenderData+0x14>,a1
     7fa:	7000           	moveq #0,d0
     7fc:	4eae ff16      	jsr -234(a6)
	for (int y = 1; y < GameMatrix.Rows - 1; y++)
     800:	0c79 0002 0000 	cmpi.w #2,47fc <GameMatrix+0x8>
     806:	47fc 
     808:	6300 00cc      	bls.w 8d6 <main+0x862>
		for (int x = 1; x < GameMatrix.Columns - 1; x++)
     80c:	3239 0000 47fe 	move.w 47fe <GameMatrix+0xa>,d1
	for (int y = 1; y < GameMatrix.Rows - 1; y++)
     812:	7801           	moveq #1,d4
     814:	47f9 0000 222c 	lea 222c <__mulsi3>,a3
				SetAPen(&rd->Rastport, GameMatrix.ColorDead);
     81a:	2c3c 0000 478a 	move.l #18314,d6
		for (int x = 1; x < GameMatrix.Columns - 1; x++)
     820:	0c41 0002      	cmpi.w #2,d1
     824:	6300 00b0      	bls.w 8d6 <main+0x862>
     828:	2004           	move.l d4,d0
     82a:	5380           	subq.l #1,d0
     82c:	2f40 0034      	move.l d0,52(sp)
     830:	7a04           	moveq #4,d5
     832:	347c 0001      	movea.w #1,a2
				SetAPen(&rd->Rastport, GameMatrix.ColorAlive);
     836:	2c79 0000 4772 	movea.l 4772 <GfxBase>,a6
			if (GameMatrix.Playfield[x][y].Status)
     83c:	2247           	movea.l d7,a1
     83e:	2051           	movea.l (a1),a0
     840:	2070 5800      	movea.l (0,a0,d5.l),a0
				SetAPen(&rd->Rastport, GameMatrix.ColorAlive);
     844:	2246           	movea.l d6,a1
     846:	7000           	moveq #0,d0
			if (GameMatrix.Playfield[x][y].Status)
     848:	4a30 4800      	tst.b (0,a0,d4.l)
     84c:	6700 00e6      	beq.w 934 <main+0x8c0>
				SetAPen(&rd->Rastport, GameMatrix.ColorAlive);
     850:	3039 0000 4800 	move.w 4800 <GameMatrix+0xc>,d0
     856:	4eae feaa      	jsr -342(a6)
			RectFill(&rd->Rastport,
     85a:	7400           	moveq #0,d2
     85c:	3439 0000 4804 	move.w 4804 <GameMatrix+0x10>,d2
     862:	2f02           	move.l d2,-(sp)
     864:	486a ffff      	pea -1(a2)
     868:	4e93           	jsr (a3)
     86a:	508f           	addq.l #8,sp
     86c:	2840           	movea.l d0,a4
     86e:	2200           	move.l d0,d1
     870:	5281           	addq.l #1,d1
     872:	7000           	moveq #0,d0
     874:	3039 0000 4806 	move.w 4806 <GameMatrix+0x12>,d0
     87a:	2a40           	movea.l d0,a5
     87c:	2f2f 0034      	move.l 52(sp),-(sp)
     880:	2f0d           	move.l a5,-(sp)
     882:	2f41 0034      	move.l d1,52(sp)
     886:	4e93           	jsr (a3)
     888:	508f           	addq.l #8,sp
     88a:	2600           	move.l d0,d3
     88c:	2c79 0000 4772 	movea.l 4772 <GfxBase>,a6
     892:	2246           	movea.l d6,a1
     894:	222f 002c      	move.l 44(sp),d1
     898:	2001           	move.l d1,d0
     89a:	2203           	move.l d3,d1
     89c:	5281           	addq.l #1,d1
     89e:	49f4 28ff      	lea (-1,a4,d2.l),a4
     8a2:	240c           	move.l a4,d2
     8a4:	4bf5 38ff      	lea (-1,a5,d3.l),a5
     8a8:	260d           	move.l a5,d3
     8aa:	4eae fece      	jsr -306(a6)
		for (int x = 1; x < GameMatrix.Columns - 1; x++)
     8ae:	528a           	addq.l #1,a2
     8b0:	3239 0000 47fe 	move.w 47fe <GameMatrix+0xa>,d1
     8b6:	5885           	addq.l #4,d5
     8b8:	7000           	moveq #0,d0
     8ba:	3001           	move.w d1,d0
     8bc:	5380           	subq.l #1,d0
     8be:	b08a           	cmp.l a2,d0
     8c0:	6e00 ff74      	bgt.w 836 <main+0x7c2>
	for (int y = 1; y < GameMatrix.Rows - 1; y++)
     8c4:	5284           	addq.l #1,d4
     8c6:	7000           	moveq #0,d0
     8c8:	3039 0000 47fc 	move.w 47fc <GameMatrix+0x8>,d0
     8ce:	5380           	subq.l #1,d0
     8d0:	b084           	cmp.l d4,d0
     8d2:	6e00 ff4c      	bgt.w 820 <main+0x7ac>
	BltBitMapRastPort(rd->Backbuffer,
     8d6:	2c79 0000 4772 	movea.l 4772 <GfxBase>,a6
     8dc:	2079 0000 47ee 	movea.l 47ee <GOLRenderData+0x78>,a0
     8e2:	7000           	moveq #0,d0
     8e4:	7200           	moveq #0,d1
     8e6:	2279 0000 477a 	movea.l 477a <GOLRenderData+0x4>,a1
     8ec:	2269 0032      	movea.l 50(a1),a1
     8f0:	7400           	moveq #0,d2
     8f2:	7600           	moveq #0,d3
     8f4:	3839 0000 4782 	move.w 4782 <GOLRenderData+0xc>,d4
     8fa:	48c4           	ext.l d4
     8fc:	3a39 0000 4784 	move.w 4784 <GOLRenderData+0xe>,d5
     902:	48c5           	ext.l d5
     904:	7c3f           	moveq #63,d6
     906:	4606           	not.b d6
     908:	4eae fda2      	jsr -606(a6)
			GameRunning ? SetWindowTitles(GOLRenderData.MainWindow, (STRPTR) "Running", (STRPTR)-1) : SetWindowTitles(GOLRenderData.MainWindow, (STRPTR) "Stopped", (STRPTR)-1);
     90c:	2c79 0000 4766 	movea.l 4766 <IntuitionBase>,a6
     912:	2079 0000 477a 	movea.l 477a <GOLRenderData+0x4>,a0
     918:	4a79 0000 476c 	tst.w 476c <GameRunning>
     91e:	6700 0216      	beq.w b36 <main+0xac2>
     922:	43f9 0000 2433 	lea 2433 <PutChar+0xff>,a1
     928:	347c ffff      	movea.w #-1,a2
     92c:	4eae feec      	jsr -276(a6)
     930:	6000 fafc      	bra.w 42e <main+0x3ba>
				SetAPen(&rd->Rastport, GameMatrix.ColorDead);
     934:	3039 0000 4802 	move.w 4802 <GameMatrix+0xe>,d0
     93a:	4eae feaa      	jsr -342(a6)
			RectFill(&rd->Rastport,
     93e:	7400           	moveq #0,d2
     940:	3439 0000 4804 	move.w 4804 <GameMatrix+0x10>,d2
     946:	2f02           	move.l d2,-(sp)
     948:	486a ffff      	pea -1(a2)
     94c:	4e93           	jsr (a3)
     94e:	508f           	addq.l #8,sp
     950:	2840           	movea.l d0,a4
     952:	2200           	move.l d0,d1
     954:	5281           	addq.l #1,d1
     956:	7000           	moveq #0,d0
     958:	3039 0000 4806 	move.w 4806 <GameMatrix+0x12>,d0
     95e:	2a40           	movea.l d0,a5
     960:	2f2f 0034      	move.l 52(sp),-(sp)
     964:	2f0d           	move.l a5,-(sp)
     966:	2f41 0034      	move.l d1,52(sp)
     96a:	4e93           	jsr (a3)
     96c:	508f           	addq.l #8,sp
     96e:	2600           	move.l d0,d3
     970:	2c79 0000 4772 	movea.l 4772 <GfxBase>,a6
     976:	2246           	movea.l d6,a1
     978:	222f 002c      	move.l 44(sp),d1
     97c:	2001           	move.l d1,d0
     97e:	2203           	move.l d3,d1
     980:	5281           	addq.l #1,d1
     982:	49f4 28ff      	lea (-1,a4,d2.l),a4
     986:	240c           	move.l a4,d2
     988:	4bf5 38ff      	lea (-1,a5,d3.l),a5
     98c:	260d           	move.l a5,d3
     98e:	4eae fece      	jsr -306(a6)
		for (int x = 1; x < GameMatrix.Columns - 1; x++)
     992:	528a           	addq.l #1,a2
     994:	3239 0000 47fe 	move.w 47fe <GameMatrix+0xa>,d1
     99a:	5885           	addq.l #4,d5
     99c:	7000           	moveq #0,d0
     99e:	3001           	move.w d1,d0
     9a0:	5380           	subq.l #1,d0
     9a2:	b08a           	cmp.l a2,d0
     9a4:	6e00 fe90      	bgt.w 836 <main+0x7c2>
     9a8:	6000 ff1a      	bra.w 8c4 <main+0x850>
			menuNumber = message->Code;
     9ac:	342a 0018      	move.w 24(a2),d2
			while ((menuNumber != MENUNULL))
     9b0:	0c42 ffff      	cmpi.w #-1,d2
     9b4:	6700 fa78      	beq.w 42e <main+0x3ba>
		for (int y = startY; y < (startY + height); y++)
		{
			args[0] = x;
			args[1] = y;
			args[2] = GameMatrix.Playfield[x][y].Status;
			VFPrintf(fh, (CONST_STRPTR) "%d,%d,%d\n", args);
     9b8:	4bf9 0000 2445 	lea 2445 <PutChar+0x111>,a5
     9be:	286f 003c      	movea.l 60(sp),a4
				item = ItemAddress(theMenu, menuNumber);
     9c2:	2c79 0000 4766 	movea.l 4766 <IntuitionBase>,a6
     9c8:	204c           	movea.l a4,a0
     9ca:	3002           	move.w d2,d0
     9cc:	4eae ff70      	jsr -144(a6)
     9d0:	2640           	movea.l d0,a3
				menuNum = MENUNUM(menuNumber);
     9d2:	3202           	move.w d2,d1
     9d4:	0241 001f      	andi.w #31,d1
				itemNum = ITEMNUM(menuNumber);
     9d8:	3002           	move.w d2,d0
     9da:	ea48           	lsr.w #5,d0
     9dc:	0240 003f      	andi.w #63,d0
				if ((menuNum == 0) && (itemNum == 5))
     9e0:	4a41           	tst.w d1
     9e2:	6676           	bne.s a5a <main+0x9e6>
     9e4:	0c40 0005      	cmpi.w #5,d0
     9e8:	6700 0096      	beq.w a80 <main+0xa0c>
				if ((menuNum == 0) && (itemNum == 1))
     9ec:	0c40 0001      	cmpi.w #1,d0
     9f0:	6700 00a2      	beq.w a94 <main+0xa20>
				if ((menuNum == 0) && (itemNum == 3) && (subNum == 2))
     9f4:	0c40 0003      	cmpi.w #3,d0
     9f8:	6632           	bne.s a2c <main+0x9b8>
				subNum = SUBNUM(menuNumber);
     9fa:	700b           	moveq #11,d0
     9fc:	e06a           	lsr.w d0,d2
				if ((menuNum == 0) && (itemNum == 3) && (subNum == 2))
     9fe:	0c42 0002      	cmpi.w #2,d2
     a02:	6700 0340      	beq.w d44 <main+0xcd0>
				if ((menuNum == 0) && (itemNum == 3) && (subNum == 0))
     a06:	4a42           	tst.w d2
     a08:	6600 013e      	bne.w b48 <main+0xad4>
					SetWindowTitles(theWindow, (STRPTR) "Running", (STRPTR)-1);
     a0c:	2c79 0000 4766 	movea.l 4766 <IntuitionBase>,a6
     a12:	206f 0030      	movea.l 48(sp),a0
     a16:	43f9 0000 2433 	lea 2433 <PutChar+0xff>,a1
     a1c:	347c ffff      	movea.w #-1,a2
     a20:	4eae feec      	jsr -276(a6)
					GameRunning = TRUE;
     a24:	33fc 0001 0000 	move.w #1,476c <GameRunning>
     a2a:	476c 
				menuNumber = item->NextSelect;
     a2c:	342b 0020      	move.w 32(a3),d2
			while ((menuNumber != MENUNULL))
     a30:	0c42 ffff      	cmpi.w #-1,d2
     a34:	6700 f9f8      	beq.w 42e <main+0x3ba>
				item = ItemAddress(theMenu, menuNumber);
     a38:	2c79 0000 4766 	movea.l 4766 <IntuitionBase>,a6
     a3e:	204c           	movea.l a4,a0
     a40:	3002           	move.w d2,d0
     a42:	4eae ff70      	jsr -144(a6)
     a46:	2640           	movea.l d0,a3
				menuNum = MENUNUM(menuNumber);
     a48:	3202           	move.w d2,d1
     a4a:	0241 001f      	andi.w #31,d1
				itemNum = ITEMNUM(menuNumber);
     a4e:	3002           	move.w d2,d0
     a50:	ea48           	lsr.w #5,d0
     a52:	0240 003f      	andi.w #63,d0
				if ((menuNum == 0) && (itemNum == 5))
     a56:	4a41           	tst.w d1
     a58:	678a           	beq.s 9e4 <main+0x970>
				if ((menuNum == 2) && (itemNum == 0))
     a5a:	0c41 0002      	cmpi.w #2,d1
     a5e:	66cc           	bne.s a2c <main+0x9b8>
     a60:	4a40           	tst.w d0
     a62:	66c8           	bne.s a2c <main+0x9b8>
					RunPPG_Window(&GOLRenderData);
     a64:	4eb9 0000 1174 	jsr 1174 <RunPPG_Window.constprop.0>
					GOLRenderData.PPG_WinOpen = TRUE;
     a6a:	33fc 0001 0000 	move.w #1,47f2 <GOLRenderData+0x7c>
     a70:	47f2 
				menuNumber = item->NextSelect;
     a72:	342b 0020      	move.w 32(a3),d2
			while ((menuNumber != MENUNULL))
     a76:	0c42 ffff      	cmpi.w #-1,d2
     a7a:	66bc           	bne.s a38 <main+0x9c4>
     a7c:	6000 f9b0      	bra.w 42e <main+0x3ba>
					AppRunning = FALSE;
     a80:	4279 0000 4718 	clr.w 4718 <AppRunning>
				menuNumber = item->NextSelect;
     a86:	342b 0020      	move.w 32(a3),d2
			while ((menuNumber != MENUNULL))
     a8a:	0c42 ffff      	cmpi.w #-1,d2
     a8e:	66a8           	bne.s a38 <main+0x9c4>
     a90:	6000 f99c      	bra.w 42e <main+0x3ba>
					SavePlayfield((CONST_STRPTR) "test.gold", 1, 1, GameMatrix.Columns - 1, GameMatrix.Rows - 1);
     a94:	7800           	moveq #0,d4
     a96:	3839 0000 47fc 	move.w 47fc <GameMatrix+0x8>,d4
     a9c:	7600           	moveq #0,d3
     a9e:	3639 0000 47fe 	move.w 47fe <GameMatrix+0xa>,d3
	fh = Open(file, MODE_NEWFILE);
     aa4:	2c79 0000 475a 	movea.l 475a <DOSBase>,a6
     aaa:	223c 0000 243b 	move.l #9275,d1
     ab0:	243c 0000 03ee 	move.l #1006,d2
     ab6:	4eae ffe2      	jsr -30(a6)
     aba:	2440           	movea.l d0,a2
	for (int x = startX; x < (startX + width); x++)
     abc:	7001           	moveq #1,d0
     abe:	b083           	cmp.l d3,d0
     ac0:	6c58           	bge.s b1a <main+0xaa6>
     ac2:	b084           	cmp.l d4,d0
     ac4:	6c54           	bge.s b1a <main+0xaa6>
     ac6:	7c04           	moveq #4,d6
     ac8:	7a01           	moveq #1,d5
     aca:	2f4c 0034      	move.l a4,52(sp)
     ace:	2f4b 0038      	move.l a3,56(sp)
     ad2:	2644           	movea.l d4,a3
     ad4:	2843           	movea.l d3,a4
		for (int y = startY; y < (startY + height); y++)
     ad6:	7801           	moveq #1,d4
			args[0] = x;
     ad8:	2f45 0048      	move.l d5,72(sp)
			args[1] = y;
     adc:	2f44 004c      	move.l d4,76(sp)
			args[2] = GameMatrix.Playfield[x][y].Status;
     ae0:	2247           	movea.l d7,a1
     ae2:	2051           	movea.l (a1),a0
     ae4:	2070 6800      	movea.l (0,a0,d6.l),a0
     ae8:	7000           	moveq #0,d0
     aea:	1030 4800      	move.b (0,a0,d4.l),d0
     aee:	2f40 0050      	move.l d0,80(sp)
			VFPrintf(fh, (CONST_STRPTR) "%d,%d,%d\n", args);
     af2:	2c79 0000 475a 	movea.l 475a <DOSBase>,a6
     af8:	220a           	move.l a2,d1
     afa:	240d           	move.l a5,d2
     afc:	7648           	moveq #72,d3
     afe:	d68f           	add.l sp,d3
     b00:	4eae fe9e      	jsr -354(a6)
		for (int y = startY; y < (startY + height); y++)
     b04:	5284           	addq.l #1,d4
     b06:	b88b           	cmp.l a3,d4
     b08:	66ce           	bne.s ad8 <main+0xa64>
	for (int x = startX; x < (startX + width); x++)
     b0a:	5285           	addq.l #1,d5
     b0c:	5886           	addq.l #4,d6
     b0e:	ba8c           	cmp.l a4,d5
     b10:	66c4           	bne.s ad6 <main+0xa62>
     b12:	286f 0034      	movea.l 52(sp),a4
     b16:	266f 0038      	movea.l 56(sp),a3
		}
	}
	Close(fh);
     b1a:	2c79 0000 475a 	movea.l 475a <DOSBase>,a6
     b20:	220a           	move.l a2,d1
     b22:	4eae ffdc      	jsr -36(a6)
				menuNumber = item->NextSelect;
     b26:	342b 0020      	move.w 32(a3),d2
			while ((menuNumber != MENUNULL))
     b2a:	0c42 ffff      	cmpi.w #-1,d2
     b2e:	6600 ff08      	bne.w a38 <main+0x9c4>
     b32:	6000 f8fa      	bra.w 42e <main+0x3ba>
			GameRunning ? SetWindowTitles(GOLRenderData.MainWindow, (STRPTR) "Running", (STRPTR)-1) : SetWindowTitles(GOLRenderData.MainWindow, (STRPTR) "Stopped", (STRPTR)-1);
     b36:	43f9 0000 23fa 	lea 23fa <PutChar+0xc6>,a1
     b3c:	347c ffff      	movea.w #-1,a2
     b40:	4eae feec      	jsr -276(a6)
     b44:	6000 f8e8      	bra.w 42e <main+0x3ba>
				if ((menuNum == 0) && (itemNum == 3) && (subNum == 1))
     b48:	0c42 0001      	cmpi.w #1,d2
     b4c:	6600 fede      	bne.w a2c <main+0x9b8>
					SetWindowTitles(theWindow, (STRPTR) "Stopped", (STRPTR)-1);
     b50:	2c79 0000 4766 	movea.l 4766 <IntuitionBase>,a6
     b56:	206f 0030      	movea.l 48(sp),a0
     b5a:	43f9 0000 23fa 	lea 23fa <PutChar+0xc6>,a1
     b60:	347c ffff      	movea.w #-1,a2
     b64:	4eae feec      	jsr -276(a6)
					GameRunning = FALSE;
     b68:	4279 0000 476c 	clr.w 476c <GameRunning>
				menuNumber = item->NextSelect;
     b6e:	342b 0020      	move.w 32(a3),d2
			while ((menuNumber != MENUNULL))
     b72:	0c42 ffff      	cmpi.w #-1,d2
     b76:	6600 fec0      	bne.w a38 <main+0x9c4>
     b7a:	6000 f8b2      	bra.w 42e <main+0x3ba>
				if (!GameRunning)
     b7e:	4a79 0000 476c 	tst.w 476c <GameRunning>
     b84:	6600 fbc2      	bne.w 748 <main+0x6d4>
					DrawActive = TRUE;
     b88:	33fc 0001 0000 	move.w #1,4754 <DrawActive>
     b8e:	4754 
					ToggleCellStatus(coordX, coordY);
     b90:	2f0a           	move.l a2,-(sp)
     b92:	2f0c           	move.l a4,-(sp)
     b94:	4eb9 0000 10b6 	jsr 10b6 <ToggleCellStatus>
					UpdateList[UpdateCnt].X = x;
     b9a:	3239 0000 476a 	move.w 476a <UpdateCnt>,d1
     ba0:	7000           	moveq #0,d0
     ba2:	3001           	move.w d1,d0
     ba4:	2240           	movea.l d0,a1
     ba6:	d3c0           	adda.l d0,a1
     ba8:	d3c0           	adda.l d0,a1
     baa:	d3c9           	adda.l a1,a1
     bac:	d3f9 0000 4756 	adda.l 4756 <UpdateList>,a1
     bb2:	3282           	move.w d2,(a1)
					UpdateList[UpdateCnt].Y = y;
     bb4:	3345 0002      	move.w d5,2(a1)
					UpdateList[UpdateCnt++].Status = GameMatrix.Playfield[x][y].Status;
     bb8:	2647           	movea.l d7,a3
     bba:	2053           	movea.l (a3),a0
     bbc:	2002           	move.l d2,d0
     bbe:	d082           	add.l d2,d0
     bc0:	d080           	add.l d0,d0
     bc2:	2070 0800      	movea.l (0,a0,d0.l),a0
     bc6:	5241           	addq.w #1,d1
     bc8:	33c1 0000 476a 	move.w d1,476a <UpdateCnt>
     bce:	4240           	clr.w d0
     bd0:	1030 5800      	move.b (0,a0,d5.l),d0
     bd4:	3340 0004      	move.w d0,4(a1)
     bd8:	508f           	addq.l #8,sp
     bda:	6000 fb76      	bra.w 752 <main+0x6de>
	for (int entry = 0; entry < UpdateCnt; entry++)
     bde:	7a00           	moveq #0,d5
		if (UpdateCnt > 0)
     be0:	7800           	moveq #0,d4
     be2:	45f9 0000 222c 	lea 222c <__mulsi3>,a2
			SetAPen(&rd->Rastport, GameMatrix.ColorDead);
     be8:	2c3c 0000 478a 	move.l #18314,d6
		int x = UpdateList[entry].X;
     bee:	2079 0000 4756 	movea.l 4756 <UpdateList>,a0
     bf4:	d1c4           	adda.l d4,a0
     bf6:	7000           	moveq #0,d0
     bf8:	3010           	move.w (a0),d0
     bfa:	2640           	movea.l d0,a3
		int y = UpdateList[entry].Y;
     bfc:	7600           	moveq #0,d3
     bfe:	3628 0002      	move.w 2(a0),d3
			SetAPen(&rd->Rastport, GameMatrix.ColorAlive);
     c02:	2c79 0000 4772 	movea.l 4772 <GfxBase>,a6
     c08:	2246           	movea.l d6,a1
     c0a:	7000           	moveq #0,d0
		if (s)
     c0c:	4a68 0004      	tst.w 4(a0)
     c10:	6700 0092      	beq.w ca4 <main+0xc30>
			SetAPen(&rd->Rastport, GameMatrix.ColorAlive);
     c14:	3039 0000 4800 	move.w 4800 <GameMatrix+0xc>,d0
     c1a:	4eae feaa      	jsr -342(a6)
		RectFill(&rd->Rastport,
     c1e:	7400           	moveq #0,d2
     c20:	3439 0000 4804 	move.w 4804 <GameMatrix+0x10>,d2
     c26:	2f02           	move.l d2,-(sp)
     c28:	486b ffff      	pea -1(a3)
     c2c:	4e92           	jsr (a2)
     c2e:	508f           	addq.l #8,sp
     c30:	2640           	movea.l d0,a3
     c32:	4beb 0001      	lea 1(a3),a5
     c36:	7200           	moveq #0,d1
     c38:	3239 0000 4806 	move.w 4806 <GameMatrix+0x12>,d1
     c3e:	2841           	movea.l d1,a4
     c40:	2f0c           	move.l a4,-(sp)
     c42:	2043           	movea.l d3,a0
     c44:	4868 ffff      	pea -1(a0)
     c48:	4e92           	jsr (a2)
     c4a:	508f           	addq.l #8,sp
     c4c:	2600           	move.l d0,d3
     c4e:	2c79 0000 4772 	movea.l 4772 <GfxBase>,a6
     c54:	2246           	movea.l d6,a1
     c56:	200d           	move.l a5,d0
     c58:	2203           	move.l d3,d1
     c5a:	5281           	addq.l #1,d1
     c5c:	47f3 28ff      	lea (-1,a3,d2.l),a3
     c60:	240b           	move.l a3,d2
     c62:	49f4 38ff      	lea (-1,a4,d3.l),a4
     c66:	260c           	move.l a4,d3
     c68:	4eae fece      	jsr -306(a6)
	for (int entry = 0; entry < UpdateCnt; entry++)
     c6c:	5285           	addq.l #1,d5
     c6e:	5c84           	addq.l #6,d4
     c70:	7000           	moveq #0,d0
     c72:	3039 0000 476a 	move.w 476a <UpdateCnt>,d0
     c78:	b085           	cmp.l d5,d0
     c7a:	6f00 f918      	ble.w 594 <main+0x520>
		int x = UpdateList[entry].X;
     c7e:	2079 0000 4756 	movea.l 4756 <UpdateList>,a0
     c84:	d1c4           	adda.l d4,a0
     c86:	7000           	moveq #0,d0
     c88:	3010           	move.w (a0),d0
     c8a:	2640           	movea.l d0,a3
		int y = UpdateList[entry].Y;
     c8c:	7600           	moveq #0,d3
     c8e:	3628 0002      	move.w 2(a0),d3
			SetAPen(&rd->Rastport, GameMatrix.ColorAlive);
     c92:	2c79 0000 4772 	movea.l 4772 <GfxBase>,a6
     c98:	2246           	movea.l d6,a1
     c9a:	7000           	moveq #0,d0
		if (s)
     c9c:	4a68 0004      	tst.w 4(a0)
     ca0:	6600 ff72      	bne.w c14 <main+0xba0>
			SetAPen(&rd->Rastport, GameMatrix.ColorDead);
     ca4:	3039 0000 4802 	move.w 4802 <GameMatrix+0xe>,d0
     caa:	4eae feaa      	jsr -342(a6)
		RectFill(&rd->Rastport,
     cae:	7400           	moveq #0,d2
     cb0:	3439 0000 4804 	move.w 4804 <GameMatrix+0x10>,d2
     cb6:	2f02           	move.l d2,-(sp)
     cb8:	486b ffff      	pea -1(a3)
     cbc:	4e92           	jsr (a2)
     cbe:	508f           	addq.l #8,sp
     cc0:	2640           	movea.l d0,a3
     cc2:	4beb 0001      	lea 1(a3),a5
     cc6:	7200           	moveq #0,d1
     cc8:	3239 0000 4806 	move.w 4806 <GameMatrix+0x12>,d1
     cce:	2841           	movea.l d1,a4
     cd0:	2f0c           	move.l a4,-(sp)
     cd2:	2043           	movea.l d3,a0
     cd4:	4868 ffff      	pea -1(a0)
     cd8:	4e92           	jsr (a2)
     cda:	508f           	addq.l #8,sp
     cdc:	2600           	move.l d0,d3
     cde:	2c79 0000 4772 	movea.l 4772 <GfxBase>,a6
     ce4:	2246           	movea.l d6,a1
     ce6:	200d           	move.l a5,d0
     ce8:	2203           	move.l d3,d1
     cea:	5281           	addq.l #1,d1
     cec:	47f3 28ff      	lea (-1,a3,d2.l),a3
     cf0:	240b           	move.l a3,d2
     cf2:	49f4 38ff      	lea (-1,a4,d3.l),a4
     cf6:	260c           	move.l a4,d3
     cf8:	4eae fece      	jsr -306(a6)
	for (int entry = 0; entry < UpdateCnt; entry++)
     cfc:	5285           	addq.l #1,d5
     cfe:	5c84           	addq.l #6,d4
     d00:	7000           	moveq #0,d0
     d02:	3039 0000 476a 	move.w 476a <UpdateCnt>,d0
     d08:	b085           	cmp.l d5,d0
     d0a:	6e00 ff72      	bgt.w c7e <main+0xc0a>
     d0e:	6000 f884      	bra.w 594 <main+0x520>
			menuNumber = message->Code;
     d12:	302a 0018      	move.w 24(a2),d0
			while ((menuNumber != MENUNULL) && (AppRunning))
     d16:	0c40 ffff      	cmpi.w #-1,d0
     d1a:	6700 f7fc      	beq.w 518 <main+0x4a4>
     d1e:	4a79 0000 4718 	tst.w 4718 <AppRunning>
     d24:	6700 f7f2      	beq.w 518 <main+0x4a4>
				item = ItemAddress(theMenu, menuNumber);
     d28:	2c79 0000 4766 	movea.l 4766 <IntuitionBase>,a6
     d2e:	91c8           	suba.l a0,a0
     d30:	4eae ff70      	jsr -144(a6)
				menuNumber = item->NextSelect;
     d34:	2040           	movea.l d0,a0
     d36:	3028 0020      	move.w 32(a0),d0
			while ((menuNumber != MENUNULL) && (AppRunning))
     d3a:	0c40 ffff      	cmpi.w #-1,d0
     d3e:	66de           	bne.s d1e <main+0xcaa>
     d40:	6000 f7d6      	bra.w 518 <main+0x4a4>
					ClearPlayfield(GameMatrix.Playfield);
     d44:	2047           	movea.l d7,a0
     d46:	2450           	movea.l (a0),a2
	for (int x = 0; x < GameMatrix.Columns; x++)
     d48:	3439 0000 47fe 	move.w 47fe <GameMatrix+0xa>,d2
     d4e:	674a           	beq.s d9a <main+0xd26>
		memset(pf[x], 0, GameMatrix.Rows * sizeof(GameOfLifeCell));
     d50:	7600           	moveq #0,d3
     d52:	3639 0000 47fc 	move.w 47fc <GameMatrix+0x8>,d3
     d58:	0282 0000 ffff 	andi.l #65535,d2
     d5e:	d482           	add.l d2,d2
     d60:	d482           	add.l d2,d2
     d62:	280a           	move.l a2,d4
     d64:	d882           	add.l d2,d4
     d66:	201a           	move.l (a2)+,d0
     d68:	2f03           	move.l d3,-(sp)
     d6a:	42a7           	clr.l -(sp)
     d6c:	2f00           	move.l d0,-(sp)
     d6e:	4eb9 0000 201a 	jsr 201a <memset>
	for (int x = 0; x < GameMatrix.Columns; x++)
     d74:	4fef 000c      	lea 12(sp),sp
     d78:	b5c4           	cmpa.l d4,a2
     d7a:	66ea           	bne.s d66 <main+0xcf2>
     d7c:	2479 0000 47f8 	movea.l 47f8 <GameMatrix+0x4>,a2
     d82:	d48a           	add.l a2,d2
		memset(pf[x], 0, GameMatrix.Rows * sizeof(GameOfLifeCell));
     d84:	201a           	move.l (a2)+,d0
     d86:	2f03           	move.l d3,-(sp)
     d88:	42a7           	clr.l -(sp)
     d8a:	2f00           	move.l d0,-(sp)
     d8c:	4eb9 0000 201a 	jsr 201a <memset>
	for (int x = 0; x < GameMatrix.Columns; x++)
     d92:	4fef 000c      	lea 12(sp),sp
     d96:	b48a           	cmp.l a2,d2
     d98:	66ea           	bne.s d84 <main+0xd10>
					SetRast(GOLRenderData.MainWindow->RPort, 0);
     d9a:	2c79 0000 4772 	movea.l 4772 <GfxBase>,a6
     da0:	2079 0000 477a 	movea.l 477a <GOLRenderData+0x4>,a0
     da6:	2268 0032      	movea.l 50(a0),a1
     daa:	7000           	moveq #0,d0
     dac:	4eae ff16      	jsr -234(a6)
					SetRast(&GOLRenderData.Rastport, 0);
     db0:	2c79 0000 4772 	movea.l 4772 <GfxBase>,a6
     db6:	43f9 0000 478a 	lea 478a <GOLRenderData+0x14>,a1
     dbc:	7000           	moveq #0,d0
     dbe:	4eae ff16      	jsr -234(a6)
				menuNumber = item->NextSelect;
     dc2:	342b 0020      	move.w 32(a3),d2
			while ((menuNumber != MENUNULL))
     dc6:	0c42 ffff      	cmpi.w #-1,d2
     dca:	6600 fc6c      	bne.w a38 <main+0x9c4>
     dce:	6000 f65e      	bra.w 42e <main+0x3ba>
			UpdateCnt = 0;
     dd2:	4279 0000 476a 	clr.w 476a <UpdateCnt>
	GameOfLifeCell **pf = GameMatrix.Playfield;
     dd8:	2247           	movea.l d7,a1
     dda:	2f51 0034      	move.l (a1),52(sp)
	GameOfLifeCell **pf_n1 = GameMatrix.Playfield_n1;
     dde:	2f79 0000 47f8 	move.l 47f8 <GameMatrix+0x4>,56(sp)
     de4:	0038 
	for (int x = 1; x < GameMatrix.Columns - 1; x++)
     de6:	7000           	moveq #0,d0
     de8:	3039 0000 47fe 	move.w 47fe <GameMatrix+0xa>,d0
     dee:	2c40           	movea.l d0,a6
     df0:	7202           	moveq #2,d1
     df2:	b28e           	cmp.l a6,d1
     df4:	6c00 0174      	bge.w f6a <main+0xef6>
		for (int y = 1; y < GameMatrix.Rows - 1; y++)
     df8:	3f79 0000 47fc 	move.w 47fc <GameMatrix+0x8>,48(sp)
     dfe:	0030 
				UpdateList[UpdateCnt].X = x;
     e00:	2c39 0000 4756 	move.l 4756 <UpdateList>,d6
     e06:	286f 0038      	movea.l 56(sp),a4
     e0a:	588c           	addq.l #4,a4
     e0c:	2a6f 0034      	movea.l 52(sp),a5
     e10:	5380           	subq.l #1,d0
     e12:	7a01           	moveq #1,d5
     e14:	4243           	clr.w d3
     e16:	7800           	moveq #0,d4
     e18:	382f 0030      	move.w 48(sp),d4
     e1c:	5384           	subq.l #1,d4
     e1e:	2f4e 003c      	move.l a6,60(sp)
     e22:	2c40           	movea.l d0,a6
		for (int y = 1; y < GameMatrix.Rows - 1; y++)
     e24:	0c6f 0002 0030 	cmpi.w #2,48(sp)
     e2a:	6300 0082      	bls.w eae <main+0xe3a>
     e2e:	2455           	movea.l (a5),a2
     e30:	226d 0008      	movea.l 8(a5),a1
     e34:	206d 0004      	movea.l 4(a5),a0
					if (pf[x + xi][y + yj].Status)
     e38:	7201           	moveq #1,d1
     e3a:	4a1a           	tst.b (a2)+
     e3c:	56c0           	sne d0
     e3e:	4880           	ext.w d0
     e40:	4440           	neg.w d0
     e42:	4a12           	tst.b (a2)
     e44:	6702           	beq.s e48 <main+0xdd4>
						neighbours++;
     e46:	5240           	addq.w #1,d0
					if (pf[x + xi][y + yj].Status)
     e48:	4a2a 0001      	tst.b 1(a2)
     e4c:	6702           	beq.s e50 <main+0xddc>
						neighbours++;
     e4e:	5240           	addq.w #1,d0
					if (pf[x + xi][y + yj].Status)
     e50:	4a18           	tst.b (a0)+
     e52:	6702           	beq.s e56 <main+0xde2>
						neighbours++;
     e54:	5240           	addq.w #1,d0
					if (pf[x + xi][y + yj].Status)
     e56:	1410           	move.b (a0),d2
     e58:	6702           	beq.s e5c <main+0xde8>
						neighbours++;
     e5a:	5240           	addq.w #1,d0
					if (pf[x + xi][y + yj].Status)
     e5c:	4a28 0001      	tst.b 1(a0)
     e60:	6702           	beq.s e64 <main+0xdf0>
						neighbours++;
     e62:	5240           	addq.w #1,d0
					if (pf[x + xi][y + yj].Status)
     e64:	4a19           	tst.b (a1)+
     e66:	6702           	beq.s e6a <main+0xdf6>
						neighbours++;
     e68:	5240           	addq.w #1,d0
					if (pf[x + xi][y + yj].Status)
     e6a:	4a11           	tst.b (a1)
     e6c:	6702           	beq.s e70 <main+0xdfc>
						neighbours++;
     e6e:	5240           	addq.w #1,d0
					if (pf[x + xi][y + yj].Status)
     e70:	4a29 0001      	tst.b 1(a1)
     e74:	6702           	beq.s e78 <main+0xe04>
						neighbours++;
     e76:	5240           	addq.w #1,d0
			if (pf[x][y].Status)
     e78:	4a02           	tst.b d2
     e7a:	6700 0098      	beq.w f14 <main+0xea0>
					pf_n1[x][y].Status = 0;
     e7e:	2654           	movea.l (a4),a3
     e80:	d7c1           	adda.l d1,a3
				if (neighbours < 2 || neighbours > 3)
     e82:	5740           	subq.w #3,d0
     e84:	0c40 0001      	cmpi.w #1,d0
     e88:	6300 00c0      	bls.w f4a <main+0xed6>
					pf_n1[x][y].Status = 0;
     e8c:	4213           	clr.b (a3)
					UpdateList[UpdateCnt].X = x;
     e8e:	7000           	moveq #0,d0
     e90:	3003           	move.w d3,d0
     e92:	2640           	movea.l d0,a3
     e94:	d7c0           	adda.l d0,a3
     e96:	d7c0           	adda.l d0,a3
     e98:	d7cb           	adda.l a3,a3
     e9a:	d7c6           	adda.l d6,a3
     e9c:	3685           	move.w d5,(a3)
					UpdateList[UpdateCnt].Y = y;
     e9e:	3741 0002      	move.w d1,2(a3)
					UpdateList[UpdateCnt].Status = pf_n1[x][y].Status;
     ea2:	426b 0004      	clr.w 4(a3)
					UpdateCnt++;
     ea6:	5243           	addq.w #1,d3
		for (int y = 1; y < GameMatrix.Rows - 1; y++)
     ea8:	5281           	addq.l #1,d1
     eaa:	b881           	cmp.l d1,d4
     eac:	668c           	bne.s e3a <main+0xdc6>
	for (int x = 1; x < GameMatrix.Columns - 1; x++)
     eae:	5285           	addq.l #1,d5
     eb0:	588c           	addq.l #4,a4
     eb2:	588d           	addq.l #4,a5
     eb4:	ba8e           	cmp.l a6,d5
     eb6:	6600 ff6c      	bne.w e24 <main+0xdb0>
     eba:	2c6f 003c      	movea.l 60(sp),a6
     ebe:	33c3 0000 476a 	move.w d3,476a <UpdateCnt>
	for (int col = 0; col < GameMatrix.Columns; col++)
     ec4:	bcfc 0000      	cmpa.w #0,a6
     ec8:	6700 f6c4      	beq.w 58e <main+0x51a>
		memcpy(pf[col], pf_n1[col], GameMatrix.Rows * sizeof(GameOfLifeCell));
     ecc:	7800           	moveq #0,d4
     ece:	382f 0030      	move.w 48(sp),d4
     ed2:	266f 0038      	movea.l 56(sp),a3
     ed6:	246f 0034      	movea.l 52(sp),a2
	for (int col = 0; col < GameMatrix.Columns; col++)
     eda:	7400           	moveq #0,d2
     edc:	49f9 0000 20e8 	lea 20e8 <memcpy>,a4
		memcpy(pf[col], pf_n1[col], GameMatrix.Rows * sizeof(GameOfLifeCell));
     ee2:	221b           	move.l (a3)+,d1
     ee4:	201a           	move.l (a2)+,d0
     ee6:	2f04           	move.l d4,-(sp)
     ee8:	2f01           	move.l d1,-(sp)
     eea:	2f00           	move.l d0,-(sp)
     eec:	4e94           	jsr (a4)
	for (int col = 0; col < GameMatrix.Columns; col++)
     eee:	5282           	addq.l #1,d2
     ef0:	4fef 000c      	lea 12(sp),sp
     ef4:	bdc2           	cmpa.l d2,a6
     ef6:	6f00 f696      	ble.w 58e <main+0x51a>
		memcpy(pf[col], pf_n1[col], GameMatrix.Rows * sizeof(GameOfLifeCell));
     efa:	221b           	move.l (a3)+,d1
     efc:	201a           	move.l (a2)+,d0
     efe:	2f04           	move.l d4,-(sp)
     f00:	2f01           	move.l d1,-(sp)
     f02:	2f00           	move.l d0,-(sp)
     f04:	4e94           	jsr (a4)
	for (int col = 0; col < GameMatrix.Columns; col++)
     f06:	5282           	addq.l #1,d2
     f08:	4fef 000c      	lea 12(sp),sp
     f0c:	bdc2           	cmpa.l d2,a6
     f0e:	6ed2           	bgt.s ee2 <main+0xe6e>
     f10:	6000 f67c      	bra.w 58e <main+0x51a>
			else if (neighbours == 3)
     f14:	0c40 0003      	cmpi.w #3,d0
     f18:	668e           	bne.s ea8 <main+0xe34>
				pf_n1[x][y].Status = 1;
     f1a:	2654           	movea.l (a4),a3
     f1c:	17bc 0001 1800 	move.b #1,(0,a3,d1.l)
				UpdateList[UpdateCnt].X = x;
     f22:	7000           	moveq #0,d0
     f24:	3003           	move.w d3,d0
     f26:	2640           	movea.l d0,a3
     f28:	d7c0           	adda.l d0,a3
     f2a:	d7c0           	adda.l d0,a3
     f2c:	d7cb           	adda.l a3,a3
     f2e:	d7c6           	adda.l d6,a3
     f30:	3685           	move.w d5,(a3)
				UpdateList[UpdateCnt].Y = y;
     f32:	3741 0002      	move.w d1,2(a3)
				UpdateList[UpdateCnt].Status = pf_n1[x][y].Status;
     f36:	377c 0001 0004 	move.w #1,4(a3)
				UpdateCnt++;
     f3c:	5243           	addq.w #1,d3
		for (int y = 1; y < GameMatrix.Rows - 1; y++)
     f3e:	5281           	addq.l #1,d1
     f40:	b881           	cmp.l d1,d4
     f42:	6600 fef6      	bne.w e3a <main+0xdc6>
     f46:	6000 ff66      	bra.w eae <main+0xe3a>
					pf_n1[x][y].Status = pf[x][y].Status;
     f4a:	1682           	move.b d2,(a3)
		for (int y = 1; y < GameMatrix.Rows - 1; y++)
     f4c:	5281           	addq.l #1,d1
     f4e:	b881           	cmp.l d1,d4
     f50:	6600 fee8      	bne.w e3a <main+0xdc6>
     f54:	6000 ff58      	bra.w eae <main+0xe3a>
     f58:	42af 0040      	clr.l 64(sp)
}
     f5c:	202f 0040      	move.l 64(sp),d0
     f60:	4cdf 7cfc      	movem.l (sp)+,d2-d7/a2-a6
     f64:	4fef 00c0      	lea 192(sp),sp
     f68:	4e75           	rts
	for (int col = 0; col < GameMatrix.Columns; col++)
     f6a:	bcfc 0000      	cmpa.w #0,a6
     f6e:	6700 f624      	beq.w 594 <main+0x520>
		memcpy(pf[col], pf_n1[col], GameMatrix.Rows * sizeof(GameOfLifeCell));
     f72:	3f79 0000 47fc 	move.w 47fc <GameMatrix+0x8>,48(sp)
     f78:	0030 
     f7a:	4243           	clr.w d3
     f7c:	7800           	moveq #0,d4
     f7e:	382f 0030      	move.w 48(sp),d4
     f82:	266f 0038      	movea.l 56(sp),a3
     f86:	246f 0034      	movea.l 52(sp),a2
	for (int col = 0; col < GameMatrix.Columns; col++)
     f8a:	7400           	moveq #0,d2
     f8c:	49f9 0000 20e8 	lea 20e8 <memcpy>,a4
     f92:	6000 ff4e      	bra.w ee2 <main+0xe6e>
     f96:	4e71           	nop

00000f98 <AllocPlayfieldMem>:
{
     f98:	48e7 3822      	movem.l d2-d4/a2/a6,-(sp)
	if ((GameMatrix.Playfield = AllocMem(GameMatrix.Columns * sizeof(GameOfLifeCell *), MEMF_ANY | MEMF_CLEAR)) == NULL)
     f9c:	45f9 0000 47f4 	lea 47f4 <GameMatrix>,a2
     fa2:	7000           	moveq #0,d0
     fa4:	3039 0000 47fe 	move.w 47fe <GameMatrix+0xa>,d0
     faa:	2c79 0000 475e 	movea.l 475e <SysBase>,a6
     fb0:	e588           	lsl.l #2,d0
     fb2:	7201           	moveq #1,d1
     fb4:	4841           	swap d1
     fb6:	4eae ff3a      	jsr -198(a6)
     fba:	2480           	move.l d0,(a2)
     fbc:	6700 00ba      	beq.w 1078 <AllocPlayfieldMem+0xe0>
	if ((GameMatrix.Playfield_n1 = AllocMem(GameMatrix.Columns * sizeof(GameOfLifeCell *), MEMF_ANY | MEMF_CLEAR)) == NULL)
     fc0:	7000           	moveq #0,d0
     fc2:	3039 0000 47fe 	move.w 47fe <GameMatrix+0xa>,d0
     fc8:	2c79 0000 475e 	movea.l 475e <SysBase>,a6
     fce:	e588           	lsl.l #2,d0
     fd0:	7201           	moveq #1,d1
     fd2:	4841           	swap d1
     fd4:	4eae ff3a      	jsr -198(a6)
     fd8:	23c0 0000 47f8 	move.l d0,47f8 <GameMatrix+0x4>
     fde:	6700 0098      	beq.w 1078 <AllocPlayfieldMem+0xe0>
	for (int i = 0; i < GameMatrix.Columns; i++)
     fe2:	4a79 0000 47fe 	tst.w 47fe <GameMatrix+0xa>
     fe8:	6700 0096      	beq.w 1080 <AllocPlayfieldMem+0xe8>
     fec:	7400           	moveq #0,d2
     fee:	7600           	moveq #0,d3
		if ((GameMatrix.Playfield[i] = AllocMem(GameMatrix.Rows * sizeof(GameOfLifeCell), MEMF_ANY | MEMF_CLEAR)) == NULL)
     ff0:	7801           	moveq #1,d4
     ff2:	4844           	swap d4
     ff4:	2c79 0000 475e 	movea.l 475e <SysBase>,a6
     ffa:	7000           	moveq #0,d0
     ffc:	3039 0000 47fc 	move.w 47fc <GameMatrix+0x8>,d0
    1002:	2204           	move.l d4,d1
    1004:	4eae ff3a      	jsr -198(a6)
    1008:	2052           	movea.l (a2),a0
    100a:	2180 2800      	move.l d0,(0,a0,d2.l)
    100e:	6768           	beq.s 1078 <AllocPlayfieldMem+0xe0>
		if ((GameMatrix.Playfield_n1[i] = AllocMem(GameMatrix.Rows * sizeof(GameOfLifeCell), MEMF_ANY | MEMF_CLEAR)) == NULL)
    1010:	2c79 0000 475e 	movea.l 475e <SysBase>,a6
    1016:	7000           	moveq #0,d0
    1018:	3039 0000 47fc 	move.w 47fc <GameMatrix+0x8>,d0
    101e:	2204           	move.l d4,d1
    1020:	4eae ff3a      	jsr -198(a6)
    1024:	2079 0000 47f8 	movea.l 47f8 <GameMatrix+0x4>,a0
    102a:	2180 2800      	move.l d0,(0,a0,d2.l)
    102e:	6748           	beq.s 1078 <AllocPlayfieldMem+0xe0>
	for (int i = 0; i < GameMatrix.Columns; i++)
    1030:	5283           	addq.l #1,d3
    1032:	7000           	moveq #0,d0
    1034:	3039 0000 47fe 	move.w 47fe <GameMatrix+0xa>,d0
    103a:	5882           	addq.l #4,d2
    103c:	b083           	cmp.l d3,d0
    103e:	6eb4           	bgt.s ff4 <AllocPlayfieldMem+0x5c>
	UpdateList = AllocMem(GameMatrix.Columns * GameMatrix.Rows * sizeof(UpdateListEntry), MEMF_ANY | MEMF_CLEAR);
    1040:	7200           	moveq #0,d1
    1042:	3239 0000 47fc 	move.w 47fc <GameMatrix+0x8>,d1
    1048:	2f00           	move.l d0,-(sp)
    104a:	2f01           	move.l d1,-(sp)
    104c:	4eb9 0000 222c 	jsr 222c <__mulsi3>
    1052:	508f           	addq.l #8,sp
    1054:	2200           	move.l d0,d1
    1056:	d281           	add.l d1,d1
    1058:	d081           	add.l d1,d0
    105a:	2c79 0000 475e 	movea.l 475e <SysBase>,a6
    1060:	d080           	add.l d0,d0
    1062:	7201           	moveq #1,d1
    1064:	4841           	swap d1
    1066:	4eae ff3a      	jsr -198(a6)
    106a:	23c0 0000 4756 	move.l d0,4756 <UpdateList>
	return RETURN_OK;
    1070:	7000           	moveq #0,d0
}
    1072:	4cdf 441c      	movem.l (sp)+,d2-d4/a2/a6
    1076:	4e75           	rts
		return RETURN_FAIL;
    1078:	7014           	moveq #20,d0
}
    107a:	4cdf 441c      	movem.l (sp)+,d2-d4/a2/a6
    107e:	4e75           	rts
	for (int i = 0; i < GameMatrix.Columns; i++)
    1080:	7000           	moveq #0,d0
	UpdateList = AllocMem(GameMatrix.Columns * GameMatrix.Rows * sizeof(UpdateListEntry), MEMF_ANY | MEMF_CLEAR);
    1082:	7200           	moveq #0,d1
    1084:	3239 0000 47fc 	move.w 47fc <GameMatrix+0x8>,d1
    108a:	2f00           	move.l d0,-(sp)
    108c:	2f01           	move.l d1,-(sp)
    108e:	4eb9 0000 222c 	jsr 222c <__mulsi3>
    1094:	508f           	addq.l #8,sp
    1096:	2200           	move.l d0,d1
    1098:	d281           	add.l d1,d1
    109a:	d081           	add.l d1,d0
    109c:	2c79 0000 475e 	movea.l 475e <SysBase>,a6
    10a2:	d080           	add.l d0,d0
    10a4:	7201           	moveq #1,d1
    10a6:	4841           	swap d1
    10a8:	4eae ff3a      	jsr -198(a6)
    10ac:	23c0 0000 4756 	move.l d0,4756 <UpdateList>
	return RETURN_OK;
    10b2:	7000           	moveq #0,d0
    10b4:	60bc           	bra.s 1072 <AllocPlayfieldMem+0xda>

000010b6 <ToggleCellStatus>:
{
    10b6:	48e7 3020      	movem.l d2-d3/a2,-(sp)
    10ba:	262f 0014      	move.l 20(sp),d3
	int x = coordX / GameMatrix.CellSizeH + 1;
    10be:	7000           	moveq #0,d0
    10c0:	3039 0000 4804 	move.w 4804 <GameMatrix+0x10>,d0
    10c6:	45f9 0000 22aa 	lea 22aa <__divsi3>,a2
    10cc:	2f00           	move.l d0,-(sp)
    10ce:	306f 0016      	movea.w 22(sp),a0
    10d2:	2f08           	move.l a0,-(sp)
    10d4:	4e92           	jsr (a2)
    10d6:	508f           	addq.l #8,sp
    10d8:	2400           	move.l d0,d2
    10da:	5282           	addq.l #1,d2
	if (!(x < 0 || x > GameMatrix.Columns - 2 || y < 0 || y > GameMatrix.Rows - 2))
    10dc:	6b74           	bmi.s 1152 <ToggleCellStatus+0x9c>
    10de:	7000           	moveq #0,d0
    10e0:	3039 0000 47fe 	move.w 47fe <GameMatrix+0xa>,d0
    10e6:	5380           	subq.l #1,d0
    10e8:	b480           	cmp.l d0,d2
    10ea:	6c66           	bge.s 1152 <ToggleCellStatus+0x9c>
	int y = coordY / GameMatrix.CellSizeV + 1;
    10ec:	7000           	moveq #0,d0
    10ee:	3039 0000 4806 	move.w 4806 <GameMatrix+0x12>,d0
    10f4:	2f00           	move.l d0,-(sp)
    10f6:	3043           	movea.w d3,a0
    10f8:	2f08           	move.l a0,-(sp)
    10fa:	4e92           	jsr (a2)
    10fc:	508f           	addq.l #8,sp
    10fe:	5280           	addq.l #1,d0
	if (!(x < 0 || x > GameMatrix.Columns - 2 || y < 0 || y > GameMatrix.Rows - 2))
    1100:	6b50           	bmi.s 1152 <ToggleCellStatus+0x9c>
    1102:	7200           	moveq #0,d1
    1104:	3239 0000 47fc 	move.w 47fc <GameMatrix+0x8>,d1
    110a:	5381           	subq.l #1,d1
    110c:	b081           	cmp.l d1,d0
    110e:	6c42           	bge.s 1152 <ToggleCellStatus+0x9c>
		if (GameMatrix.Playfield[x][y].Status)
    1110:	2079 0000 47f4 	movea.l 47f4 <GameMatrix>,a0
    1116:	2202           	move.l d2,d1
    1118:	d282           	add.l d2,d1
    111a:	d281           	add.l d1,d1
    111c:	2270 1800      	movea.l (0,a0,d1.l),a1
    1120:	d3c0           	adda.l d0,a1
			UpdateList[UpdateCnt].X = x;
    1122:	3239 0000 476a 	move.w 476a <UpdateCnt>,d1
    1128:	7600           	moveq #0,d3
    112a:	3601           	move.w d1,d3
    112c:	2043           	movea.l d3,a0
    112e:	d1c3           	adda.l d3,a0
    1130:	d1c3           	adda.l d3,a0
    1132:	d1c8           	adda.l a0,a0
    1134:	d1f9 0000 4756 	adda.l 4756 <UpdateList>,a0
			UpdateCnt++;
    113a:	5241           	addq.w #1,d1
		if (GameMatrix.Playfield[x][y].Status)
    113c:	4a11           	tst.b (a1)
    113e:	6718           	beq.s 1158 <ToggleCellStatus+0xa2>
			GameMatrix.Playfield[x][y].Status = 0;
    1140:	4211           	clr.b (a1)
			UpdateList[UpdateCnt].X = x;
    1142:	3082           	move.w d2,(a0)
			UpdateList[UpdateCnt].Y = y;
    1144:	3140 0002      	move.w d0,2(a0)
			UpdateList[UpdateCnt].Status = 0;
    1148:	4268 0004      	clr.w 4(a0)
			UpdateCnt++;
    114c:	33c1 0000 476a 	move.w d1,476a <UpdateCnt>
}
    1152:	4cdf 040c      	movem.l (sp)+,d2-d3/a2
    1156:	4e75           	rts
			GameMatrix.Playfield[x][y].Status = 1;
    1158:	12bc 0001      	move.b #1,(a1)
			UpdateList[UpdateCnt].X = x;
    115c:	3082           	move.w d2,(a0)
			UpdateList[UpdateCnt].Y = y;
    115e:	3140 0002      	move.w d0,2(a0)
			UpdateList[UpdateCnt].Status = 1;
    1162:	317c 0001 0004 	move.w #1,4(a0)
			UpdateCnt++;
    1168:	33c1 0000 476a 	move.w d1,476a <UpdateCnt>
}
    116e:	4cdf 040c      	movem.l (sp)+,d2-d3/a2
    1172:	4e75           	rts

00001174 <RunPPG_Window.constprop.0>:

	return RETURN_OK;
}

void RunPPG_Window(RenderData *rd)
    1174:	4fef ff48      	lea -184(sp),sp
    1178:	48e7 303a      	movem.l d2-d3/a2-a4/a6,-(sp)
{
	GOLRenderData.PPG_Window = (struct Window *)OpenWindowTags(NULL,
    117c:	2f7c 8000 0070 	move.l #-2147483536,44(sp)
    1182:	002c 
    1184:	2079 0000 4776 	movea.l 4776 <GOLRenderData>,a0
    118a:	2f48 0030      	move.l a0,48(sp)
    118e:	2f7c 8000 0064 	move.l #-2147483548,52(sp)
    1194:	0034 
    1196:	42af 0038      	clr.l 56(sp)
    119a:	2f7c 8000 0065 	move.l #-2147483547,60(sp)
    11a0:	003c 
    11a2:	1028 001e      	move.b 30(a0),d0
    11a6:	4880           	ext.w d0
    11a8:	48c0           	ext.l d0
    11aa:	5280           	addq.l #1,d0
    11ac:	2f40 0040      	move.l d0,64(sp)
    11b0:	2f7c 8000 0066 	move.l #-2147483546,68(sp)
    11b6:	0044 
    11b8:	2f7c 0000 0096 	move.l #150,72(sp)
    11be:	0048 
    11c0:	2f7c 8000 0067 	move.l #-2147483545,76(sp)
    11c6:	004c 
    11c8:	7078           	moveq #120,d0
    11ca:	2f40 0050      	move.l d0,80(sp)
    11ce:	2f7c 8000 0074 	move.l #-2147483532,84(sp)
    11d4:	0054 
    11d6:	1028 0024      	move.b 36(a0),d0
    11da:	4880           	ext.w d0
    11dc:	327c 0280      	movea.w #640,a1
    11e0:	92c0           	suba.w d0,a1
    11e2:	1028 0025      	move.b 37(a0),d0
    11e6:	4880           	ext.w d0
    11e8:	92c0           	suba.w d0,a1
    11ea:	2f49 0058      	move.l a1,88(sp)
    11ee:	2f7c 8000 0075 	move.l #-2147483531,92(sp)
    11f4:	005c 
    11f6:	1028 0023      	move.b 35(a0),d0
    11fa:	4880           	ext.w d0
    11fc:	327c 0100      	movea.w #256,a1
    1200:	92c0           	suba.w d0,a1
    1202:	1028 0026      	move.b 38(a0),d0
    1206:	4880           	ext.w d0
    1208:	92c0           	suba.w d0,a1
    120a:	2f49 0060      	move.l a1,96(sp)
    120e:	2f7c 8000 006e 	move.l #-2147483538,100(sp)
    1214:	0064 
    1216:	2f7c 0000 2338 	move.l #9016,104(sp)
    121c:	0068 
    121e:	2f7c 8000 0083 	move.l #-2147483517,108(sp)
    1224:	006c 
    1226:	7201           	moveq #1,d1
    1228:	2f41 0070      	move.l d1,112(sp)
    122c:	2f7c 8000 0084 	move.l #-2147483516,116(sp)
    1232:	0074 
    1234:	2f41 0078      	move.l d1,120(sp)
    1238:	2f7c 8000 0081 	move.l #-2147483519,124(sp)
    123e:	007c 
    1240:	2f41 0080      	move.l d1,128(sp)
    1244:	2f7c 8000 0082 	move.l #-2147483518,132(sp)
    124a:	0084 
    124c:	2f41 0088      	move.l d1,136(sp)
    1250:	2f7c 8000 0091 	move.l #-2147483503,140(sp)
    1256:	008c 
    1258:	2f41 0090      	move.l d1,144(sp)
    125c:	2f7c 8000 0086 	move.l #-2147483514,148(sp)
    1262:	0094 
    1264:	2f41 0098      	move.l d1,152(sp)
    1268:	2f7c 8000 0093 	move.l #-2147483501,156(sp)
    126e:	009c 
    1270:	2f41 00a0      	move.l d1,160(sp)
    1274:	2f7c 8000 0089 	move.l #-2147483511,164(sp)
    127a:	00a4 
    127c:	2f41 00a8      	move.l d1,168(sp)
    1280:	2f7c 8000 006f 	move.l #-2147483537,172(sp)
    1286:	00ac 
    1288:	2f7c 0000 234b 	move.l #9035,176(sp)
    128e:	00b0 
    1290:	2f7c 8000 006a 	move.l #-2147483542,180(sp)
    1296:	00b4 
    1298:	2f7c 0000 031e 	move.l #798,184(sp)
    129e:	00b8 
    12a0:	2f7c 8000 0068 	move.l #-2147483544,188(sp)
    12a6:	00bc 
    12a8:	2f41 00c0      	move.l d1,192(sp)
    12ac:	2f7c 8000 0069 	move.l #-2147483543,196(sp)
    12b2:	00c4 
    12b4:	7002           	moveq #2,d0
    12b6:	2f40 00c8      	move.l d0,200(sp)
    12ba:	42af 00cc      	clr.l 204(sp)
    12be:	2c79 0000 4766 	movea.l 4766 <IntuitionBase>,a6
    12c4:	91c8           	suba.l a0,a0
    12c6:	43ef 002c      	lea 44(sp),a1
    12ca:	4eae fda2      	jsr -606(a6)
    12ce:	2040           	movea.l d0,a0
    12d0:	23c0 0000 477e 	move.l d0,477e <GOLRenderData+0x8>
															   WA_IDCMP, IDCMP_CLOSEWINDOW | IDCMP_MOUSEBUTTONS | IDCMP_MOUSEMOVE | IDCMP_MENUPICK | IDCMP_REFRESHWINDOW | IDCMP_NEWSIZE,
															   WA_DetailPen, 1,
															   WA_BlockPen, 2,
															   TAG_END);

	PPG_Frame = (struct Gadget *)NewObject(NULL, (STRPTR) "frameiclass",
    12d6:	2f7c 8003 0010 	move.l #-2147287024,44(sp)
    12dc:	002c 
    12de:	7201           	moveq #1,d1
    12e0:	2f41 0030      	move.l d1,48(sp)
    12e4:	2f7c 8003 001f 	move.l #-2147287009,52(sp)
    12ea:	0034 
    12ec:	42af 0038      	clr.l 56(sp)
    12f0:	2f7c 8003 0001 	move.l #-2147287039,60(sp)
    12f6:	003c 
    12f8:	1028 0036      	move.b 54(a0),d0
    12fc:	4880           	ext.w d0
    12fe:	3240           	movea.w d0,a1
    1300:	2f49 0040      	move.l a1,64(sp)
    1304:	2f7c 8003 0003 	move.l #-2147287037,68(sp)
    130a:	0044 
    130c:	1028 0037      	move.b 55(a0),d0
    1310:	4880           	ext.w d0
    1312:	3040           	movea.w d0,a0
    1314:	2f48 0048      	move.l a0,72(sp)
    1318:	2f7c 8003 0005 	move.l #-2147287035,76(sp)
    131e:	004c 
    1320:	7064           	moveq #100,d0
    1322:	2f40 0050      	move.l d0,80(sp)
    1326:	2f7c 8003 0007 	move.l #-2147287033,84(sp)
    132c:	0054 
    132e:	7278           	moveq #120,d1
    1330:	2f41 0058      	move.l d1,88(sp)
    1334:	42af 005c      	clr.l 92(sp)
    1338:	2c79 0000 4766 	movea.l 4766 <IntuitionBase>,a6
    133e:	91c8           	suba.l a0,a0
    1340:	43f9 0000 236d 	lea 236d <PutChar+0x39>,a1
    1346:	45ef 002c      	lea 44(sp),a2
    134a:	4eae fd84      	jsr -636(a6)
										   GA_Top, GOLRenderData.PPG_Window->BorderTop,
										   GA_WIDTH, 100,
										   GA_HEIGHT, 120,
										   TAG_END);

	WORD points[] = {0, 0, 51, 0, 51, 13, 0, 13, 0, 0};
    134e:	426f 0018      	clr.w 24(sp)
    1352:	426f 001a      	clr.w 26(sp)
    1356:	3f7c 0033 001c 	move.w #51,28(sp)
    135c:	426f 001e      	clr.w 30(sp)
    1360:	3f7c 0033 0020 	move.w #51,32(sp)
    1366:	3f7c 000d 0022 	move.w #13,34(sp)
    136c:	426f 0024      	clr.w 36(sp)
    1370:	3f7c 000d 0026 	move.w #13,38(sp)
    1376:	426f 0028      	clr.w 40(sp)
    137a:	426f 002a      	clr.w 42(sp)
	PPG_Border.DrawMode = JAM1;
	PPG_Border.FrontPen = 1;
    137e:	49f9 0000 473c 	lea 473c <PPG_Border>,a4
    1384:	13fc 0001 0000 	move.b #1,4740 <PPG_Border+0x4>
    138a:	4740 
	PPG_Border.LeftEdge = -1;
    138c:	72ff           	moveq #-1,d1
    138e:	2881           	move.l d1,(a4)
	PPG_Border.DrawMode = JAM1;
    1390:	33fc 0005 0000 	move.w #5,4742 <PPG_Border+0x6>
    1396:	4742 
	PPG_Border.TopEdge = -1;
	PPG_Border.Count = 5;
	PPG_Border.XY = points;
    1398:	7218           	moveq #24,d1
    139a:	d28f           	add.l sp,d1
    139c:	23c1 0000 4744 	move.l d1,4744 <PPG_Border+0x8>

	PPG_StrgWidth = (struct Gadget *)NewObject(NULL, (STRPTR) "strgclass",
    13a2:	2f7c 8003 0010 	move.l #-2147287024,44(sp)
    13a8:	002c 
    13aa:	7203           	moveq #3,d1
    13ac:	2f41 0030      	move.l d1,48(sp)
    13b0:	2f7c 8003 001f 	move.l #-2147287009,52(sp)
    13b6:	0034 
    13b8:	2f40 0038      	move.l d0,56(sp)
    13bc:	2f7c 8003 0001 	move.l #-2147287039,60(sp)
    13c2:	003c 
    13c4:	7005           	moveq #5,d0
    13c6:	2f40 0040      	move.l d0,64(sp)
    13ca:	2f7c 8003 000b 	move.l #-2147287029,68(sp)
    13d0:	0044 
    13d2:	2f4c 0048      	move.l a4,72(sp)
    13d6:	2f7c 8003 0003 	move.l #-2147287037,76(sp)
    13dc:	004c 
    13de:	2f40 0050      	move.l d0,80(sp)
    13e2:	2f7c 8003 0005 	move.l #-2147287035,84(sp)
    13e8:	0054 
    13ea:	7232           	moveq #50,d1
    13ec:	2f41 0058      	move.l d1,88(sp)
    13f0:	2f7c 8003 0007 	move.l #-2147287033,92(sp)
    13f6:	005c 
    13f8:	700c           	moveq #12,d0
    13fa:	2f40 0060      	move.l d0,96(sp)
    13fe:	2f7c 8003 2010 	move.l #-2147278832,100(sp)
    1404:	0064 
    1406:	7202           	moveq #2,d1
    1408:	2f41 0068      	move.l d1,104(sp)
    140c:	2f7c 8003 2011 	move.l #-2147278831,108(sp)
    1412:	006c 
    1414:	2079 0000 477a 	movea.l 477a <GOLRenderData+0x4>,a0
    141a:	3068 0008      	movea.w 8(a0),a0
    141e:	2f48 0070      	move.l a0,112(sp)
    1422:	2f7c 8003 2001 	move.l #-2147278847,116(sp)
    1428:	0074 
    142a:	7004           	moveq #4,d0
    142c:	2f40 0078      	move.l d0,120(sp)
    1430:	42af 007c      	clr.l 124(sp)
    1434:	2c79 0000 4766 	movea.l 4766 <IntuitionBase>,a6
    143a:	91c8           	suba.l a0,a0
    143c:	43f9 0000 2379 	lea 2379 <PutChar+0x45>,a1
    1442:	4eae fd84      	jsr -636(a6)
    1446:	23c0 0000 4738 	move.l d0,4738 <PPG_StrgWidth>
											   STRINGA_Justification, GTJ_CENTER,
											   STRINGA_LongVal, GOLRenderData.MainWindow->Width,
											   STRINGA_MaxChars, 4,
											   TAG_END);

	PPG_PropWidth = (struct Gadget *)NewObject(NULL, (STRPTR) "propgclass",
    144c:	2f7c 8003 0010 	move.l #-2147287024,44(sp)
    1452:	002c 
    1454:	7202           	moveq #2,d1
    1456:	2f41 0030      	move.l d1,48(sp)
    145a:	2f7c 8003 001f 	move.l #-2147287009,52(sp)
    1460:	0034 
    1462:	2f40 0038      	move.l d0,56(sp)
    1466:	2f7c 8004 0001 	move.l #-2147221503,60(sp)
    146c:	003c 
    146e:	2f40 0040      	move.l d0,64(sp)
    1472:	2f7c 8004 0002 	move.l #-2147221502,68(sp)
    1478:	0044 
    147a:	263c 0000 4500 	move.l #17664,d3
    1480:	2f43 0048      	move.l d3,72(sp)
    1484:	2f7c 8003 0001 	move.l #-2147287039,76(sp)
    148a:	004c 
    148c:	7005           	moveq #5,d0
    148e:	2f40 0050      	move.l d0,80(sp)
    1492:	2f7c 8003 0003 	move.l #-2147287037,84(sp)
    1498:	0054 
    149a:	7215           	moveq #21,d1
    149c:	2f41 0058      	move.l d1,88(sp)
    14a0:	2f7c 8003 0005 	move.l #-2147287035,92(sp)
    14a6:	005c 
    14a8:	7032           	moveq #50,d0
    14aa:	2f40 0060      	move.l d0,96(sp)
    14ae:	2f7c 8003 0007 	move.l #-2147287033,100(sp)
    14b4:	0064 
    14b6:	720c           	moveq #12,d1
    14b8:	2f41 0068      	move.l d1,104(sp)
    14bc:	2f7c 8003 100a 	move.l #-2147282934,108(sp)
    14c2:	006c 
    14c4:	7001           	moveq #1,d0
    14c6:	2f40 0070      	move.l d0,112(sp)
    14ca:	2f7c 8003 1001 	move.l #-2147282943,116(sp)
    14d0:	0074 
    14d2:	7202           	moveq #2,d1
    14d4:	2f41 0078      	move.l d1,120(sp)
    14d8:	2f7c 8003 1009 	move.l #-2147282935,124(sp)
    14de:	007c 
    14e0:	2079 0000 477a 	movea.l 477a <GOLRenderData+0x4>,a0
    14e6:	3068 0008      	movea.w 8(a0),a0
    14ea:	2f48 0080      	move.l a0,128(sp)
    14ee:	2f7c 8003 1007 	move.l #-2147282937,132(sp)
    14f4:	0084 
    14f6:	2f7c 0000 0281 	move.l #641,136(sp)
    14fc:	0088 
    14fe:	2f7c 8003 1008 	move.l #-2147282936,140(sp)
    1504:	008c 
    1506:	2f40 0090      	move.l d0,144(sp)
    150a:	42af 0094      	clr.l 148(sp)
    150e:	2c79 0000 4766 	movea.l 4766 <IntuitionBase>,a6
    1514:	91c8           	suba.l a0,a0
    1516:	43f9 0000 2383 	lea 2383 <PutChar+0x4f>,a1
    151c:	4eae fd84      	jsr -636(a6)
    1520:	23c0 0000 4734 	move.l d0,4734 <PPG_PropWidth>
											   PGA_Top, GOLRenderData.MainWindow->Width,
											   PGA_Total, ScreenW + 1,
											   PGA_VISIBLE, 1,
											   TAG_END);

	SetGadgetAttrs(PPG_StrgWidth, GOLRenderData.PPG_Window, NULL,
    1526:	2f7c 8004 0001 	move.l #-2147221503,44(sp)
    152c:	002c 
    152e:	2f40 0030      	move.l d0,48(sp)
    1532:	2f7c 8004 0002 	move.l #-2147221502,52(sp)
    1538:	0034 
    153a:	243c 0000 44f0 	move.l #17648,d2
    1540:	2f42 0038      	move.l d2,56(sp)
    1544:	42af 003c      	clr.l 60(sp)
    1548:	2c79 0000 4766 	movea.l 4766 <IntuitionBase>,a6
    154e:	2079 0000 4738 	movea.l 4738 <PPG_StrgWidth>,a0
    1554:	2279 0000 477e 	movea.l 477e <GOLRenderData+0x8>,a1
    155a:	95ca           	suba.l a2,a2
    155c:	47ef 002c      	lea 44(sp),a3
    1560:	4eae fd6c      	jsr -660(a6)
				   ICA_TARGET, (ULONG)PPG_PropWidth,
				   ICA_MAP, (ULONG)SliderToString,
				   TAG_END);

	PPG_StrgHeight = (struct Gadget *)NewObject(NULL, (STRPTR) "strgclass",
    1564:	2f7c 8003 0010 	move.l #-2147287024,44(sp)
    156a:	002c 
    156c:	7005           	moveq #5,d0
    156e:	2f40 0030      	move.l d0,48(sp)
    1572:	2f7c 8003 001f 	move.l #-2147287009,52(sp)
    1578:	0034 
    157a:	2f79 0000 4734 	move.l 4734 <PPG_PropWidth>,56(sp)
    1580:	0038 
    1582:	2f7c 8003 0001 	move.l #-2147287039,60(sp)
    1588:	003c 
    158a:	723c           	moveq #60,d1
    158c:	2f41 0040      	move.l d1,64(sp)
    1590:	2f7c 8003 0003 	move.l #-2147287037,68(sp)
    1596:	0044 
    1598:	2f40 0048      	move.l d0,72(sp)
    159c:	2f7c 8003 0005 	move.l #-2147287035,76(sp)
    15a2:	004c 
    15a4:	7032           	moveq #50,d0
    15a6:	2f40 0050      	move.l d0,80(sp)
    15aa:	2f7c 8003 0007 	move.l #-2147287033,84(sp)
    15b0:	0054 
    15b2:	720c           	moveq #12,d1
    15b4:	2f41 0058      	move.l d1,88(sp)
    15b8:	2f7c 8003 000b 	move.l #-2147287029,92(sp)
    15be:	005c 
    15c0:	2f4c 0060      	move.l a4,96(sp)
    15c4:	2f7c 8003 2011 	move.l #-2147278831,100(sp)
    15ca:	0064 
    15cc:	2079 0000 477a 	movea.l 477a <GOLRenderData+0x4>,a0
    15d2:	3068 000a      	movea.w 10(a0),a0
    15d6:	2f48 0068      	move.l a0,104(sp)
    15da:	2f7c 8003 2001 	move.l #-2147278847,108(sp)
    15e0:	006c 
    15e2:	7004           	moveq #4,d0
    15e4:	2f40 0070      	move.l d0,112(sp)
    15e8:	42af 0074      	clr.l 116(sp)
    15ec:	2c79 0000 4766 	movea.l 4766 <IntuitionBase>,a6
    15f2:	91c8           	suba.l a0,a0
    15f4:	43f9 0000 2379 	lea 2379 <PutChar+0x45>,a1
    15fa:	244b           	movea.l a3,a2
    15fc:	4eae fd84      	jsr -636(a6)
    1600:	23c0 0000 4730 	move.l d0,4730 <PPG_StrgHeight>
												GA_BORDER, (ULONG)&PPG_Border,
												STRINGA_LongVal, GOLRenderData.MainWindow->Height,
												STRINGA_MaxChars, 4,
												TAG_END);

	PPG_PropHeight = (struct Gadget *)NewObject(NULL, (STRPTR) "propgclass",
    1606:	2f7c 8003 0010 	move.l #-2147287024,44(sp)
    160c:	002c 
    160e:	7204           	moveq #4,d1
    1610:	2f41 0030      	move.l d1,48(sp)
    1614:	2f7c 8003 001f 	move.l #-2147287009,52(sp)
    161a:	0034 
    161c:	2f40 0038      	move.l d0,56(sp)
    1620:	2f7c 8003 0001 	move.l #-2147287039,60(sp)
    1626:	003c 
    1628:	723c           	moveq #60,d1
    162a:	2f41 0040      	move.l d1,64(sp)
    162e:	2f7c 8003 0003 	move.l #-2147287037,68(sp)
    1634:	0044 
    1636:	7215           	moveq #21,d1
    1638:	2f41 0048      	move.l d1,72(sp)
    163c:	2f7c 8003 0005 	move.l #-2147287035,76(sp)
    1642:	004c 
    1644:	7232           	moveq #50,d1
    1646:	2f41 0050      	move.l d1,80(sp)
    164a:	2f7c 8003 0007 	move.l #-2147287033,84(sp)
    1650:	0054 
    1652:	720c           	moveq #12,d1
    1654:	2f41 0058      	move.l d1,88(sp)
    1658:	2f7c 8003 1008 	move.l #-2147282936,92(sp)
    165e:	005c 
    1660:	7201           	moveq #1,d1
    1662:	2f41 0060      	move.l d1,96(sp)
    1666:	2f7c 8003 1007 	move.l #-2147282937,100(sp)
    166c:	0064 
    166e:	2f7c 0000 0101 	move.l #257,104(sp)
    1674:	0068 
    1676:	2f7c 8003 1009 	move.l #-2147282935,108(sp)
    167c:	006c 
    167e:	2079 0000 477a 	movea.l 477a <GOLRenderData+0x4>,a0
    1684:	3068 000a      	movea.w 10(a0),a0
    1688:	2f48 0070      	move.l a0,112(sp)
    168c:	2f7c 8003 100a 	move.l #-2147282934,116(sp)
    1692:	0074 
    1694:	2f41 0078      	move.l d1,120(sp)
    1698:	2f7c 8003 1001 	move.l #-2147282943,124(sp)
    169e:	007c 
    16a0:	7202           	moveq #2,d1
    16a2:	2f41 0080      	move.l d1,128(sp)
    16a6:	2f7c 8004 0001 	move.l #-2147221503,132(sp)
    16ac:	0084 
    16ae:	2f40 0088      	move.l d0,136(sp)
    16b2:	2f7c 8004 0002 	move.l #-2147221502,140(sp)
    16b8:	008c 
    16ba:	2f43 0090      	move.l d3,144(sp)
    16be:	42af 0094      	clr.l 148(sp)
    16c2:	2c79 0000 4766 	movea.l 4766 <IntuitionBase>,a6
    16c8:	91c8           	suba.l a0,a0
    16ca:	43f9 0000 2383 	lea 2383 <PutChar+0x4f>,a1
    16d0:	4eae fd84      	jsr -636(a6)
    16d4:	23c0 0000 472c 	move.l d0,472c <PPG_PropHeight>
												PGA_FREEDOM, FREEHORIZ,
												ICA_TARGET, (ULONG)PPG_StrgHeight,
												ICA_MAP, (ULONG)StringToSlider,
												TAG_END);

	SetGadgetAttrs(PPG_StrgHeight, GOLRenderData.PPG_Window, NULL,
    16da:	2f7c 8004 0001 	move.l #-2147221503,44(sp)
    16e0:	002c 
    16e2:	2f40 0030      	move.l d0,48(sp)
    16e6:	2f7c 8004 0002 	move.l #-2147221502,52(sp)
    16ec:	0034 
    16ee:	2f42 0038      	move.l d2,56(sp)
    16f2:	42af 003c      	clr.l 60(sp)
    16f6:	2c79 0000 4766 	movea.l 4766 <IntuitionBase>,a6
    16fc:	2079 0000 4730 	movea.l 4730 <PPG_StrgHeight>,a0
    1702:	2279 0000 477e 	movea.l 477e <GOLRenderData+0x8>,a1
    1708:	95ca           	suba.l a2,a2
    170a:	4eae fd6c      	jsr -660(a6)
				   ICA_TARGET, (ULONG)PPG_PropHeight,
				   ICA_MAP, (ULONG)SliderToString,
				   TAG_END);

	PPG_StrgCellWidth = (struct Gadget *)NewObject(NULL, (STRPTR) "strgclass",
    170e:	2f7c 8003 0010 	move.l #-2147287024,44(sp)
    1714:	002c 
    1716:	7008           	moveq #8,d0
    1718:	2f40 0030      	move.l d0,48(sp)
    171c:	2f7c 8003 001f 	move.l #-2147287009,52(sp)
    1722:	0034 
    1724:	2f79 0000 472c 	move.l 472c <PPG_PropHeight>,56(sp)
    172a:	0038 
    172c:	2f7c 8003 0001 	move.l #-2147287039,60(sp)
    1732:	003c 
    1734:	7205           	moveq #5,d1
    1736:	2f41 0040      	move.l d1,64(sp)
    173a:	2f7c 8003 0003 	move.l #-2147287037,68(sp)
    1740:	0044 
    1742:	7025           	moveq #37,d0
    1744:	2f40 0048      	move.l d0,72(sp)
    1748:	2f7c 8003 0005 	move.l #-2147287035,76(sp)
    174e:	004c 
    1750:	7232           	moveq #50,d1
    1752:	2f41 0050      	move.l d1,80(sp)
    1756:	2f7c 8003 0007 	move.l #-2147287033,84(sp)
    175c:	0054 
    175e:	700c           	moveq #12,d0
    1760:	2f40 0058      	move.l d0,88(sp)
    1764:	2f7c 8003 000b 	move.l #-2147287029,92(sp)
    176a:	005c 
    176c:	2f4c 0060      	move.l a4,96(sp)
    1770:	2f7c 8003 2011 	move.l #-2147278831,100(sp)
    1776:	0064 
    1778:	7000           	moveq #0,d0
    177a:	3039 0000 4804 	move.w 4804 <GameMatrix+0x10>,d0
    1780:	2f40 0068      	move.l d0,104(sp)
    1784:	2f7c 8003 2001 	move.l #-2147278847,108(sp)
    178a:	006c 
    178c:	7204           	moveq #4,d1
    178e:	2f41 0070      	move.l d1,112(sp)
    1792:	42af 0074      	clr.l 116(sp)
    1796:	2c79 0000 4766 	movea.l 4766 <IntuitionBase>,a6
    179c:	91c8           	suba.l a0,a0
    179e:	43f9 0000 2379 	lea 2379 <PutChar+0x45>,a1
    17a4:	244b           	movea.l a3,a2
    17a6:	4eae fd84      	jsr -636(a6)
    17aa:	23c0 0000 4728 	move.l d0,4728 <PPG_StrgCellWidth>
												   GA_BORDER, (ULONG)&PPG_Border,
												   STRINGA_LongVal, GameMatrix.CellSizeH,
												   STRINGA_MaxChars, 4,
												   TAG_END);

	PPG_PropCellWidth = (struct Gadget *)NewObject(NULL, (STRPTR) "propgclass",
    17b0:	2f7c 8003 0010 	move.l #-2147287024,44(sp)
    17b6:	002c 
    17b8:	7206           	moveq #6,d1
    17ba:	2f41 0030      	move.l d1,48(sp)
    17be:	2f7c 8003 001f 	move.l #-2147287009,52(sp)
    17c4:	0034 
    17c6:	2f40 0038      	move.l d0,56(sp)
    17ca:	2f7c 8003 0001 	move.l #-2147287039,60(sp)
    17d0:	003c 
    17d2:	7205           	moveq #5,d1
    17d4:	2f41 0040      	move.l d1,64(sp)
    17d8:	2f7c 8003 0003 	move.l #-2147287037,68(sp)
    17de:	0044 
    17e0:	7235           	moveq #53,d1
    17e2:	2f41 0048      	move.l d1,72(sp)
    17e6:	2f7c 8003 0005 	move.l #-2147287035,76(sp)
    17ec:	004c 
    17ee:	7232           	moveq #50,d1
    17f0:	2f41 0050      	move.l d1,80(sp)
    17f4:	2f7c 8003 0007 	move.l #-2147287033,84(sp)
    17fa:	0054 
    17fc:	720c           	moveq #12,d1
    17fe:	2f41 0058      	move.l d1,88(sp)
    1802:	2f7c 8003 100a 	move.l #-2147282934,92(sp)
    1808:	005c 
    180a:	7201           	moveq #1,d1
    180c:	2f41 0060      	move.l d1,96(sp)
    1810:	2f7c 8003 1001 	move.l #-2147282943,100(sp)
    1816:	0064 
    1818:	7202           	moveq #2,d1
    181a:	2f41 0068      	move.l d1,104(sp)
    181e:	2f7c 8003 1008 	move.l #-2147282936,108(sp)
    1824:	006c 
    1826:	7201           	moveq #1,d1
    1828:	2f41 0070      	move.l d1,112(sp)
    182c:	2f7c 8003 1007 	move.l #-2147282937,116(sp)
    1832:	0074 
    1834:	7215           	moveq #21,d1
    1836:	2f41 0078      	move.l d1,120(sp)
    183a:	2f7c 8003 1009 	move.l #-2147282935,124(sp)
    1840:	007c 
    1842:	7200           	moveq #0,d1
    1844:	3239 0000 4804 	move.w 4804 <GameMatrix+0x10>,d1
    184a:	2f41 0080      	move.l d1,128(sp)
    184e:	2f7c 8004 0001 	move.l #-2147221503,132(sp)
    1854:	0084 
    1856:	2f40 0088      	move.l d0,136(sp)
    185a:	2f7c 8004 0002 	move.l #-2147221502,140(sp)
    1860:	008c 
    1862:	2f43 0090      	move.l d3,144(sp)
    1866:	42af 0094      	clr.l 148(sp)
    186a:	2c79 0000 4766 	movea.l 4766 <IntuitionBase>,a6
    1870:	91c8           	suba.l a0,a0
    1872:	43f9 0000 2383 	lea 2383 <PutChar+0x4f>,a1
    1878:	4eae fd84      	jsr -636(a6)
    187c:	23c0 0000 4724 	move.l d0,4724 <PPG_PropCellWidth>
												   PGA_TOP, GameMatrix.CellSizeH,
												   ICA_TARGET, (ULONG)PPG_StrgCellWidth,
												   ICA_MAP, (ULONG)StringToSlider,
												   TAG_END);

	SetGadgetAttrs(PPG_StrgCellWidth, GOLRenderData.PPG_Window, NULL,
    1882:	2f7c 8004 0001 	move.l #-2147221503,44(sp)
    1888:	002c 
    188a:	2f40 0030      	move.l d0,48(sp)
    188e:	2f7c 8004 0002 	move.l #-2147221502,52(sp)
    1894:	0034 
    1896:	2f42 0038      	move.l d2,56(sp)
    189a:	42af 003c      	clr.l 60(sp)
    189e:	2c79 0000 4766 	movea.l 4766 <IntuitionBase>,a6
    18a4:	2079 0000 4728 	movea.l 4728 <PPG_StrgCellWidth>,a0
    18aa:	2279 0000 477e 	movea.l 477e <GOLRenderData+0x8>,a1
    18b0:	95ca           	suba.l a2,a2
    18b2:	4eae fd6c      	jsr -660(a6)
				   ICA_TARGET, (ULONG)PPG_PropCellWidth,
				   ICA_MAP, (ULONG)SliderToString,
				   TAG_END);

	PPG_StrgCellHeight = (struct Gadget *)NewObject(NULL, (STRPTR) "strgclass",
    18b6:	2f7c 8003 0010 	move.l #-2147287024,44(sp)
    18bc:	002c 
    18be:	7009           	moveq #9,d0
    18c0:	2f40 0030      	move.l d0,48(sp)
    18c4:	2f7c 8003 001f 	move.l #-2147287009,52(sp)
    18ca:	0034 
    18cc:	2f79 0000 4724 	move.l 4724 <PPG_PropCellWidth>,56(sp)
    18d2:	0038 
    18d4:	2f7c 8003 0001 	move.l #-2147287039,60(sp)
    18da:	003c 
    18dc:	723c           	moveq #60,d1
    18de:	2f41 0040      	move.l d1,64(sp)
    18e2:	2f7c 8003 0003 	move.l #-2147287037,68(sp)
    18e8:	0044 
    18ea:	7025           	moveq #37,d0
    18ec:	2f40 0048      	move.l d0,72(sp)
    18f0:	2f7c 8003 0005 	move.l #-2147287035,76(sp)
    18f6:	004c 
    18f8:	7232           	moveq #50,d1
    18fa:	2f41 0050      	move.l d1,80(sp)
    18fe:	2f7c 8003 0007 	move.l #-2147287033,84(sp)
    1904:	0054 
    1906:	700c           	moveq #12,d0
    1908:	2f40 0058      	move.l d0,88(sp)
    190c:	2f7c 8003 000b 	move.l #-2147287029,92(sp)
    1912:	005c 
    1914:	2f4c 0060      	move.l a4,96(sp)
    1918:	2f7c 8003 2011 	move.l #-2147278831,100(sp)
    191e:	0064 
    1920:	7000           	moveq #0,d0
    1922:	3039 0000 4806 	move.w 4806 <GameMatrix+0x12>,d0
    1928:	2f40 0068      	move.l d0,104(sp)
    192c:	2f7c 8003 2001 	move.l #-2147278847,108(sp)
    1932:	006c 
    1934:	7204           	moveq #4,d1
    1936:	2f41 0070      	move.l d1,112(sp)
    193a:	42af 0074      	clr.l 116(sp)
    193e:	2c79 0000 4766 	movea.l 4766 <IntuitionBase>,a6
    1944:	91c8           	suba.l a0,a0
    1946:	43f9 0000 2379 	lea 2379 <PutChar+0x45>,a1
    194c:	244b           	movea.l a3,a2
    194e:	4eae fd84      	jsr -636(a6)
    1952:	23c0 0000 4720 	move.l d0,4720 <PPG_StrgCellHeight>
													GA_BORDER, (ULONG)&PPG_Border,
													STRINGA_LongVal, GameMatrix.CellSizeV,
													STRINGA_MaxChars, 4,
													TAG_END);

	PPG_PropCellHeight = (struct Gadget *)NewObject(NULL, (STRPTR) "propgclass",
    1958:	2f7c 8003 0010 	move.l #-2147287024,44(sp)
    195e:	002c 
    1960:	7207           	moveq #7,d1
    1962:	2f41 0030      	move.l d1,48(sp)
    1966:	2f7c 8003 001f 	move.l #-2147287009,52(sp)
    196c:	0034 
    196e:	2f40 0038      	move.l d0,56(sp)
    1972:	2f7c 8003 0001 	move.l #-2147287039,60(sp)
    1978:	003c 
    197a:	723c           	moveq #60,d1
    197c:	2f41 0040      	move.l d1,64(sp)
    1980:	2f7c 8003 0003 	move.l #-2147287037,68(sp)
    1986:	0044 
    1988:	7235           	moveq #53,d1
    198a:	2f41 0048      	move.l d1,72(sp)
    198e:	2f7c 8003 0005 	move.l #-2147287035,76(sp)
    1994:	004c 
    1996:	7232           	moveq #50,d1
    1998:	2f41 0050      	move.l d1,80(sp)
    199c:	2f7c 8003 0007 	move.l #-2147287033,84(sp)
    19a2:	0054 
    19a4:	720c           	moveq #12,d1
    19a6:	2f41 0058      	move.l d1,88(sp)
    19aa:	2f7c 8003 100a 	move.l #-2147282934,92(sp)
    19b0:	005c 
    19b2:	7201           	moveq #1,d1
    19b4:	2f41 0060      	move.l d1,96(sp)
    19b8:	2f7c 8003 1001 	move.l #-2147282943,100(sp)
    19be:	0064 
    19c0:	7202           	moveq #2,d1
    19c2:	2f41 0068      	move.l d1,104(sp)
    19c6:	2f7c 8003 1008 	move.l #-2147282936,108(sp)
    19cc:	006c 
    19ce:	7201           	moveq #1,d1
    19d0:	2f41 0070      	move.l d1,112(sp)
    19d4:	2f7c 8003 1007 	move.l #-2147282937,116(sp)
    19da:	0074 
    19dc:	7215           	moveq #21,d1
    19de:	2f41 0078      	move.l d1,120(sp)
    19e2:	2f7c 8003 1009 	move.l #-2147282935,124(sp)
    19e8:	007c 
    19ea:	7200           	moveq #0,d1
    19ec:	3239 0000 4806 	move.w 4806 <GameMatrix+0x12>,d1
    19f2:	2f41 0080      	move.l d1,128(sp)
    19f6:	2f7c 8004 0001 	move.l #-2147221503,132(sp)
    19fc:	0084 
    19fe:	2f40 0088      	move.l d0,136(sp)
    1a02:	2f7c 8004 0002 	move.l #-2147221502,140(sp)
    1a08:	008c 
    1a0a:	2f43 0090      	move.l d3,144(sp)
    1a0e:	42af 0094      	clr.l 148(sp)
    1a12:	2c79 0000 4766 	movea.l 4766 <IntuitionBase>,a6
    1a18:	91c8           	suba.l a0,a0
    1a1a:	43f9 0000 2383 	lea 2383 <PutChar+0x4f>,a1
    1a20:	4eae fd84      	jsr -636(a6)
    1a24:	23c0 0000 471c 	move.l d0,471c <PPG_PropCellHeight>
													PGA_TOP, GameMatrix.CellSizeV,
													ICA_TARGET, (ULONG)PPG_StrgCellHeight,
													ICA_MAP, (ULONG)StringToSlider,
													TAG_END);

	SetGadgetAttrs(PPG_StrgCellHeight, GOLRenderData.PPG_Window, NULL,
    1a2a:	2f7c 8004 0001 	move.l #-2147221503,44(sp)
    1a30:	002c 
    1a32:	2f40 0030      	move.l d0,48(sp)
    1a36:	2f7c 8004 0002 	move.l #-2147221502,52(sp)
    1a3c:	0034 
    1a3e:	2f42 0038      	move.l d2,56(sp)
    1a42:	42af 003c      	clr.l 60(sp)
    1a46:	2c79 0000 4766 	movea.l 4766 <IntuitionBase>,a6
    1a4c:	2079 0000 4720 	movea.l 4720 <PPG_StrgCellHeight>,a0
    1a52:	2279 0000 477e 	movea.l 477e <GOLRenderData+0x8>,a1
    1a58:	95ca           	suba.l a2,a2
    1a5a:	4eae fd6c      	jsr -660(a6)
				   ICA_TARGET, (ULONG)PPG_PropCellHeight,
				   ICA_MAP, (ULONG)SliderToString,
				   TAG_END);

	PPG_ButtonOk = (struct Gadget *)NewObject(NULL, (STRPTR) "buttongclass",
    1a5e:	2f7c 8003 0010 	move.l #-2147287024,44(sp)
    1a64:	002c 
    1a66:	700a           	moveq #10,d0
    1a68:	2f40 0030      	move.l d0,48(sp)
    1a6c:	2f7c 8003 001f 	move.l #-2147287009,52(sp)
    1a72:	0034 
    1a74:	2f79 0000 471c 	move.l 471c <PPG_PropCellHeight>,56(sp)
    1a7a:	0038 
    1a7c:	2f7c 8003 000b 	move.l #-2147287029,60(sp)
    1a82:	003c 
    1a84:	2f4c 0040      	move.l a4,64(sp)
    1a88:	2f7c 8003 0001 	move.l #-2147287039,68(sp)
    1a8e:	0044 
    1a90:	7205           	moveq #5,d1
    1a92:	2f41 0048      	move.l d1,72(sp)
    1a96:	2f7c 8003 0003 	move.l #-2147287037,76(sp)
    1a9c:	004c 
    1a9e:	7050           	moveq #80,d0
    1aa0:	2f40 0050      	move.l d0,80(sp)
    1aa4:	2f7c 8003 0005 	move.l #-2147287035,84(sp)
    1aaa:	0054 
    1aac:	7232           	moveq #50,d1
    1aae:	2f41 0058      	move.l d1,88(sp)
    1ab2:	2f7c 8003 0007 	move.l #-2147287033,92(sp)
    1ab8:	005c 
    1aba:	7010           	moveq #16,d0
    1abc:	2f40 0060      	move.l d0,96(sp)
    1ac0:	42af 0064      	clr.l 100(sp)
    1ac4:	2c79 0000 4766 	movea.l 4766 <IntuitionBase>,a6
    1aca:	91c8           	suba.l a0,a0
    1acc:	43f9 0000 238e 	lea 238e <PutChar+0x5a>,a1
    1ad2:	244b           	movea.l a3,a2
    1ad4:	4eae fd84      	jsr -636(a6)
											  GA_Top, 80,
											  GA_WIDTH, 50,
											  GA_HEIGHT, 16,
											  TAG_END);

	PPG_ButtonCancel = (struct Gadget *)NewObject(NULL, (STRPTR) "buttongclass",
    1ad8:	2f7c 8003 0010 	move.l #-2147287024,44(sp)
    1ade:	002c 
    1ae0:	720b           	moveq #11,d1
    1ae2:	2f41 0030      	move.l d1,48(sp)
    1ae6:	2f7c 8003 001f 	move.l #-2147287009,52(sp)
    1aec:	0034 
    1aee:	2f40 0038      	move.l d0,56(sp)
    1af2:	2f7c 8003 0001 	move.l #-2147287039,60(sp)
    1af8:	003c 
    1afa:	703c           	moveq #60,d0
    1afc:	2f40 0040      	move.l d0,64(sp)
    1b00:	2f7c 8003 0003 	move.l #-2147287037,68(sp)
    1b06:	0044 
    1b08:	7250           	moveq #80,d1
    1b0a:	2f41 0048      	move.l d1,72(sp)
    1b0e:	2f7c 8003 0005 	move.l #-2147287035,76(sp)
    1b14:	004c 
    1b16:	7032           	moveq #50,d0
    1b18:	2f40 0050      	move.l d0,80(sp)
    1b1c:	2f7c 8003 0007 	move.l #-2147287033,84(sp)
    1b22:	0054 
    1b24:	7210           	moveq #16,d1
    1b26:	2f41 0058      	move.l d1,88(sp)
    1b2a:	2f7c 8003 0009 	move.l #-2147287031,92(sp)
    1b30:	005c 
    1b32:	2f7c 0000 239b 	move.l #9115,96(sp)
    1b38:	0060 
    1b3a:	42af 0064      	clr.l 100(sp)
    1b3e:	2c79 0000 4766 	movea.l 4766 <IntuitionBase>,a6
    1b44:	91c8           	suba.l a0,a0
    1b46:	43f9 0000 238e 	lea 238e <PutChar+0x5a>,a1
    1b4c:	4eae fd84      	jsr -636(a6)
												  GA_WIDTH, 50,
												  GA_HEIGHT, 16,
												  GA_TEXT, (ULONG) "Cancel",
												  TAG_END);

	AddGList(GOLRenderData.PPG_Window, PPG_StrgWidth, -1, -1, NULL);
    1b50:	2c79 0000 4766 	movea.l 4766 <IntuitionBase>,a6
    1b56:	2079 0000 477e 	movea.l 477e <GOLRenderData+0x8>,a0
    1b5c:	2279 0000 4738 	movea.l 4738 <PPG_StrgWidth>,a1
    1b62:	70ff           	moveq #-1,d0
    1b64:	72ff           	moveq #-1,d1
    1b66:	95ca           	suba.l a2,a2
    1b68:	4eae fe4a      	jsr -438(a6)
	RefreshGList(PPG_StrgWidth, GOLRenderData.PPG_Window, NULL, -1);
    1b6c:	2c79 0000 4766 	movea.l 4766 <IntuitionBase>,a6
    1b72:	2079 0000 4738 	movea.l 4738 <PPG_StrgWidth>,a0
    1b78:	2279 0000 477e 	movea.l 477e <GOLRenderData+0x8>,a1
    1b7e:	70ff           	moveq #-1,d0
    1b80:	4eae fe50      	jsr -432(a6)
}
    1b84:	4cdf 5c0c      	movem.l (sp)+,d2-d3/a2-a4/a6
    1b88:	4fef 00b8      	lea 184(sp),sp
    1b8c:	4e75           	rts

00001b8e <PrepareBackbuffer.constprop.0>:
int PrepareBackbuffer(RenderData *rd)
    1b8e:	48e7 383e      	movem.l d2-d4/a2-a6,-(sp)
		if (rd->Backbuffer)
    1b92:	2679 0000 47ee 	movea.l 47ee <GOLRenderData+0x78>,a3
	if (rd->OutputSize.x != rd->BackbufferSize.x || rd->OutputSize.y != rd->BackbufferSize.y)
    1b98:	2039 0000 4782 	move.l 4782 <GOLRenderData+0xc>,d0
    1b9e:	b0b9 0000 4786 	cmp.l 4786 <GOLRenderData+0x10>,d0
    1ba4:	6700 0122      	beq.w 1cc8 <PrepareBackbuffer.constprop.0+0x13a>
	if (GfxBase->LibNode.lib_Version < 39)
    1ba8:	2c79 0000 4772 	movea.l 4772 <GfxBase>,a6
    1bae:	302e 0014      	move.w 20(a6),d0
		if (rd->Backbuffer)
    1bb2:	b6fc 0000      	cmpa.w #0,a3
    1bb6:	6770           	beq.s 1c28 <PrepareBackbuffer.constprop.0+0x9a>
	if (GfxBase->LibNode.lib_Version < 39)
    1bb8:	0c40 0026      	cmpi.w #38,d0
    1bbc:	6200 0166      	bhi.w 1d24 <PrepareBackbuffer.constprop.0+0x196>
		width = bitmap->BytesPerRow * 8;
    1bc0:	7800           	moveq #0,d4
    1bc2:	3813           	move.w (a3),d4
    1bc4:	e78c           	lsl.l #3,d4
		for (i = 0; i < bitmap->Depth; i++)
    1bc6:	122b 0005      	move.b 5(a3),d1
    1bca:	673e           	beq.s 1c0a <PrepareBackbuffer.constprop.0+0x7c>
    1bcc:	4242           	clr.w d2
    1bce:	91c8           	suba.l a0,a0
    1bd0:	d1c8           	adda.l a0,a0
    1bd2:	d1c8           	adda.l a0,a0
    1bd4:	45f3 8800      	lea (0,a3,a0.l),a2
			if (bitmap->Planes[i])
    1bd8:	206a 0008      	movea.l 8(a2),a0
    1bdc:	b0fc 0000      	cmpa.w #0,a0
    1be0:	6700 0122      	beq.w 1d04 <PrepareBackbuffer.constprop.0+0x176>
				FreeRaster(bitmap->Planes[i], width, bitmap->Rows);
    1be4:	2c79 0000 4772 	movea.l 4772 <GfxBase>,a6
    1bea:	2004           	move.l d4,d0
    1bec:	7200           	moveq #0,d1
    1bee:	322b 0002      	move.w 2(a3),d1
    1bf2:	4eae fe0e      	jsr -498(a6)
				bitmap->Planes[i] = 0;
    1bf6:	42aa 0008      	clr.l 8(a2)
		for (i = 0; i < bitmap->Depth; i++)
    1bfa:	122b 0005      	move.b 5(a3),d1
    1bfe:	5242           	addq.w #1,d2
    1c00:	3042           	movea.w d2,a0
    1c02:	7600           	moveq #0,d3
    1c04:	1601           	move.b d1,d3
    1c06:	b1c3           	cmpa.l d3,a0
    1c08:	6dc6           	blt.s 1bd0 <PrepareBackbuffer.constprop.0+0x42>
		FreeMem(bitmap, sizeof(struct BitMap));
    1c0a:	2c79 0000 475e 	movea.l 475e <SysBase>,a6
    1c10:	224b           	movea.l a3,a1
    1c12:	7028           	moveq #40,d0
    1c14:	4eae ff2e      	jsr -210(a6)
			rd->Backbuffer = 0;
    1c18:	42b9 0000 47ee 	clr.l 47ee <GOLRenderData+0x78>
	if (GfxBase->LibNode.lib_Version < 39)
    1c1e:	2c79 0000 4772 	movea.l 4772 <GfxBase>,a6
    1c24:	302e 0014      	move.w 20(a6),d0
		rd->Backbuffer = MyAllocBitMap(rd->OutputSize.x, rd->OutputSize.y, ScreenD, rd->MainWindow->RPort->BitMap);
    1c28:	3879 0000 4784 	movea.w 4784 <GOLRenderData+0xe>,a4
    1c2e:	3a79 0000 4782 	movea.w 4782 <GOLRenderData+0xc>,a5
	if (GfxBase->LibNode.lib_Version < 39)
    1c34:	0c40 0026      	cmpi.w #38,d0
    1c38:	6200 009c      	bhi.w 1cd6 <PrepareBackbuffer.constprop.0+0x148>
				AllocMem(sizeof(struct BitMap), MEMF_ANY | MEMF_CLEAR);
    1c3c:	2c79 0000 475e 	movea.l 475e <SysBase>,a6
    1c42:	7028           	moveq #40,d0
    1c44:	7201           	moveq #1,d1
    1c46:	4841           	swap d1
    1c48:	4eae ff3a      	jsr -198(a6)
    1c4c:	2640           	movea.l d0,a3
			if (bitmap)
    1c4e:	4a80           	tst.l d0
    1c50:	6700 0182      	beq.w 1dd4 <PrepareBackbuffer.constprop.0+0x246>
				InitBitMap(bitmap, depth, width, height);
    1c54:	2c79 0000 4772 	movea.l 4772 <GfxBase>,a6
    1c5a:	2040           	movea.l d0,a0
    1c5c:	7004           	moveq #4,d0
    1c5e:	220d           	move.l a5,d1
    1c60:	240c           	move.l a4,d2
    1c62:	4eae fe7a      	jsr -390(a6)
				for (i = 0; i < bitmap->Depth; i++)
    1c66:	4a2b 0005      	tst.b 5(a3)
    1c6a:	6730           	beq.s 1c9c <PrepareBackbuffer.constprop.0+0x10e>
    1c6c:	4242           	clr.w d2
    1c6e:	95ca           	suba.l a2,a2
					bitmap->Planes[i] = AllocRaster(width, height);
    1c70:	2c79 0000 4772 	movea.l 4772 <GfxBase>,a6
    1c76:	200d           	move.l a5,d0
    1c78:	220c           	move.l a4,d1
    1c7a:	4eae fe14      	jsr -492(a6)
    1c7e:	220a           	move.l a2,d1
    1c80:	5481           	addq.l #2,d1
    1c82:	d281           	add.l d1,d1
    1c84:	d281           	add.l d1,d1
    1c86:	2780 1800      	move.l d0,(0,a3,d1.l)
					if (!(bitmap->Planes[i]))
    1c8a:	6700 00ba      	beq.w 1d46 <PrepareBackbuffer.constprop.0+0x1b8>
    1c8e:	5242           	addq.w #1,d2
				for (i = 0; i < bitmap->Depth; i++)
    1c90:	3442           	movea.w d2,a2
    1c92:	7000           	moveq #0,d0
    1c94:	102b 0005      	move.b 5(a3),d0
    1c98:	b08a           	cmp.l a2,d0
    1c9a:	6ed4           	bgt.s 1c70 <PrepareBackbuffer.constprop.0+0xe2>
		rd->Backbuffer = MyAllocBitMap(rd->OutputSize.x, rd->OutputSize.y, ScreenD, rd->MainWindow->RPort->BitMap);
    1c9c:	23cb 0000 47ee 	move.l a3,47ee <GOLRenderData+0x78>
			rd->BackbufferSize = rd->OutputSize;
    1ca2:	23f9 0000 4782 	move.l 4782 <GOLRenderData+0xc>,4786 <GOLRenderData+0x10>
    1ca8:	0000 4786 
		InitRastPort(&rd->Rastport);
    1cac:	2c79 0000 4772 	movea.l 4772 <GfxBase>,a6
    1cb2:	43f9 0000 478a 	lea 478a <GOLRenderData+0x14>,a1
    1cb8:	4eae ff3a      	jsr -198(a6)
		rd->Rastport.BitMap = rd->Backbuffer;
    1cbc:	2679 0000 47ee 	movea.l 47ee <GOLRenderData+0x78>,a3
    1cc2:	23cb 0000 478e 	move.l a3,478e <GOLRenderData+0x18>
	result = rd->Backbuffer ? RETURN_OK : RETURN_ERROR;
    1cc8:	b6fc 0000      	cmpa.w #0,a3
    1ccc:	6770           	beq.s 1d3e <PrepareBackbuffer.constprop.0+0x1b0>
    1cce:	7000           	moveq #0,d0
}
    1cd0:	4cdf 7c1c      	movem.l (sp)+,d2-d4/a2-a6
    1cd4:	4e75           	rts
		rd->Backbuffer = MyAllocBitMap(rd->OutputSize.x, rd->OutputSize.y, ScreenD, rd->MainWindow->RPort->BitMap);
    1cd6:	2079 0000 477a 	movea.l 477a <GOLRenderData+0x4>,a0
    1cdc:	2068 0032      	movea.l 50(a0),a0
		bitmap = AllocBitMap(width, height, depth, 0, likeBitMap);
    1ce0:	200d           	move.l a5,d0
    1ce2:	220c           	move.l a4,d1
    1ce4:	7404           	moveq #4,d2
    1ce6:	7600           	moveq #0,d3
    1ce8:	2068 0004      	movea.l 4(a0),a0
    1cec:	4eae fc6a      	jsr -918(a6)
		rd->Backbuffer = MyAllocBitMap(rd->OutputSize.x, rd->OutputSize.y, ScreenD, rd->MainWindow->RPort->BitMap);
    1cf0:	23c0 0000 47ee 	move.l d0,47ee <GOLRenderData+0x78>
		if (rd->Backbuffer)
    1cf6:	67b4           	beq.s 1cac <PrepareBackbuffer.constprop.0+0x11e>
			rd->BackbufferSize = rd->OutputSize;
    1cf8:	23f9 0000 4782 	move.l 4782 <GOLRenderData+0xc>,4786 <GOLRenderData+0x10>
    1cfe:	0000 4786 
    1d02:	60a8           	bra.s 1cac <PrepareBackbuffer.constprop.0+0x11e>
    1d04:	5242           	addq.w #1,d2
		for (i = 0; i < bitmap->Depth; i++)
    1d06:	3042           	movea.w d2,a0
    1d08:	7000           	moveq #0,d0
    1d0a:	1001           	move.b d1,d0
    1d0c:	b088           	cmp.l a0,d0
    1d0e:	6e00 fec0      	bgt.w 1bd0 <PrepareBackbuffer.constprop.0+0x42>
		FreeMem(bitmap, sizeof(struct BitMap));
    1d12:	2c79 0000 475e 	movea.l 475e <SysBase>,a6
    1d18:	224b           	movea.l a3,a1
    1d1a:	7028           	moveq #40,d0
    1d1c:	4eae ff2e      	jsr -210(a6)
    1d20:	6000 fef6      	bra.w 1c18 <PrepareBackbuffer.constprop.0+0x8a>
		FreeBitMap(bitmap);
    1d24:	204b           	movea.l a3,a0
    1d26:	4eae fc64      	jsr -924(a6)
			rd->Backbuffer = 0;
    1d2a:	42b9 0000 47ee 	clr.l 47ee <GOLRenderData+0x78>
	if (GfxBase->LibNode.lib_Version < 39)
    1d30:	2c79 0000 4772 	movea.l 4772 <GfxBase>,a6
    1d36:	302e 0014      	move.w 20(a6),d0
    1d3a:	6000 feec      	bra.w 1c28 <PrepareBackbuffer.constprop.0+0x9a>
	result = rd->Backbuffer ? RETURN_OK : RETURN_ERROR;
    1d3e:	700a           	moveq #10,d0
}
    1d40:	4cdf 7c1c      	movem.l (sp)+,d2-d4/a2-a6
    1d44:	4e75           	rts
	if (GfxBase->LibNode.lib_Version < 39)
    1d46:	2c79 0000 4772 	movea.l 4772 <GfxBase>,a6
    1d4c:	0c6e 0026 0014 	cmpi.w #38,20(a6)
    1d52:	6200 00a6      	bhi.w 1dfa <PrepareBackbuffer.constprop.0+0x26c>
		width = bitmap->BytesPerRow * 8;
    1d56:	7800           	moveq #0,d4
    1d58:	3813           	move.w (a3),d4
    1d5a:	e78c           	lsl.l #3,d4
		for (i = 0; i < bitmap->Depth; i++)
    1d5c:	122b 0005      	move.b 5(a3),d1
    1d60:	673e           	beq.s 1da0 <PrepareBackbuffer.constprop.0+0x212>
    1d62:	4242           	clr.w d2
    1d64:	91c8           	suba.l a0,a0
    1d66:	d1c8           	adda.l a0,a0
    1d68:	d1c8           	adda.l a0,a0
    1d6a:	45f3 8800      	lea (0,a3,a0.l),a2
			if (bitmap->Planes[i])
    1d6e:	206a 0008      	movea.l 8(a2),a0
    1d72:	b0fc 0000      	cmpa.w #0,a0
    1d76:	6700 00ae      	beq.w 1e26 <PrepareBackbuffer.constprop.0+0x298>
				FreeRaster(bitmap->Planes[i], width, bitmap->Rows);
    1d7a:	2c79 0000 4772 	movea.l 4772 <GfxBase>,a6
    1d80:	2004           	move.l d4,d0
    1d82:	7200           	moveq #0,d1
    1d84:	322b 0002      	move.w 2(a3),d1
    1d88:	4eae fe0e      	jsr -498(a6)
				bitmap->Planes[i] = 0;
    1d8c:	42aa 0008      	clr.l 8(a2)
		for (i = 0; i < bitmap->Depth; i++)
    1d90:	122b 0005      	move.b 5(a3),d1
    1d94:	5242           	addq.w #1,d2
    1d96:	3042           	movea.w d2,a0
    1d98:	7600           	moveq #0,d3
    1d9a:	1601           	move.b d1,d3
    1d9c:	b1c3           	cmpa.l d3,a0
    1d9e:	6dc6           	blt.s 1d66 <PrepareBackbuffer.constprop.0+0x1d8>
		FreeMem(bitmap, sizeof(struct BitMap));
    1da0:	2c79 0000 475e 	movea.l 475e <SysBase>,a6
    1da6:	224b           	movea.l a3,a1
    1da8:	7028           	moveq #40,d0
    1daa:	4eae ff2e      	jsr -210(a6)
		rd->Backbuffer = MyAllocBitMap(rd->OutputSize.x, rd->OutputSize.y, ScreenD, rd->MainWindow->RPort->BitMap);
    1dae:	42b9 0000 47ee 	clr.l 47ee <GOLRenderData+0x78>
		InitRastPort(&rd->Rastport);
    1db4:	2c79 0000 4772 	movea.l 4772 <GfxBase>,a6
    1dba:	43f9 0000 478a 	lea 478a <GOLRenderData+0x14>,a1
    1dc0:	4eae ff3a      	jsr -198(a6)
		rd->Rastport.BitMap = rd->Backbuffer;
    1dc4:	2679 0000 47ee 	movea.l 47ee <GOLRenderData+0x78>,a3
    1dca:	23cb 0000 478e 	move.l a3,478e <GOLRenderData+0x18>
    1dd0:	6000 fef6      	bra.w 1cc8 <PrepareBackbuffer.constprop.0+0x13a>
		rd->Backbuffer = MyAllocBitMap(rd->OutputSize.x, rd->OutputSize.y, ScreenD, rd->MainWindow->RPort->BitMap);
    1dd4:	42b9 0000 47ee 	clr.l 47ee <GOLRenderData+0x78>
		InitRastPort(&rd->Rastport);
    1dda:	2c79 0000 4772 	movea.l 4772 <GfxBase>,a6
    1de0:	43f9 0000 478a 	lea 478a <GOLRenderData+0x14>,a1
    1de6:	4eae ff3a      	jsr -198(a6)
		rd->Rastport.BitMap = rd->Backbuffer;
    1dea:	2679 0000 47ee 	movea.l 47ee <GOLRenderData+0x78>,a3
    1df0:	23cb 0000 478e 	move.l a3,478e <GOLRenderData+0x18>
    1df6:	6000 fed0      	bra.w 1cc8 <PrepareBackbuffer.constprop.0+0x13a>
		FreeBitMap(bitmap);
    1dfa:	204b           	movea.l a3,a0
    1dfc:	4eae fc64      	jsr -924(a6)
		rd->Backbuffer = MyAllocBitMap(rd->OutputSize.x, rd->OutputSize.y, ScreenD, rd->MainWindow->RPort->BitMap);
    1e00:	42b9 0000 47ee 	clr.l 47ee <GOLRenderData+0x78>
		InitRastPort(&rd->Rastport);
    1e06:	2c79 0000 4772 	movea.l 4772 <GfxBase>,a6
    1e0c:	43f9 0000 478a 	lea 478a <GOLRenderData+0x14>,a1
    1e12:	4eae ff3a      	jsr -198(a6)
		rd->Rastport.BitMap = rd->Backbuffer;
    1e16:	2679 0000 47ee 	movea.l 47ee <GOLRenderData+0x78>,a3
    1e1c:	23cb 0000 478e 	move.l a3,478e <GOLRenderData+0x18>
    1e22:	6000 fea4      	bra.w 1cc8 <PrepareBackbuffer.constprop.0+0x13a>
    1e26:	5242           	addq.w #1,d2
		for (i = 0; i < bitmap->Depth; i++)
    1e28:	3042           	movea.w d2,a0
    1e2a:	7000           	moveq #0,d0
    1e2c:	1001           	move.b d1,d0
    1e2e:	b088           	cmp.l a0,d0
    1e30:	6e00 ff34      	bgt.w 1d66 <PrepareBackbuffer.constprop.0+0x1d8>
		FreeMem(bitmap, sizeof(struct BitMap));
    1e34:	2c79 0000 475e 	movea.l 475e <SysBase>,a6
    1e3a:	224b           	movea.l a3,a1
    1e3c:	7028           	moveq #40,d0
    1e3e:	4eae ff2e      	jsr -210(a6)
		rd->Backbuffer = MyAllocBitMap(rd->OutputSize.x, rd->OutputSize.y, ScreenD, rd->MainWindow->RPort->BitMap);
    1e42:	42b9 0000 47ee 	clr.l 47ee <GOLRenderData+0x78>
    1e48:	6000 ff6a      	bra.w 1db4 <PrepareBackbuffer.constprop.0+0x226>

00001e4c <memset.constprop.0>:
	void* memset(void *dest, int val, unsigned long len)
    1e4c:	2f0a           	move.l a2,-(sp)
    1e4e:	2f02           	move.l d2,-(sp)
    1e50:	202f 000c      	move.l 12(sp),d0
    1e54:	206f 0014      	movea.l 20(sp),a0
	while(len-- > 0)
    1e58:	43e8 ffff      	lea -1(a0),a1
    1e5c:	b0fc 0000      	cmpa.w #0,a0
    1e60:	6700 0096      	beq.w 1ef8 <memset.constprop.0+0xac>
    1e64:	2200           	move.l d0,d1
    1e66:	4481           	neg.l d1
    1e68:	7403           	moveq #3,d2
    1e6a:	c282           	and.l d2,d1
    1e6c:	7405           	moveq #5,d2
		*ptr++ = val;
    1e6e:	2440           	movea.l d0,a2
    1e70:	b489           	cmp.l a1,d2
    1e72:	6450           	bcc.s 1ec4 <memset.constprop.0+0x78>
    1e74:	4a81           	tst.l d1
    1e76:	672c           	beq.s 1ea4 <memset.constprop.0+0x58>
    1e78:	421a           	clr.b (a2)+
	while(len-- > 0)
    1e7a:	43e8 fffe      	lea -2(a0),a1
    1e7e:	7401           	moveq #1,d2
    1e80:	b481           	cmp.l d1,d2
    1e82:	6720           	beq.s 1ea4 <memset.constprop.0+0x58>
		*ptr++ = val;
    1e84:	2440           	movea.l d0,a2
    1e86:	548a           	addq.l #2,a2
    1e88:	2240           	movea.l d0,a1
    1e8a:	4229 0001      	clr.b 1(a1)
	while(len-- > 0)
    1e8e:	43e8 fffd      	lea -3(a0),a1
    1e92:	7403           	moveq #3,d2
    1e94:	b481           	cmp.l d1,d2
    1e96:	660c           	bne.s 1ea4 <memset.constprop.0+0x58>
		*ptr++ = val;
    1e98:	528a           	addq.l #1,a2
    1e9a:	2240           	movea.l d0,a1
    1e9c:	4229 0002      	clr.b 2(a1)
	while(len-- > 0)
    1ea0:	43e8 fffc      	lea -4(a0),a1
    1ea4:	2408           	move.l a0,d2
    1ea6:	9481           	sub.l d1,d2
    1ea8:	2040           	movea.l d0,a0
    1eaa:	d1c1           	adda.l d1,a0
    1eac:	72fc           	moveq #-4,d1
    1eae:	c282           	and.l d2,d1
    1eb0:	d288           	add.l a0,d1
		*ptr++ = val;
    1eb2:	4298           	clr.l (a0)+
    1eb4:	b1c1           	cmpa.l d1,a0
    1eb6:	66fa           	bne.s 1eb2 <memset.constprop.0+0x66>
    1eb8:	72fc           	moveq #-4,d1
    1eba:	c282           	and.l d2,d1
    1ebc:	d5c1           	adda.l d1,a2
    1ebe:	93c1           	suba.l d1,a1
    1ec0:	b282           	cmp.l d2,d1
    1ec2:	6734           	beq.s 1ef8 <memset.constprop.0+0xac>
    1ec4:	4212           	clr.b (a2)
	while(len-- > 0)
    1ec6:	b2fc 0000      	cmpa.w #0,a1
    1eca:	672c           	beq.s 1ef8 <memset.constprop.0+0xac>
		*ptr++ = val;
    1ecc:	422a 0001      	clr.b 1(a2)
	while(len-- > 0)
    1ed0:	7201           	moveq #1,d1
    1ed2:	b289           	cmp.l a1,d1
    1ed4:	6722           	beq.s 1ef8 <memset.constprop.0+0xac>
		*ptr++ = val;
    1ed6:	422a 0002      	clr.b 2(a2)
	while(len-- > 0)
    1eda:	7402           	moveq #2,d2
    1edc:	b489           	cmp.l a1,d2
    1ede:	6718           	beq.s 1ef8 <memset.constprop.0+0xac>
		*ptr++ = val;
    1ee0:	422a 0003      	clr.b 3(a2)
	while(len-- > 0)
    1ee4:	7203           	moveq #3,d1
    1ee6:	b289           	cmp.l a1,d1
    1ee8:	670e           	beq.s 1ef8 <memset.constprop.0+0xac>
		*ptr++ = val;
    1eea:	422a 0004      	clr.b 4(a2)
	while(len-- > 0)
    1eee:	7404           	moveq #4,d2
    1ef0:	b489           	cmp.l a1,d2
    1ef2:	6704           	beq.s 1ef8 <memset.constprop.0+0xac>
		*ptr++ = val;
    1ef4:	422a 0005      	clr.b 5(a2)
}
    1ef8:	241f           	move.l (sp)+,d2
    1efa:	245f           	movea.l (sp)+,a2
    1efc:	4e75           	rts

00001efe <FreePlayfieldMem.isra.0>:
int FreePlayfieldMem()
    1efe:	48e7 3022      	movem.l d2-d3/a2/a6,-(sp)
	for (int i = 0; i < GameMatrix.Columns; i++)
    1f02:	4a79 0000 47fe 	tst.w 47fe <GameMatrix+0xa>
    1f08:	6700 00a2      	beq.w 1fac <FreePlayfieldMem.isra.0+0xae>
    1f0c:	7400           	moveq #0,d2
    1f0e:	7600           	moveq #0,d3
    1f10:	45f9 0000 47f4 	lea 47f4 <GameMatrix>,a2
		FreeMem(GameMatrix.Playfield[i], GameMatrix.Rows * sizeof(GameOfLifeCell));
    1f16:	2052           	movea.l (a2),a0
    1f18:	2c79 0000 475e 	movea.l 475e <SysBase>,a6
    1f1e:	2270 2800      	movea.l (0,a0,d2.l),a1
    1f22:	7000           	moveq #0,d0
    1f24:	3039 0000 47fc 	move.w 47fc <GameMatrix+0x8>,d0
    1f2a:	4eae ff2e      	jsr -210(a6)
		FreeMem(GameMatrix.Playfield_n1[i], GameMatrix.Rows * sizeof(GameOfLifeCell));
    1f2e:	2c79 0000 475e 	movea.l 475e <SysBase>,a6
    1f34:	2079 0000 47f8 	movea.l 47f8 <GameMatrix+0x4>,a0
    1f3a:	2270 2800      	movea.l (0,a0,d2.l),a1
    1f3e:	7000           	moveq #0,d0
    1f40:	3039 0000 47fc 	move.w 47fc <GameMatrix+0x8>,d0
    1f46:	4eae ff2e      	jsr -210(a6)
	for (int i = 0; i < GameMatrix.Columns; i++)
    1f4a:	5283           	addq.l #1,d3
    1f4c:	5882           	addq.l #4,d2
    1f4e:	7000           	moveq #0,d0
    1f50:	3039 0000 47fe 	move.w 47fe <GameMatrix+0xa>,d0
    1f56:	b083           	cmp.l d3,d0
    1f58:	6ebc           	bgt.s 1f16 <FreePlayfieldMem.isra.0+0x18>
	FreeMem(GameMatrix.Playfield, GameMatrix.Columns * sizeof(GameOfLifeCell *));
    1f5a:	2c79 0000 475e 	movea.l 475e <SysBase>,a6
    1f60:	2252           	movea.l (a2),a1
    1f62:	e588           	lsl.l #2,d0
    1f64:	4eae ff2e      	jsr -210(a6)
	FreeMem(GameMatrix.Playfield_n1, GameMatrix.Columns * sizeof(GameOfLifeCell *));
    1f68:	7000           	moveq #0,d0
    1f6a:	3039 0000 47fe 	move.w 47fe <GameMatrix+0xa>,d0
    1f70:	2c79 0000 475e 	movea.l 475e <SysBase>,a6
    1f76:	2279 0000 47f8 	movea.l 47f8 <GameMatrix+0x4>,a1
    1f7c:	e588           	lsl.l #2,d0
    1f7e:	4eae ff2e      	jsr -210(a6)
	FreeMem(UpdateList, GameMatrix.Columns * GameMatrix.Rows * sizeof(UpdateListEntry));
    1f82:	3239 0000 47fe 	move.w 47fe <GameMatrix+0xa>,d1
    1f88:	c2f9 0000 47fc 	mulu.w 47fc <GameMatrix+0x8>,d1
    1f8e:	2001           	move.l d1,d0
    1f90:	d081           	add.l d1,d0
    1f92:	d081           	add.l d1,d0
    1f94:	2c79 0000 475e 	movea.l 475e <SysBase>,a6
    1f9a:	2279 0000 4756 	movea.l 4756 <UpdateList>,a1
    1fa0:	d080           	add.l d0,d0
    1fa2:	4eae ff2e      	jsr -210(a6)
}
    1fa6:	4cdf 440c      	movem.l (sp)+,d2-d3/a2/a6
    1faa:	4e75           	rts
    1fac:	45f9 0000 47f4 	lea 47f4 <GameMatrix>,a2
    1fb2:	7000           	moveq #0,d0
	FreeMem(GameMatrix.Playfield, GameMatrix.Columns * sizeof(GameOfLifeCell *));
    1fb4:	2c79 0000 475e 	movea.l 475e <SysBase>,a6
    1fba:	2252           	movea.l (a2),a1
    1fbc:	e588           	lsl.l #2,d0
    1fbe:	4eae ff2e      	jsr -210(a6)
	FreeMem(GameMatrix.Playfield_n1, GameMatrix.Columns * sizeof(GameOfLifeCell *));
    1fc2:	7000           	moveq #0,d0
    1fc4:	3039 0000 47fe 	move.w 47fe <GameMatrix+0xa>,d0
    1fca:	2c79 0000 475e 	movea.l 475e <SysBase>,a6
    1fd0:	2279 0000 47f8 	movea.l 47f8 <GameMatrix+0x4>,a1
    1fd6:	e588           	lsl.l #2,d0
    1fd8:	4eae ff2e      	jsr -210(a6)
	FreeMem(UpdateList, GameMatrix.Columns * GameMatrix.Rows * sizeof(UpdateListEntry));
    1fdc:	3239 0000 47fe 	move.w 47fe <GameMatrix+0xa>,d1
    1fe2:	c2f9 0000 47fc 	mulu.w 47fc <GameMatrix+0x8>,d1
    1fe8:	2001           	move.l d1,d0
    1fea:	d081           	add.l d1,d0
    1fec:	d081           	add.l d1,d0
    1fee:	2c79 0000 475e 	movea.l 475e <SysBase>,a6
    1ff4:	2279 0000 4756 	movea.l 4756 <UpdateList>,a1
    1ffa:	d080           	add.l d0,d0
    1ffc:	4eae ff2e      	jsr -210(a6)
}
    2000:	4cdf 440c      	movem.l (sp)+,d2-d3/a2/a6
    2004:	4e75           	rts

00002006 <strlen>:
{
    2006:	206f 0004      	movea.l 4(sp),a0
	unsigned long t=0;
    200a:	7000           	moveq #0,d0
	while(*s++)
    200c:	4a10           	tst.b (a0)
    200e:	6708           	beq.s 2018 <strlen+0x12>
		t++;
    2010:	5280           	addq.l #1,d0
	while(*s++)
    2012:	4a30 0800      	tst.b (0,a0,d0.l)
    2016:	66f8           	bne.s 2010 <strlen+0xa>
}
    2018:	4e75           	rts

0000201a <memset>:
{
    201a:	48e7 3f30      	movem.l d2-d7/a2-a3,-(sp)
    201e:	202f 0024      	move.l 36(sp),d0
    2022:	282f 0028      	move.l 40(sp),d4
    2026:	226f 002c      	movea.l 44(sp),a1
	while(len-- > 0)
    202a:	2a09           	move.l a1,d5
    202c:	5385           	subq.l #1,d5
    202e:	b2fc 0000      	cmpa.w #0,a1
    2032:	6700 00ae      	beq.w 20e2 <memset+0xc8>
		*ptr++ = val;
    2036:	1e04           	move.b d4,d7
    2038:	2200           	move.l d0,d1
    203a:	4481           	neg.l d1
    203c:	7403           	moveq #3,d2
    203e:	c282           	and.l d2,d1
    2040:	7c05           	moveq #5,d6
    2042:	2440           	movea.l d0,a2
    2044:	bc85           	cmp.l d5,d6
    2046:	646a           	bcc.s 20b2 <memset+0x98>
    2048:	4a81           	tst.l d1
    204a:	6724           	beq.s 2070 <memset+0x56>
    204c:	14c4           	move.b d4,(a2)+
	while(len-- > 0)
    204e:	5385           	subq.l #1,d5
    2050:	7401           	moveq #1,d2
    2052:	b481           	cmp.l d1,d2
    2054:	671a           	beq.s 2070 <memset+0x56>
		*ptr++ = val;
    2056:	2440           	movea.l d0,a2
    2058:	548a           	addq.l #2,a2
    205a:	2040           	movea.l d0,a0
    205c:	1144 0001      	move.b d4,1(a0)
	while(len-- > 0)
    2060:	5385           	subq.l #1,d5
    2062:	7403           	moveq #3,d2
    2064:	b481           	cmp.l d1,d2
    2066:	6608           	bne.s 2070 <memset+0x56>
		*ptr++ = val;
    2068:	528a           	addq.l #1,a2
    206a:	1144 0002      	move.b d4,2(a0)
	while(len-- > 0)
    206e:	5385           	subq.l #1,d5
    2070:	2609           	move.l a1,d3
    2072:	9681           	sub.l d1,d3
    2074:	7c00           	moveq #0,d6
    2076:	1c04           	move.b d4,d6
    2078:	2406           	move.l d6,d2
    207a:	4842           	swap d2
    207c:	4242           	clr.w d2
    207e:	2042           	movea.l d2,a0
    2080:	2404           	move.l d4,d2
    2082:	e14a           	lsl.w #8,d2
    2084:	4842           	swap d2
    2086:	4242           	clr.w d2
    2088:	e18e           	lsl.l #8,d6
    208a:	2646           	movea.l d6,a3
    208c:	2c08           	move.l a0,d6
    208e:	8486           	or.l d6,d2
    2090:	2c0b           	move.l a3,d6
    2092:	8486           	or.l d6,d2
    2094:	1407           	move.b d7,d2
    2096:	2040           	movea.l d0,a0
    2098:	d1c1           	adda.l d1,a0
    209a:	72fc           	moveq #-4,d1
    209c:	c283           	and.l d3,d1
    209e:	d288           	add.l a0,d1
		*ptr++ = val;
    20a0:	20c2           	move.l d2,(a0)+
	while(len-- > 0)
    20a2:	b1c1           	cmpa.l d1,a0
    20a4:	66fa           	bne.s 20a0 <memset+0x86>
    20a6:	72fc           	moveq #-4,d1
    20a8:	c283           	and.l d3,d1
    20aa:	d5c1           	adda.l d1,a2
    20ac:	9a81           	sub.l d1,d5
    20ae:	b283           	cmp.l d3,d1
    20b0:	6730           	beq.s 20e2 <memset+0xc8>
		*ptr++ = val;
    20b2:	1484           	move.b d4,(a2)
	while(len-- > 0)
    20b4:	4a85           	tst.l d5
    20b6:	672a           	beq.s 20e2 <memset+0xc8>
		*ptr++ = val;
    20b8:	1544 0001      	move.b d4,1(a2)
	while(len-- > 0)
    20bc:	7201           	moveq #1,d1
    20be:	b285           	cmp.l d5,d1
    20c0:	6720           	beq.s 20e2 <memset+0xc8>
		*ptr++ = val;
    20c2:	1544 0002      	move.b d4,2(a2)
	while(len-- > 0)
    20c6:	7402           	moveq #2,d2
    20c8:	b485           	cmp.l d5,d2
    20ca:	6716           	beq.s 20e2 <memset+0xc8>
		*ptr++ = val;
    20cc:	1544 0003      	move.b d4,3(a2)
	while(len-- > 0)
    20d0:	7c03           	moveq #3,d6
    20d2:	bc85           	cmp.l d5,d6
    20d4:	670c           	beq.s 20e2 <memset+0xc8>
		*ptr++ = val;
    20d6:	1544 0004      	move.b d4,4(a2)
	while(len-- > 0)
    20da:	5985           	subq.l #4,d5
    20dc:	6704           	beq.s 20e2 <memset+0xc8>
		*ptr++ = val;
    20de:	1544 0005      	move.b d4,5(a2)
}
    20e2:	4cdf 0cfc      	movem.l (sp)+,d2-d7/a2-a3
    20e6:	4e75           	rts

000020e8 <memcpy>:
{
    20e8:	48e7 3e00      	movem.l d2-d6,-(sp)
    20ec:	202f 0018      	move.l 24(sp),d0
    20f0:	222f 001c      	move.l 28(sp),d1
    20f4:	262f 0020      	move.l 32(sp),d3
	while(len--)
    20f8:	2803           	move.l d3,d4
    20fa:	5384           	subq.l #1,d4
    20fc:	4a83           	tst.l d3
    20fe:	675e           	beq.s 215e <memcpy+0x76>
    2100:	2041           	movea.l d1,a0
    2102:	5288           	addq.l #1,a0
    2104:	2400           	move.l d0,d2
    2106:	9488           	sub.l a0,d2
    2108:	7a02           	moveq #2,d5
    210a:	ba82           	cmp.l d2,d5
    210c:	55c2           	sc.s d2
    210e:	4402           	neg.b d2
    2110:	7c08           	moveq #8,d6
    2112:	bc84           	cmp.l d4,d6
    2114:	55c5           	sc.s d5
    2116:	4405           	neg.b d5
    2118:	c405           	and.b d5,d2
    211a:	6748           	beq.s 2164 <memcpy+0x7c>
    211c:	2400           	move.l d0,d2
    211e:	8481           	or.l d1,d2
    2120:	7a03           	moveq #3,d5
    2122:	c485           	and.l d5,d2
    2124:	663e           	bne.s 2164 <memcpy+0x7c>
    2126:	2041           	movea.l d1,a0
    2128:	2240           	movea.l d0,a1
    212a:	74fc           	moveq #-4,d2
    212c:	c483           	and.l d3,d2
    212e:	d481           	add.l d1,d2
		*d++ = *s++;
    2130:	22d8           	move.l (a0)+,(a1)+
	while(len--)
    2132:	b488           	cmp.l a0,d2
    2134:	66fa           	bne.s 2130 <memcpy+0x48>
    2136:	74fc           	moveq #-4,d2
    2138:	c483           	and.l d3,d2
    213a:	2040           	movea.l d0,a0
    213c:	d1c2           	adda.l d2,a0
    213e:	d282           	add.l d2,d1
    2140:	9882           	sub.l d2,d4
    2142:	b483           	cmp.l d3,d2
    2144:	6718           	beq.s 215e <memcpy+0x76>
		*d++ = *s++;
    2146:	2241           	movea.l d1,a1
    2148:	1091           	move.b (a1),(a0)
	while(len--)
    214a:	4a84           	tst.l d4
    214c:	6710           	beq.s 215e <memcpy+0x76>
		*d++ = *s++;
    214e:	1169 0001 0001 	move.b 1(a1),1(a0)
	while(len--)
    2154:	5384           	subq.l #1,d4
    2156:	6706           	beq.s 215e <memcpy+0x76>
		*d++ = *s++;
    2158:	1169 0002 0002 	move.b 2(a1),2(a0)
}
    215e:	4cdf 007c      	movem.l (sp)+,d2-d6
    2162:	4e75           	rts
    2164:	2240           	movea.l d0,a1
    2166:	d283           	add.l d3,d1
		*d++ = *s++;
    2168:	12e8 ffff      	move.b -1(a0),(a1)+
	while(len--)
    216c:	b288           	cmp.l a0,d1
    216e:	67ee           	beq.s 215e <memcpy+0x76>
    2170:	5288           	addq.l #1,a0
    2172:	60f4           	bra.s 2168 <memcpy+0x80>

00002174 <memmove>:
{
    2174:	48e7 3c20      	movem.l d2-d5/a2,-(sp)
    2178:	202f 0018      	move.l 24(sp),d0
    217c:	222f 001c      	move.l 28(sp),d1
    2180:	242f 0020      	move.l 32(sp),d2
		while (len--)
    2184:	2242           	movea.l d2,a1
    2186:	5389           	subq.l #1,a1
	if (d < s) {
    2188:	b280           	cmp.l d0,d1
    218a:	636c           	bls.s 21f8 <memmove+0x84>
		while (len--)
    218c:	4a82           	tst.l d2
    218e:	6762           	beq.s 21f2 <memmove+0x7e>
    2190:	2441           	movea.l d1,a2
    2192:	528a           	addq.l #1,a2
    2194:	2600           	move.l d0,d3
    2196:	968a           	sub.l a2,d3
    2198:	7802           	moveq #2,d4
    219a:	b883           	cmp.l d3,d4
    219c:	55c3           	sc.s d3
    219e:	4403           	neg.b d3
    21a0:	7a08           	moveq #8,d5
    21a2:	ba89           	cmp.l a1,d5
    21a4:	55c4           	sc.s d4
    21a6:	4404           	neg.b d4
    21a8:	c604           	and.b d4,d3
    21aa:	6770           	beq.s 221c <memmove+0xa8>
    21ac:	2600           	move.l d0,d3
    21ae:	8681           	or.l d1,d3
    21b0:	7803           	moveq #3,d4
    21b2:	c684           	and.l d4,d3
    21b4:	6666           	bne.s 221c <memmove+0xa8>
    21b6:	2041           	movea.l d1,a0
    21b8:	2440           	movea.l d0,a2
    21ba:	76fc           	moveq #-4,d3
    21bc:	c682           	and.l d2,d3
    21be:	d681           	add.l d1,d3
			*d++ = *s++;
    21c0:	24d8           	move.l (a0)+,(a2)+
		while (len--)
    21c2:	b688           	cmp.l a0,d3
    21c4:	66fa           	bne.s 21c0 <memmove+0x4c>
    21c6:	76fc           	moveq #-4,d3
    21c8:	c682           	and.l d2,d3
    21ca:	2440           	movea.l d0,a2
    21cc:	d5c3           	adda.l d3,a2
    21ce:	2041           	movea.l d1,a0
    21d0:	d1c3           	adda.l d3,a0
    21d2:	93c3           	suba.l d3,a1
    21d4:	b682           	cmp.l d2,d3
    21d6:	671a           	beq.s 21f2 <memmove+0x7e>
			*d++ = *s++;
    21d8:	1490           	move.b (a0),(a2)
		while (len--)
    21da:	b2fc 0000      	cmpa.w #0,a1
    21de:	6712           	beq.s 21f2 <memmove+0x7e>
			*d++ = *s++;
    21e0:	1568 0001 0001 	move.b 1(a0),1(a2)
		while (len--)
    21e6:	7a01           	moveq #1,d5
    21e8:	ba89           	cmp.l a1,d5
    21ea:	6706           	beq.s 21f2 <memmove+0x7e>
			*d++ = *s++;
    21ec:	1568 0002 0002 	move.b 2(a0),2(a2)
}
    21f2:	4cdf 043c      	movem.l (sp)+,d2-d5/a2
    21f6:	4e75           	rts
		const char *lasts = s + (len - 1);
    21f8:	41f1 1800      	lea (0,a1,d1.l),a0
		char *lastd = d + (len - 1);
    21fc:	d3c0           	adda.l d0,a1
		while (len--)
    21fe:	4a82           	tst.l d2
    2200:	67f0           	beq.s 21f2 <memmove+0x7e>
    2202:	2208           	move.l a0,d1
    2204:	9282           	sub.l d2,d1
			*lastd-- = *lasts--;
    2206:	1290           	move.b (a0),(a1)
		while (len--)
    2208:	5388           	subq.l #1,a0
    220a:	5389           	subq.l #1,a1
    220c:	b288           	cmp.l a0,d1
    220e:	67e2           	beq.s 21f2 <memmove+0x7e>
			*lastd-- = *lasts--;
    2210:	1290           	move.b (a0),(a1)
		while (len--)
    2212:	5388           	subq.l #1,a0
    2214:	5389           	subq.l #1,a1
    2216:	b288           	cmp.l a0,d1
    2218:	66ec           	bne.s 2206 <memmove+0x92>
    221a:	60d6           	bra.s 21f2 <memmove+0x7e>
    221c:	2240           	movea.l d0,a1
    221e:	d282           	add.l d2,d1
			*d++ = *s++;
    2220:	12ea ffff      	move.b -1(a2),(a1)+
		while (len--)
    2224:	b28a           	cmp.l a2,d1
    2226:	67ca           	beq.s 21f2 <memmove+0x7e>
    2228:	528a           	addq.l #1,a2
    222a:	60f4           	bra.s 2220 <memmove+0xac>

0000222c <__mulsi3>:
	.text
	FUNC(__mulsi3)
	.globl	SYM (__mulsi3)
SYM (__mulsi3):
	.cfi_startproc
	movew	sp@(4), d0	/* x0 -> d0 */
    222c:	302f 0004      	move.w 4(sp),d0
	muluw	sp@(10), d0	/* x0*y1 */
    2230:	c0ef 000a      	mulu.w 10(sp),d0
	movew	sp@(6), d1	/* x1 -> d1 */
    2234:	322f 0006      	move.w 6(sp),d1
	muluw	sp@(8), d1	/* x1*y0 */
    2238:	c2ef 0008      	mulu.w 8(sp),d1
	addw	d1, d0
    223c:	d041           	add.w d1,d0
	swap	d0
    223e:	4840           	swap d0
	clrw	d0
    2240:	4240           	clr.w d0
	movew	sp@(6), d1	/* x1 -> d1 */
    2242:	322f 0006      	move.w 6(sp),d1
	muluw	sp@(10), d1	/* x1*y1 */
    2246:	c2ef 000a      	mulu.w 10(sp),d1
	addl	d1, d0
    224a:	d081           	add.l d1,d0
	rts
    224c:	4e75           	rts

0000224e <__udivsi3>:
	.text
	FUNC(__udivsi3)
	.globl	SYM (__udivsi3)
SYM (__udivsi3):
	.cfi_startproc
	movel	d2, sp@-
    224e:	2f02           	move.l d2,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	sp@(12), d1	/* d1 = divisor */
    2250:	222f 000c      	move.l 12(sp),d1
	movel	sp@(8), d0	/* d0 = dividend */
    2254:	202f 0008      	move.l 8(sp),d0

	cmpl	IMM (0x10000), d1 /* divisor >= 2 ^ 16 ?   */
    2258:	0c81 0001 0000 	cmpi.l #65536,d1
	jcc	3f		/* then try next algorithm */
    225e:	6416           	bcc.s 2276 <__udivsi3+0x28>
	movel	d0, d2
    2260:	2400           	move.l d0,d2
	clrw	d2
    2262:	4242           	clr.w d2
	swap	d2
    2264:	4842           	swap d2
	divu	d1, d2          /* high quotient in lower word */
    2266:	84c1           	divu.w d1,d2
	movew	d2, d0		/* save high quotient */
    2268:	3002           	move.w d2,d0
	swap	d0
    226a:	4840           	swap d0
	movew	sp@(10), d2	/* get low dividend + high rest */
    226c:	342f 000a      	move.w 10(sp),d2
	divu	d1, d2		/* low quotient */
    2270:	84c1           	divu.w d1,d2
	movew	d2, d0
    2272:	3002           	move.w d2,d0
	jra	6f
    2274:	6030           	bra.s 22a6 <__udivsi3+0x58>

3:	movel	d1, d2		/* use d2 as divisor backup */
    2276:	2401           	move.l d1,d2
4:	lsrl	IMM (1), d1	/* shift divisor */
    2278:	e289           	lsr.l #1,d1
	lsrl	IMM (1), d0	/* shift dividend */
    227a:	e288           	lsr.l #1,d0
	cmpl	IMM (0x10000), d1 /* still divisor >= 2 ^ 16 ?  */
    227c:	0c81 0001 0000 	cmpi.l #65536,d1
	jcc	4b
    2282:	64f4           	bcc.s 2278 <__udivsi3+0x2a>
	divu	d1, d0		/* now we have 16-bit divisor */
    2284:	80c1           	divu.w d1,d0
	andl	IMM (0xffff), d0 /* mask out divisor, ignore remainder */
    2286:	0280 0000 ffff 	andi.l #65535,d0

/* Multiply the 16-bit tentative quotient with the 32-bit divisor.  Because of
   the operand ranges, this might give a 33-bit product.  If this product is
   greater than the dividend, the tentative quotient was too large. */
	movel	d2, d1
    228c:	2202           	move.l d2,d1
	mulu	d0, d1		/* low part, 32 bits */
    228e:	c2c0           	mulu.w d0,d1
	swap	d2
    2290:	4842           	swap d2
	mulu	d0, d2		/* high part, at most 17 bits */
    2292:	c4c0           	mulu.w d0,d2
	swap	d2		/* align high part with low part */
    2294:	4842           	swap d2
	tstw	d2		/* high part 17 bits? */
    2296:	4a42           	tst.w d2
	jne	5f		/* if 17 bits, quotient was too large */
    2298:	660a           	bne.s 22a4 <__udivsi3+0x56>
	addl	d2, d1		/* add parts */
    229a:	d282           	add.l d2,d1
	jcs	5f		/* if sum is 33 bits, quotient was too large */
    229c:	6506           	bcs.s 22a4 <__udivsi3+0x56>
	cmpl	sp@(8), d1	/* compare the sum with the dividend */
    229e:	b2af 0008      	cmp.l 8(sp),d1
	jls	6f		/* if sum > dividend, quotient was too large */
    22a2:	6302           	bls.s 22a6 <__udivsi3+0x58>
5:	subql	IMM (1), d0	/* adjust quotient */
    22a4:	5380           	subq.l #1,d0

6:	movel	sp@+, d2
    22a6:	241f           	move.l (sp)+,d2
	.cfi_adjust_cfa_offset -4
	rts
    22a8:	4e75           	rts

000022aa <__divsi3>:
	.text
	FUNC(__divsi3)
	.globl	SYM (__divsi3)
SYM (__divsi3):
	.cfi_startproc
	movel	d2, sp@-
    22aa:	2f02           	move.l d2,-(sp)
	.cfi_adjust_cfa_offset 4

	moveq	IMM (1), d2	/* sign of result stored in d2 (=1 or =-1) */
    22ac:	7401           	moveq #1,d2
	movel	sp@(12), d1	/* d1 = divisor */
    22ae:	222f 000c      	move.l 12(sp),d1
	jpl	1f
    22b2:	6a04           	bpl.s 22b8 <__divsi3+0xe>
	negl	d1
    22b4:	4481           	neg.l d1
	negb	d2		/* change sign because divisor <0  */
    22b6:	4402           	neg.b d2
1:	movel	sp@(8), d0	/* d0 = dividend */
    22b8:	202f 0008      	move.l 8(sp),d0
	jpl	2f
    22bc:	6a04           	bpl.s 22c2 <__divsi3+0x18>
	negl	d0
    22be:	4480           	neg.l d0
	negb	d2
    22c0:	4402           	neg.b d2

2:	movel	d1, sp@-
    22c2:	2f01           	move.l d1,-(sp)
	movel	d0, sp@-
    22c4:	2f00           	move.l d0,-(sp)
	PICCALL	SYM (__udivsi3)	/* divide abs(dividend) by abs(divisor) */
    22c6:	6186           	bsr.s 224e <__udivsi3>
	addql	IMM (8), sp
    22c8:	508f           	addq.l #8,sp

	tstb	d2
    22ca:	4a02           	tst.b d2
	jpl	3f
    22cc:	6a02           	bpl.s 22d0 <__divsi3+0x26>
	negl	d0
    22ce:	4480           	neg.l d0

3:	movel	sp@+, d2
    22d0:	241f           	move.l (sp)+,d2
	.cfi_adjust_cfa_offset -4
	rts
    22d2:	4e75           	rts

000022d4 <__modsi3>:
	.text
	FUNC(__modsi3)
	.globl	SYM (__modsi3)
SYM (__modsi3):
	.cfi_startproc
	movel	sp@(8), d1	/* d1 = divisor */
    22d4:	222f 0008      	move.l 8(sp),d1
	movel	sp@(4), d0	/* d0 = dividend */
    22d8:	202f 0004      	move.l 4(sp),d0
	movel	d1, sp@-
    22dc:	2f01           	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    22de:	2f00           	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	PICCALL	SYM (__divsi3)
    22e0:	61c8           	bsr.s 22aa <__divsi3>
	addql	IMM (8), sp
    22e2:	508f           	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(8), d1	/* d1 = divisor */
    22e4:	222f 0008      	move.l 8(sp),d1
	movel	d1, sp@-
    22e8:	2f01           	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    22ea:	2f00           	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	PICCALL	SYM (__mulsi3)	/* d0 = (a/b)*b */
    22ec:	6100 ff3e      	bsr.w 222c <__mulsi3>
	addql	IMM (8), sp
    22f0:	508f           	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(4), d1	/* d1 = dividend */
    22f2:	222f 0004      	move.l 4(sp),d1
	subl	d0, d1		/* d1 = a - (a/b)*b */
    22f6:	9280           	sub.l d0,d1
	movel	d1, d0
    22f8:	2001           	move.l d1,d0
	rts
    22fa:	4e75           	rts

000022fc <__umodsi3>:
	.text
	FUNC(__umodsi3)
	.globl	SYM (__umodsi3)
SYM (__umodsi3):
	.cfi_startproc
	movel	sp@(8), d1	/* d1 = divisor */
    22fc:	222f 0008      	move.l 8(sp),d1
	movel	sp@(4), d0	/* d0 = dividend */
    2300:	202f 0004      	move.l 4(sp),d0
	movel	d1, sp@-
    2304:	2f01           	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    2306:	2f00           	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	PICCALL	SYM (__udivsi3)
    2308:	6100 ff44      	bsr.w 224e <__udivsi3>
	addql	IMM (8), sp
    230c:	508f           	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(8), d1	/* d1 = divisor */
    230e:	222f 0008      	move.l 8(sp),d1
	movel	d1, sp@-
    2312:	2f01           	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    2314:	2f00           	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	PICCALL	SYM (__mulsi3)	/* d0 = (a/b)*b */
    2316:	6100 ff14      	bsr.w 222c <__mulsi3>
	addql	IMM (8), sp
    231a:	508f           	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(4), d1	/* d1 = dividend */
    231c:	222f 0004      	move.l 4(sp),d1
	subl	d0, d1		/* d1 = a - (a/b)*b */
    2320:	9280           	sub.l d0,d1
	movel	d1, d0
    2322:	2001           	move.l d1,d0
	rts
    2324:	4e75           	rts

00002326 <KPutCharX>:
	FUNC(KPutCharX)
	.globl	SYM (KPutCharX)

SYM(KPutCharX):
	.cfi_startproc
    move.l  a6, -(sp)
    2326:	2f0e           	move.l a6,-(sp)
	.cfi_adjust_cfa_offset 4
    move.l  4.w, a6
    2328:	2c78 0004      	movea.l 4 <_start+0x4>,a6
    jsr     -0x204(a6)
    232c:	4eae fdfc      	jsr -516(a6)
    movea.l (sp)+, a6
    2330:	2c5f           	movea.l (sp)+,a6
	.cfi_adjust_cfa_offset -4
    rts
    2332:	4e75           	rts

00002334 <PutChar>:
	FUNC(PutChar)
	.globl	SYM (PutChar)

SYM(PutChar):
	.cfi_startproc
	move.b d0, (a3)+
    2334:	16c0           	move.b d0,(a3)+
	rts
    2336:	4e75           	rts
