
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
       4:	263c 0000 3bef 	move.l #15343,d3
       a:	0483 0000 3bef 	subi.l #15343,d3
      10:	e483           	asr.l #2,d3
	for (i = 0; i < count; i++)
      12:	6712           	beq.s 26 <_start+0x26>
      14:	45f9 0000 3bef 	lea 3bef <__fini_array_end>,a2
      1a:	7400           	moveq #0,d2
		__preinit_array_start[i]();
      1c:	205a           	movea.l (a2)+,a0
      1e:	4e90           	jsr (a0)
	for (i = 0; i < count; i++)
      20:	5282           	addq.l #1,d2
      22:	b483           	cmp.l d3,d2
      24:	66f6           	bne.s 1c <_start+0x1c>

	count = __init_array_end - __init_array_start;
      26:	263c 0000 3bef 	move.l #15343,d3
      2c:	0483 0000 3bef 	subi.l #15343,d3
      32:	e483           	asr.l #2,d3
	for (i = 0; i < count; i++)
      34:	6712           	beq.s 48 <_start+0x48>
      36:	45f9 0000 3bef 	lea 3bef <__fini_array_end>,a2
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
      4e:	243c 0000 3bef 	move.l #15343,d2
      54:	0482 0000 3bef 	subi.l #15343,d2
      5a:	e482           	asr.l #2,d2
	for (i = count; i > 0; i--)
      5c:	6710           	beq.s 6e <_start+0x6e>
      5e:	45f9 0000 3bef 	lea 3bef <__fini_array_end>,a2
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
      74:	4fef ff44      	lea -188(sp),sp
      78:	48e7 3f3e      	movem.l d2-d7/a2-a6,-(sp)
	GameMatrix.ColorAlive = 4;
	GameMatrix.ColorDead = 0;
	GameMatrix.Columns = 100;
	GameMatrix.Rows = 40;
      7c:	23fc 0028 0064 	move.l #2621540,3eac <GameMatrix+0x8>
      82:	0000 3eac 
      86:	23fc 0004 0000 	move.l #262144,3eb0 <GameMatrix+0xc>
      8c:	0000 3eb0 
      90:	23fc 0005 0005 	move.l #327685,3eb4 <GameMatrix+0x10>
      96:	0000 3eb4 
	return RETURN_OK;
}

int StartApp(RenderData *rd)
{
	SysBase = *((struct ExecBase **)4UL);
      9a:	2c78 0004      	movea.l 4 <_start+0x4>,a6
      9e:	23ce 0000 3e0e 	move.l a6,3e0e <SysBase>
	custom = (struct Custom *)0xdff000;
	unsigned int pens[] = {~0};
      a4:	70ff           	moveq #-1,d0
      a6:	2f40 0040      	move.l d0,64(sp)
	APTR *my_VisualInfo;

	if ((DOSBase = (struct DosLibrary *)OpenLibrary((CONST_STRPTR) "dos.library", 0)))
      aa:	43f9 0000 1a6c 	lea 1a6c <PutChar+0x4>,a1
      b0:	7000           	moveq #0,d0
      b2:	4eae fdd8      	jsr -552(a6)
      b6:	23c0 0000 3e0a 	move.l d0,3e0a <DOSBase>
      bc:	6700 05ca      	beq.w 688 <main+0x614>
	{
		if ((GfxBase = (struct GfxBase *)OpenLibrary((CONST_STRPTR) "graphics.library", 0)))
      c0:	2c79 0000 3e0e 	movea.l 3e0e <SysBase>,a6
      c6:	43f9 0000 1a78 	lea 1a78 <PutChar+0x10>,a1
      cc:	7000           	moveq #0,d0
      ce:	4eae fdd8      	jsr -552(a6)
      d2:	23c0 0000 3e22 	move.l d0,3e22 <GfxBase>
      d8:	6700 05ae      	beq.w 688 <main+0x614>
		{
			if ((IntuitionBase = (struct IntuitionBase *)OpenLibrary((CONST_STRPTR) "intuition.library", 0)))
      dc:	2c79 0000 3e0e 	movea.l 3e0e <SysBase>,a6
      e2:	43f9 0000 1a89 	lea 1a89 <PutChar+0x21>,a1
      e8:	7000           	moveq #0,d0
      ea:	4eae fdd8      	jsr -552(a6)
      ee:	2c40           	movea.l d0,a6
      f0:	23c0 0000 3e16 	move.l d0,3e16 <IntuitionBase>
      f6:	6700 0590      	beq.w 688 <main+0x614>
			{
				if ((GOLRenderData.Screen = (struct Screen *)OpenScreenTags(NULL,
      fa:	2f7c 8000 003a 	move.l #-2147483590,68(sp)
     100:	0044 
     102:	7040           	moveq #64,d0
     104:	d08f           	add.l sp,d0
     106:	2f40 0048      	move.l d0,72(sp)
     10a:	2f7c 8000 0032 	move.l #-2147483598,76(sp)
     110:	004c 
     112:	2f7c 0000 8000 	move.l #32768,80(sp)
     118:	0050 
     11a:	2f7c 8000 0025 	move.l #-2147483611,84(sp)
     120:	0054 
     122:	7204           	moveq #4,d1
     124:	2f41 0058      	move.l d1,88(sp)
     128:	2f7c 8000 003b 	move.l #-2147483589,92(sp)
     12e:	005c 
     130:	7001           	moveq #1,d0
     132:	2f40 0060      	move.l d0,96(sp)
     136:	2f7c 8000 0028 	move.l #-2147483608,100(sp)
     13c:	0064 
     13e:	2f7c 0000 1a9b 	move.l #6811,104(sp)
     144:	0068 
     146:	2f7c 8000 002d 	move.l #-2147483603,108(sp)
     14c:	006c 
     14e:	720f           	moveq #15,d1
     150:	2f41 0070      	move.l d1,112(sp)
     154:	2f7c 8000 0026 	move.l #-2147483610,116(sp)
     15a:	0074 
     15c:	2f40 0078      	move.l d0,120(sp)
     160:	2f7c 8000 0027 	move.l #-2147483609,124(sp)
     166:	007c 
     168:	42af 0080      	clr.l 128(sp)
     16c:	42af 0084      	clr.l 132(sp)
     170:	91c8           	suba.l a0,a0
     172:	43ef 0044      	lea 68(sp),a1
     176:	4eae fd9c      	jsr -612(a6)
     17a:	41f9 0000 3e26 	lea 3e26 <GOLRenderData>,a0
     180:	2080           	move.l d0,(a0)
     182:	6700 0504      	beq.w 688 <main+0x614>
																			SA_Type, CUSTOMSCREEN,
																			SA_DetailPen, 1,
																			SA_BlockPen, 0,
																			TAG_END)))
				{
					if ((GadToolsBase = (struct Library *)OpenLibrary((CONST_STRPTR) "gadtools.library", 0)))
     186:	2c79 0000 3e0e 	movea.l 3e0e <SysBase>,a6
     18c:	43f9 0000 1ab3 	lea 1ab3 <PutChar+0x4b>,a1
     192:	7000           	moveq #0,d0
     194:	4eae fdd8      	jsr -552(a6)
     198:	23c0 0000 3e12 	move.l d0,3e12 <GadToolsBase>
     19e:	6700 04e8      	beq.w 688 <main+0x614>
					{
						if ((GOLRenderData.MainWindow = (struct Window *)OpenWindowTags(NULL,
     1a2:	2f7c 8000 0070 	move.l #-2147483536,68(sp)
     1a8:	0044 
     1aa:	43f9 0000 3e26 	lea 3e26 <GOLRenderData>,a1
     1b0:	2051           	movea.l (a1),a0
     1b2:	2f48 0048      	move.l a0,72(sp)
     1b6:	2f7c 8000 0064 	move.l #-2147483548,76(sp)
     1bc:	004c 
     1be:	42af 0050      	clr.l 80(sp)
     1c2:	2f7c 8000 0065 	move.l #-2147483547,84(sp)
     1c8:	0054 
     1ca:	1028 001e      	move.b 30(a0),d0
     1ce:	4880           	ext.w d0
     1d0:	48c0           	ext.l d0
     1d2:	5280           	addq.l #1,d0
     1d4:	2f40 0058      	move.l d0,88(sp)
     1d8:	2f7c 8000 0066 	move.l #-2147483546,92(sp)
     1de:	005c 
     1e0:	1028 0024      	move.b 36(a0),d0
     1e4:	4880           	ext.w d0
     1e6:	3640           	movea.w d0,a3
     1e8:	1028 0025      	move.b 37(a0),d0
     1ec:	4880           	ext.w d0
     1ee:	3440           	movea.w d0,a2
     1f0:	3039 0000 3eb4 	move.w 3eb4 <GameMatrix+0x10>,d0
     1f6:	c0f9 0000 3eae 	mulu.w 3eae <GameMatrix+0xa>,d0
     1fc:	d08b           	add.l a3,d0
     1fe:	d08a           	add.l a2,d0
     200:	2f40 0060      	move.l d0,96(sp)
     204:	2f7c 8000 0067 	move.l #-2147483545,100(sp)
     20a:	0064 
     20c:	1028 0026      	move.b 38(a0),d0
     210:	4880           	ext.w d0
     212:	3240           	movea.w d0,a1
     214:	1028 0023      	move.b 35(a0),d0
     218:	4880           	ext.w d0
     21a:	3040           	movea.w d0,a0
     21c:	3039 0000 3eb6 	move.w 3eb6 <GameMatrix+0x12>,d0
     222:	c0f9 0000 3eac 	mulu.w 3eac <GameMatrix+0x8>,d0
     228:	d089           	add.l a1,d0
     22a:	d088           	add.l a0,d0
     22c:	2f40 0068      	move.l d0,104(sp)
     230:	2f7c 8000 0074 	move.l #-2147483532,108(sp)
     236:	006c 
     238:	203c 0000 0280 	move.l #640,d0
     23e:	908b           	sub.l a3,d0
     240:	908a           	sub.l a2,d0
     242:	2f40 0070      	move.l d0,112(sp)
     246:	2f7c 8000 0075 	move.l #-2147483531,116(sp)
     24c:	0074 
     24e:	203c 0000 0100 	move.l #256,d0
     254:	9088           	sub.l a0,d0
     256:	9089           	sub.l a1,d0
     258:	2f40 0078      	move.l d0,120(sp)
     25c:	2f7c 8000 006e 	move.l #-2147483538,124(sp)
     262:	007c 
     264:	2f7c 0000 1ac4 	move.l #6852,128(sp)
     26a:	0080 
     26c:	2f7c 8000 0083 	move.l #-2147483517,132(sp)
     272:	0084 
     274:	7001           	moveq #1,d0
     276:	2f40 0088      	move.l d0,136(sp)
     27a:	2f7c 8000 0084 	move.l #-2147483516,140(sp)
     280:	008c 
     282:	2f40 0090      	move.l d0,144(sp)
     286:	2f7c 8000 0081 	move.l #-2147483519,148(sp)
     28c:	0094 
     28e:	2f40 0098      	move.l d0,152(sp)
     292:	2f7c 8000 0082 	move.l #-2147483518,156(sp)
     298:	009c 
     29a:	2f40 00a0      	move.l d0,160(sp)
     29e:	2f7c 8000 0091 	move.l #-2147483503,164(sp)
     2a4:	00a4 
     2a6:	2f40 00a8      	move.l d0,168(sp)
     2aa:	2f7c 8000 0086 	move.l #-2147483514,172(sp)
     2b0:	00ac 
     2b2:	2f40 00b0      	move.l d0,176(sp)
     2b6:	2f7c 8000 0093 	move.l #-2147483501,180(sp)
     2bc:	00b4 
     2be:	2f40 00b8      	move.l d0,184(sp)
     2c2:	2f7c 8000 0089 	move.l #-2147483511,188(sp)
     2c8:	00bc 
     2ca:	2f40 00c0      	move.l d0,192(sp)
     2ce:	2f7c 8000 006f 	move.l #-2147483537,196(sp)
     2d4:	00c4 
     2d6:	2f7c 0000 1acc 	move.l #6860,200(sp)
     2dc:	00c8 
     2de:	2f7c 8000 006a 	move.l #-2147483542,204(sp)
     2e4:	00cc 
     2e6:	2f7c 0000 031e 	move.l #798,208(sp)
     2ec:	00d0 
     2ee:	2f7c 8000 0068 	move.l #-2147483544,212(sp)
     2f4:	00d4 
     2f6:	7204           	moveq #4,d1
     2f8:	2f41 00d8      	move.l d1,216(sp)
     2fc:	2f7c 8000 0069 	move.l #-2147483543,220(sp)
     302:	00dc 
     304:	7008           	moveq #8,d0
     306:	2f40 00e0      	move.l d0,224(sp)
     30a:	42af 00e4      	clr.l 228(sp)
     30e:	2c79 0000 3e16 	movea.l 3e16 <IntuitionBase>,a6
     314:	91c8           	suba.l a0,a0
     316:	43ef 0044      	lea 68(sp),a1
     31a:	4eae fda2      	jsr -606(a6)
     31e:	2040           	movea.l d0,a0
     320:	23c0 0000 3e2a 	move.l d0,3e2a <GOLRenderData+0x4>
     326:	6700 0360      	beq.w 688 <main+0x614>

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
     33e:	33c1 0000 3e32 	move.w d1,3e32 <GOLRenderData+0xc>
	rd->OutputSize.y =
		rd->MainWindow->Height - rd->MainWindow->BorderTop - rd->MainWindow->BorderBottom;
     344:	1028 0037      	move.b 55(a0),d0
     348:	4880           	ext.w d0
     34a:	1228 0039      	move.b 57(a0),d1
     34e:	4881           	ext.w d1
     350:	d041           	add.w d1,d0
     352:	3268 000a      	movea.w 10(a0),a1
     356:	92c0           	suba.w d0,a1
     358:	33c9 0000 3e34 	move.w a1,3e34 <GOLRenderData+0xe>
							my_VisualInfo = GetVisualInfo(GOLRenderData.MainWindow->WScreen, TAG_END);
     35e:	42af 0044      	clr.l 68(sp)
     362:	2c79 0000 3e12 	movea.l 3e12 <GadToolsBase>,a6
     368:	2068 002e      	movea.l 46(a0),a0
     36c:	43ef 0044      	lea 68(sp),a1
     370:	4eae ff82      	jsr -126(a6)
     374:	2400           	move.l d0,d2
							MainMenuStrip = CreateMenus(GolMainMenu, TAG_END);
     376:	42af 0044      	clr.l 68(sp)
     37a:	2c79 0000 3e12 	movea.l 3e12 <GadToolsBase>,a6
     380:	41f9 0000 3bf0 	lea 3bf0 <GolMainMenu>,a0
     386:	43ef 0044      	lea 68(sp),a1
     38a:	4eae ffd0      	jsr -48(a6)
     38e:	2040           	movea.l d0,a0
     390:	23c0 0000 3e1e 	move.l d0,3e1e <MainMenuStrip>
							LayoutMenus(MainMenuStrip, my_VisualInfo, TAG_END);
     396:	42af 0044      	clr.l 68(sp)
     39a:	2c79 0000 3e12 	movea.l 3e12 <GadToolsBase>,a6
     3a0:	2242           	movea.l d2,a1
     3a2:	45ef 0044      	lea 68(sp),a2
     3a6:	4eae ffbe      	jsr -66(a6)
							SetMenuStrip(GOLRenderData.MainWindow, MainMenuStrip);
     3aa:	2c79 0000 3e16 	movea.l 3e16 <IntuitionBase>,a6
     3b0:	2079 0000 3e2a 	movea.l 3e2a <GOLRenderData+0x4>,a0
     3b6:	2279 0000 3e1e 	movea.l 3e1e <MainMenuStrip>,a1
     3bc:	4eae fef8      	jsr -264(a6)
	if (AllocPlayfieldMem() != RETURN_OK)
     3c0:	4eb9 0000 10e4 	jsr 10e4 <AllocPlayfieldMem>
     3c6:	4a80           	tst.l d0
     3c8:	6600 0c92      	bne.w 105c <main+0xfe8>
	if (PrepareBackbuffer(&GOLRenderData) != RETURN_OK)
     3cc:	4eb9 0000 12c0 	jsr 12c0 <PrepareBackbuffer.constprop.0>
     3d2:	2f40 003c      	move.l d0,60(sp)
     3d6:	6600 0c84      	bne.w 105c <main+0xfe8>
	SetRast(GOLRenderData.MainWindow->RPort, 0);
     3da:	2c79 0000 3e22 	movea.l 3e22 <GfxBase>,a6
     3e0:	2079 0000 3e2a 	movea.l 3e2a <GOLRenderData+0x4>,a0
     3e6:	2268 0032      	movea.l 50(a0),a1
     3ea:	4eae ff16      	jsr -234(a6)
	SetRast(&GOLRenderData.Rastport, 0);
     3ee:	2c79 0000 3e22 	movea.l 3e22 <GfxBase>,a6
     3f4:	43f9 0000 3e3a 	lea 3e3a <GOLRenderData+0x14>,a1
     3fa:	7000           	moveq #0,d0
     3fc:	4eae ff16      	jsr -234(a6)
	while (AppRunning)
     400:	4a79 0000 3df8 	tst.w 3df8 <AppRunning>
     406:	6700 01be      	beq.w 5c6 <main+0x552>
					ClearPlayfield(GameMatrix.Playfield);
     40a:	4bf9 0000 3ea4 	lea 3ea4 <GameMatrix>,a5
		EventLoop(GOLRenderData.MainWindow, MainMenuStrip);
     410:	2f79 0000 3e1e 	move.l 3e1e <MainMenuStrip>,52(sp)
     416:	0034 
     418:	2679 0000 3e2a 	movea.l 3e2a <GOLRenderData+0x4>,a3
	if (!GameRunning)
     41e:	4a79 0000 3e1c 	tst.w 3e1c <GameRunning>
     424:	6606           	bne.s 42c <main+0x3b8>
		UpdateCnt = 0;
     426:	4279 0000 3e1a 	clr.w 3e1a <UpdateCnt>
	while ((message = (struct IntuiMessage *)GetMsg(theWindow->UserPort)))
     42c:	2c79 0000 3e0e 	movea.l 3e0e <SysBase>,a6
     432:	206b 0056      	movea.l 86(a3),a0
     436:	4eae fe8c      	jsr -372(a6)
     43a:	2440           	movea.l d0,a2
     43c:	4a80           	tst.l d0
     43e:	6700 00b4      	beq.w 4f4 <main+0x480>
		msg_class = message->Class;
     442:	242a 0014      	move.l 20(a2),d2
		msg_code = message->Code;
     446:	382a 0018      	move.w 24(a2),d4
		coordX = message->MouseX - theWindow->BorderLeft;
     44a:	102b 0036      	move.b 54(a3),d0
     44e:	4880           	ext.w d0
     450:	3a2a 0020      	move.w 32(a2),d5
     454:	9a40           	sub.w d0,d5
		coordY = message->MouseY - theWindow->BorderTop;
     456:	102b 0037      	move.b 55(a3),d0
     45a:	4880           	ext.w d0
     45c:	362a 0022      	move.w 34(a2),d3
     460:	9640           	sub.w d0,d3
		ReplyMsg((struct Message *)message);
     462:	2c79 0000 3e0e 	movea.l 3e0e <SysBase>,a6
     468:	224a           	movea.l a2,a1
     46a:	4eae fe86      	jsr -378(a6)
		switch (msg_class)
     46e:	7010           	moveq #16,d0
     470:	b082           	cmp.l d2,d0
     472:	6700 028a      	beq.w 6fe <main+0x68a>
     476:	6500 0268      	bcs.w 6e0 <main+0x66c>
     47a:	7204           	moveq #4,d1
     47c:	b282           	cmp.l d2,d1
     47e:	6700 02e8      	beq.w 768 <main+0x6f4>
     482:	7008           	moveq #8,d0
     484:	b082           	cmp.l d2,d0
     486:	6600 0214      	bne.w 69c <main+0x628>
			x = (coordX / GameMatrix.CellSizeH) + 1;
     48a:	3c45           	movea.w d5,a6
			y = (coordY / GameMatrix.CellSizeV) + 1;
     48c:	3443           	movea.w d3,a2
     48e:	7000           	moveq #0,d0
     490:	3039 0000 3eb6 	move.w 3eb6 <GameMatrix+0x12>,d0
     496:	49f9 0000 19de 	lea 19de <__divsi3>,a4
     49c:	2f00           	move.l d0,-(sp)
     49e:	2f0a           	move.l a2,-(sp)
     4a0:	4e94           	jsr (a4)
     4a2:	508f           	addq.l #8,sp
     4a4:	2600           	move.l d0,d3
     4a6:	5283           	addq.l #1,d3
			x = (coordX / GameMatrix.CellSizeH) + 1;
     4a8:	7000           	moveq #0,d0
     4aa:	3039 0000 3eb4 	move.w 3eb4 <GameMatrix+0x10>,d0
     4b0:	2f00           	move.l d0,-(sp)
     4b2:	2f0e           	move.l a6,-(sp)
     4b4:	4e94           	jsr (a4)
     4b6:	508f           	addq.l #8,sp
     4b8:	2400           	move.l d0,d2
     4ba:	5282           	addq.l #1,d2
     4bc:	0c44 0068      	cmpi.w #104,d4
     4c0:	6700 0808      	beq.w cca <main+0xc56>
     4c4:	0c44 00e8      	cmpi.w #232,d4
     4c8:	6600 0266      	bne.w 730 <main+0x6bc>
				DrawActive = FALSE;
     4cc:	4279 0000 3e04 	clr.w 3e04 <DrawActive>
			OldSelectX = x;
     4d2:	23c2 0000 3e00 	move.l d2,3e00 <OldSelectX>
			OldSelectY = y;
     4d8:	23c3 0000 3dfc 	move.l d3,3dfc <OldSelectY>
	while ((message = (struct IntuiMessage *)GetMsg(theWindow->UserPort)))
     4de:	2c79 0000 3e0e 	movea.l 3e0e <SysBase>,a6
     4e4:	206b 0056      	movea.l 86(a3),a0
     4e8:	4eae fe8c      	jsr -372(a6)
     4ec:	2440           	movea.l d0,a2
     4ee:	4a80           	tst.l d0
     4f0:	6600 ff50      	bne.w 442 <main+0x3ce>
		if (GOLRenderData.PPG_Window)
     4f4:	2679 0000 3e2e 	movea.l 3e2e <GOLRenderData+0x8>,a3
     4fa:	b6fc 0000      	cmpa.w #0,a3
     4fe:	6766           	beq.s 566 <main+0x4f2>
	while ((message = (struct IntuiMessage *)GetMsg(theWindow->UserPort)) && GOLRenderData.PPG_WinOpen)
     500:	2c79 0000 3e0e 	movea.l 3e0e <SysBase>,a6
     506:	206b 0056      	movea.l 86(a3),a0
     50a:	4eae fe8c      	jsr -372(a6)
     50e:	2440           	movea.l d0,a2
     510:	4a80           	tst.l d0
     512:	6752           	beq.s 566 <main+0x4f2>
     514:	4a79 0000 3ea2 	tst.w 3ea2 <GOLRenderData+0x7c>
     51a:	674a           	beq.s 566 <main+0x4f2>
		msg_class = message->Class;
     51c:	242a 0014      	move.l 20(a2),d2
		ReplyMsg((struct Message *)message);
     520:	2c79 0000 3e0e 	movea.l 3e0e <SysBase>,a6
     526:	224a           	movea.l a2,a1
     528:	4eae fe86      	jsr -378(a6)
		switch (msg_class)
     52c:	0c82 0000 0100 	cmpi.l #256,d2
     532:	6700 09b8      	beq.w eec <main+0xe78>
     536:	0c82 0000 0200 	cmpi.l #512,d2
     53c:	66c2           	bne.s 500 <main+0x48c>
			CloseWindow(theWindow);
     53e:	2c79 0000 3e16 	movea.l 3e16 <IntuitionBase>,a6
     544:	204b           	movea.l a3,a0
     546:	4eae ffb8      	jsr -72(a6)
			GOLRenderData.PPG_WinOpen = FALSE;
     54a:	4279 0000 3ea2 	clr.w 3ea2 <GOLRenderData+0x7c>
			theWindow = 0;
     550:	97cb           	suba.l a3,a3
	while ((message = (struct IntuiMessage *)GetMsg(theWindow->UserPort)) && GOLRenderData.PPG_WinOpen)
     552:	2c79 0000 3e0e 	movea.l 3e0e <SysBase>,a6
     558:	206b 0056      	movea.l 86(a3),a0
     55c:	4eae fe8c      	jsr -372(a6)
     560:	2440           	movea.l d0,a2
     562:	4a80           	tst.l d0
     564:	66ae           	bne.s 514 <main+0x4a0>
		if (GameRunning)
     566:	4a79 0000 3e1c 	tst.w 3e1c <GameRunning>
     56c:	6600 09b0      	bne.w f1e <main+0xeaa>
		if (UpdateCnt > 0)
     570:	3439 0000 3e1a 	move.w 3e1a <UpdateCnt>,d2
     576:	4a42           	tst.w d2
     578:	6600 083e      	bne.w db8 <main+0xd44>
		WaitTOF();
     57c:	2c79 0000 3e22 	movea.l 3e22 <GfxBase>,a6
     582:	4eae fef2      	jsr -270(a6)
}

void RepaintWindow(RenderData *rd)
{
	/* on repaint we simply blit our backbuffer into our window's RastPort */
	BltBitMapRastPort(rd->Backbuffer,
     586:	2c79 0000 3e22 	movea.l 3e22 <GfxBase>,a6
     58c:	2079 0000 3e9e 	movea.l 3e9e <GOLRenderData+0x78>,a0
     592:	7000           	moveq #0,d0
     594:	7200           	moveq #0,d1
     596:	2279 0000 3e2a 	movea.l 3e2a <GOLRenderData+0x4>,a1
     59c:	2269 0032      	movea.l 50(a1),a1
     5a0:	7400           	moveq #0,d2
     5a2:	7600           	moveq #0,d3
     5a4:	3839 0000 3e32 	move.w 3e32 <GOLRenderData+0xc>,d4
     5aa:	48c4           	ext.l d4
     5ac:	3a39 0000 3e34 	move.w 3e34 <GOLRenderData+0xe>,d5
     5b2:	48c5           	ext.l d5
     5b4:	7c3f           	moveq #63,d6
     5b6:	4606           	not.b d6
     5b8:	4eae fda2      	jsr -606(a6)
	while (AppRunning)
     5bc:	4a79 0000 3df8 	tst.w 3df8 <AppRunning>
     5c2:	6600 fe4c      	bne.w 410 <main+0x39c>
	FreePlayfieldMem();
     5c6:	4eb9 0000 1630 	jsr 1630 <FreePlayfieldMem.isra.0>
	FreeBitMap(GOLRenderData.Backbuffer);
     5cc:	2c79 0000 3e22 	movea.l 3e22 <GfxBase>,a6
     5d2:	2079 0000 3e9e 	movea.l 3e9e <GOLRenderData+0x78>,a0
     5d8:	4eae fc64      	jsr -924(a6)
	if (GOLRenderData.PPG_Window)
     5dc:	2079 0000 3e2e 	movea.l 3e2e <GOLRenderData+0x8>,a0
     5e2:	b0fc 0000      	cmpa.w #0,a0
     5e6:	670a           	beq.s 5f2 <main+0x57e>
		CloseWindow(GOLRenderData.PPG_Window);
     5e8:	2c79 0000 3e16 	movea.l 3e16 <IntuitionBase>,a6
     5ee:	4eae ffb8      	jsr -72(a6)
	if (GOLRenderData.MainWindow)
     5f2:	2079 0000 3e2a 	movea.l 3e2a <GOLRenderData+0x4>,a0
     5f8:	b0fc 0000      	cmpa.w #0,a0
     5fc:	670a           	beq.s 608 <main+0x594>
		CloseWindow(GOLRenderData.MainWindow);
     5fe:	2c79 0000 3e16 	movea.l 3e16 <IntuitionBase>,a6
     604:	4eae ffb8      	jsr -72(a6)
	if (GadToolsBase)
     608:	2279 0000 3e12 	movea.l 3e12 <GadToolsBase>,a1
     60e:	b2fc 0000      	cmpa.w #0,a1
     612:	670a           	beq.s 61e <main+0x5aa>
		CloseLibrary((struct Library *)GadToolsBase);
     614:	2c79 0000 3e0e 	movea.l 3e0e <SysBase>,a6
     61a:	4eae fe62      	jsr -414(a6)
	if (GOLRenderData.Screen)
     61e:	43f9 0000 3e26 	lea 3e26 <GOLRenderData>,a1
     624:	2051           	movea.l (a1),a0
     626:	b0fc 0000      	cmpa.w #0,a0
     62a:	670a           	beq.s 636 <main+0x5c2>
		CloseScreen(GOLRenderData.Screen);
     62c:	2c79 0000 3e16 	movea.l 3e16 <IntuitionBase>,a6
     632:	4eae ffbe      	jsr -66(a6)
	if (GfxBase)
     636:	2279 0000 3e22 	movea.l 3e22 <GfxBase>,a1
     63c:	b2fc 0000      	cmpa.w #0,a1
     640:	670a           	beq.s 64c <main+0x5d8>
		CloseLibrary((struct Library *)GfxBase);
     642:	2c79 0000 3e0e 	movea.l 3e0e <SysBase>,a6
     648:	4eae fe62      	jsr -414(a6)
	if (IntuitionBase)
     64c:	2279 0000 3e16 	movea.l 3e16 <IntuitionBase>,a1
     652:	b2fc 0000      	cmpa.w #0,a1
     656:	670a           	beq.s 662 <main+0x5ee>
		CloseLibrary((struct Library *)IntuitionBase);
     658:	2c79 0000 3e0e 	movea.l 3e0e <SysBase>,a6
     65e:	4eae fe62      	jsr -414(a6)
	if (DOSBase)
     662:	2279 0000 3e0a 	movea.l 3e0a <DOSBase>,a1
     668:	b2fc 0000      	cmpa.w #0,a1
     66c:	6700 09ee      	beq.w 105c <main+0xfe8>
		CloseLibrary((struct Library *)DOSBase);
     670:	2c79 0000 3e0e 	movea.l 3e0e <SysBase>,a6
     676:	4eae fe62      	jsr -414(a6)
}
     67a:	202f 003c      	move.l 60(sp),d0
     67e:	4cdf 7cfc      	movem.l (sp)+,d2-d7/a2-a6
     682:	4fef 00bc      	lea 188(sp),sp
     686:	4e75           	rts
		return RETURN_FAIL;
     688:	7214           	moveq #20,d1
     68a:	2f41 003c      	move.l d1,60(sp)
}
     68e:	202f 003c      	move.l 60(sp),d0
     692:	4cdf 7cfc      	movem.l (sp)+,d2-d7/a2-a6
     696:	4fef 00bc      	lea 188(sp),sp
     69a:	4e75           	rts
		switch (msg_class)
     69c:	5582           	subq.l #2,d2
     69e:	6600 fd8c      	bne.w 42c <main+0x3b8>
		rd->MainWindow->Width - rd->MainWindow->BorderLeft - rd->MainWindow->BorderRight;
     6a2:	2079 0000 3e2a 	movea.l 3e2a <GOLRenderData+0x4>,a0
     6a8:	1028 0036      	move.b 54(a0),d0
     6ac:	4880           	ext.w d0
     6ae:	1228 0038      	move.b 56(a0),d1
     6b2:	4881           	ext.w d1
     6b4:	d041           	add.w d1,d0
     6b6:	3268 0008      	movea.w 8(a0),a1
     6ba:	92c0           	suba.w d0,a1
     6bc:	33c9 0000 3e32 	move.w a1,3e32 <GOLRenderData+0xc>
		rd->MainWindow->Height - rd->MainWindow->BorderTop - rd->MainWindow->BorderBottom;
     6c2:	1028 0037      	move.b 55(a0),d0
     6c6:	4880           	ext.w d0
     6c8:	1228 0039      	move.b 57(a0),d1
     6cc:	4881           	ext.w d1
     6ce:	d041           	add.w d1,d0
     6d0:	3068 000a      	movea.w 10(a0),a0
     6d4:	90c0           	suba.w d0,a0
     6d6:	33c8 0000 3e34 	move.w a0,3e34 <GOLRenderData+0xe>
     6dc:	6000 fd4e      	bra.w 42c <main+0x3b8>
		switch (msg_class)
     6e0:	0c82 0000 0100 	cmpi.l #256,d2
     6e6:	6700 02ba      	beq.w 9a2 <main+0x92e>
     6ea:	0c82 0000 0200 	cmpi.l #512,d2
     6f0:	6600 fd3a      	bne.w 42c <main+0x3b8>
			AppRunning = FALSE;
     6f4:	4279 0000 3df8 	clr.w 3df8 <AppRunning>
			break;
     6fa:	6000 fd30      	bra.w 42c <main+0x3b8>
			x = (coordX / GameMatrix.CellSizeH) + 1;
     6fe:	3c45           	movea.w d5,a6
			y = (coordY / GameMatrix.CellSizeV) + 1;
     700:	3443           	movea.w d3,a2
     702:	7000           	moveq #0,d0
     704:	3039 0000 3eb6 	move.w 3eb6 <GameMatrix+0x12>,d0
     70a:	49f9 0000 19de 	lea 19de <__divsi3>,a4
     710:	2f00           	move.l d0,-(sp)
     712:	2f0a           	move.l a2,-(sp)
     714:	4e94           	jsr (a4)
     716:	508f           	addq.l #8,sp
     718:	2600           	move.l d0,d3
     71a:	5283           	addq.l #1,d3
			x = (coordX / GameMatrix.CellSizeH) + 1;
     71c:	7000           	moveq #0,d0
     71e:	3039 0000 3eb4 	move.w 3eb4 <GameMatrix+0x10>,d0
     724:	2f00           	move.l d0,-(sp)
     726:	2f0e           	move.l a6,-(sp)
     728:	4e94           	jsr (a4)
     72a:	508f           	addq.l #8,sp
     72c:	2400           	move.l d0,d2
     72e:	5282           	addq.l #1,d2
			if (DrawActive && (x != OldSelectX || y != OldSelectY))
     730:	4a79 0000 3e04 	tst.w 3e04 <DrawActive>
     736:	6700 fd9a      	beq.w 4d2 <main+0x45e>
     73a:	b4b9 0000 3e00 	cmp.l 3e00 <OldSelectX>,d2
     740:	660a           	bne.s 74c <main+0x6d8>
     742:	b6b9 0000 3dfc 	cmp.l 3dfc <OldSelectY>,d3
     748:	6700 fd88      	beq.w 4d2 <main+0x45e>
				ToggleCellStatus(coordX, coordY);
     74c:	2f0a           	move.l a2,-(sp)
     74e:	2f0e           	move.l a6,-(sp)
     750:	4eb9 0000 1202 	jsr 1202 <ToggleCellStatus>
     756:	508f           	addq.l #8,sp
			OldSelectX = x;
     758:	23c2 0000 3e00 	move.l d2,3e00 <OldSelectX>
			OldSelectY = y;
     75e:	23c3 0000 3dfc 	move.l d3,3dfc <OldSelectY>
			break;
     764:	6000 fd78      	bra.w 4de <main+0x46a>
			SetWindowTitles(GOLRenderData.MainWindow, (STRPTR) "Reconfiguring Memory...", (STRPTR)-1);
     768:	2c79 0000 3e16 	movea.l 3e16 <IntuitionBase>,a6
     76e:	2079 0000 3e2a 	movea.l 3e2a <GOLRenderData+0x4>,a0
     774:	43f9 0000 1ae5 	lea 1ae5 <PutChar+0x7d>,a1
     77a:	347c ffff      	movea.w #-1,a2
     77e:	4eae feec      	jsr -276(a6)
			PrepareBackbuffer(&GOLRenderData);
     782:	4eb9 0000 12c0 	jsr 12c0 <PrepareBackbuffer.constprop.0>
			FreePlayfieldMem();
     788:	4eb9 0000 1630 	jsr 1630 <FreePlayfieldMem.isra.0>
			GameMatrix.Columns = GOLRenderData.OutputSize.x / GameMatrix.CellSizeH +2;
     78e:	7000           	moveq #0,d0
     790:	3039 0000 3eb4 	move.w 3eb4 <GameMatrix+0x10>,d0
     796:	45f9 0000 19de 	lea 19de <__divsi3>,a2
     79c:	2f00           	move.l d0,-(sp)
     79e:	3079 0000 3e32 	movea.w 3e32 <GOLRenderData+0xc>,a0
     7a4:	2f08           	move.l a0,-(sp)
     7a6:	4e92           	jsr (a2)
     7a8:	508f           	addq.l #8,sp
     7aa:	5440           	addq.w #2,d0
     7ac:	33c0 0000 3eae 	move.w d0,3eae <GameMatrix+0xa>
			GameMatrix.Rows = GOLRenderData.OutputSize.y / GameMatrix.CellSizeV +2;
     7b2:	7000           	moveq #0,d0
     7b4:	3039 0000 3eb6 	move.w 3eb6 <GameMatrix+0x12>,d0
     7ba:	2f00           	move.l d0,-(sp)
     7bc:	3279 0000 3e34 	movea.w 3e34 <GOLRenderData+0xe>,a1
     7c2:	2f09           	move.l a1,-(sp)
     7c4:	4e92           	jsr (a2)
     7c6:	508f           	addq.l #8,sp
     7c8:	5440           	addq.w #2,d0
     7ca:	33c0 0000 3eac 	move.w d0,3eac <GameMatrix+0x8>
			AllocPlayfieldMem();
     7d0:	4eb9 0000 10e4 	jsr 10e4 <AllocPlayfieldMem>
			SetRast(&GOLRenderData.Rastport, 0);
     7d6:	2c79 0000 3e22 	movea.l 3e22 <GfxBase>,a6
     7dc:	43f9 0000 3e3a 	lea 3e3a <GOLRenderData+0x14>,a1
     7e2:	7000           	moveq #0,d0
     7e4:	4eae ff16      	jsr -234(a6)
	for (int y = 1; y < GameMatrix.Rows - 1; y++)
     7e8:	0c79 0002 0000 	cmpi.w #2,3eac <GameMatrix+0x8>
     7ee:	3eac 
     7f0:	6300 00da      	bls.w 8cc <main+0x858>
		for (int x = 1; x < GameMatrix.Columns - 1; x++)
     7f4:	3239 0000 3eae 	move.w 3eae <GameMatrix+0xa>,d1
	for (int y = 1; y < GameMatrix.Rows - 1; y++)
     7fa:	7001           	moveq #1,d0
     7fc:	2f40 0030      	move.l d0,48(sp)
				SetAPen(&rd->Rastport, GameMatrix.ColorDead);
     800:	283c 0000 3e3a 	move.l #15930,d4
		for (int x = 1; x < GameMatrix.Columns - 1; x++)
     806:	0c41 0002      	cmpi.w #2,d1
     80a:	6300 00c0      	bls.w 8cc <main+0x858>
     80e:	222f 0030      	move.l 48(sp),d1
     812:	5381           	subq.l #1,d1
     814:	2f41 002c      	move.l d1,44(sp)
     818:	7a04           	moveq #4,d5
     81a:	347c 0001      	movea.w #1,a2
     81e:	2f4b 0038      	move.l a3,56(sp)
     822:	2c2f 0030      	move.l 48(sp),d6
				SetAPen(&rd->Rastport, GameMatrix.ColorAlive);
     826:	2c79 0000 3e22 	movea.l 3e22 <GfxBase>,a6
			if (GameMatrix.Playfield[x][y].Status)
     82c:	2055           	movea.l (a5),a0
     82e:	2070 5800      	movea.l (0,a0,d5.l),a0
				SetAPen(&rd->Rastport, GameMatrix.ColorAlive);
     832:	2244           	movea.l d4,a1
     834:	7000           	moveq #0,d0
			if (GameMatrix.Playfield[x][y].Status)
     836:	4a30 6800      	tst.b (0,a0,d6.l)
     83a:	6700 00ee      	beq.w 92a <main+0x8b6>
				SetAPen(&rd->Rastport, GameMatrix.ColorAlive);
     83e:	3039 0000 3eb0 	move.w 3eb0 <GameMatrix+0xc>,d0
     844:	4eae feaa      	jsr -342(a6)
			RectFill(&rd->Rastport,
     848:	7400           	moveq #0,d2
     84a:	3439 0000 3eb4 	move.w 3eb4 <GameMatrix+0x10>,d2
     850:	2f02           	move.l d2,-(sp)
     852:	486a ffff      	pea -1(a2)
     856:	4eb9 0000 1960 	jsr 1960 <__mulsi3>
     85c:	508f           	addq.l #8,sp
     85e:	2840           	movea.l d0,a4
     860:	2e00           	move.l d0,d7
     862:	5287           	addq.l #1,d7
     864:	7000           	moveq #0,d0
     866:	3039 0000 3eb6 	move.w 3eb6 <GameMatrix+0x12>,d0
     86c:	2640           	movea.l d0,a3
     86e:	2f2f 002c      	move.l 44(sp),-(sp)
     872:	2f0b           	move.l a3,-(sp)
     874:	4eb9 0000 1960 	jsr 1960 <__mulsi3>
     87a:	508f           	addq.l #8,sp
     87c:	2600           	move.l d0,d3
     87e:	2c79 0000 3e22 	movea.l 3e22 <GfxBase>,a6
     884:	2244           	movea.l d4,a1
     886:	2007           	move.l d7,d0
     888:	2203           	move.l d3,d1
     88a:	5281           	addq.l #1,d1
     88c:	49f4 28ff      	lea (-1,a4,d2.l),a4
     890:	240c           	move.l a4,d2
     892:	47f3 38ff      	lea (-1,a3,d3.l),a3
     896:	260b           	move.l a3,d3
     898:	4eae fece      	jsr -306(a6)
		for (int x = 1; x < GameMatrix.Columns - 1; x++)
     89c:	528a           	addq.l #1,a2
     89e:	3239 0000 3eae 	move.w 3eae <GameMatrix+0xa>,d1
     8a4:	5885           	addq.l #4,d5
     8a6:	7000           	moveq #0,d0
     8a8:	3001           	move.w d1,d0
     8aa:	5380           	subq.l #1,d0
     8ac:	b08a           	cmp.l a2,d0
     8ae:	6e00 ff76      	bgt.w 826 <main+0x7b2>
	for (int y = 1; y < GameMatrix.Rows - 1; y++)
     8b2:	266f 0038      	movea.l 56(sp),a3
     8b6:	52af 0030      	addq.l #1,48(sp)
     8ba:	7000           	moveq #0,d0
     8bc:	3039 0000 3eac 	move.w 3eac <GameMatrix+0x8>,d0
     8c2:	5380           	subq.l #1,d0
     8c4:	b0af 0030      	cmp.l 48(sp),d0
     8c8:	6e00 ff3c      	bgt.w 806 <main+0x792>
	BltBitMapRastPort(rd->Backbuffer,
     8cc:	2c79 0000 3e22 	movea.l 3e22 <GfxBase>,a6
     8d2:	2079 0000 3e9e 	movea.l 3e9e <GOLRenderData+0x78>,a0
     8d8:	7000           	moveq #0,d0
     8da:	7200           	moveq #0,d1
     8dc:	2279 0000 3e2a 	movea.l 3e2a <GOLRenderData+0x4>,a1
     8e2:	2269 0032      	movea.l 50(a1),a1
     8e6:	7400           	moveq #0,d2
     8e8:	7600           	moveq #0,d3
     8ea:	3839 0000 3e32 	move.w 3e32 <GOLRenderData+0xc>,d4
     8f0:	48c4           	ext.l d4
     8f2:	3a39 0000 3e34 	move.w 3e34 <GOLRenderData+0xe>,d5
     8f8:	48c5           	ext.l d5
     8fa:	7c3f           	moveq #63,d6
     8fc:	4606           	not.b d6
     8fe:	4eae fda2      	jsr -606(a6)
			GameRunning ? SetWindowTitles(GOLRenderData.MainWindow, (STRPTR) "Running", (STRPTR)-1) : SetWindowTitles(GOLRenderData.MainWindow, (STRPTR) "Stopped", (STRPTR)-1);
     902:	2c79 0000 3e16 	movea.l 3e16 <IntuitionBase>,a6
     908:	2079 0000 3e2a 	movea.l 3e2a <GOLRenderData+0x4>,a0
     90e:	4a79 0000 3e1c 	tst.w 3e1c <GameRunning>
     914:	6700 036a      	beq.w c80 <main+0xc0c>
     918:	43f9 0000 1afd 	lea 1afd <PutChar+0x95>,a1
     91e:	347c ffff      	movea.w #-1,a2
     922:	4eae feec      	jsr -276(a6)
     926:	6000 fb04      	bra.w 42c <main+0x3b8>
				SetAPen(&rd->Rastport, GameMatrix.ColorDead);
     92a:	3039 0000 3eb2 	move.w 3eb2 <GameMatrix+0xe>,d0
     930:	4eae feaa      	jsr -342(a6)
			RectFill(&rd->Rastport,
     934:	7400           	moveq #0,d2
     936:	3439 0000 3eb4 	move.w 3eb4 <GameMatrix+0x10>,d2
     93c:	2f02           	move.l d2,-(sp)
     93e:	486a ffff      	pea -1(a2)
     942:	4eb9 0000 1960 	jsr 1960 <__mulsi3>
     948:	508f           	addq.l #8,sp
     94a:	2840           	movea.l d0,a4
     94c:	2e00           	move.l d0,d7
     94e:	5287           	addq.l #1,d7
     950:	7000           	moveq #0,d0
     952:	3039 0000 3eb6 	move.w 3eb6 <GameMatrix+0x12>,d0
     958:	2640           	movea.l d0,a3
     95a:	2f2f 002c      	move.l 44(sp),-(sp)
     95e:	2f0b           	move.l a3,-(sp)
     960:	4eb9 0000 1960 	jsr 1960 <__mulsi3>
     966:	508f           	addq.l #8,sp
     968:	2600           	move.l d0,d3
     96a:	2c79 0000 3e22 	movea.l 3e22 <GfxBase>,a6
     970:	2244           	movea.l d4,a1
     972:	2007           	move.l d7,d0
     974:	2203           	move.l d3,d1
     976:	5281           	addq.l #1,d1
     978:	49f4 28ff      	lea (-1,a4,d2.l),a4
     97c:	240c           	move.l a4,d2
     97e:	47f3 38ff      	lea (-1,a3,d3.l),a3
     982:	260b           	move.l a3,d3
     984:	4eae fece      	jsr -306(a6)
		for (int x = 1; x < GameMatrix.Columns - 1; x++)
     988:	528a           	addq.l #1,a2
     98a:	3239 0000 3eae 	move.w 3eae <GameMatrix+0xa>,d1
     990:	5885           	addq.l #4,d5
     992:	7000           	moveq #0,d0
     994:	3001           	move.w d1,d0
     996:	5380           	subq.l #1,d0
     998:	b08a           	cmp.l a2,d0
     99a:	6e00 fe8a      	bgt.w 826 <main+0x7b2>
     99e:	6000 ff12      	bra.w 8b2 <main+0x83e>
			menuNumber = message->Code;
     9a2:	342a 0018      	move.w 24(a2),d2
			while ((menuNumber != MENUNULL) && (AppRunning))
     9a6:	0c42 ffff      	cmpi.w #-1,d2
     9aa:	6700 fa80      	beq.w 42c <main+0x3b8>
     9ae:	4a79 0000 3df8 	tst.w 3df8 <AppRunning>
     9b4:	6700 fa76      	beq.w 42c <main+0x3b8>
				item = ItemAddress(theMenu, menuNumber);
     9b8:	2c79 0000 3e16 	movea.l 3e16 <IntuitionBase>,a6
     9be:	206f 0034      	movea.l 52(sp),a0
     9c2:	3002           	move.w d2,d0
     9c4:	4eae ff70      	jsr -144(a6)
     9c8:	2f40 002c      	move.l d0,44(sp)
				menuNum = MENUNUM(menuNumber);
     9cc:	3202           	move.w d2,d1
     9ce:	0241 001f      	andi.w #31,d1
				itemNum = ITEMNUM(menuNumber);
     9d2:	3002           	move.w d2,d0
     9d4:	ea48           	lsr.w #5,d0
     9d6:	0240 003f      	andi.w #63,d0
				if ((menuNum == 0) && (itemNum == 5))
     9da:	4a41           	tst.w d1
     9dc:	665a           	bne.s a38 <main+0x9c4>
     9de:	0c40 0005      	cmpi.w #5,d0
     9e2:	6700 01d4      	beq.w bb8 <main+0xb44>
				if ((menuNum == 0) && (itemNum == 1))
     9e6:	0c40 0001      	cmpi.w #1,d0
     9ea:	6700 01fc      	beq.w be8 <main+0xb74>
				if ((menuNum == 0) && (itemNum == 3) && (subNum == 2))
     9ee:	0c40 0003      	cmpi.w #3,d0
     9f2:	6630           	bne.s a24 <main+0x9b0>
				subNum = SUBNUM(menuNumber);
     9f4:	720b           	moveq #11,d1
     9f6:	e26a           	lsr.w d1,d2
				if ((menuNum == 0) && (itemNum == 3) && (subNum == 2))
     9f8:	0c42 0002      	cmpi.w #2,d2
     9fc:	6700 032a      	beq.w d28 <main+0xcb4>
				if ((menuNum == 0) && (itemNum == 3) && (subNum == 0))
     a00:	4a42           	tst.w d2
     a02:	6600 028e      	bne.w c92 <main+0xc1e>
					SetWindowTitles(theWindow, (STRPTR) "Running", (STRPTR)-1);
     a06:	2c79 0000 3e16 	movea.l 3e16 <IntuitionBase>,a6
     a0c:	204b           	movea.l a3,a0
     a0e:	43f9 0000 1afd 	lea 1afd <PutChar+0x95>,a1
     a14:	347c ffff      	movea.w #-1,a2
     a18:	4eae feec      	jsr -276(a6)
					GameRunning = TRUE;
     a1c:	33fc 0001 0000 	move.w #1,3e1c <GameRunning>
     a22:	3e1c 
				menuNumber = item->NextSelect;
     a24:	206f 002c      	movea.l 44(sp),a0
     a28:	3428 0020      	move.w 32(a0),d2
			while ((menuNumber != MENUNULL) && (AppRunning))
     a2c:	0c42 ffff      	cmpi.w #-1,d2
     a30:	6600 ff7c      	bne.w 9ae <main+0x93a>
     a34:	6000 f9f6      	bra.w 42c <main+0x3b8>
				if ((menuNum == 2) && (itemNum == 0))
     a38:	0c41 0002      	cmpi.w #2,d1
     a3c:	66e6           	bne.s a24 <main+0x9b0>
     a3e:	4a40           	tst.w d0
     a40:	66e2           	bne.s a24 <main+0x9b0>
	return RETURN_OK;
}

void RunPPG_Window(RenderData *rd)
{
	GOLRenderData.PPG_Window = (struct Window *)OpenWindowTags(NULL,
     a42:	2f7c 8000 0070 	move.l #-2147483536,68(sp)
     a48:	0044 
     a4a:	43f9 0000 3e26 	lea 3e26 <GOLRenderData>,a1
     a50:	2051           	movea.l (a1),a0
     a52:	2f48 0048      	move.l a0,72(sp)
     a56:	2f7c 8000 0064 	move.l #-2147483548,76(sp)
     a5c:	004c 
     a5e:	42af 0050      	clr.l 80(sp)
     a62:	2f7c 8000 0065 	move.l #-2147483547,84(sp)
     a68:	0054 
     a6a:	1028 001e      	move.b 30(a0),d0
     a6e:	4880           	ext.w d0
     a70:	48c0           	ext.l d0
     a72:	5280           	addq.l #1,d0
     a74:	2f40 0058      	move.l d0,88(sp)
     a78:	2f7c 8000 0066 	move.l #-2147483546,92(sp)
     a7e:	005c 
     a80:	7078           	moveq #120,d0
     a82:	2f40 0060      	move.l d0,96(sp)
     a86:	2f7c 8000 0067 	move.l #-2147483545,100(sp)
     a8c:	0064 
     a8e:	2f7c 0000 00fa 	move.l #250,104(sp)
     a94:	0068 
     a96:	2f7c 8000 0074 	move.l #-2147483532,108(sp)
     a9c:	006c 
     a9e:	1028 0024      	move.b 36(a0),d0
     aa2:	4880           	ext.w d0
     aa4:	327c 0280      	movea.w #640,a1
     aa8:	92c0           	suba.w d0,a1
     aaa:	1028 0025      	move.b 37(a0),d0
     aae:	4880           	ext.w d0
     ab0:	92c0           	suba.w d0,a1
     ab2:	2f49 0070      	move.l a1,112(sp)
     ab6:	2f7c 8000 0075 	move.l #-2147483531,116(sp)
     abc:	0074 
     abe:	1028 0023      	move.b 35(a0),d0
     ac2:	4880           	ext.w d0
     ac4:	327c 0100      	movea.w #256,a1
     ac8:	92c0           	suba.w d0,a1
     aca:	1028 0026      	move.b 38(a0),d0
     ace:	4880           	ext.w d0
     ad0:	92c0           	suba.w d0,a1
     ad2:	2f49 0078      	move.l a1,120(sp)
     ad6:	2f7c 8000 006e 	move.l #-2147483538,124(sp)
     adc:	007c 
     ade:	2f7c 0000 1b19 	move.l #6937,128(sp)
     ae4:	0080 
     ae6:	2f7c 8000 0083 	move.l #-2147483517,132(sp)
     aec:	0084 
     aee:	7201           	moveq #1,d1
     af0:	2f41 0088      	move.l d1,136(sp)
     af4:	2f7c 8000 0084 	move.l #-2147483516,140(sp)
     afa:	008c 
     afc:	2f41 0090      	move.l d1,144(sp)
     b00:	2f7c 8000 0081 	move.l #-2147483519,148(sp)
     b06:	0094 
     b08:	2f41 0098      	move.l d1,152(sp)
     b0c:	2f7c 8000 0082 	move.l #-2147483518,156(sp)
     b12:	009c 
     b14:	2f41 00a0      	move.l d1,160(sp)
     b18:	2f7c 8000 0091 	move.l #-2147483503,164(sp)
     b1e:	00a4 
     b20:	2f41 00a8      	move.l d1,168(sp)
     b24:	2f7c 8000 0086 	move.l #-2147483514,172(sp)
     b2a:	00ac 
     b2c:	2f41 00b0      	move.l d1,176(sp)
     b30:	2f7c 8000 0093 	move.l #-2147483501,180(sp)
     b36:	00b4 
     b38:	2f41 00b8      	move.l d1,184(sp)
     b3c:	2f7c 8000 0089 	move.l #-2147483511,188(sp)
     b42:	00bc 
     b44:	2f41 00c0      	move.l d1,192(sp)
     b48:	2f7c 8000 006f 	move.l #-2147483537,196(sp)
     b4e:	00c4 
     b50:	2f7c 0000 1b2c 	move.l #6956,200(sp)
     b56:	00c8 
     b58:	2f7c 8000 006a 	move.l #-2147483542,204(sp)
     b5e:	00cc 
     b60:	2f7c 0000 031e 	move.l #798,208(sp)
     b66:	00d0 
     b68:	2f7c 8000 0068 	move.l #-2147483544,212(sp)
     b6e:	00d4 
     b70:	2f41 00d8      	move.l d1,216(sp)
     b74:	2f7c 8000 0069 	move.l #-2147483543,220(sp)
     b7a:	00dc 
     b7c:	7002           	moveq #2,d0
     b7e:	2f40 00e0      	move.l d0,224(sp)
     b82:	42af 00e4      	clr.l 228(sp)
     b86:	2c79 0000 3e16 	movea.l 3e16 <IntuitionBase>,a6
     b8c:	91c8           	suba.l a0,a0
     b8e:	43ef 0044      	lea 68(sp),a1
     b92:	4eae fda2      	jsr -606(a6)
     b96:	23c0 0000 3e2e 	move.l d0,3e2e <GOLRenderData+0x8>
					GOLRenderData.PPG_WinOpen = TRUE;
     b9c:	33fc 0001 0000 	move.w #1,3ea2 <GOLRenderData+0x7c>
     ba2:	3ea2 
				menuNumber = item->NextSelect;
     ba4:	206f 002c      	movea.l 44(sp),a0
     ba8:	3428 0020      	move.w 32(a0),d2
			while ((menuNumber != MENUNULL) && (AppRunning))
     bac:	0c42 ffff      	cmpi.w #-1,d2
     bb0:	6600 fdfc      	bne.w 9ae <main+0x93a>
     bb4:	6000 f876      	bra.w 42c <main+0x3b8>
					AppRunning = FALSE;
     bb8:	4279 0000 3df8 	clr.w 3df8 <AppRunning>
					SetWindowTitles(theWindow, (STRPTR) "Running", (STRPTR)-1);
     bbe:	2c79 0000 3e16 	movea.l 3e16 <IntuitionBase>,a6
     bc4:	204b           	movea.l a3,a0
     bc6:	43f9 0000 1afd 	lea 1afd <PutChar+0x95>,a1
     bcc:	347c ffff      	movea.w #-1,a2
     bd0:	4eae feec      	jsr -276(a6)
				menuNumber = item->NextSelect;
     bd4:	206f 002c      	movea.l 44(sp),a0
     bd8:	3428 0020      	move.w 32(a0),d2
			while ((menuNumber != MENUNULL) && (AppRunning))
     bdc:	0c42 ffff      	cmpi.w #-1,d2
     be0:	6600 fdcc      	bne.w 9ae <main+0x93a>
     be4:	6000 f846      	bra.w 42c <main+0x3b8>
					SavePlayfield((CONST_STRPTR) "test.gold", 1, 1, GameMatrix.Columns - 1, GameMatrix.Rows - 1);
     be8:	7200           	moveq #0,d1
     bea:	3239 0000 3eac 	move.w 3eac <GameMatrix+0x8>,d1
     bf0:	2841           	movea.l d1,a4
     bf2:	7000           	moveq #0,d0
     bf4:	3039 0000 3eae 	move.w 3eae <GameMatrix+0xa>,d0
     bfa:	2440           	movea.l d0,a2
	fh = Open(file, MODE_NEWFILE);
     bfc:	2c79 0000 3e0a 	movea.l 3e0a <DOSBase>,a6
     c02:	223c 0000 1b05 	move.l #6917,d1
     c08:	243c 0000 03ee 	move.l #1006,d2
     c0e:	4eae ffe2      	jsr -30(a6)
     c12:	2e00           	move.l d0,d7
	for (int x = startX; x < (startX + width); x++)
     c14:	7201           	moveq #1,d1
     c16:	b28a           	cmp.l a2,d1
     c18:	6c46           	bge.s c60 <main+0xbec>
     c1a:	b28c           	cmp.l a4,d1
     c1c:	6c42           	bge.s c60 <main+0xbec>
     c1e:	7c04           	moveq #4,d6
     c20:	7a01           	moveq #1,d5
		for (int y = startY; y < (startY + height); y++)
     c22:	7801           	moveq #1,d4
			args[0] = x;
     c24:	2f45 0044      	move.l d5,68(sp)
			args[1] = y;
     c28:	2f44 0048      	move.l d4,72(sp)
			args[2] = GameMatrix.Playfield[x][y].Status;
     c2c:	2055           	movea.l (a5),a0
     c2e:	2070 6800      	movea.l (0,a0,d6.l),a0
     c32:	7000           	moveq #0,d0
     c34:	1030 4800      	move.b (0,a0,d4.l),d0
     c38:	2f40 004c      	move.l d0,76(sp)
			VFPrintf(fh, (CONST_STRPTR) "%d,%d,%d\n", args);
     c3c:	2c79 0000 3e0a 	movea.l 3e0a <DOSBase>,a6
     c42:	2207           	move.l d7,d1
     c44:	243c 0000 1b0f 	move.l #6927,d2
     c4a:	7644           	moveq #68,d3
     c4c:	d68f           	add.l sp,d3
     c4e:	4eae fe9e      	jsr -354(a6)
		for (int y = startY; y < (startY + height); y++)
     c52:	5284           	addq.l #1,d4
     c54:	b88c           	cmp.l a4,d4
     c56:	66cc           	bne.s c24 <main+0xbb0>
	for (int x = startX; x < (startX + width); x++)
     c58:	5285           	addq.l #1,d5
     c5a:	5886           	addq.l #4,d6
     c5c:	ba8a           	cmp.l a2,d5
     c5e:	66c2           	bne.s c22 <main+0xbae>
	Close(fh);
     c60:	2c79 0000 3e0a 	movea.l 3e0a <DOSBase>,a6
     c66:	2207           	move.l d7,d1
     c68:	4eae ffdc      	jsr -36(a6)
				menuNumber = item->NextSelect;
     c6c:	206f 002c      	movea.l 44(sp),a0
     c70:	3428 0020      	move.w 32(a0),d2
			while ((menuNumber != MENUNULL) && (AppRunning))
     c74:	0c42 ffff      	cmpi.w #-1,d2
     c78:	6600 fd34      	bne.w 9ae <main+0x93a>
     c7c:	6000 f7ae      	bra.w 42c <main+0x3b8>
			GameRunning ? SetWindowTitles(GOLRenderData.MainWindow, (STRPTR) "Running", (STRPTR)-1) : SetWindowTitles(GOLRenderData.MainWindow, (STRPTR) "Stopped", (STRPTR)-1);
     c80:	43f9 0000 1ac4 	lea 1ac4 <PutChar+0x5c>,a1
     c86:	347c ffff      	movea.w #-1,a2
     c8a:	4eae feec      	jsr -276(a6)
     c8e:	6000 f79c      	bra.w 42c <main+0x3b8>
				if ((menuNum == 0) && (itemNum == 3) && (subNum == 1))
     c92:	0c42 0001      	cmpi.w #1,d2
     c96:	6600 fd8c      	bne.w a24 <main+0x9b0>
					SetWindowTitles(theWindow, (STRPTR) "Stopped", (STRPTR)-1);
     c9a:	2c79 0000 3e16 	movea.l 3e16 <IntuitionBase>,a6
     ca0:	204b           	movea.l a3,a0
     ca2:	43f9 0000 1ac4 	lea 1ac4 <PutChar+0x5c>,a1
     ca8:	347c ffff      	movea.w #-1,a2
     cac:	4eae feec      	jsr -276(a6)
					GameRunning = FALSE;
     cb0:	4279 0000 3e1c 	clr.w 3e1c <GameRunning>
				menuNumber = item->NextSelect;
     cb6:	206f 002c      	movea.l 44(sp),a0
     cba:	3428 0020      	move.w 32(a0),d2
			while ((menuNumber != MENUNULL) && (AppRunning))
     cbe:	0c42 ffff      	cmpi.w #-1,d2
     cc2:	6600 fcea      	bne.w 9ae <main+0x93a>
     cc6:	6000 f764      	bra.w 42c <main+0x3b8>
				if (!GameRunning)
     cca:	4a79 0000 3e1c 	tst.w 3e1c <GameRunning>
     cd0:	6600 fa5e      	bne.w 730 <main+0x6bc>
					DrawActive = TRUE;
     cd4:	33fc 0001 0000 	move.w #1,3e04 <DrawActive>
     cda:	3e04 
					ToggleCellStatus(coordX, coordY);
     cdc:	2f0a           	move.l a2,-(sp)
     cde:	2f0e           	move.l a6,-(sp)
     ce0:	4eb9 0000 1202 	jsr 1202 <ToggleCellStatus>
					UpdateList[UpdateCnt].X = x;
     ce6:	3239 0000 3e1a 	move.w 3e1a <UpdateCnt>,d1
     cec:	7000           	moveq #0,d0
     cee:	3001           	move.w d1,d0
     cf0:	2240           	movea.l d0,a1
     cf2:	d3c0           	adda.l d0,a1
     cf4:	d3c0           	adda.l d0,a1
     cf6:	d3c9           	adda.l a1,a1
     cf8:	d3f9 0000 3e06 	adda.l 3e06 <UpdateList>,a1
     cfe:	3282           	move.w d2,(a1)
					UpdateList[UpdateCnt].Y = y;
     d00:	3343 0002      	move.w d3,2(a1)
					UpdateList[UpdateCnt++].Status = GameMatrix.Playfield[x][y].Status;
     d04:	2055           	movea.l (a5),a0
     d06:	2002           	move.l d2,d0
     d08:	d082           	add.l d2,d0
     d0a:	d080           	add.l d0,d0
     d0c:	2070 0800      	movea.l (0,a0,d0.l),a0
     d10:	5241           	addq.w #1,d1
     d12:	33c1 0000 3e1a 	move.w d1,3e1a <UpdateCnt>
     d18:	4240           	clr.w d0
     d1a:	1030 3800      	move.b (0,a0,d3.l),d0
     d1e:	3340 0004      	move.w d0,4(a1)
     d22:	508f           	addq.l #8,sp
     d24:	6000 fa14      	bra.w 73a <main+0x6c6>
					ClearPlayfield(GameMatrix.Playfield);
     d28:	2455           	movea.l (a5),a2
	for (int x = 0; x < GameMatrix.Columns; x++)
     d2a:	3439 0000 3eae 	move.w 3eae <GameMatrix+0xa>,d2
     d30:	674a           	beq.s d7c <main+0xd08>
		memset(pf[x], 0, GameMatrix.Rows * sizeof(GameOfLifeCell));
     d32:	7600           	moveq #0,d3
     d34:	3639 0000 3eac 	move.w 3eac <GameMatrix+0x8>,d3
     d3a:	0282 0000 ffff 	andi.l #65535,d2
     d40:	d482           	add.l d2,d2
     d42:	d482           	add.l d2,d2
     d44:	280a           	move.l a2,d4
     d46:	d882           	add.l d2,d4
     d48:	201a           	move.l (a2)+,d0
     d4a:	2f03           	move.l d3,-(sp)
     d4c:	42a7           	clr.l -(sp)
     d4e:	2f00           	move.l d0,-(sp)
     d50:	4eb9 0000 174c 	jsr 174c <memset>
	for (int x = 0; x < GameMatrix.Columns; x++)
     d56:	4fef 000c      	lea 12(sp),sp
     d5a:	b5c4           	cmpa.l d4,a2
     d5c:	66ea           	bne.s d48 <main+0xcd4>
     d5e:	2479 0000 3ea8 	movea.l 3ea8 <GameMatrix+0x4>,a2
     d64:	d48a           	add.l a2,d2
		memset(pf[x], 0, GameMatrix.Rows * sizeof(GameOfLifeCell));
     d66:	201a           	move.l (a2)+,d0
     d68:	2f03           	move.l d3,-(sp)
     d6a:	42a7           	clr.l -(sp)
     d6c:	2f00           	move.l d0,-(sp)
     d6e:	4eb9 0000 174c 	jsr 174c <memset>
	for (int x = 0; x < GameMatrix.Columns; x++)
     d74:	4fef 000c      	lea 12(sp),sp
     d78:	b48a           	cmp.l a2,d2
     d7a:	66ea           	bne.s d66 <main+0xcf2>
					SetRast(GOLRenderData.MainWindow->RPort, 0);
     d7c:	2c79 0000 3e22 	movea.l 3e22 <GfxBase>,a6
     d82:	2079 0000 3e2a 	movea.l 3e2a <GOLRenderData+0x4>,a0
     d88:	2268 0032      	movea.l 50(a0),a1
     d8c:	7000           	moveq #0,d0
     d8e:	4eae ff16      	jsr -234(a6)
					SetRast(&GOLRenderData.Rastport, 0);
     d92:	2c79 0000 3e22 	movea.l 3e22 <GfxBase>,a6
     d98:	43f9 0000 3e3a 	lea 3e3a <GOLRenderData+0x14>,a1
     d9e:	7000           	moveq #0,d0
     da0:	4eae ff16      	jsr -234(a6)
				menuNumber = item->NextSelect;
     da4:	206f 002c      	movea.l 44(sp),a0
     da8:	3428 0020      	move.w 32(a0),d2
			while ((menuNumber != MENUNULL) && (AppRunning))
     dac:	0c42 ffff      	cmpi.w #-1,d2
     db0:	6600 fbfc      	bne.w 9ae <main+0x93a>
     db4:	6000 f676      	bra.w 42c <main+0x3b8>
	for (int entry = 0; entry < UpdateCnt; entry++)
     db8:	7a00           	moveq #0,d5
		if (UpdateCnt > 0)
     dba:	7800           	moveq #0,d4
     dbc:	47f9 0000 1960 	lea 1960 <__mulsi3>,a3
			SetAPen(&rd->Rastport, GameMatrix.ColorDead);
     dc2:	2c3c 0000 3e3a 	move.l #15930,d6
		int x = UpdateList[entry].X;
     dc8:	2079 0000 3e06 	movea.l 3e06 <UpdateList>,a0
     dce:	d1c4           	adda.l d4,a0
     dd0:	7e00           	moveq #0,d7
     dd2:	3e10           	move.w (a0),d7
		int y = UpdateList[entry].Y;
     dd4:	7600           	moveq #0,d3
     dd6:	3628 0002      	move.w 2(a0),d3
			SetAPen(&rd->Rastport, GameMatrix.ColorAlive);
     dda:	2c79 0000 3e22 	movea.l 3e22 <GfxBase>,a6
     de0:	2246           	movea.l d6,a1
     de2:	7000           	moveq #0,d0
		if (s)
     de4:	4a68 0004      	tst.w 4(a0)
     de8:	6700 0092      	beq.w e7c <main+0xe08>
			SetAPen(&rd->Rastport, GameMatrix.ColorAlive);
     dec:	3039 0000 3eb0 	move.w 3eb0 <GameMatrix+0xc>,d0
     df2:	4eae feaa      	jsr -342(a6)
		RectFill(&rd->Rastport,
     df6:	7400           	moveq #0,d2
     df8:	3439 0000 3eb4 	move.w 3eb4 <GameMatrix+0x10>,d2
     dfe:	2f02           	move.l d2,-(sp)
     e00:	2047           	movea.l d7,a0
     e02:	4868 ffff      	pea -1(a0)
     e06:	4e93           	jsr (a3)
     e08:	508f           	addq.l #8,sp
     e0a:	2440           	movea.l d0,a2
     e0c:	49ea 0001      	lea 1(a2),a4
     e10:	7e00           	moveq #0,d7
     e12:	3e39 0000 3eb6 	move.w 3eb6 <GameMatrix+0x12>,d7
     e18:	2f07           	move.l d7,-(sp)
     e1a:	2243           	movea.l d3,a1
     e1c:	4869 ffff      	pea -1(a1)
     e20:	4e93           	jsr (a3)
     e22:	508f           	addq.l #8,sp
     e24:	2600           	move.l d0,d3
     e26:	2c79 0000 3e22 	movea.l 3e22 <GfxBase>,a6
     e2c:	2246           	movea.l d6,a1
     e2e:	200c           	move.l a4,d0
     e30:	2203           	move.l d3,d1
     e32:	5281           	addq.l #1,d1
     e34:	45f2 28ff      	lea (-1,a2,d2.l),a2
     e38:	240a           	move.l a2,d2
     e3a:	2047           	movea.l d7,a0
     e3c:	41f0 38ff      	lea (-1,a0,d3.l),a0
     e40:	2608           	move.l a0,d3
     e42:	4eae fece      	jsr -306(a6)
	for (int entry = 0; entry < UpdateCnt; entry++)
     e46:	5285           	addq.l #1,d5
     e48:	5c84           	addq.l #6,d4
     e4a:	7000           	moveq #0,d0
     e4c:	3039 0000 3e1a 	move.w 3e1a <UpdateCnt>,d0
     e52:	b085           	cmp.l d5,d0
     e54:	6f00 f726      	ble.w 57c <main+0x508>
		int x = UpdateList[entry].X;
     e58:	2079 0000 3e06 	movea.l 3e06 <UpdateList>,a0
     e5e:	d1c4           	adda.l d4,a0
     e60:	7e00           	moveq #0,d7
     e62:	3e10           	move.w (a0),d7
		int y = UpdateList[entry].Y;
     e64:	7600           	moveq #0,d3
     e66:	3628 0002      	move.w 2(a0),d3
			SetAPen(&rd->Rastport, GameMatrix.ColorAlive);
     e6a:	2c79 0000 3e22 	movea.l 3e22 <GfxBase>,a6
     e70:	2246           	movea.l d6,a1
     e72:	7000           	moveq #0,d0
		if (s)
     e74:	4a68 0004      	tst.w 4(a0)
     e78:	6600 ff72      	bne.w dec <main+0xd78>
			SetAPen(&rd->Rastport, GameMatrix.ColorDead);
     e7c:	3039 0000 3eb2 	move.w 3eb2 <GameMatrix+0xe>,d0
     e82:	4eae feaa      	jsr -342(a6)
		RectFill(&rd->Rastport,
     e86:	7400           	moveq #0,d2
     e88:	3439 0000 3eb4 	move.w 3eb4 <GameMatrix+0x10>,d2
     e8e:	2f02           	move.l d2,-(sp)
     e90:	2047           	movea.l d7,a0
     e92:	4868 ffff      	pea -1(a0)
     e96:	4e93           	jsr (a3)
     e98:	508f           	addq.l #8,sp
     e9a:	2440           	movea.l d0,a2
     e9c:	49ea 0001      	lea 1(a2),a4
     ea0:	7e00           	moveq #0,d7
     ea2:	3e39 0000 3eb6 	move.w 3eb6 <GameMatrix+0x12>,d7
     ea8:	2f07           	move.l d7,-(sp)
     eaa:	2243           	movea.l d3,a1
     eac:	4869 ffff      	pea -1(a1)
     eb0:	4e93           	jsr (a3)
     eb2:	508f           	addq.l #8,sp
     eb4:	2600           	move.l d0,d3
     eb6:	2c79 0000 3e22 	movea.l 3e22 <GfxBase>,a6
     ebc:	2246           	movea.l d6,a1
     ebe:	200c           	move.l a4,d0
     ec0:	2203           	move.l d3,d1
     ec2:	5281           	addq.l #1,d1
     ec4:	45f2 28ff      	lea (-1,a2,d2.l),a2
     ec8:	240a           	move.l a2,d2
     eca:	2047           	movea.l d7,a0
     ecc:	41f0 38ff      	lea (-1,a0,d3.l),a0
     ed0:	2608           	move.l a0,d3
     ed2:	4eae fece      	jsr -306(a6)
	for (int entry = 0; entry < UpdateCnt; entry++)
     ed6:	5285           	addq.l #1,d5
     ed8:	5c84           	addq.l #6,d4
     eda:	7000           	moveq #0,d0
     edc:	3039 0000 3e1a 	move.w 3e1a <UpdateCnt>,d0
     ee2:	b085           	cmp.l d5,d0
     ee4:	6e00 ff72      	bgt.w e58 <main+0xde4>
     ee8:	6000 f692      	bra.w 57c <main+0x508>
			menuNumber = message->Code;
     eec:	302a 0018      	move.w 24(a2),d0
			while ((menuNumber != MENUNULL) && (AppRunning))
     ef0:	0c40 ffff      	cmpi.w #-1,d0
     ef4:	6700 f60a      	beq.w 500 <main+0x48c>
     ef8:	4a79 0000 3df8 	tst.w 3df8 <AppRunning>
     efe:	6700 f600      	beq.w 500 <main+0x48c>
				item = ItemAddress(theMenu, menuNumber);
     f02:	2c79 0000 3e16 	movea.l 3e16 <IntuitionBase>,a6
     f08:	91c8           	suba.l a0,a0
     f0a:	4eae ff70      	jsr -144(a6)
				menuNumber = item->NextSelect;
     f0e:	2240           	movea.l d0,a1
     f10:	3029 0020      	move.w 32(a1),d0
			while ((menuNumber != MENUNULL) && (AppRunning))
     f14:	0c40 ffff      	cmpi.w #-1,d0
     f18:	66de           	bne.s ef8 <main+0xe84>
     f1a:	6000 f5e4      	bra.w 500 <main+0x48c>
			UpdateCnt = 0;
     f1e:	4279 0000 3e1a 	clr.w 3e1a <UpdateCnt>
	GameOfLifeCell **pf = GameMatrix.Playfield;
     f24:	2f55 0034      	move.l (a5),52(sp)
	GameOfLifeCell **pf_n1 = GameMatrix.Playfield_n1;
     f28:	2f79 0000 3ea8 	move.l 3ea8 <GameMatrix+0x4>,56(sp)
     f2e:	0038 
	for (int x = 1; x < GameMatrix.Columns - 1; x++)
     f30:	7800           	moveq #0,d4
     f32:	3839 0000 3eae 	move.w 3eae <GameMatrix+0xa>,d4
     f38:	7002           	moveq #2,d0
     f3a:	b084           	cmp.l d4,d0
     f3c:	6c00 0130      	bge.w 106e <main+0xffa>
		for (int y = 1; y < GameMatrix.Rows - 1; y++)
     f40:	3f79 0000 3eac 	move.w 3eac <GameMatrix+0x8>,44(sp)
     f46:	002c 
				UpdateList[UpdateCnt].X = x;
     f48:	2e39 0000 3e06 	move.l 3e06 <UpdateList>,d7
     f4e:	286f 0038      	movea.l 56(sp),a4
     f52:	588c           	addq.l #4,a4
     f54:	2c2f 0034      	move.l 52(sp),d6
     f58:	2204           	move.l d4,d1
     f5a:	5381           	subq.l #1,d1
     f5c:	2f41 0030      	move.l d1,48(sp)
     f60:	7a01           	moveq #1,d5
     f62:	4242           	clr.w d2
     f64:	7000           	moveq #0,d0
     f66:	302f 002c      	move.w 44(sp),d0
     f6a:	2240           	movea.l d0,a1
     f6c:	5389           	subq.l #1,a1
		for (int y = 1; y < GameMatrix.Rows - 1; y++)
     f6e:	0c6f 0002 002c 	cmpi.w #2,44(sp)
     f74:	6300 0084      	bls.w ffa <main+0xf86>
     f78:	2046           	movea.l d6,a0
     f7a:	2c50           	movea.l (a0),a6
     f7c:	2468 0008      	movea.l 8(a0),a2
     f80:	2068 0004      	movea.l 4(a0),a0
					if (pf[x + xi][y + yj].Status)
     f84:	7001           	moveq #1,d0
     f86:	4a1e           	tst.b (a6)+
     f88:	56c1           	sne d1
     f8a:	4881           	ext.w d1
     f8c:	4441           	neg.w d1
     f8e:	4a16           	tst.b (a6)
     f90:	6702           	beq.s f94 <main+0xf20>
						neighbours++;
     f92:	5241           	addq.w #1,d1
					if (pf[x + xi][y + yj].Status)
     f94:	4a2e 0001      	tst.b 1(a6)
     f98:	6702           	beq.s f9c <main+0xf28>
						neighbours++;
     f9a:	5241           	addq.w #1,d1
					if (pf[x + xi][y + yj].Status)
     f9c:	4a18           	tst.b (a0)+
     f9e:	6702           	beq.s fa2 <main+0xf2e>
						neighbours++;
     fa0:	5241           	addq.w #1,d1
					if (pf[x + xi][y + yj].Status)
     fa2:	1610           	move.b (a0),d3
     fa4:	6702           	beq.s fa8 <main+0xf34>
						neighbours++;
     fa6:	5241           	addq.w #1,d1
					if (pf[x + xi][y + yj].Status)
     fa8:	4a28 0001      	tst.b 1(a0)
     fac:	6600 012e      	bne.w 10dc <main+0x1068>
     fb0:	4a1a           	tst.b (a2)+
     fb2:	6702           	beq.s fb6 <main+0xf42>
						neighbours++;
     fb4:	5241           	addq.w #1,d1
					if (pf[x + xi][y + yj].Status)
     fb6:	4a12           	tst.b (a2)
     fb8:	6702           	beq.s fbc <main+0xf48>
						neighbours++;
     fba:	5241           	addq.w #1,d1
					if (pf[x + xi][y + yj].Status)
     fbc:	4a2a 0001      	tst.b 1(a2)
     fc0:	6702           	beq.s fc4 <main+0xf50>
						neighbours++;
     fc2:	5241           	addq.w #1,d1
			if (pf[x][y].Status)
     fc4:	4a03           	tst.b d3
     fc6:	6700 00ce      	beq.w 1096 <main+0x1022>
					pf_n1[x][y].Status = 0;
     fca:	2654           	movea.l (a4),a3
     fcc:	d7c0           	adda.l d0,a3
				if (neighbours < 2 || neighbours > 3)
     fce:	5741           	subq.w #3,d1
     fd0:	0c41 0001      	cmpi.w #1,d1
     fd4:	6300 00f8      	bls.w 10ce <main+0x105a>
					pf_n1[x][y].Status = 0;
     fd8:	4213           	clr.b (a3)
					UpdateList[UpdateCnt].X = x;
     fda:	7200           	moveq #0,d1
     fdc:	3202           	move.w d2,d1
     fde:	2641           	movea.l d1,a3
     fe0:	d7c1           	adda.l d1,a3
     fe2:	d7c1           	adda.l d1,a3
     fe4:	d7cb           	adda.l a3,a3
     fe6:	d7c7           	adda.l d7,a3
     fe8:	3685           	move.w d5,(a3)
					UpdateList[UpdateCnt].Y = y;
     fea:	3740 0002      	move.w d0,2(a3)
					UpdateList[UpdateCnt].Status = pf_n1[x][y].Status;
     fee:	426b 0004      	clr.w 4(a3)
					UpdateCnt++;
     ff2:	5242           	addq.w #1,d2
		for (int y = 1; y < GameMatrix.Rows - 1; y++)
     ff4:	5280           	addq.l #1,d0
     ff6:	b089           	cmp.l a1,d0
     ff8:	668c           	bne.s f86 <main+0xf12>
	for (int x = 1; x < GameMatrix.Columns - 1; x++)
     ffa:	5285           	addq.l #1,d5
     ffc:	588c           	addq.l #4,a4
     ffe:	5886           	addq.l #4,d6
    1000:	baaf 0030      	cmp.l 48(sp),d5
    1004:	6600 ff68      	bne.w f6e <main+0xefa>
    1008:	33c2 0000 3e1a 	move.w d2,3e1a <UpdateCnt>
	for (int col = 0; col < GameMatrix.Columns; col++)
    100e:	4a84           	tst.l d4
    1010:	6700 f564      	beq.w 576 <main+0x502>
		memcpy(pf[col], pf_n1[col], GameMatrix.Rows * sizeof(GameOfLifeCell));
    1014:	7a00           	moveq #0,d5
    1016:	3a2f 002c      	move.w 44(sp),d5
    101a:	266f 0038      	movea.l 56(sp),a3
    101e:	246f 0034      	movea.l 52(sp),a2
	for (int col = 0; col < GameMatrix.Columns; col++)
    1022:	7600           	moveq #0,d3
    1024:	49f9 0000 181a 	lea 181a <memcpy>,a4
		memcpy(pf[col], pf_n1[col], GameMatrix.Rows * sizeof(GameOfLifeCell));
    102a:	221b           	move.l (a3)+,d1
    102c:	201a           	move.l (a2)+,d0
    102e:	2f05           	move.l d5,-(sp)
    1030:	2f01           	move.l d1,-(sp)
    1032:	2f00           	move.l d0,-(sp)
    1034:	4e94           	jsr (a4)
	for (int col = 0; col < GameMatrix.Columns; col++)
    1036:	5283           	addq.l #1,d3
    1038:	4fef 000c      	lea 12(sp),sp
    103c:	b684           	cmp.l d4,d3
    103e:	6c00 f536      	bge.w 576 <main+0x502>
		memcpy(pf[col], pf_n1[col], GameMatrix.Rows * sizeof(GameOfLifeCell));
    1042:	221b           	move.l (a3)+,d1
    1044:	201a           	move.l (a2)+,d0
    1046:	2f05           	move.l d5,-(sp)
    1048:	2f01           	move.l d1,-(sp)
    104a:	2f00           	move.l d0,-(sp)
    104c:	4e94           	jsr (a4)
	for (int col = 0; col < GameMatrix.Columns; col++)
    104e:	5283           	addq.l #1,d3
    1050:	4fef 000c      	lea 12(sp),sp
    1054:	b684           	cmp.l d4,d3
    1056:	6dd2           	blt.s 102a <main+0xfb6>
    1058:	6000 f51c      	bra.w 576 <main+0x502>
    105c:	42af 003c      	clr.l 60(sp)
}
    1060:	202f 003c      	move.l 60(sp),d0
    1064:	4cdf 7cfc      	movem.l (sp)+,d2-d7/a2-a6
    1068:	4fef 00bc      	lea 188(sp),sp
    106c:	4e75           	rts
	for (int col = 0; col < GameMatrix.Columns; col++)
    106e:	4a84           	tst.l d4
    1070:	6700 f50a      	beq.w 57c <main+0x508>
		memcpy(pf[col], pf_n1[col], GameMatrix.Rows * sizeof(GameOfLifeCell));
    1074:	3f79 0000 3eac 	move.w 3eac <GameMatrix+0x8>,44(sp)
    107a:	002c 
    107c:	4242           	clr.w d2
    107e:	7a00           	moveq #0,d5
    1080:	3a2f 002c      	move.w 44(sp),d5
    1084:	266f 0038      	movea.l 56(sp),a3
    1088:	246f 0034      	movea.l 52(sp),a2
	for (int col = 0; col < GameMatrix.Columns; col++)
    108c:	7600           	moveq #0,d3
    108e:	49f9 0000 181a 	lea 181a <memcpy>,a4
    1094:	6094           	bra.s 102a <main+0xfb6>
			else if (neighbours == 3)
    1096:	0c41 0003      	cmpi.w #3,d1
    109a:	6600 ff58      	bne.w ff4 <main+0xf80>
				pf_n1[x][y].Status = 1;
    109e:	2654           	movea.l (a4),a3
    10a0:	17bc 0001 0800 	move.b #1,(0,a3,d0.l)
				UpdateList[UpdateCnt].X = x;
    10a6:	7200           	moveq #0,d1
    10a8:	3202           	move.w d2,d1
    10aa:	2641           	movea.l d1,a3
    10ac:	d7c1           	adda.l d1,a3
    10ae:	d7c1           	adda.l d1,a3
    10b0:	d7cb           	adda.l a3,a3
    10b2:	d7c7           	adda.l d7,a3
    10b4:	3685           	move.w d5,(a3)
				UpdateList[UpdateCnt].Y = y;
    10b6:	3740 0002      	move.w d0,2(a3)
				UpdateList[UpdateCnt].Status = pf_n1[x][y].Status;
    10ba:	377c 0001 0004 	move.w #1,4(a3)
				UpdateCnt++;
    10c0:	5242           	addq.w #1,d2
		for (int y = 1; y < GameMatrix.Rows - 1; y++)
    10c2:	5280           	addq.l #1,d0
    10c4:	b089           	cmp.l a1,d0
    10c6:	6600 febe      	bne.w f86 <main+0xf12>
    10ca:	6000 ff2e      	bra.w ffa <main+0xf86>
					pf_n1[x][y].Status = pf[x][y].Status;
    10ce:	1683           	move.b d3,(a3)
		for (int y = 1; y < GameMatrix.Rows - 1; y++)
    10d0:	5280           	addq.l #1,d0
    10d2:	b089           	cmp.l a1,d0
    10d4:	6600 feb0      	bne.w f86 <main+0xf12>
    10d8:	6000 ff20      	bra.w ffa <main+0xf86>
						neighbours++;
    10dc:	5241           	addq.w #1,d1
    10de:	6000 fed0      	bra.w fb0 <main+0xf3c>
    10e2:	4e71           	nop

000010e4 <AllocPlayfieldMem>:
{
    10e4:	48e7 3822      	movem.l d2-d4/a2/a6,-(sp)
	if ((GameMatrix.Playfield = AllocMem(GameMatrix.Columns * sizeof(GameOfLifeCell *), MEMF_ANY | MEMF_CLEAR)) == NULL)
    10e8:	45f9 0000 3ea4 	lea 3ea4 <GameMatrix>,a2
    10ee:	7000           	moveq #0,d0
    10f0:	3039 0000 3eae 	move.w 3eae <GameMatrix+0xa>,d0
    10f6:	2c79 0000 3e0e 	movea.l 3e0e <SysBase>,a6
    10fc:	e588           	lsl.l #2,d0
    10fe:	7201           	moveq #1,d1
    1100:	4841           	swap d1
    1102:	4eae ff3a      	jsr -198(a6)
    1106:	2480           	move.l d0,(a2)
    1108:	6700 00ba      	beq.w 11c4 <AllocPlayfieldMem+0xe0>
	if ((GameMatrix.Playfield_n1 = AllocMem(GameMatrix.Columns * sizeof(GameOfLifeCell *), MEMF_ANY | MEMF_CLEAR)) == NULL)
    110c:	7000           	moveq #0,d0
    110e:	3039 0000 3eae 	move.w 3eae <GameMatrix+0xa>,d0
    1114:	2c79 0000 3e0e 	movea.l 3e0e <SysBase>,a6
    111a:	e588           	lsl.l #2,d0
    111c:	7201           	moveq #1,d1
    111e:	4841           	swap d1
    1120:	4eae ff3a      	jsr -198(a6)
    1124:	23c0 0000 3ea8 	move.l d0,3ea8 <GameMatrix+0x4>
    112a:	6700 0098      	beq.w 11c4 <AllocPlayfieldMem+0xe0>
	for (int i = 0; i < GameMatrix.Columns; i++)
    112e:	4a79 0000 3eae 	tst.w 3eae <GameMatrix+0xa>
    1134:	6700 0096      	beq.w 11cc <AllocPlayfieldMem+0xe8>
    1138:	7400           	moveq #0,d2
    113a:	7600           	moveq #0,d3
		if ((GameMatrix.Playfield[i] = AllocMem(GameMatrix.Rows * sizeof(GameOfLifeCell), MEMF_ANY | MEMF_CLEAR)) == NULL)
    113c:	7801           	moveq #1,d4
    113e:	4844           	swap d4
    1140:	2c79 0000 3e0e 	movea.l 3e0e <SysBase>,a6
    1146:	7000           	moveq #0,d0
    1148:	3039 0000 3eac 	move.w 3eac <GameMatrix+0x8>,d0
    114e:	2204           	move.l d4,d1
    1150:	4eae ff3a      	jsr -198(a6)
    1154:	2052           	movea.l (a2),a0
    1156:	2180 2800      	move.l d0,(0,a0,d2.l)
    115a:	6768           	beq.s 11c4 <AllocPlayfieldMem+0xe0>
		if ((GameMatrix.Playfield_n1[i] = AllocMem(GameMatrix.Rows * sizeof(GameOfLifeCell), MEMF_ANY | MEMF_CLEAR)) == NULL)
    115c:	2c79 0000 3e0e 	movea.l 3e0e <SysBase>,a6
    1162:	7000           	moveq #0,d0
    1164:	3039 0000 3eac 	move.w 3eac <GameMatrix+0x8>,d0
    116a:	2204           	move.l d4,d1
    116c:	4eae ff3a      	jsr -198(a6)
    1170:	2079 0000 3ea8 	movea.l 3ea8 <GameMatrix+0x4>,a0
    1176:	2180 2800      	move.l d0,(0,a0,d2.l)
    117a:	6748           	beq.s 11c4 <AllocPlayfieldMem+0xe0>
	for (int i = 0; i < GameMatrix.Columns; i++)
    117c:	5283           	addq.l #1,d3
    117e:	7000           	moveq #0,d0
    1180:	3039 0000 3eae 	move.w 3eae <GameMatrix+0xa>,d0
    1186:	5882           	addq.l #4,d2
    1188:	b083           	cmp.l d3,d0
    118a:	6eb4           	bgt.s 1140 <AllocPlayfieldMem+0x5c>
	UpdateList = AllocMem(GameMatrix.Columns * GameMatrix.Rows * sizeof(UpdateListEntry), MEMF_ANY | MEMF_CLEAR);
    118c:	7200           	moveq #0,d1
    118e:	3239 0000 3eac 	move.w 3eac <GameMatrix+0x8>,d1
    1194:	2f00           	move.l d0,-(sp)
    1196:	2f01           	move.l d1,-(sp)
    1198:	4eb9 0000 1960 	jsr 1960 <__mulsi3>
    119e:	508f           	addq.l #8,sp
    11a0:	2200           	move.l d0,d1
    11a2:	d281           	add.l d1,d1
    11a4:	d081           	add.l d1,d0
    11a6:	2c79 0000 3e0e 	movea.l 3e0e <SysBase>,a6
    11ac:	d080           	add.l d0,d0
    11ae:	7201           	moveq #1,d1
    11b0:	4841           	swap d1
    11b2:	4eae ff3a      	jsr -198(a6)
    11b6:	23c0 0000 3e06 	move.l d0,3e06 <UpdateList>
	return RETURN_OK;
    11bc:	7000           	moveq #0,d0
}
    11be:	4cdf 441c      	movem.l (sp)+,d2-d4/a2/a6
    11c2:	4e75           	rts
		return RETURN_FAIL;
    11c4:	7014           	moveq #20,d0
}
    11c6:	4cdf 441c      	movem.l (sp)+,d2-d4/a2/a6
    11ca:	4e75           	rts
	for (int i = 0; i < GameMatrix.Columns; i++)
    11cc:	7000           	moveq #0,d0
	UpdateList = AllocMem(GameMatrix.Columns * GameMatrix.Rows * sizeof(UpdateListEntry), MEMF_ANY | MEMF_CLEAR);
    11ce:	7200           	moveq #0,d1
    11d0:	3239 0000 3eac 	move.w 3eac <GameMatrix+0x8>,d1
    11d6:	2f00           	move.l d0,-(sp)
    11d8:	2f01           	move.l d1,-(sp)
    11da:	4eb9 0000 1960 	jsr 1960 <__mulsi3>
    11e0:	508f           	addq.l #8,sp
    11e2:	2200           	move.l d0,d1
    11e4:	d281           	add.l d1,d1
    11e6:	d081           	add.l d1,d0
    11e8:	2c79 0000 3e0e 	movea.l 3e0e <SysBase>,a6
    11ee:	d080           	add.l d0,d0
    11f0:	7201           	moveq #1,d1
    11f2:	4841           	swap d1
    11f4:	4eae ff3a      	jsr -198(a6)
    11f8:	23c0 0000 3e06 	move.l d0,3e06 <UpdateList>
	return RETURN_OK;
    11fe:	7000           	moveq #0,d0
    1200:	60bc           	bra.s 11be <AllocPlayfieldMem+0xda>

00001202 <ToggleCellStatus>:
{
    1202:	48e7 3020      	movem.l d2-d3/a2,-(sp)
    1206:	262f 0014      	move.l 20(sp),d3
	int x = coordX / GameMatrix.CellSizeH + 1;
    120a:	7000           	moveq #0,d0
    120c:	3039 0000 3eb4 	move.w 3eb4 <GameMatrix+0x10>,d0
    1212:	45f9 0000 19de 	lea 19de <__divsi3>,a2
    1218:	2f00           	move.l d0,-(sp)
    121a:	306f 0016      	movea.w 22(sp),a0
    121e:	2f08           	move.l a0,-(sp)
    1220:	4e92           	jsr (a2)
    1222:	508f           	addq.l #8,sp
    1224:	2400           	move.l d0,d2
    1226:	5282           	addq.l #1,d2
	if (!(x < 0 || x > GameMatrix.Columns - 2 || y < 0 || y > GameMatrix.Rows - 2))
    1228:	6b74           	bmi.s 129e <ToggleCellStatus+0x9c>
    122a:	7000           	moveq #0,d0
    122c:	3039 0000 3eae 	move.w 3eae <GameMatrix+0xa>,d0
    1232:	5380           	subq.l #1,d0
    1234:	b480           	cmp.l d0,d2
    1236:	6c66           	bge.s 129e <ToggleCellStatus+0x9c>
	int y = coordY / GameMatrix.CellSizeV + 1;
    1238:	7000           	moveq #0,d0
    123a:	3039 0000 3eb6 	move.w 3eb6 <GameMatrix+0x12>,d0
    1240:	2f00           	move.l d0,-(sp)
    1242:	3043           	movea.w d3,a0
    1244:	2f08           	move.l a0,-(sp)
    1246:	4e92           	jsr (a2)
    1248:	508f           	addq.l #8,sp
    124a:	5280           	addq.l #1,d0
	if (!(x < 0 || x > GameMatrix.Columns - 2 || y < 0 || y > GameMatrix.Rows - 2))
    124c:	6b50           	bmi.s 129e <ToggleCellStatus+0x9c>
    124e:	7200           	moveq #0,d1
    1250:	3239 0000 3eac 	move.w 3eac <GameMatrix+0x8>,d1
    1256:	5381           	subq.l #1,d1
    1258:	b081           	cmp.l d1,d0
    125a:	6c42           	bge.s 129e <ToggleCellStatus+0x9c>
		if (GameMatrix.Playfield[x][y].Status)
    125c:	2079 0000 3ea4 	movea.l 3ea4 <GameMatrix>,a0
    1262:	2202           	move.l d2,d1
    1264:	d282           	add.l d2,d1
    1266:	d281           	add.l d1,d1
    1268:	2270 1800      	movea.l (0,a0,d1.l),a1
    126c:	d3c0           	adda.l d0,a1
			UpdateList[UpdateCnt].X = x;
    126e:	3239 0000 3e1a 	move.w 3e1a <UpdateCnt>,d1
    1274:	7600           	moveq #0,d3
    1276:	3601           	move.w d1,d3
    1278:	2043           	movea.l d3,a0
    127a:	d1c3           	adda.l d3,a0
    127c:	d1c3           	adda.l d3,a0
    127e:	d1c8           	adda.l a0,a0
    1280:	d1f9 0000 3e06 	adda.l 3e06 <UpdateList>,a0
			UpdateCnt++;
    1286:	5241           	addq.w #1,d1
		if (GameMatrix.Playfield[x][y].Status)
    1288:	4a11           	tst.b (a1)
    128a:	6718           	beq.s 12a4 <ToggleCellStatus+0xa2>
			GameMatrix.Playfield[x][y].Status = 0;
    128c:	4211           	clr.b (a1)
			UpdateList[UpdateCnt].X = x;
    128e:	3082           	move.w d2,(a0)
			UpdateList[UpdateCnt].Y = y;
    1290:	3140 0002      	move.w d0,2(a0)
			UpdateList[UpdateCnt].Status = 0;
    1294:	4268 0004      	clr.w 4(a0)
			UpdateCnt++;
    1298:	33c1 0000 3e1a 	move.w d1,3e1a <UpdateCnt>
}
    129e:	4cdf 040c      	movem.l (sp)+,d2-d3/a2
    12a2:	4e75           	rts
			GameMatrix.Playfield[x][y].Status = 1;
    12a4:	12bc 0001      	move.b #1,(a1)
			UpdateList[UpdateCnt].X = x;
    12a8:	3082           	move.w d2,(a0)
			UpdateList[UpdateCnt].Y = y;
    12aa:	3140 0002      	move.w d0,2(a0)
			UpdateList[UpdateCnt].Status = 1;
    12ae:	317c 0001 0004 	move.w #1,4(a0)
			UpdateCnt++;
    12b4:	33c1 0000 3e1a 	move.w d1,3e1a <UpdateCnt>
}
    12ba:	4cdf 040c      	movem.l (sp)+,d2-d3/a2
    12be:	4e75           	rts

000012c0 <PrepareBackbuffer.constprop.0>:
int PrepareBackbuffer(RenderData *rd)
    12c0:	48e7 383e      	movem.l d2-d4/a2-a6,-(sp)
		if (rd->Backbuffer)
    12c4:	2679 0000 3e9e 	movea.l 3e9e <GOLRenderData+0x78>,a3
	if (rd->OutputSize.x != rd->BackbufferSize.x || rd->OutputSize.y != rd->BackbufferSize.y)
    12ca:	2039 0000 3e32 	move.l 3e32 <GOLRenderData+0xc>,d0
    12d0:	b0b9 0000 3e36 	cmp.l 3e36 <GOLRenderData+0x10>,d0
    12d6:	6700 0122      	beq.w 13fa <PrepareBackbuffer.constprop.0+0x13a>
	if (GfxBase->LibNode.lib_Version < 39)
    12da:	2c79 0000 3e22 	movea.l 3e22 <GfxBase>,a6
    12e0:	302e 0014      	move.w 20(a6),d0
		if (rd->Backbuffer)
    12e4:	b6fc 0000      	cmpa.w #0,a3
    12e8:	6770           	beq.s 135a <PrepareBackbuffer.constprop.0+0x9a>
	if (GfxBase->LibNode.lib_Version < 39)
    12ea:	0c40 0026      	cmpi.w #38,d0
    12ee:	6200 0166      	bhi.w 1456 <PrepareBackbuffer.constprop.0+0x196>
		width = bitmap->BytesPerRow * 8;
    12f2:	7800           	moveq #0,d4
    12f4:	3813           	move.w (a3),d4
    12f6:	e78c           	lsl.l #3,d4
		for (i = 0; i < bitmap->Depth; i++)
    12f8:	122b 0005      	move.b 5(a3),d1
    12fc:	673e           	beq.s 133c <PrepareBackbuffer.constprop.0+0x7c>
    12fe:	4242           	clr.w d2
    1300:	91c8           	suba.l a0,a0
    1302:	d1c8           	adda.l a0,a0
    1304:	d1c8           	adda.l a0,a0
    1306:	45f3 8800      	lea (0,a3,a0.l),a2
			if (bitmap->Planes[i])
    130a:	206a 0008      	movea.l 8(a2),a0
    130e:	b0fc 0000      	cmpa.w #0,a0
    1312:	6700 0122      	beq.w 1436 <PrepareBackbuffer.constprop.0+0x176>
				FreeRaster(bitmap->Planes[i], width, bitmap->Rows);
    1316:	2c79 0000 3e22 	movea.l 3e22 <GfxBase>,a6
    131c:	2004           	move.l d4,d0
    131e:	7200           	moveq #0,d1
    1320:	322b 0002      	move.w 2(a3),d1
    1324:	4eae fe0e      	jsr -498(a6)
				bitmap->Planes[i] = 0;
    1328:	42aa 0008      	clr.l 8(a2)
		for (i = 0; i < bitmap->Depth; i++)
    132c:	122b 0005      	move.b 5(a3),d1
    1330:	5242           	addq.w #1,d2
    1332:	3042           	movea.w d2,a0
    1334:	7600           	moveq #0,d3
    1336:	1601           	move.b d1,d3
    1338:	b1c3           	cmpa.l d3,a0
    133a:	6dc6           	blt.s 1302 <PrepareBackbuffer.constprop.0+0x42>
		FreeMem(bitmap, sizeof(struct BitMap));
    133c:	2c79 0000 3e0e 	movea.l 3e0e <SysBase>,a6
    1342:	224b           	movea.l a3,a1
    1344:	7028           	moveq #40,d0
    1346:	4eae ff2e      	jsr -210(a6)
			rd->Backbuffer = 0;
    134a:	42b9 0000 3e9e 	clr.l 3e9e <GOLRenderData+0x78>
	if (GfxBase->LibNode.lib_Version < 39)
    1350:	2c79 0000 3e22 	movea.l 3e22 <GfxBase>,a6
    1356:	302e 0014      	move.w 20(a6),d0
		rd->Backbuffer = MyAllocBitMap(rd->OutputSize.x, rd->OutputSize.y, ScreenD, rd->MainWindow->RPort->BitMap);
    135a:	3879 0000 3e34 	movea.w 3e34 <GOLRenderData+0xe>,a4
    1360:	3a79 0000 3e32 	movea.w 3e32 <GOLRenderData+0xc>,a5
	if (GfxBase->LibNode.lib_Version < 39)
    1366:	0c40 0026      	cmpi.w #38,d0
    136a:	6200 009c      	bhi.w 1408 <PrepareBackbuffer.constprop.0+0x148>
				AllocMem(sizeof(struct BitMap), MEMF_ANY | MEMF_CLEAR);
    136e:	2c79 0000 3e0e 	movea.l 3e0e <SysBase>,a6
    1374:	7028           	moveq #40,d0
    1376:	7201           	moveq #1,d1
    1378:	4841           	swap d1
    137a:	4eae ff3a      	jsr -198(a6)
    137e:	2640           	movea.l d0,a3
			if (bitmap)
    1380:	4a80           	tst.l d0
    1382:	6700 0182      	beq.w 1506 <PrepareBackbuffer.constprop.0+0x246>
				InitBitMap(bitmap, depth, width, height);
    1386:	2c79 0000 3e22 	movea.l 3e22 <GfxBase>,a6
    138c:	2040           	movea.l d0,a0
    138e:	7004           	moveq #4,d0
    1390:	220d           	move.l a5,d1
    1392:	240c           	move.l a4,d2
    1394:	4eae fe7a      	jsr -390(a6)
				for (i = 0; i < bitmap->Depth; i++)
    1398:	4a2b 0005      	tst.b 5(a3)
    139c:	6730           	beq.s 13ce <PrepareBackbuffer.constprop.0+0x10e>
    139e:	4242           	clr.w d2
    13a0:	95ca           	suba.l a2,a2
					bitmap->Planes[i] = AllocRaster(width, height);
    13a2:	2c79 0000 3e22 	movea.l 3e22 <GfxBase>,a6
    13a8:	200d           	move.l a5,d0
    13aa:	220c           	move.l a4,d1
    13ac:	4eae fe14      	jsr -492(a6)
    13b0:	220a           	move.l a2,d1
    13b2:	5481           	addq.l #2,d1
    13b4:	d281           	add.l d1,d1
    13b6:	d281           	add.l d1,d1
    13b8:	2780 1800      	move.l d0,(0,a3,d1.l)
					if (!(bitmap->Planes[i]))
    13bc:	6700 00ba      	beq.w 1478 <PrepareBackbuffer.constprop.0+0x1b8>
    13c0:	5242           	addq.w #1,d2
				for (i = 0; i < bitmap->Depth; i++)
    13c2:	3442           	movea.w d2,a2
    13c4:	7000           	moveq #0,d0
    13c6:	102b 0005      	move.b 5(a3),d0
    13ca:	b08a           	cmp.l a2,d0
    13cc:	6ed4           	bgt.s 13a2 <PrepareBackbuffer.constprop.0+0xe2>
		rd->Backbuffer = MyAllocBitMap(rd->OutputSize.x, rd->OutputSize.y, ScreenD, rd->MainWindow->RPort->BitMap);
    13ce:	23cb 0000 3e9e 	move.l a3,3e9e <GOLRenderData+0x78>
			rd->BackbufferSize = rd->OutputSize;
    13d4:	23f9 0000 3e32 	move.l 3e32 <GOLRenderData+0xc>,3e36 <GOLRenderData+0x10>
    13da:	0000 3e36 
		InitRastPort(&rd->Rastport);
    13de:	2c79 0000 3e22 	movea.l 3e22 <GfxBase>,a6
    13e4:	43f9 0000 3e3a 	lea 3e3a <GOLRenderData+0x14>,a1
    13ea:	4eae ff3a      	jsr -198(a6)
		rd->Rastport.BitMap = rd->Backbuffer;
    13ee:	2679 0000 3e9e 	movea.l 3e9e <GOLRenderData+0x78>,a3
    13f4:	23cb 0000 3e3e 	move.l a3,3e3e <GOLRenderData+0x18>
	result = rd->Backbuffer ? RETURN_OK : RETURN_ERROR;
    13fa:	b6fc 0000      	cmpa.w #0,a3
    13fe:	6770           	beq.s 1470 <PrepareBackbuffer.constprop.0+0x1b0>
    1400:	7000           	moveq #0,d0
}
    1402:	4cdf 7c1c      	movem.l (sp)+,d2-d4/a2-a6
    1406:	4e75           	rts
		rd->Backbuffer = MyAllocBitMap(rd->OutputSize.x, rd->OutputSize.y, ScreenD, rd->MainWindow->RPort->BitMap);
    1408:	2079 0000 3e2a 	movea.l 3e2a <GOLRenderData+0x4>,a0
    140e:	2068 0032      	movea.l 50(a0),a0
		bitmap = AllocBitMap(width, height, depth, 0, likeBitMap);
    1412:	200d           	move.l a5,d0
    1414:	220c           	move.l a4,d1
    1416:	7404           	moveq #4,d2
    1418:	7600           	moveq #0,d3
    141a:	2068 0004      	movea.l 4(a0),a0
    141e:	4eae fc6a      	jsr -918(a6)
		rd->Backbuffer = MyAllocBitMap(rd->OutputSize.x, rd->OutputSize.y, ScreenD, rd->MainWindow->RPort->BitMap);
    1422:	23c0 0000 3e9e 	move.l d0,3e9e <GOLRenderData+0x78>
		if (rd->Backbuffer)
    1428:	67b4           	beq.s 13de <PrepareBackbuffer.constprop.0+0x11e>
			rd->BackbufferSize = rd->OutputSize;
    142a:	23f9 0000 3e32 	move.l 3e32 <GOLRenderData+0xc>,3e36 <GOLRenderData+0x10>
    1430:	0000 3e36 
    1434:	60a8           	bra.s 13de <PrepareBackbuffer.constprop.0+0x11e>
    1436:	5242           	addq.w #1,d2
		for (i = 0; i < bitmap->Depth; i++)
    1438:	3042           	movea.w d2,a0
    143a:	7000           	moveq #0,d0
    143c:	1001           	move.b d1,d0
    143e:	b088           	cmp.l a0,d0
    1440:	6e00 fec0      	bgt.w 1302 <PrepareBackbuffer.constprop.0+0x42>
		FreeMem(bitmap, sizeof(struct BitMap));
    1444:	2c79 0000 3e0e 	movea.l 3e0e <SysBase>,a6
    144a:	224b           	movea.l a3,a1
    144c:	7028           	moveq #40,d0
    144e:	4eae ff2e      	jsr -210(a6)
    1452:	6000 fef6      	bra.w 134a <PrepareBackbuffer.constprop.0+0x8a>
		FreeBitMap(bitmap);
    1456:	204b           	movea.l a3,a0
    1458:	4eae fc64      	jsr -924(a6)
			rd->Backbuffer = 0;
    145c:	42b9 0000 3e9e 	clr.l 3e9e <GOLRenderData+0x78>
	if (GfxBase->LibNode.lib_Version < 39)
    1462:	2c79 0000 3e22 	movea.l 3e22 <GfxBase>,a6
    1468:	302e 0014      	move.w 20(a6),d0
    146c:	6000 feec      	bra.w 135a <PrepareBackbuffer.constprop.0+0x9a>
	result = rd->Backbuffer ? RETURN_OK : RETURN_ERROR;
    1470:	700a           	moveq #10,d0
}
    1472:	4cdf 7c1c      	movem.l (sp)+,d2-d4/a2-a6
    1476:	4e75           	rts
	if (GfxBase->LibNode.lib_Version < 39)
    1478:	2c79 0000 3e22 	movea.l 3e22 <GfxBase>,a6
    147e:	0c6e 0026 0014 	cmpi.w #38,20(a6)
    1484:	6200 00a6      	bhi.w 152c <PrepareBackbuffer.constprop.0+0x26c>
		width = bitmap->BytesPerRow * 8;
    1488:	7800           	moveq #0,d4
    148a:	3813           	move.w (a3),d4
    148c:	e78c           	lsl.l #3,d4
		for (i = 0; i < bitmap->Depth; i++)
    148e:	122b 0005      	move.b 5(a3),d1
    1492:	673e           	beq.s 14d2 <PrepareBackbuffer.constprop.0+0x212>
    1494:	4242           	clr.w d2
    1496:	91c8           	suba.l a0,a0
    1498:	d1c8           	adda.l a0,a0
    149a:	d1c8           	adda.l a0,a0
    149c:	45f3 8800      	lea (0,a3,a0.l),a2
			if (bitmap->Planes[i])
    14a0:	206a 0008      	movea.l 8(a2),a0
    14a4:	b0fc 0000      	cmpa.w #0,a0
    14a8:	6700 00ae      	beq.w 1558 <PrepareBackbuffer.constprop.0+0x298>
				FreeRaster(bitmap->Planes[i], width, bitmap->Rows);
    14ac:	2c79 0000 3e22 	movea.l 3e22 <GfxBase>,a6
    14b2:	2004           	move.l d4,d0
    14b4:	7200           	moveq #0,d1
    14b6:	322b 0002      	move.w 2(a3),d1
    14ba:	4eae fe0e      	jsr -498(a6)
				bitmap->Planes[i] = 0;
    14be:	42aa 0008      	clr.l 8(a2)
		for (i = 0; i < bitmap->Depth; i++)
    14c2:	122b 0005      	move.b 5(a3),d1
    14c6:	5242           	addq.w #1,d2
    14c8:	3042           	movea.w d2,a0
    14ca:	7600           	moveq #0,d3
    14cc:	1601           	move.b d1,d3
    14ce:	b1c3           	cmpa.l d3,a0
    14d0:	6dc6           	blt.s 1498 <PrepareBackbuffer.constprop.0+0x1d8>
		FreeMem(bitmap, sizeof(struct BitMap));
    14d2:	2c79 0000 3e0e 	movea.l 3e0e <SysBase>,a6
    14d8:	224b           	movea.l a3,a1
    14da:	7028           	moveq #40,d0
    14dc:	4eae ff2e      	jsr -210(a6)
		rd->Backbuffer = MyAllocBitMap(rd->OutputSize.x, rd->OutputSize.y, ScreenD, rd->MainWindow->RPort->BitMap);
    14e0:	42b9 0000 3e9e 	clr.l 3e9e <GOLRenderData+0x78>
		InitRastPort(&rd->Rastport);
    14e6:	2c79 0000 3e22 	movea.l 3e22 <GfxBase>,a6
    14ec:	43f9 0000 3e3a 	lea 3e3a <GOLRenderData+0x14>,a1
    14f2:	4eae ff3a      	jsr -198(a6)
		rd->Rastport.BitMap = rd->Backbuffer;
    14f6:	2679 0000 3e9e 	movea.l 3e9e <GOLRenderData+0x78>,a3
    14fc:	23cb 0000 3e3e 	move.l a3,3e3e <GOLRenderData+0x18>
    1502:	6000 fef6      	bra.w 13fa <PrepareBackbuffer.constprop.0+0x13a>
		rd->Backbuffer = MyAllocBitMap(rd->OutputSize.x, rd->OutputSize.y, ScreenD, rd->MainWindow->RPort->BitMap);
    1506:	42b9 0000 3e9e 	clr.l 3e9e <GOLRenderData+0x78>
		InitRastPort(&rd->Rastport);
    150c:	2c79 0000 3e22 	movea.l 3e22 <GfxBase>,a6
    1512:	43f9 0000 3e3a 	lea 3e3a <GOLRenderData+0x14>,a1
    1518:	4eae ff3a      	jsr -198(a6)
		rd->Rastport.BitMap = rd->Backbuffer;
    151c:	2679 0000 3e9e 	movea.l 3e9e <GOLRenderData+0x78>,a3
    1522:	23cb 0000 3e3e 	move.l a3,3e3e <GOLRenderData+0x18>
    1528:	6000 fed0      	bra.w 13fa <PrepareBackbuffer.constprop.0+0x13a>
		FreeBitMap(bitmap);
    152c:	204b           	movea.l a3,a0
    152e:	4eae fc64      	jsr -924(a6)
		rd->Backbuffer = MyAllocBitMap(rd->OutputSize.x, rd->OutputSize.y, ScreenD, rd->MainWindow->RPort->BitMap);
    1532:	42b9 0000 3e9e 	clr.l 3e9e <GOLRenderData+0x78>
		InitRastPort(&rd->Rastport);
    1538:	2c79 0000 3e22 	movea.l 3e22 <GfxBase>,a6
    153e:	43f9 0000 3e3a 	lea 3e3a <GOLRenderData+0x14>,a1
    1544:	4eae ff3a      	jsr -198(a6)
		rd->Rastport.BitMap = rd->Backbuffer;
    1548:	2679 0000 3e9e 	movea.l 3e9e <GOLRenderData+0x78>,a3
    154e:	23cb 0000 3e3e 	move.l a3,3e3e <GOLRenderData+0x18>
    1554:	6000 fea4      	bra.w 13fa <PrepareBackbuffer.constprop.0+0x13a>
    1558:	5242           	addq.w #1,d2
		for (i = 0; i < bitmap->Depth; i++)
    155a:	3042           	movea.w d2,a0
    155c:	7000           	moveq #0,d0
    155e:	1001           	move.b d1,d0
    1560:	b088           	cmp.l a0,d0
    1562:	6e00 ff34      	bgt.w 1498 <PrepareBackbuffer.constprop.0+0x1d8>
		FreeMem(bitmap, sizeof(struct BitMap));
    1566:	2c79 0000 3e0e 	movea.l 3e0e <SysBase>,a6
    156c:	224b           	movea.l a3,a1
    156e:	7028           	moveq #40,d0
    1570:	4eae ff2e      	jsr -210(a6)
		rd->Backbuffer = MyAllocBitMap(rd->OutputSize.x, rd->OutputSize.y, ScreenD, rd->MainWindow->RPort->BitMap);
    1574:	42b9 0000 3e9e 	clr.l 3e9e <GOLRenderData+0x78>
    157a:	6000 ff6a      	bra.w 14e6 <PrepareBackbuffer.constprop.0+0x226>

0000157e <memset.constprop.0>:
	void* memset(void *dest, int val, unsigned long len)
    157e:	2f0a           	move.l a2,-(sp)
    1580:	2f02           	move.l d2,-(sp)
    1582:	202f 000c      	move.l 12(sp),d0
    1586:	206f 0014      	movea.l 20(sp),a0
	while(len-- > 0)
    158a:	43e8 ffff      	lea -1(a0),a1
    158e:	b0fc 0000      	cmpa.w #0,a0
    1592:	6700 0096      	beq.w 162a <memset.constprop.0+0xac>
    1596:	2200           	move.l d0,d1
    1598:	4481           	neg.l d1
    159a:	7403           	moveq #3,d2
    159c:	c282           	and.l d2,d1
    159e:	7405           	moveq #5,d2
		*ptr++ = val;
    15a0:	2440           	movea.l d0,a2
    15a2:	b489           	cmp.l a1,d2
    15a4:	6450           	bcc.s 15f6 <memset.constprop.0+0x78>
    15a6:	4a81           	tst.l d1
    15a8:	672c           	beq.s 15d6 <memset.constprop.0+0x58>
    15aa:	421a           	clr.b (a2)+
	while(len-- > 0)
    15ac:	43e8 fffe      	lea -2(a0),a1
    15b0:	7401           	moveq #1,d2
    15b2:	b481           	cmp.l d1,d2
    15b4:	6720           	beq.s 15d6 <memset.constprop.0+0x58>
		*ptr++ = val;
    15b6:	2440           	movea.l d0,a2
    15b8:	548a           	addq.l #2,a2
    15ba:	2240           	movea.l d0,a1
    15bc:	4229 0001      	clr.b 1(a1)
	while(len-- > 0)
    15c0:	43e8 fffd      	lea -3(a0),a1
    15c4:	7403           	moveq #3,d2
    15c6:	b481           	cmp.l d1,d2
    15c8:	660c           	bne.s 15d6 <memset.constprop.0+0x58>
		*ptr++ = val;
    15ca:	528a           	addq.l #1,a2
    15cc:	2240           	movea.l d0,a1
    15ce:	4229 0002      	clr.b 2(a1)
	while(len-- > 0)
    15d2:	43e8 fffc      	lea -4(a0),a1
    15d6:	2408           	move.l a0,d2
    15d8:	9481           	sub.l d1,d2
    15da:	2040           	movea.l d0,a0
    15dc:	d1c1           	adda.l d1,a0
    15de:	72fc           	moveq #-4,d1
    15e0:	c282           	and.l d2,d1
    15e2:	d288           	add.l a0,d1
		*ptr++ = val;
    15e4:	4298           	clr.l (a0)+
    15e6:	b1c1           	cmpa.l d1,a0
    15e8:	66fa           	bne.s 15e4 <memset.constprop.0+0x66>
    15ea:	72fc           	moveq #-4,d1
    15ec:	c282           	and.l d2,d1
    15ee:	d5c1           	adda.l d1,a2
    15f0:	93c1           	suba.l d1,a1
    15f2:	b282           	cmp.l d2,d1
    15f4:	6734           	beq.s 162a <memset.constprop.0+0xac>
    15f6:	4212           	clr.b (a2)
	while(len-- > 0)
    15f8:	b2fc 0000      	cmpa.w #0,a1
    15fc:	672c           	beq.s 162a <memset.constprop.0+0xac>
		*ptr++ = val;
    15fe:	422a 0001      	clr.b 1(a2)
	while(len-- > 0)
    1602:	7201           	moveq #1,d1
    1604:	b289           	cmp.l a1,d1
    1606:	6722           	beq.s 162a <memset.constprop.0+0xac>
		*ptr++ = val;
    1608:	422a 0002      	clr.b 2(a2)
	while(len-- > 0)
    160c:	7402           	moveq #2,d2
    160e:	b489           	cmp.l a1,d2
    1610:	6718           	beq.s 162a <memset.constprop.0+0xac>
		*ptr++ = val;
    1612:	422a 0003      	clr.b 3(a2)
	while(len-- > 0)
    1616:	7203           	moveq #3,d1
    1618:	b289           	cmp.l a1,d1
    161a:	670e           	beq.s 162a <memset.constprop.0+0xac>
		*ptr++ = val;
    161c:	422a 0004      	clr.b 4(a2)
	while(len-- > 0)
    1620:	7404           	moveq #4,d2
    1622:	b489           	cmp.l a1,d2
    1624:	6704           	beq.s 162a <memset.constprop.0+0xac>
		*ptr++ = val;
    1626:	422a 0005      	clr.b 5(a2)
}
    162a:	241f           	move.l (sp)+,d2
    162c:	245f           	movea.l (sp)+,a2
    162e:	4e75           	rts

00001630 <FreePlayfieldMem.isra.0>:
int FreePlayfieldMem()
    1630:	48e7 3022      	movem.l d2-d3/a2/a6,-(sp)
	for (int i = 0; i < GameMatrix.Columns; i++)
    1634:	4a79 0000 3eae 	tst.w 3eae <GameMatrix+0xa>
    163a:	6700 00a2      	beq.w 16de <FreePlayfieldMem.isra.0+0xae>
    163e:	7400           	moveq #0,d2
    1640:	7600           	moveq #0,d3
    1642:	45f9 0000 3ea4 	lea 3ea4 <GameMatrix>,a2
		FreeMem(GameMatrix.Playfield[i], GameMatrix.Rows * sizeof(GameOfLifeCell));
    1648:	2052           	movea.l (a2),a0
    164a:	2c79 0000 3e0e 	movea.l 3e0e <SysBase>,a6
    1650:	2270 2800      	movea.l (0,a0,d2.l),a1
    1654:	7000           	moveq #0,d0
    1656:	3039 0000 3eac 	move.w 3eac <GameMatrix+0x8>,d0
    165c:	4eae ff2e      	jsr -210(a6)
		FreeMem(GameMatrix.Playfield_n1[i], GameMatrix.Rows * sizeof(GameOfLifeCell));
    1660:	2c79 0000 3e0e 	movea.l 3e0e <SysBase>,a6
    1666:	2079 0000 3ea8 	movea.l 3ea8 <GameMatrix+0x4>,a0
    166c:	2270 2800      	movea.l (0,a0,d2.l),a1
    1670:	7000           	moveq #0,d0
    1672:	3039 0000 3eac 	move.w 3eac <GameMatrix+0x8>,d0
    1678:	4eae ff2e      	jsr -210(a6)
	for (int i = 0; i < GameMatrix.Columns; i++)
    167c:	5283           	addq.l #1,d3
    167e:	5882           	addq.l #4,d2
    1680:	7000           	moveq #0,d0
    1682:	3039 0000 3eae 	move.w 3eae <GameMatrix+0xa>,d0
    1688:	b083           	cmp.l d3,d0
    168a:	6ebc           	bgt.s 1648 <FreePlayfieldMem.isra.0+0x18>
	FreeMem(GameMatrix.Playfield, GameMatrix.Columns * sizeof(GameOfLifeCell *));
    168c:	2c79 0000 3e0e 	movea.l 3e0e <SysBase>,a6
    1692:	2252           	movea.l (a2),a1
    1694:	e588           	lsl.l #2,d0
    1696:	4eae ff2e      	jsr -210(a6)
	FreeMem(GameMatrix.Playfield_n1, GameMatrix.Columns * sizeof(GameOfLifeCell *));
    169a:	7000           	moveq #0,d0
    169c:	3039 0000 3eae 	move.w 3eae <GameMatrix+0xa>,d0
    16a2:	2c79 0000 3e0e 	movea.l 3e0e <SysBase>,a6
    16a8:	2279 0000 3ea8 	movea.l 3ea8 <GameMatrix+0x4>,a1
    16ae:	e588           	lsl.l #2,d0
    16b0:	4eae ff2e      	jsr -210(a6)
	FreeMem(UpdateList, GameMatrix.Columns * GameMatrix.Rows * sizeof(UpdateListEntry));
    16b4:	3239 0000 3eae 	move.w 3eae <GameMatrix+0xa>,d1
    16ba:	c2f9 0000 3eac 	mulu.w 3eac <GameMatrix+0x8>,d1
    16c0:	2001           	move.l d1,d0
    16c2:	d081           	add.l d1,d0
    16c4:	d081           	add.l d1,d0
    16c6:	2c79 0000 3e0e 	movea.l 3e0e <SysBase>,a6
    16cc:	2279 0000 3e06 	movea.l 3e06 <UpdateList>,a1
    16d2:	d080           	add.l d0,d0
    16d4:	4eae ff2e      	jsr -210(a6)
}
    16d8:	4cdf 440c      	movem.l (sp)+,d2-d3/a2/a6
    16dc:	4e75           	rts
    16de:	45f9 0000 3ea4 	lea 3ea4 <GameMatrix>,a2
    16e4:	7000           	moveq #0,d0
	FreeMem(GameMatrix.Playfield, GameMatrix.Columns * sizeof(GameOfLifeCell *));
    16e6:	2c79 0000 3e0e 	movea.l 3e0e <SysBase>,a6
    16ec:	2252           	movea.l (a2),a1
    16ee:	e588           	lsl.l #2,d0
    16f0:	4eae ff2e      	jsr -210(a6)
	FreeMem(GameMatrix.Playfield_n1, GameMatrix.Columns * sizeof(GameOfLifeCell *));
    16f4:	7000           	moveq #0,d0
    16f6:	3039 0000 3eae 	move.w 3eae <GameMatrix+0xa>,d0
    16fc:	2c79 0000 3e0e 	movea.l 3e0e <SysBase>,a6
    1702:	2279 0000 3ea8 	movea.l 3ea8 <GameMatrix+0x4>,a1
    1708:	e588           	lsl.l #2,d0
    170a:	4eae ff2e      	jsr -210(a6)
	FreeMem(UpdateList, GameMatrix.Columns * GameMatrix.Rows * sizeof(UpdateListEntry));
    170e:	3239 0000 3eae 	move.w 3eae <GameMatrix+0xa>,d1
    1714:	c2f9 0000 3eac 	mulu.w 3eac <GameMatrix+0x8>,d1
    171a:	2001           	move.l d1,d0
    171c:	d081           	add.l d1,d0
    171e:	d081           	add.l d1,d0
    1720:	2c79 0000 3e0e 	movea.l 3e0e <SysBase>,a6
    1726:	2279 0000 3e06 	movea.l 3e06 <UpdateList>,a1
    172c:	d080           	add.l d0,d0
    172e:	4eae ff2e      	jsr -210(a6)
}
    1732:	4cdf 440c      	movem.l (sp)+,d2-d3/a2/a6
    1736:	4e75           	rts

00001738 <strlen>:
{
    1738:	206f 0004      	movea.l 4(sp),a0
	unsigned long t=0;
    173c:	7000           	moveq #0,d0
	while(*s++)
    173e:	4a10           	tst.b (a0)
    1740:	6708           	beq.s 174a <strlen+0x12>
		t++;
    1742:	5280           	addq.l #1,d0
	while(*s++)
    1744:	4a30 0800      	tst.b (0,a0,d0.l)
    1748:	66f8           	bne.s 1742 <strlen+0xa>
}
    174a:	4e75           	rts

0000174c <memset>:
{
    174c:	48e7 3f30      	movem.l d2-d7/a2-a3,-(sp)
    1750:	202f 0024      	move.l 36(sp),d0
    1754:	282f 0028      	move.l 40(sp),d4
    1758:	226f 002c      	movea.l 44(sp),a1
	while(len-- > 0)
    175c:	2a09           	move.l a1,d5
    175e:	5385           	subq.l #1,d5
    1760:	b2fc 0000      	cmpa.w #0,a1
    1764:	6700 00ae      	beq.w 1814 <memset+0xc8>
		*ptr++ = val;
    1768:	1e04           	move.b d4,d7
    176a:	2200           	move.l d0,d1
    176c:	4481           	neg.l d1
    176e:	7403           	moveq #3,d2
    1770:	c282           	and.l d2,d1
    1772:	7c05           	moveq #5,d6
    1774:	2440           	movea.l d0,a2
    1776:	bc85           	cmp.l d5,d6
    1778:	646a           	bcc.s 17e4 <memset+0x98>
    177a:	4a81           	tst.l d1
    177c:	6724           	beq.s 17a2 <memset+0x56>
    177e:	14c4           	move.b d4,(a2)+
	while(len-- > 0)
    1780:	5385           	subq.l #1,d5
    1782:	7401           	moveq #1,d2
    1784:	b481           	cmp.l d1,d2
    1786:	671a           	beq.s 17a2 <memset+0x56>
		*ptr++ = val;
    1788:	2440           	movea.l d0,a2
    178a:	548a           	addq.l #2,a2
    178c:	2040           	movea.l d0,a0
    178e:	1144 0001      	move.b d4,1(a0)
	while(len-- > 0)
    1792:	5385           	subq.l #1,d5
    1794:	7403           	moveq #3,d2
    1796:	b481           	cmp.l d1,d2
    1798:	6608           	bne.s 17a2 <memset+0x56>
		*ptr++ = val;
    179a:	528a           	addq.l #1,a2
    179c:	1144 0002      	move.b d4,2(a0)
	while(len-- > 0)
    17a0:	5385           	subq.l #1,d5
    17a2:	2609           	move.l a1,d3
    17a4:	9681           	sub.l d1,d3
    17a6:	7c00           	moveq #0,d6
    17a8:	1c04           	move.b d4,d6
    17aa:	2406           	move.l d6,d2
    17ac:	4842           	swap d2
    17ae:	4242           	clr.w d2
    17b0:	2042           	movea.l d2,a0
    17b2:	2404           	move.l d4,d2
    17b4:	e14a           	lsl.w #8,d2
    17b6:	4842           	swap d2
    17b8:	4242           	clr.w d2
    17ba:	e18e           	lsl.l #8,d6
    17bc:	2646           	movea.l d6,a3
    17be:	2c08           	move.l a0,d6
    17c0:	8486           	or.l d6,d2
    17c2:	2c0b           	move.l a3,d6
    17c4:	8486           	or.l d6,d2
    17c6:	1407           	move.b d7,d2
    17c8:	2040           	movea.l d0,a0
    17ca:	d1c1           	adda.l d1,a0
    17cc:	72fc           	moveq #-4,d1
    17ce:	c283           	and.l d3,d1
    17d0:	d288           	add.l a0,d1
		*ptr++ = val;
    17d2:	20c2           	move.l d2,(a0)+
	while(len-- > 0)
    17d4:	b1c1           	cmpa.l d1,a0
    17d6:	66fa           	bne.s 17d2 <memset+0x86>
    17d8:	72fc           	moveq #-4,d1
    17da:	c283           	and.l d3,d1
    17dc:	d5c1           	adda.l d1,a2
    17de:	9a81           	sub.l d1,d5
    17e0:	b283           	cmp.l d3,d1
    17e2:	6730           	beq.s 1814 <memset+0xc8>
		*ptr++ = val;
    17e4:	1484           	move.b d4,(a2)
	while(len-- > 0)
    17e6:	4a85           	tst.l d5
    17e8:	672a           	beq.s 1814 <memset+0xc8>
		*ptr++ = val;
    17ea:	1544 0001      	move.b d4,1(a2)
	while(len-- > 0)
    17ee:	7201           	moveq #1,d1
    17f0:	b285           	cmp.l d5,d1
    17f2:	6720           	beq.s 1814 <memset+0xc8>
		*ptr++ = val;
    17f4:	1544 0002      	move.b d4,2(a2)
	while(len-- > 0)
    17f8:	7402           	moveq #2,d2
    17fa:	b485           	cmp.l d5,d2
    17fc:	6716           	beq.s 1814 <memset+0xc8>
		*ptr++ = val;
    17fe:	1544 0003      	move.b d4,3(a2)
	while(len-- > 0)
    1802:	7c03           	moveq #3,d6
    1804:	bc85           	cmp.l d5,d6
    1806:	670c           	beq.s 1814 <memset+0xc8>
		*ptr++ = val;
    1808:	1544 0004      	move.b d4,4(a2)
	while(len-- > 0)
    180c:	5985           	subq.l #4,d5
    180e:	6704           	beq.s 1814 <memset+0xc8>
		*ptr++ = val;
    1810:	1544 0005      	move.b d4,5(a2)
}
    1814:	4cdf 0cfc      	movem.l (sp)+,d2-d7/a2-a3
    1818:	4e75           	rts

0000181a <memcpy>:
{
    181a:	48e7 3e00      	movem.l d2-d6,-(sp)
    181e:	202f 0018      	move.l 24(sp),d0
    1822:	222f 001c      	move.l 28(sp),d1
    1826:	262f 0020      	move.l 32(sp),d3
	while(len--)
    182a:	2803           	move.l d3,d4
    182c:	5384           	subq.l #1,d4
    182e:	4a83           	tst.l d3
    1830:	675e           	beq.s 1890 <memcpy+0x76>
    1832:	2041           	movea.l d1,a0
    1834:	5288           	addq.l #1,a0
    1836:	2400           	move.l d0,d2
    1838:	9488           	sub.l a0,d2
    183a:	7a02           	moveq #2,d5
    183c:	ba82           	cmp.l d2,d5
    183e:	55c2           	sc.s d2
    1840:	4402           	neg.b d2
    1842:	7c08           	moveq #8,d6
    1844:	bc84           	cmp.l d4,d6
    1846:	55c5           	sc.s d5
    1848:	4405           	neg.b d5
    184a:	c405           	and.b d5,d2
    184c:	6748           	beq.s 1896 <memcpy+0x7c>
    184e:	2400           	move.l d0,d2
    1850:	8481           	or.l d1,d2
    1852:	7a03           	moveq #3,d5
    1854:	c485           	and.l d5,d2
    1856:	663e           	bne.s 1896 <memcpy+0x7c>
    1858:	2041           	movea.l d1,a0
    185a:	2240           	movea.l d0,a1
    185c:	74fc           	moveq #-4,d2
    185e:	c483           	and.l d3,d2
    1860:	d481           	add.l d1,d2
		*d++ = *s++;
    1862:	22d8           	move.l (a0)+,(a1)+
	while(len--)
    1864:	b488           	cmp.l a0,d2
    1866:	66fa           	bne.s 1862 <memcpy+0x48>
    1868:	74fc           	moveq #-4,d2
    186a:	c483           	and.l d3,d2
    186c:	2040           	movea.l d0,a0
    186e:	d1c2           	adda.l d2,a0
    1870:	d282           	add.l d2,d1
    1872:	9882           	sub.l d2,d4
    1874:	b483           	cmp.l d3,d2
    1876:	6718           	beq.s 1890 <memcpy+0x76>
		*d++ = *s++;
    1878:	2241           	movea.l d1,a1
    187a:	1091           	move.b (a1),(a0)
	while(len--)
    187c:	4a84           	tst.l d4
    187e:	6710           	beq.s 1890 <memcpy+0x76>
		*d++ = *s++;
    1880:	1169 0001 0001 	move.b 1(a1),1(a0)
	while(len--)
    1886:	5384           	subq.l #1,d4
    1888:	6706           	beq.s 1890 <memcpy+0x76>
		*d++ = *s++;
    188a:	1169 0002 0002 	move.b 2(a1),2(a0)
}
    1890:	4cdf 007c      	movem.l (sp)+,d2-d6
    1894:	4e75           	rts
    1896:	2240           	movea.l d0,a1
    1898:	d283           	add.l d3,d1
		*d++ = *s++;
    189a:	12e8 ffff      	move.b -1(a0),(a1)+
	while(len--)
    189e:	b288           	cmp.l a0,d1
    18a0:	67ee           	beq.s 1890 <memcpy+0x76>
    18a2:	5288           	addq.l #1,a0
    18a4:	60f4           	bra.s 189a <memcpy+0x80>

000018a6 <memmove>:
{
    18a6:	48e7 3c20      	movem.l d2-d5/a2,-(sp)
    18aa:	202f 0018      	move.l 24(sp),d0
    18ae:	222f 001c      	move.l 28(sp),d1
    18b2:	242f 0020      	move.l 32(sp),d2
		while (len--)
    18b6:	2242           	movea.l d2,a1
    18b8:	5389           	subq.l #1,a1
	if (d < s) {
    18ba:	b280           	cmp.l d0,d1
    18bc:	636c           	bls.s 192a <memmove+0x84>
		while (len--)
    18be:	4a82           	tst.l d2
    18c0:	6762           	beq.s 1924 <memmove+0x7e>
    18c2:	2441           	movea.l d1,a2
    18c4:	528a           	addq.l #1,a2
    18c6:	2600           	move.l d0,d3
    18c8:	968a           	sub.l a2,d3
    18ca:	7802           	moveq #2,d4
    18cc:	b883           	cmp.l d3,d4
    18ce:	55c3           	sc.s d3
    18d0:	4403           	neg.b d3
    18d2:	7a08           	moveq #8,d5
    18d4:	ba89           	cmp.l a1,d5
    18d6:	55c4           	sc.s d4
    18d8:	4404           	neg.b d4
    18da:	c604           	and.b d4,d3
    18dc:	6770           	beq.s 194e <memmove+0xa8>
    18de:	2600           	move.l d0,d3
    18e0:	8681           	or.l d1,d3
    18e2:	7803           	moveq #3,d4
    18e4:	c684           	and.l d4,d3
    18e6:	6666           	bne.s 194e <memmove+0xa8>
    18e8:	2041           	movea.l d1,a0
    18ea:	2440           	movea.l d0,a2
    18ec:	76fc           	moveq #-4,d3
    18ee:	c682           	and.l d2,d3
    18f0:	d681           	add.l d1,d3
			*d++ = *s++;
    18f2:	24d8           	move.l (a0)+,(a2)+
		while (len--)
    18f4:	b688           	cmp.l a0,d3
    18f6:	66fa           	bne.s 18f2 <memmove+0x4c>
    18f8:	76fc           	moveq #-4,d3
    18fa:	c682           	and.l d2,d3
    18fc:	2440           	movea.l d0,a2
    18fe:	d5c3           	adda.l d3,a2
    1900:	2041           	movea.l d1,a0
    1902:	d1c3           	adda.l d3,a0
    1904:	93c3           	suba.l d3,a1
    1906:	b682           	cmp.l d2,d3
    1908:	671a           	beq.s 1924 <memmove+0x7e>
			*d++ = *s++;
    190a:	1490           	move.b (a0),(a2)
		while (len--)
    190c:	b2fc 0000      	cmpa.w #0,a1
    1910:	6712           	beq.s 1924 <memmove+0x7e>
			*d++ = *s++;
    1912:	1568 0001 0001 	move.b 1(a0),1(a2)
		while (len--)
    1918:	7a01           	moveq #1,d5
    191a:	ba89           	cmp.l a1,d5
    191c:	6706           	beq.s 1924 <memmove+0x7e>
			*d++ = *s++;
    191e:	1568 0002 0002 	move.b 2(a0),2(a2)
}
    1924:	4cdf 043c      	movem.l (sp)+,d2-d5/a2
    1928:	4e75           	rts
		const char *lasts = s + (len - 1);
    192a:	41f1 1800      	lea (0,a1,d1.l),a0
		char *lastd = d + (len - 1);
    192e:	d3c0           	adda.l d0,a1
		while (len--)
    1930:	4a82           	tst.l d2
    1932:	67f0           	beq.s 1924 <memmove+0x7e>
    1934:	2208           	move.l a0,d1
    1936:	9282           	sub.l d2,d1
			*lastd-- = *lasts--;
    1938:	1290           	move.b (a0),(a1)
		while (len--)
    193a:	5388           	subq.l #1,a0
    193c:	5389           	subq.l #1,a1
    193e:	b288           	cmp.l a0,d1
    1940:	67e2           	beq.s 1924 <memmove+0x7e>
			*lastd-- = *lasts--;
    1942:	1290           	move.b (a0),(a1)
		while (len--)
    1944:	5388           	subq.l #1,a0
    1946:	5389           	subq.l #1,a1
    1948:	b288           	cmp.l a0,d1
    194a:	66ec           	bne.s 1938 <memmove+0x92>
    194c:	60d6           	bra.s 1924 <memmove+0x7e>
    194e:	2240           	movea.l d0,a1
    1950:	d282           	add.l d2,d1
			*d++ = *s++;
    1952:	12ea ffff      	move.b -1(a2),(a1)+
		while (len--)
    1956:	b28a           	cmp.l a2,d1
    1958:	67ca           	beq.s 1924 <memmove+0x7e>
    195a:	528a           	addq.l #1,a2
    195c:	60f4           	bra.s 1952 <memmove+0xac>
    195e:	4e71           	nop

00001960 <__mulsi3>:
	.text
	FUNC(__mulsi3)
	.globl	SYM (__mulsi3)
SYM (__mulsi3):
	.cfi_startproc
	movew	sp@(4), d0	/* x0 -> d0 */
    1960:	302f 0004      	move.w 4(sp),d0
	muluw	sp@(10), d0	/* x0*y1 */
    1964:	c0ef 000a      	mulu.w 10(sp),d0
	movew	sp@(6), d1	/* x1 -> d1 */
    1968:	322f 0006      	move.w 6(sp),d1
	muluw	sp@(8), d1	/* x1*y0 */
    196c:	c2ef 0008      	mulu.w 8(sp),d1
	addw	d1, d0
    1970:	d041           	add.w d1,d0
	swap	d0
    1972:	4840           	swap d0
	clrw	d0
    1974:	4240           	clr.w d0
	movew	sp@(6), d1	/* x1 -> d1 */
    1976:	322f 0006      	move.w 6(sp),d1
	muluw	sp@(10), d1	/* x1*y1 */
    197a:	c2ef 000a      	mulu.w 10(sp),d1
	addl	d1, d0
    197e:	d081           	add.l d1,d0
	rts
    1980:	4e75           	rts

00001982 <__udivsi3>:
	.text
	FUNC(__udivsi3)
	.globl	SYM (__udivsi3)
SYM (__udivsi3):
	.cfi_startproc
	movel	d2, sp@-
    1982:	2f02           	move.l d2,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	sp@(12), d1	/* d1 = divisor */
    1984:	222f 000c      	move.l 12(sp),d1
	movel	sp@(8), d0	/* d0 = dividend */
    1988:	202f 0008      	move.l 8(sp),d0

	cmpl	IMM (0x10000), d1 /* divisor >= 2 ^ 16 ?   */
    198c:	0c81 0001 0000 	cmpi.l #65536,d1
	jcc	3f		/* then try next algorithm */
    1992:	6416           	bcc.s 19aa <__udivsi3+0x28>
	movel	d0, d2
    1994:	2400           	move.l d0,d2
	clrw	d2
    1996:	4242           	clr.w d2
	swap	d2
    1998:	4842           	swap d2
	divu	d1, d2          /* high quotient in lower word */
    199a:	84c1           	divu.w d1,d2
	movew	d2, d0		/* save high quotient */
    199c:	3002           	move.w d2,d0
	swap	d0
    199e:	4840           	swap d0
	movew	sp@(10), d2	/* get low dividend + high rest */
    19a0:	342f 000a      	move.w 10(sp),d2
	divu	d1, d2		/* low quotient */
    19a4:	84c1           	divu.w d1,d2
	movew	d2, d0
    19a6:	3002           	move.w d2,d0
	jra	6f
    19a8:	6030           	bra.s 19da <__udivsi3+0x58>

3:	movel	d1, d2		/* use d2 as divisor backup */
    19aa:	2401           	move.l d1,d2
4:	lsrl	IMM (1), d1	/* shift divisor */
    19ac:	e289           	lsr.l #1,d1
	lsrl	IMM (1), d0	/* shift dividend */
    19ae:	e288           	lsr.l #1,d0
	cmpl	IMM (0x10000), d1 /* still divisor >= 2 ^ 16 ?  */
    19b0:	0c81 0001 0000 	cmpi.l #65536,d1
	jcc	4b
    19b6:	64f4           	bcc.s 19ac <__udivsi3+0x2a>
	divu	d1, d0		/* now we have 16-bit divisor */
    19b8:	80c1           	divu.w d1,d0
	andl	IMM (0xffff), d0 /* mask out divisor, ignore remainder */
    19ba:	0280 0000 ffff 	andi.l #65535,d0

/* Multiply the 16-bit tentative quotient with the 32-bit divisor.  Because of
   the operand ranges, this might give a 33-bit product.  If this product is
   greater than the dividend, the tentative quotient was too large. */
	movel	d2, d1
    19c0:	2202           	move.l d2,d1
	mulu	d0, d1		/* low part, 32 bits */
    19c2:	c2c0           	mulu.w d0,d1
	swap	d2
    19c4:	4842           	swap d2
	mulu	d0, d2		/* high part, at most 17 bits */
    19c6:	c4c0           	mulu.w d0,d2
	swap	d2		/* align high part with low part */
    19c8:	4842           	swap d2
	tstw	d2		/* high part 17 bits? */
    19ca:	4a42           	tst.w d2
	jne	5f		/* if 17 bits, quotient was too large */
    19cc:	660a           	bne.s 19d8 <__udivsi3+0x56>
	addl	d2, d1		/* add parts */
    19ce:	d282           	add.l d2,d1
	jcs	5f		/* if sum is 33 bits, quotient was too large */
    19d0:	6506           	bcs.s 19d8 <__udivsi3+0x56>
	cmpl	sp@(8), d1	/* compare the sum with the dividend */
    19d2:	b2af 0008      	cmp.l 8(sp),d1
	jls	6f		/* if sum > dividend, quotient was too large */
    19d6:	6302           	bls.s 19da <__udivsi3+0x58>
5:	subql	IMM (1), d0	/* adjust quotient */
    19d8:	5380           	subq.l #1,d0

6:	movel	sp@+, d2
    19da:	241f           	move.l (sp)+,d2
	.cfi_adjust_cfa_offset -4
	rts
    19dc:	4e75           	rts

000019de <__divsi3>:
	.text
	FUNC(__divsi3)
	.globl	SYM (__divsi3)
SYM (__divsi3):
	.cfi_startproc
	movel	d2, sp@-
    19de:	2f02           	move.l d2,-(sp)
	.cfi_adjust_cfa_offset 4

	moveq	IMM (1), d2	/* sign of result stored in d2 (=1 or =-1) */
    19e0:	7401           	moveq #1,d2
	movel	sp@(12), d1	/* d1 = divisor */
    19e2:	222f 000c      	move.l 12(sp),d1
	jpl	1f
    19e6:	6a04           	bpl.s 19ec <__divsi3+0xe>
	negl	d1
    19e8:	4481           	neg.l d1
	negb	d2		/* change sign because divisor <0  */
    19ea:	4402           	neg.b d2
1:	movel	sp@(8), d0	/* d0 = dividend */
    19ec:	202f 0008      	move.l 8(sp),d0
	jpl	2f
    19f0:	6a04           	bpl.s 19f6 <__divsi3+0x18>
	negl	d0
    19f2:	4480           	neg.l d0
	negb	d2
    19f4:	4402           	neg.b d2

2:	movel	d1, sp@-
    19f6:	2f01           	move.l d1,-(sp)
	movel	d0, sp@-
    19f8:	2f00           	move.l d0,-(sp)
	PICCALL	SYM (__udivsi3)	/* divide abs(dividend) by abs(divisor) */
    19fa:	6186           	bsr.s 1982 <__udivsi3>
	addql	IMM (8), sp
    19fc:	508f           	addq.l #8,sp

	tstb	d2
    19fe:	4a02           	tst.b d2
	jpl	3f
    1a00:	6a02           	bpl.s 1a04 <__divsi3+0x26>
	negl	d0
    1a02:	4480           	neg.l d0

3:	movel	sp@+, d2
    1a04:	241f           	move.l (sp)+,d2
	.cfi_adjust_cfa_offset -4
	rts
    1a06:	4e75           	rts

00001a08 <__modsi3>:
	.text
	FUNC(__modsi3)
	.globl	SYM (__modsi3)
SYM (__modsi3):
	.cfi_startproc
	movel	sp@(8), d1	/* d1 = divisor */
    1a08:	222f 0008      	move.l 8(sp),d1
	movel	sp@(4), d0	/* d0 = dividend */
    1a0c:	202f 0004      	move.l 4(sp),d0
	movel	d1, sp@-
    1a10:	2f01           	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    1a12:	2f00           	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	PICCALL	SYM (__divsi3)
    1a14:	61c8           	bsr.s 19de <__divsi3>
	addql	IMM (8), sp
    1a16:	508f           	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(8), d1	/* d1 = divisor */
    1a18:	222f 0008      	move.l 8(sp),d1
	movel	d1, sp@-
    1a1c:	2f01           	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    1a1e:	2f00           	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	PICCALL	SYM (__mulsi3)	/* d0 = (a/b)*b */
    1a20:	6100 ff3e      	bsr.w 1960 <__mulsi3>
	addql	IMM (8), sp
    1a24:	508f           	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(4), d1	/* d1 = dividend */
    1a26:	222f 0004      	move.l 4(sp),d1
	subl	d0, d1		/* d1 = a - (a/b)*b */
    1a2a:	9280           	sub.l d0,d1
	movel	d1, d0
    1a2c:	2001           	move.l d1,d0
	rts
    1a2e:	4e75           	rts

00001a30 <__umodsi3>:
	.text
	FUNC(__umodsi3)
	.globl	SYM (__umodsi3)
SYM (__umodsi3):
	.cfi_startproc
	movel	sp@(8), d1	/* d1 = divisor */
    1a30:	222f 0008      	move.l 8(sp),d1
	movel	sp@(4), d0	/* d0 = dividend */
    1a34:	202f 0004      	move.l 4(sp),d0
	movel	d1, sp@-
    1a38:	2f01           	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    1a3a:	2f00           	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	PICCALL	SYM (__udivsi3)
    1a3c:	6100 ff44      	bsr.w 1982 <__udivsi3>
	addql	IMM (8), sp
    1a40:	508f           	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(8), d1	/* d1 = divisor */
    1a42:	222f 0008      	move.l 8(sp),d1
	movel	d1, sp@-
    1a46:	2f01           	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    1a48:	2f00           	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	PICCALL	SYM (__mulsi3)	/* d0 = (a/b)*b */
    1a4a:	6100 ff14      	bsr.w 1960 <__mulsi3>
	addql	IMM (8), sp
    1a4e:	508f           	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(4), d1	/* d1 = dividend */
    1a50:	222f 0004      	move.l 4(sp),d1
	subl	d0, d1		/* d1 = a - (a/b)*b */
    1a54:	9280           	sub.l d0,d1
	movel	d1, d0
    1a56:	2001           	move.l d1,d0
	rts
    1a58:	4e75           	rts

00001a5a <KPutCharX>:
	FUNC(KPutCharX)
	.globl	SYM (KPutCharX)

SYM(KPutCharX):
	.cfi_startproc
    move.l  a6, -(sp)
    1a5a:	2f0e           	move.l a6,-(sp)
	.cfi_adjust_cfa_offset 4
    move.l  4.w, a6
    1a5c:	2c78 0004      	movea.l 4 <_start+0x4>,a6
    jsr     -0x204(a6)
    1a60:	4eae fdfc      	jsr -516(a6)
    movea.l (sp)+, a6
    1a64:	2c5f           	movea.l (sp)+,a6
	.cfi_adjust_cfa_offset -4
    rts
    1a66:	4e75           	rts

00001a68 <PutChar>:
	FUNC(PutChar)
	.globl	SYM (PutChar)

SYM(PutChar):
	.cfi_startproc
	move.b d0, (a3)+
    1a68:	16c0           	move.b d0,(a3)+
	rts
    1a6a:	4e75           	rts
