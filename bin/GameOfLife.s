
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
       4:	263c 0000 39b2 	move.l #14770,d3
       a:	0483 0000 39b2 	subi.l #14770,d3
      10:	e483           	asr.l #2,d3
	for (i = 0; i < count; i++)
      12:	6712           	beq.s 26 <_start+0x26>
      14:	45f9 0000 39b2 	lea 39b2 <__fini_array_end>,a2
      1a:	7400           	moveq #0,d2
		__preinit_array_start[i]();
      1c:	205a           	movea.l (a2)+,a0
      1e:	4e90           	jsr (a0)
	for (i = 0; i < count; i++)
      20:	5282           	addq.l #1,d2
      22:	b483           	cmp.l d3,d2
      24:	66f6           	bne.s 1c <_start+0x1c>

	count = __init_array_end - __init_array_start;
      26:	263c 0000 39b2 	move.l #14770,d3
      2c:	0483 0000 39b2 	subi.l #14770,d3
      32:	e483           	asr.l #2,d3
	for (i = 0; i < count; i++)
      34:	6712           	beq.s 48 <_start+0x48>
      36:	45f9 0000 39b2 	lea 39b2 <__fini_array_end>,a2
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
      4e:	243c 0000 39b2 	move.l #14770,d2
      54:	0482 0000 39b2 	subi.l #14770,d2
      5a:	e482           	asr.l #2,d2
	for (i = count; i > 0; i--)
      5c:	6710           	beq.s 6e <_start+0x6e>
      5e:	45f9 0000 39b2 	lea 39b2 <__fini_array_end>,a2
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
      7c:	23fc 0028 0064 	move.l #2621540,3c6c <GameMatrix+0x8>
      82:	0000 3c6c 
      86:	23fc 0004 0000 	move.l #262144,3c70 <GameMatrix+0xc>
      8c:	0000 3c70 
      90:	23fc 0005 0005 	move.l #327685,3c74 <GameMatrix+0x10>
      96:	0000 3c74 
	return RETURN_OK;
}

int StartApp(RenderData *rd)
{
	SysBase = *((struct ExecBase **)4UL);
      9a:	2c78 0004      	movea.l 4 <_start+0x4>,a6
      9e:	23ce 0000 3bd2 	move.l a6,3bd2 <SysBase>
	custom = (struct Custom *)0xdff000;
	unsigned int pens[] = {~0};
      a4:	70ff           	moveq #-1,d0
      a6:	2f40 0040      	move.l d0,64(sp)
	APTR *my_VisualInfo;

	if ((DOSBase = (struct DosLibrary *)OpenLibrary((CONST_STRPTR) "dos.library", 0)))
      aa:	43f9 0000 1864 	lea 1864 <PutChar+0x4>,a1
      b0:	7000           	moveq #0,d0
      b2:	4eae fdd8      	jsr -552(a6)
      b6:	23c0 0000 3bce 	move.l d0,3bce <DOSBase>
      bc:	6700 056c      	beq.w 62a <main+0x5b6>
	{
		if ((GfxBase = (struct GfxBase *)OpenLibrary((CONST_STRPTR) "graphics.library", 0)))
      c0:	2c79 0000 3bd2 	movea.l 3bd2 <SysBase>,a6
      c6:	43f9 0000 1870 	lea 1870 <PutChar+0x10>,a1
      cc:	7000           	moveq #0,d0
      ce:	4eae fdd8      	jsr -552(a6)
      d2:	23c0 0000 3be6 	move.l d0,3be6 <GfxBase>
      d8:	6700 0550      	beq.w 62a <main+0x5b6>
		{
			if ((IntuitionBase = (struct IntuitionBase *)OpenLibrary((CONST_STRPTR) "intuition.library", 0)))
      dc:	2c79 0000 3bd2 	movea.l 3bd2 <SysBase>,a6
      e2:	43f9 0000 1881 	lea 1881 <PutChar+0x21>,a1
      e8:	7000           	moveq #0,d0
      ea:	4eae fdd8      	jsr -552(a6)
      ee:	2c40           	movea.l d0,a6
      f0:	23c0 0000 3bda 	move.l d0,3bda <IntuitionBase>
      f6:	6700 0532      	beq.w 62a <main+0x5b6>
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
     13e:	2f7c 0000 1893 	move.l #6291,104(sp)
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
     17a:	41f9 0000 3bea 	lea 3bea <GOLRenderData>,a0
     180:	2080           	move.l d0,(a0)
     182:	6700 04a6      	beq.w 62a <main+0x5b6>
																			SA_Type, CUSTOMSCREEN,
																			SA_DetailPen, 1,
																			SA_BlockPen, 0,
																			TAG_END)))
				{
					if ((GadToolsBase = (struct Library *)OpenLibrary((CONST_STRPTR) "gadtools.library", 0)))
     186:	2c79 0000 3bd2 	movea.l 3bd2 <SysBase>,a6
     18c:	43f9 0000 18ab 	lea 18ab <PutChar+0x4b>,a1
     192:	7000           	moveq #0,d0
     194:	4eae fdd8      	jsr -552(a6)
     198:	23c0 0000 3bd6 	move.l d0,3bd6 <GadToolsBase>
     19e:	6700 048a      	beq.w 62a <main+0x5b6>
					{
						if ((GOLRenderData.MainWindow = (struct Window *)OpenWindowTags(NULL,
     1a2:	2f7c 8000 0070 	move.l #-2147483536,68(sp)
     1a8:	0044 
     1aa:	43f9 0000 3bea 	lea 3bea <GOLRenderData>,a1
     1b0:	2451           	movea.l (a1),a2
     1b2:	2f4a 0048      	move.l a2,72(sp)
     1b6:	2f7c 8000 0064 	move.l #-2147483548,76(sp)
     1bc:	004c 
     1be:	42af 0050      	clr.l 80(sp)
     1c2:	2f7c 8000 0065 	move.l #-2147483547,84(sp)
     1c8:	0054 
     1ca:	102a 001e      	move.b 30(a2),d0
     1ce:	4880           	ext.w d0
     1d0:	48c0           	ext.l d0
     1d2:	5280           	addq.l #1,d0
     1d4:	2f40 0058      	move.l d0,88(sp)
     1d8:	2f7c 8000 0066 	move.l #-2147483546,92(sp)
     1de:	005c 
     1e0:	102a 0024      	move.b 36(a2),d0
     1e4:	4880           	ext.w d0
     1e6:	3a40           	movea.w d0,a5
     1e8:	102a 0025      	move.b 37(a2),d0
     1ec:	4880           	ext.w d0
     1ee:	3840           	movea.w d0,a4
     1f0:	7000           	moveq #0,d0
     1f2:	3039 0000 3c6e 	move.w 3c6e <GameMatrix+0xa>,d0
     1f8:	7200           	moveq #0,d1
     1fa:	3239 0000 3c74 	move.w 3c74 <GameMatrix+0x10>,d1
     200:	2f01           	move.l d1,-(sp)
     202:	2640           	movea.l d0,a3
     204:	486b ffff      	pea -1(a3)
     208:	4eb9 0000 1758 	jsr 1758 <__mulsi3>
     20e:	508f           	addq.l #8,sp
     210:	d08d           	add.l a5,d0
     212:	d08c           	add.l a4,d0
     214:	2f40 0060      	move.l d0,96(sp)
     218:	2f7c 8000 0067 	move.l #-2147483545,100(sp)
     21e:	0064 
     220:	102a 0023      	move.b 35(a2),d0
     224:	4880           	ext.w d0
     226:	3640           	movea.w d0,a3
     228:	102a 0026      	move.b 38(a2),d0
     22c:	4880           	ext.w d0
     22e:	3440           	movea.w d0,a2
     230:	7000           	moveq #0,d0
     232:	3039 0000 3c6c 	move.w 3c6c <GameMatrix+0x8>,d0
     238:	7200           	moveq #0,d1
     23a:	3239 0000 3c76 	move.w 3c76 <GameMatrix+0x12>,d1
     240:	2f01           	move.l d1,-(sp)
     242:	2040           	movea.l d0,a0
     244:	4868 ffff      	pea -1(a0)
     248:	4eb9 0000 1758 	jsr 1758 <__mulsi3>
     24e:	508f           	addq.l #8,sp
     250:	d08b           	add.l a3,d0
     252:	d08a           	add.l a2,d0
     254:	2f40 0068      	move.l d0,104(sp)
     258:	2f7c 8000 0074 	move.l #-2147483532,108(sp)
     25e:	006c 
     260:	203c 0000 0280 	move.l #640,d0
     266:	908d           	sub.l a5,d0
     268:	908c           	sub.l a4,d0
     26a:	2f40 0070      	move.l d0,112(sp)
     26e:	2f7c 8000 0075 	move.l #-2147483531,116(sp)
     274:	0074 
     276:	203c 0000 0100 	move.l #256,d0
     27c:	908b           	sub.l a3,d0
     27e:	908a           	sub.l a2,d0
     280:	2f40 0078      	move.l d0,120(sp)
     284:	2f7c 8000 006e 	move.l #-2147483538,124(sp)
     28a:	007c 
     28c:	2f7c 0000 18bc 	move.l #6332,128(sp)
     292:	0080 
     294:	2f7c 8000 0083 	move.l #-2147483517,132(sp)
     29a:	0084 
     29c:	7001           	moveq #1,d0
     29e:	2f40 0088      	move.l d0,136(sp)
     2a2:	2f7c 8000 0084 	move.l #-2147483516,140(sp)
     2a8:	008c 
     2aa:	2f40 0090      	move.l d0,144(sp)
     2ae:	2f7c 8000 0081 	move.l #-2147483519,148(sp)
     2b4:	0094 
     2b6:	2f40 0098      	move.l d0,152(sp)
     2ba:	2f7c 8000 0082 	move.l #-2147483518,156(sp)
     2c0:	009c 
     2c2:	2f40 00a0      	move.l d0,160(sp)
     2c6:	2f7c 8000 0091 	move.l #-2147483503,164(sp)
     2cc:	00a4 
     2ce:	2f40 00a8      	move.l d0,168(sp)
     2d2:	2f7c 8000 0086 	move.l #-2147483514,172(sp)
     2d8:	00ac 
     2da:	2f40 00b0      	move.l d0,176(sp)
     2de:	2f7c 8000 0093 	move.l #-2147483501,180(sp)
     2e4:	00b4 
     2e6:	2f40 00b8      	move.l d0,184(sp)
     2ea:	2f7c 8000 0089 	move.l #-2147483511,188(sp)
     2f0:	00bc 
     2f2:	2f40 00c0      	move.l d0,192(sp)
     2f6:	2f7c 8000 006f 	move.l #-2147483537,196(sp)
     2fc:	00c4 
     2fe:	2f7c 0000 18c4 	move.l #6340,200(sp)
     304:	00c8 
     306:	2f7c 8000 006a 	move.l #-2147483542,204(sp)
     30c:	00cc 
     30e:	2f7c 0000 031e 	move.l #798,208(sp)
     314:	00d0 
     316:	2f7c 8000 0068 	move.l #-2147483544,212(sp)
     31c:	00d4 
     31e:	7204           	moveq #4,d1
     320:	2f41 00d8      	move.l d1,216(sp)
     324:	2f7c 8000 0069 	move.l #-2147483543,220(sp)
     32a:	00dc 
     32c:	7008           	moveq #8,d0
     32e:	2f40 00e0      	move.l d0,224(sp)
     332:	42af 00e4      	clr.l 228(sp)
     336:	2c79 0000 3bda 	movea.l 3bda <IntuitionBase>,a6
     33c:	91c8           	suba.l a0,a0
     33e:	43ef 0044      	lea 68(sp),a1
     342:	4eae fda2      	jsr -606(a6)
     346:	2040           	movea.l d0,a0
     348:	23c0 0000 3bee 	move.l d0,3bee <GOLRenderData+0x4>
     34e:	6700 02da      	beq.w 62a <main+0x5b6>

void ComputeOutputSize(RenderData *rd)
{
	/* our output size is simply the window's size minus its borders */
	rd->OutputSize.x =
		rd->MainWindow->Width - rd->MainWindow->BorderLeft - rd->MainWindow->BorderRight;
     352:	1028 0036      	move.b 54(a0),d0
     356:	4880           	ext.w d0
     358:	1228 0038      	move.b 56(a0),d1
     35c:	4881           	ext.w d1
     35e:	d041           	add.w d1,d0
     360:	3228 0008      	move.w 8(a0),d1
     364:	9240           	sub.w d0,d1
     366:	33c1 0000 3bf2 	move.w d1,3bf2 <GOLRenderData+0x8>
	rd->OutputSize.y =
		rd->MainWindow->Height - rd->MainWindow->BorderTop - rd->MainWindow->BorderBottom;
     36c:	1028 0037      	move.b 55(a0),d0
     370:	4880           	ext.w d0
     372:	1228 0039      	move.b 57(a0),d1
     376:	4881           	ext.w d1
     378:	d041           	add.w d1,d0
     37a:	3268 000a      	movea.w 10(a0),a1
     37e:	92c0           	suba.w d0,a1
     380:	33c9 0000 3bf4 	move.w a1,3bf4 <GOLRenderData+0xa>
							my_VisualInfo = GetVisualInfo(GOLRenderData.MainWindow->WScreen, TAG_END);
     386:	42af 0044      	clr.l 68(sp)
     38a:	2c79 0000 3bd6 	movea.l 3bd6 <GadToolsBase>,a6
     390:	2068 002e      	movea.l 46(a0),a0
     394:	43ef 0044      	lea 68(sp),a1
     398:	4eae ff82      	jsr -126(a6)
     39c:	2400           	move.l d0,d2
							MainMenuStrip = CreateMenus(GolMainMenu, TAG_END);
     39e:	42af 0044      	clr.l 68(sp)
     3a2:	2c79 0000 3bd6 	movea.l 3bd6 <GadToolsBase>,a6
     3a8:	41f9 0000 39b4 	lea 39b4 <GolMainMenu>,a0
     3ae:	43ef 0044      	lea 68(sp),a1
     3b2:	4eae ffd0      	jsr -48(a6)
     3b6:	2040           	movea.l d0,a0
     3b8:	23c0 0000 3be2 	move.l d0,3be2 <MainMenuStrip>
							LayoutMenus(MainMenuStrip, my_VisualInfo, TAG_END);
     3be:	42af 0044      	clr.l 68(sp)
     3c2:	2c79 0000 3bd6 	movea.l 3bd6 <GadToolsBase>,a6
     3c8:	2242           	movea.l d2,a1
     3ca:	45ef 0044      	lea 68(sp),a2
     3ce:	4eae ffbe      	jsr -66(a6)
							SetMenuStrip(GOLRenderData.MainWindow, MainMenuStrip);
     3d2:	2c79 0000 3bda 	movea.l 3bda <IntuitionBase>,a6
     3d8:	2079 0000 3bee 	movea.l 3bee <GOLRenderData+0x4>,a0
     3de:	2279 0000 3be2 	movea.l 3be2 <MainMenuStrip>,a1
     3e4:	4eae fef8      	jsr -264(a6)
	if (AllocPlayfieldMem() != RETURN_OK)
     3e8:	4eb9 0000 0edc 	jsr edc <AllocPlayfieldMem>
     3ee:	4a80           	tst.l d0
     3f0:	6600 0a62      	bne.w e54 <main+0xde0>
	if (PrepareBackbuffer(&GOLRenderData) != RETURN_OK)
     3f4:	4eb9 0000 10b8 	jsr 10b8 <PrepareBackbuffer.constprop.0>
     3fa:	2f40 003c      	move.l d0,60(sp)
     3fe:	6600 0a54      	bne.w e54 <main+0xde0>
	SetRast(GOLRenderData.MainWindow->RPort, 0);
     402:	2c79 0000 3be6 	movea.l 3be6 <GfxBase>,a6
     408:	2079 0000 3bee 	movea.l 3bee <GOLRenderData+0x4>,a0
     40e:	2268 0032      	movea.l 50(a0),a1
     412:	4eae ff16      	jsr -234(a6)
	SetRast(&GOLRenderData.Rastport, 0);
     416:	2c79 0000 3be6 	movea.l 3be6 <GfxBase>,a6
     41c:	43f9 0000 3bfa 	lea 3bfa <GOLRenderData+0x10>,a1
     422:	7000           	moveq #0,d0
     424:	4eae ff16      	jsr -234(a6)
	while (AppRunning)
     428:	4a79 0000 3bbc 	tst.w 3bbc <AppRunning>
     42e:	6700 014e      	beq.w 57e <main+0x50a>
					ClearPlayfield(GameMatrix.Playfield);
     432:	4bf9 0000 3c64 	lea 3c64 <GameMatrix>,a5
		EventLoop(GOLRenderData.MainWindow, MainMenuStrip);
     438:	2f79 0000 3be2 	move.l 3be2 <MainMenuStrip>,52(sp)
     43e:	0034 
     440:	2879 0000 3bee 	movea.l 3bee <GOLRenderData+0x4>,a4
	if (!GameRunning)
     446:	4a79 0000 3be0 	tst.w 3be0 <GameRunning>
     44c:	6606           	bne.s 454 <main+0x3e0>
		UpdateCnt = 0;
     44e:	4279 0000 3bde 	clr.w 3bde <UpdateCnt>
     454:	264c           	movea.l a4,a3
	while ((message = (struct IntuiMessage *)GetMsg(theWindow->UserPort)))
     456:	2c79 0000 3bd2 	movea.l 3bd2 <SysBase>,a6
     45c:	206b 0056      	movea.l 86(a3),a0
     460:	4eae fe8c      	jsr -372(a6)
     464:	2440           	movea.l d0,a2
     466:	4a80           	tst.l d0
     468:	6700 00b4      	beq.w 51e <main+0x4aa>
		msg_class = message->Class;
     46c:	242a 0014      	move.l 20(a2),d2
		msg_code = message->Code;
     470:	3a2a 0018      	move.w 24(a2),d5
		coordX = message->MouseX - theWindow->BorderLeft;
     474:	102b 0036      	move.b 54(a3),d0
     478:	4880           	ext.w d0
     47a:	382a 0020      	move.w 32(a2),d4
     47e:	9840           	sub.w d0,d4
		coordY = message->MouseY - theWindow->BorderTop;
     480:	102b 0037      	move.b 55(a3),d0
     484:	4880           	ext.w d0
     486:	362a 0022      	move.w 34(a2),d3
     48a:	9640           	sub.w d0,d3
		ReplyMsg((struct Message *)message);
     48c:	2c79 0000 3bd2 	movea.l 3bd2 <SysBase>,a6
     492:	224a           	movea.l a2,a1
     494:	4eae fe86      	jsr -378(a6)
		switch (msg_class)
     498:	7010           	moveq #16,d0
     49a:	b082           	cmp.l d2,d0
     49c:	6700 0202      	beq.w 6a0 <main+0x62c>
     4a0:	6500 01e0      	bcs.w 682 <main+0x60e>
     4a4:	7204           	moveq #4,d1
     4a6:	b282           	cmp.l d2,d1
     4a8:	6700 0260      	beq.w 70a <main+0x696>
     4ac:	7008           	moveq #8,d0
     4ae:	b082           	cmp.l d2,d0
     4b0:	6600 018c      	bne.w 63e <main+0x5ca>
			x = (coordX / GameMatrix.CellSizeH) + 1;
     4b4:	3444           	movea.w d4,a2
			y = (coordY / GameMatrix.CellSizeV) + 1;
     4b6:	3c43           	movea.w d3,a6
			x = (coordX / GameMatrix.CellSizeH) + 1;
     4b8:	7000           	moveq #0,d0
     4ba:	3039 0000 3c74 	move.w 3c74 <GameMatrix+0x10>,d0
     4c0:	49f9 0000 17d6 	lea 17d6 <__divsi3>,a4
     4c6:	2f00           	move.l d0,-(sp)
     4c8:	2f0a           	move.l a2,-(sp)
     4ca:	4e94           	jsr (a4)
     4cc:	508f           	addq.l #8,sp
     4ce:	2400           	move.l d0,d2
     4d0:	5282           	addq.l #1,d2
			y = (coordY / GameMatrix.CellSizeV) + 1;
     4d2:	7000           	moveq #0,d0
     4d4:	3039 0000 3c76 	move.w 3c76 <GameMatrix+0x12>,d0
     4da:	2f00           	move.l d0,-(sp)
     4dc:	2f0e           	move.l a6,-(sp)
     4de:	4e94           	jsr (a4)
     4e0:	508f           	addq.l #8,sp
     4e2:	2600           	move.l d0,d3
     4e4:	5283           	addq.l #1,d3
     4e6:	0c45 0068      	cmpi.w #104,d5
     4ea:	6700 05fe      	beq.w aea <main+0xa76>
     4ee:	0c45 00e8      	cmpi.w #232,d5
     4f2:	6600 01de      	bne.w 6d2 <main+0x65e>
				DrawActive = FALSE;
     4f6:	4279 0000 3bc8 	clr.w 3bc8 <DrawActive>
			OldSelectX = x;
     4fc:	23c2 0000 3bc4 	move.l d2,3bc4 <OldSelectX>
			OldSelectY = y;
     502:	23c3 0000 3bc0 	move.l d3,3bc0 <OldSelectY>
	while ((message = (struct IntuiMessage *)GetMsg(theWindow->UserPort)))
     508:	2c79 0000 3bd2 	movea.l 3bd2 <SysBase>,a6
     50e:	206b 0056      	movea.l 86(a3),a0
     512:	4eae fe8c      	jsr -372(a6)
     516:	2440           	movea.l d0,a2
     518:	4a80           	tst.l d0
     51a:	6600 ff50      	bne.w 46c <main+0x3f8>
		if (GameRunning)
     51e:	4a79 0000 3be0 	tst.w 3be0 <GameRunning>
     524:	6600 07f0      	bne.w d16 <main+0xca2>
		if (UpdateCnt > 0)
     528:	3439 0000 3bde 	move.w 3bde <UpdateCnt>,d2
     52e:	4a42           	tst.w d2
     530:	6600 06a6      	bne.w bd8 <main+0xb64>
		WaitTOF();
     534:	2c79 0000 3be6 	movea.l 3be6 <GfxBase>,a6
     53a:	4eae fef2      	jsr -270(a6)
}

void RepaintWindow(RenderData *rd)
{
	/* on repaint we simply blit our backbuffer into our window's RastPort */
	BltBitMapRastPort(rd->Backbuffer,
     53e:	2c79 0000 3be6 	movea.l 3be6 <GfxBase>,a6
     544:	2079 0000 3c5e 	movea.l 3c5e <GOLRenderData+0x74>,a0
     54a:	7000           	moveq #0,d0
     54c:	7200           	moveq #0,d1
     54e:	2279 0000 3bee 	movea.l 3bee <GOLRenderData+0x4>,a1
     554:	2269 0032      	movea.l 50(a1),a1
     558:	7400           	moveq #0,d2
     55a:	7600           	moveq #0,d3
     55c:	3839 0000 3bf2 	move.w 3bf2 <GOLRenderData+0x8>,d4
     562:	48c4           	ext.l d4
     564:	3a39 0000 3bf4 	move.w 3bf4 <GOLRenderData+0xa>,d5
     56a:	48c5           	ext.l d5
     56c:	7c3f           	moveq #63,d6
     56e:	4606           	not.b d6
     570:	4eae fda2      	jsr -606(a6)
	while (AppRunning)
     574:	4a79 0000 3bbc 	tst.w 3bbc <AppRunning>
     57a:	6600 febc      	bne.w 438 <main+0x3c4>
	FreePlayfieldMem();
     57e:	4eb9 0000 1428 	jsr 1428 <FreePlayfieldMem.isra.0>
	FreeBitMap(GOLRenderData.Backbuffer);
     584:	2c79 0000 3be6 	movea.l 3be6 <GfxBase>,a6
     58a:	2079 0000 3c5e 	movea.l 3c5e <GOLRenderData+0x74>,a0
     590:	4eae fc64      	jsr -924(a6)
	if (GOLRenderData.MainWindow)
     594:	2079 0000 3bee 	movea.l 3bee <GOLRenderData+0x4>,a0
     59a:	b0fc 0000      	cmpa.w #0,a0
     59e:	670a           	beq.s 5aa <main+0x536>
		CloseWindow(GOLRenderData.MainWindow);
     5a0:	2c79 0000 3bda 	movea.l 3bda <IntuitionBase>,a6
     5a6:	4eae ffb8      	jsr -72(a6)
	if (GadToolsBase)
     5aa:	2279 0000 3bd6 	movea.l 3bd6 <GadToolsBase>,a1
     5b0:	b2fc 0000      	cmpa.w #0,a1
     5b4:	670a           	beq.s 5c0 <main+0x54c>
		CloseLibrary((struct Library *)GadToolsBase);
     5b6:	2c79 0000 3bd2 	movea.l 3bd2 <SysBase>,a6
     5bc:	4eae fe62      	jsr -414(a6)
	if (GOLRenderData.Screen)
     5c0:	43f9 0000 3bea 	lea 3bea <GOLRenderData>,a1
     5c6:	2051           	movea.l (a1),a0
     5c8:	b0fc 0000      	cmpa.w #0,a0
     5cc:	670a           	beq.s 5d8 <main+0x564>
		CloseScreen(GOLRenderData.Screen);
     5ce:	2c79 0000 3bda 	movea.l 3bda <IntuitionBase>,a6
     5d4:	4eae ffbe      	jsr -66(a6)
	if (GfxBase)
     5d8:	2279 0000 3be6 	movea.l 3be6 <GfxBase>,a1
     5de:	b2fc 0000      	cmpa.w #0,a1
     5e2:	670a           	beq.s 5ee <main+0x57a>
		CloseLibrary((struct Library *)GfxBase);
     5e4:	2c79 0000 3bd2 	movea.l 3bd2 <SysBase>,a6
     5ea:	4eae fe62      	jsr -414(a6)
	if (IntuitionBase)
     5ee:	2279 0000 3bda 	movea.l 3bda <IntuitionBase>,a1
     5f4:	b2fc 0000      	cmpa.w #0,a1
     5f8:	670a           	beq.s 604 <main+0x590>
		CloseLibrary((struct Library *)IntuitionBase);
     5fa:	2c79 0000 3bd2 	movea.l 3bd2 <SysBase>,a6
     600:	4eae fe62      	jsr -414(a6)
	if (DOSBase)
     604:	2279 0000 3bce 	movea.l 3bce <DOSBase>,a1
     60a:	b2fc 0000      	cmpa.w #0,a1
     60e:	6700 0844      	beq.w e54 <main+0xde0>
		CloseLibrary((struct Library *)DOSBase);
     612:	2c79 0000 3bd2 	movea.l 3bd2 <SysBase>,a6
     618:	4eae fe62      	jsr -414(a6)
}
     61c:	202f 003c      	move.l 60(sp),d0
     620:	4cdf 7cfc      	movem.l (sp)+,d2-d7/a2-a6
     624:	4fef 00bc      	lea 188(sp),sp
     628:	4e75           	rts
		return RETURN_FAIL;
     62a:	7214           	moveq #20,d1
     62c:	2f41 003c      	move.l d1,60(sp)
}
     630:	202f 003c      	move.l 60(sp),d0
     634:	4cdf 7cfc      	movem.l (sp)+,d2-d7/a2-a6
     638:	4fef 00bc      	lea 188(sp),sp
     63c:	4e75           	rts
		switch (msg_class)
     63e:	5582           	subq.l #2,d2
     640:	6600 fe14      	bne.w 456 <main+0x3e2>
		rd->MainWindow->Width - rd->MainWindow->BorderLeft - rd->MainWindow->BorderRight;
     644:	2079 0000 3bee 	movea.l 3bee <GOLRenderData+0x4>,a0
     64a:	1028 0036      	move.b 54(a0),d0
     64e:	4880           	ext.w d0
     650:	1228 0038      	move.b 56(a0),d1
     654:	4881           	ext.w d1
     656:	d041           	add.w d1,d0
     658:	3268 0008      	movea.w 8(a0),a1
     65c:	92c0           	suba.w d0,a1
     65e:	33c9 0000 3bf2 	move.w a1,3bf2 <GOLRenderData+0x8>
		rd->MainWindow->Height - rd->MainWindow->BorderTop - rd->MainWindow->BorderBottom;
     664:	1028 0037      	move.b 55(a0),d0
     668:	4880           	ext.w d0
     66a:	1228 0039      	move.b 57(a0),d1
     66e:	4881           	ext.w d1
     670:	d041           	add.w d1,d0
     672:	3068 000a      	movea.w 10(a0),a0
     676:	90c0           	suba.w d0,a0
     678:	33c8 0000 3bf4 	move.w a0,3bf4 <GOLRenderData+0xa>
     67e:	6000 fdd6      	bra.w 456 <main+0x3e2>
		switch (msg_class)
     682:	0c82 0000 0100 	cmpi.l #256,d2
     688:	6700 02b6      	beq.w 940 <main+0x8cc>
     68c:	0c82 0000 0200 	cmpi.l #512,d2
     692:	6600 fdc2      	bne.w 456 <main+0x3e2>
			AppRunning = FALSE;
     696:	4279 0000 3bbc 	clr.w 3bbc <AppRunning>
			break;
     69c:	6000 fdb8      	bra.w 456 <main+0x3e2>
			x = (coordX / GameMatrix.CellSizeH) + 1;
     6a0:	3444           	movea.w d4,a2
			y = (coordY / GameMatrix.CellSizeV) + 1;
     6a2:	3c43           	movea.w d3,a6
			x = (coordX / GameMatrix.CellSizeH) + 1;
     6a4:	7000           	moveq #0,d0
     6a6:	3039 0000 3c74 	move.w 3c74 <GameMatrix+0x10>,d0
     6ac:	49f9 0000 17d6 	lea 17d6 <__divsi3>,a4
     6b2:	2f00           	move.l d0,-(sp)
     6b4:	2f0a           	move.l a2,-(sp)
     6b6:	4e94           	jsr (a4)
     6b8:	508f           	addq.l #8,sp
     6ba:	2400           	move.l d0,d2
     6bc:	5282           	addq.l #1,d2
			y = (coordY / GameMatrix.CellSizeV) + 1;
     6be:	7000           	moveq #0,d0
     6c0:	3039 0000 3c76 	move.w 3c76 <GameMatrix+0x12>,d0
     6c6:	2f00           	move.l d0,-(sp)
     6c8:	2f0e           	move.l a6,-(sp)
     6ca:	4e94           	jsr (a4)
     6cc:	508f           	addq.l #8,sp
     6ce:	2600           	move.l d0,d3
     6d0:	5283           	addq.l #1,d3
			if (DrawActive && (x != OldSelectX || y != OldSelectY))
     6d2:	4a79 0000 3bc8 	tst.w 3bc8 <DrawActive>
     6d8:	6700 fe22      	beq.w 4fc <main+0x488>
     6dc:	b4b9 0000 3bc4 	cmp.l 3bc4 <OldSelectX>,d2
     6e2:	660a           	bne.s 6ee <main+0x67a>
     6e4:	b6b9 0000 3bc0 	cmp.l 3bc0 <OldSelectY>,d3
     6ea:	6700 fe10      	beq.w 4fc <main+0x488>
				ToggleCellStatus(coordX, coordY);
     6ee:	2f0e           	move.l a6,-(sp)
     6f0:	2f0a           	move.l a2,-(sp)
     6f2:	4eb9 0000 0ffa 	jsr ffa <ToggleCellStatus>
     6f8:	508f           	addq.l #8,sp
			OldSelectX = x;
     6fa:	23c2 0000 3bc4 	move.l d2,3bc4 <OldSelectX>
			OldSelectY = y;
     700:	23c3 0000 3bc0 	move.l d3,3bc0 <OldSelectY>
			break;
     706:	6000 fe00      	bra.w 508 <main+0x494>
			SetWindowTitles(GOLRenderData.MainWindow, "Reconfiguring Memory...", -1);
     70a:	2c79 0000 3bda 	movea.l 3bda <IntuitionBase>,a6
     710:	2079 0000 3bee 	movea.l 3bee <GOLRenderData+0x4>,a0
     716:	43f9 0000 18dd 	lea 18dd <PutChar+0x7d>,a1
     71c:	347c ffff      	movea.w #-1,a2
     720:	4eae feec      	jsr -276(a6)
			PrepareBackbuffer(&GOLRenderData);
     724:	4eb9 0000 10b8 	jsr 10b8 <PrepareBackbuffer.constprop.0>
			FreePlayfieldMem();
     72a:	4eb9 0000 1428 	jsr 1428 <FreePlayfieldMem.isra.0>
			GameMatrix.Columns = GOLRenderData.OutputSize.x / GameMatrix.CellSizeH;
     730:	7000           	moveq #0,d0
     732:	3039 0000 3c74 	move.w 3c74 <GameMatrix+0x10>,d0
     738:	45f9 0000 17d6 	lea 17d6 <__divsi3>,a2
     73e:	2f00           	move.l d0,-(sp)
     740:	3079 0000 3bf2 	movea.w 3bf2 <GOLRenderData+0x8>,a0
     746:	2f08           	move.l a0,-(sp)
     748:	4e92           	jsr (a2)
     74a:	508f           	addq.l #8,sp
     74c:	33c0 0000 3c6e 	move.w d0,3c6e <GameMatrix+0xa>
			GameMatrix.Rows = GOLRenderData.OutputSize.y / GameMatrix.CellSizeV;
     752:	7000           	moveq #0,d0
     754:	3039 0000 3c76 	move.w 3c76 <GameMatrix+0x12>,d0
     75a:	2f00           	move.l d0,-(sp)
     75c:	3279 0000 3bf4 	movea.w 3bf4 <GOLRenderData+0xa>,a1
     762:	2f09           	move.l a1,-(sp)
     764:	4e92           	jsr (a2)
     766:	508f           	addq.l #8,sp
     768:	33c0 0000 3c6c 	move.w d0,3c6c <GameMatrix+0x8>
			AllocPlayfieldMem();
     76e:	4eb9 0000 0edc 	jsr edc <AllocPlayfieldMem>
			SetRast(&GOLRenderData.Rastport, 0);
     774:	2c79 0000 3be6 	movea.l 3be6 <GfxBase>,a6
     77a:	43f9 0000 3bfa 	lea 3bfa <GOLRenderData+0x10>,a1
     780:	7000           	moveq #0,d0
     782:	4eae ff16      	jsr -234(a6)
	for (int y = 1; y < GameMatrix.Rows - 1; y++)
     786:	0c79 0002 0000 	cmpi.w #2,3c6c <GameMatrix+0x8>
     78c:	3c6c 
     78e:	6300 00da      	bls.w 86a <main+0x7f6>
		for (int x = 1; x < GameMatrix.Columns - 1; x++)
     792:	3239 0000 3c6e 	move.w 3c6e <GameMatrix+0xa>,d1
	for (int y = 1; y < GameMatrix.Rows - 1; y++)
     798:	7001           	moveq #1,d0
     79a:	2f40 0030      	move.l d0,48(sp)
				SetAPen(&rd->Rastport, GameMatrix.ColorDead);
     79e:	283c 0000 3bfa 	move.l #15354,d4
		for (int x = 1; x < GameMatrix.Columns - 1; x++)
     7a4:	0c41 0002      	cmpi.w #2,d1
     7a8:	6300 00c0      	bls.w 86a <main+0x7f6>
     7ac:	222f 0030      	move.l 48(sp),d1
     7b0:	5381           	subq.l #1,d1
     7b2:	2f41 002c      	move.l d1,44(sp)
     7b6:	7a04           	moveq #4,d5
     7b8:	347c 0001      	movea.w #1,a2
     7bc:	2f4b 0038      	move.l a3,56(sp)
     7c0:	2c2f 0030      	move.l 48(sp),d6
				SetAPen(&rd->Rastport, GameMatrix.ColorAlive);
     7c4:	2c79 0000 3be6 	movea.l 3be6 <GfxBase>,a6
			if (GameMatrix.Playfield[x][y].Status)
     7ca:	2055           	movea.l (a5),a0
     7cc:	2070 5800      	movea.l (0,a0,d5.l),a0
				SetAPen(&rd->Rastport, GameMatrix.ColorAlive);
     7d0:	2244           	movea.l d4,a1
     7d2:	7000           	moveq #0,d0
			if (GameMatrix.Playfield[x][y].Status)
     7d4:	4a30 6800      	tst.b (0,a0,d6.l)
     7d8:	6700 00ee      	beq.w 8c8 <main+0x854>
				SetAPen(&rd->Rastport, GameMatrix.ColorAlive);
     7dc:	3039 0000 3c70 	move.w 3c70 <GameMatrix+0xc>,d0
     7e2:	4eae feaa      	jsr -342(a6)
			RectFill(&rd->Rastport,
     7e6:	7400           	moveq #0,d2
     7e8:	3439 0000 3c74 	move.w 3c74 <GameMatrix+0x10>,d2
     7ee:	2f02           	move.l d2,-(sp)
     7f0:	486a ffff      	pea -1(a2)
     7f4:	4eb9 0000 1758 	jsr 1758 <__mulsi3>
     7fa:	508f           	addq.l #8,sp
     7fc:	2840           	movea.l d0,a4
     7fe:	2e00           	move.l d0,d7
     800:	5287           	addq.l #1,d7
     802:	7000           	moveq #0,d0
     804:	3039 0000 3c76 	move.w 3c76 <GameMatrix+0x12>,d0
     80a:	2640           	movea.l d0,a3
     80c:	2f2f 002c      	move.l 44(sp),-(sp)
     810:	2f0b           	move.l a3,-(sp)
     812:	4eb9 0000 1758 	jsr 1758 <__mulsi3>
     818:	508f           	addq.l #8,sp
     81a:	2600           	move.l d0,d3
     81c:	2c79 0000 3be6 	movea.l 3be6 <GfxBase>,a6
     822:	2244           	movea.l d4,a1
     824:	2007           	move.l d7,d0
     826:	2203           	move.l d3,d1
     828:	5281           	addq.l #1,d1
     82a:	49f4 28ff      	lea (-1,a4,d2.l),a4
     82e:	240c           	move.l a4,d2
     830:	47f3 38ff      	lea (-1,a3,d3.l),a3
     834:	260b           	move.l a3,d3
     836:	4eae fece      	jsr -306(a6)
		for (int x = 1; x < GameMatrix.Columns - 1; x++)
     83a:	528a           	addq.l #1,a2
     83c:	3239 0000 3c6e 	move.w 3c6e <GameMatrix+0xa>,d1
     842:	5885           	addq.l #4,d5
     844:	7000           	moveq #0,d0
     846:	3001           	move.w d1,d0
     848:	5380           	subq.l #1,d0
     84a:	b08a           	cmp.l a2,d0
     84c:	6e00 ff76      	bgt.w 7c4 <main+0x750>
	for (int y = 1; y < GameMatrix.Rows - 1; y++)
     850:	266f 0038      	movea.l 56(sp),a3
     854:	52af 0030      	addq.l #1,48(sp)
     858:	7000           	moveq #0,d0
     85a:	3039 0000 3c6c 	move.w 3c6c <GameMatrix+0x8>,d0
     860:	5380           	subq.l #1,d0
     862:	b0af 0030      	cmp.l 48(sp),d0
     866:	6e00 ff3c      	bgt.w 7a4 <main+0x730>
	BltBitMapRastPort(rd->Backbuffer,
     86a:	2c79 0000 3be6 	movea.l 3be6 <GfxBase>,a6
     870:	2079 0000 3c5e 	movea.l 3c5e <GOLRenderData+0x74>,a0
     876:	7000           	moveq #0,d0
     878:	7200           	moveq #0,d1
     87a:	2279 0000 3bee 	movea.l 3bee <GOLRenderData+0x4>,a1
     880:	2269 0032      	movea.l 50(a1),a1
     884:	7400           	moveq #0,d2
     886:	7600           	moveq #0,d3
     888:	3839 0000 3bf2 	move.w 3bf2 <GOLRenderData+0x8>,d4
     88e:	48c4           	ext.l d4
     890:	3a39 0000 3bf4 	move.w 3bf4 <GOLRenderData+0xa>,d5
     896:	48c5           	ext.l d5
     898:	7c3f           	moveq #63,d6
     89a:	4606           	not.b d6
     89c:	4eae fda2      	jsr -606(a6)
			GameRunning ? SetWindowTitles(GOLRenderData.MainWindow, "Running", -1) : SetWindowTitles(GOLRenderData.MainWindow, "Stopped", -1);
     8a0:	2c79 0000 3bda 	movea.l 3bda <IntuitionBase>,a6
     8a6:	2079 0000 3bee 	movea.l 3bee <GOLRenderData+0x4>,a0
     8ac:	4a79 0000 3be0 	tst.w 3be0 <GameRunning>
     8b2:	6700 01ec      	beq.w aa0 <main+0xa2c>
     8b6:	43f9 0000 18f5 	lea 18f5 <PutChar+0x95>,a1
     8bc:	347c ffff      	movea.w #-1,a2
     8c0:	4eae feec      	jsr -276(a6)
     8c4:	6000 fb90      	bra.w 456 <main+0x3e2>
				SetAPen(&rd->Rastport, GameMatrix.ColorDead);
     8c8:	3039 0000 3c72 	move.w 3c72 <GameMatrix+0xe>,d0
     8ce:	4eae feaa      	jsr -342(a6)
			RectFill(&rd->Rastport,
     8d2:	7400           	moveq #0,d2
     8d4:	3439 0000 3c74 	move.w 3c74 <GameMatrix+0x10>,d2
     8da:	2f02           	move.l d2,-(sp)
     8dc:	486a ffff      	pea -1(a2)
     8e0:	4eb9 0000 1758 	jsr 1758 <__mulsi3>
     8e6:	508f           	addq.l #8,sp
     8e8:	2840           	movea.l d0,a4
     8ea:	2e00           	move.l d0,d7
     8ec:	5287           	addq.l #1,d7
     8ee:	7000           	moveq #0,d0
     8f0:	3039 0000 3c76 	move.w 3c76 <GameMatrix+0x12>,d0
     8f6:	2640           	movea.l d0,a3
     8f8:	2f2f 002c      	move.l 44(sp),-(sp)
     8fc:	2f0b           	move.l a3,-(sp)
     8fe:	4eb9 0000 1758 	jsr 1758 <__mulsi3>
     904:	508f           	addq.l #8,sp
     906:	2600           	move.l d0,d3
     908:	2c79 0000 3be6 	movea.l 3be6 <GfxBase>,a6
     90e:	2244           	movea.l d4,a1
     910:	2007           	move.l d7,d0
     912:	2203           	move.l d3,d1
     914:	5281           	addq.l #1,d1
     916:	49f4 28ff      	lea (-1,a4,d2.l),a4
     91a:	240c           	move.l a4,d2
     91c:	47f3 38ff      	lea (-1,a3,d3.l),a3
     920:	260b           	move.l a3,d3
     922:	4eae fece      	jsr -306(a6)
		for (int x = 1; x < GameMatrix.Columns - 1; x++)
     926:	528a           	addq.l #1,a2
     928:	3239 0000 3c6e 	move.w 3c6e <GameMatrix+0xa>,d1
     92e:	5885           	addq.l #4,d5
     930:	7000           	moveq #0,d0
     932:	3001           	move.w d1,d0
     934:	5380           	subq.l #1,d0
     936:	b08a           	cmp.l a2,d0
     938:	6e00 fe8a      	bgt.w 7c4 <main+0x750>
     93c:	6000 ff12      	bra.w 850 <main+0x7dc>
			menuNumber = message->Code;
     940:	342a 0018      	move.w 24(a2),d2
			while ((menuNumber != MENUNULL) && (AppRunning))
     944:	0c42 ffff      	cmpi.w #-1,d2
     948:	6700 fb0c      	beq.w 456 <main+0x3e2>
		for (int y = startY; y < (startY + height); y++)
		{
			args[0] = x;
			args[1] = y;
			args[2] = GameMatrix.Playfield[x][y].Status;
			VFPrintf(fh, (CONST_STRPTR) "%d,%d,%d\n", args);
     94c:	49f9 0000 1907 	lea 1907 <PutChar+0xa7>,a4
			while ((menuNumber != MENUNULL) && (AppRunning))
     952:	4a79 0000 3bbc 	tst.w 3bbc <AppRunning>
     958:	6700 fafc      	beq.w 456 <main+0x3e2>
				item = ItemAddress(theMenu, menuNumber);
     95c:	2c79 0000 3bda 	movea.l 3bda <IntuitionBase>,a6
     962:	206f 0034      	movea.l 52(sp),a0
     966:	3002           	move.w d2,d0
     968:	4eae ff70      	jsr -144(a6)
     96c:	2f40 002c      	move.l d0,44(sp)
				menuNum = MENUNUM(menuNumber);
     970:	3002           	move.w d2,d0
     972:	0240 001f      	andi.w #31,d0
				if ((menuNum == 0) && (itemNum == 5))
     976:	664a           	bne.s 9c2 <main+0x94e>
				itemNum = ITEMNUM(menuNumber);
     978:	3002           	move.w d2,d0
     97a:	ea48           	lsr.w #5,d0
     97c:	0240 003f      	andi.w #63,d0
				if ((menuNum == 0) && (itemNum == 5))
     980:	0c40 0005      	cmpi.w #5,d0
     984:	674e           	beq.s 9d4 <main+0x960>
				if ((menuNum == 0) && (itemNum == 1))
     986:	0c40 0001      	cmpi.w #1,d0
     98a:	6778           	beq.s a04 <main+0x990>
				if ((menuNum == 0) && (itemNum == 3) && (subNum == 2))
     98c:	0c40 0003      	cmpi.w #3,d0
     990:	6630           	bne.s 9c2 <main+0x94e>
				subNum = SUBNUM(menuNumber);
     992:	720b           	moveq #11,d1
     994:	e26a           	lsr.w d1,d2
				if ((menuNum == 0) && (itemNum == 3) && (subNum == 2))
     996:	0c42 0002      	cmpi.w #2,d2
     99a:	6700 01ac      	beq.w b48 <main+0xad4>
				if ((menuNum == 0) && (itemNum == 3) && (subNum == 0))
     99e:	4a42           	tst.w d2
     9a0:	6600 0110      	bne.w ab2 <main+0xa3e>
					SetWindowTitles(theWindow, (STRPTR) "Running", (STRPTR)-1);
     9a4:	2c79 0000 3bda 	movea.l 3bda <IntuitionBase>,a6
     9aa:	204b           	movea.l a3,a0
     9ac:	43f9 0000 18f5 	lea 18f5 <PutChar+0x95>,a1
     9b2:	347c ffff      	movea.w #-1,a2
     9b6:	4eae feec      	jsr -276(a6)
					GameRunning = TRUE;
     9ba:	33fc 0001 0000 	move.w #1,3be0 <GameRunning>
     9c0:	3be0 
				menuNumber = item->NextSelect;
     9c2:	206f 002c      	movea.l 44(sp),a0
     9c6:	3428 0020      	move.w 32(a0),d2
			while ((menuNumber != MENUNULL) && (AppRunning))
     9ca:	0c42 ffff      	cmpi.w #-1,d2
     9ce:	6682           	bne.s 952 <main+0x8de>
     9d0:	6000 fa84      	bra.w 456 <main+0x3e2>
					AppRunning = FALSE;
     9d4:	4279 0000 3bbc 	clr.w 3bbc <AppRunning>
					SetWindowTitles(theWindow, (STRPTR) "Running", (STRPTR)-1);
     9da:	2c79 0000 3bda 	movea.l 3bda <IntuitionBase>,a6
     9e0:	204b           	movea.l a3,a0
     9e2:	43f9 0000 18f5 	lea 18f5 <PutChar+0x95>,a1
     9e8:	347c ffff      	movea.w #-1,a2
     9ec:	4eae feec      	jsr -276(a6)
				menuNumber = item->NextSelect;
     9f0:	206f 002c      	movea.l 44(sp),a0
     9f4:	3428 0020      	move.w 32(a0),d2
			while ((menuNumber != MENUNULL) && (AppRunning))
     9f8:	0c42 ffff      	cmpi.w #-1,d2
     9fc:	6600 ff54      	bne.w 952 <main+0x8de>
     a00:	6000 fa54      	bra.w 456 <main+0x3e2>
					SavePlayfield((CONST_STRPTR) "test.gold", 1, 1, GameMatrix.Columns - 1, GameMatrix.Rows - 1);
     a04:	7600           	moveq #0,d3
     a06:	3639 0000 3c6c 	move.w 3c6c <GameMatrix+0x8>,d3
     a0c:	7200           	moveq #0,d1
     a0e:	3239 0000 3c6e 	move.w 3c6e <GameMatrix+0xa>,d1
     a14:	2441           	movea.l d1,a2
	fh = Open(file, MODE_NEWFILE);
     a16:	2c79 0000 3bce 	movea.l 3bce <DOSBase>,a6
     a1c:	223c 0000 18fd 	move.l #6397,d1
     a22:	243c 0000 03ee 	move.l #1006,d2
     a28:	4eae ffe2      	jsr -30(a6)
     a2c:	2e00           	move.l d0,d7
	for (int x = startX; x < (startX + width); x++)
     a2e:	7001           	moveq #1,d0
     a30:	b08a           	cmp.l a2,d0
     a32:	6c4c           	bge.s a80 <main+0xa0c>
     a34:	b083           	cmp.l d3,d0
     a36:	6c48           	bge.s a80 <main+0xa0c>
     a38:	7c04           	moveq #4,d6
     a3a:	7a01           	moveq #1,d5
     a3c:	2f4b 0030      	move.l a3,48(sp)
     a40:	2643           	movea.l d3,a3
		for (int y = startY; y < (startY + height); y++)
     a42:	7801           	moveq #1,d4
			args[0] = x;
     a44:	2f45 0044      	move.l d5,68(sp)
			args[1] = y;
     a48:	2f44 0048      	move.l d4,72(sp)
			args[2] = GameMatrix.Playfield[x][y].Status;
     a4c:	2055           	movea.l (a5),a0
     a4e:	2070 6800      	movea.l (0,a0,d6.l),a0
     a52:	7000           	moveq #0,d0
     a54:	1030 4800      	move.b (0,a0,d4.l),d0
     a58:	2f40 004c      	move.l d0,76(sp)
			VFPrintf(fh, (CONST_STRPTR) "%d,%d,%d\n", args);
     a5c:	2c79 0000 3bce 	movea.l 3bce <DOSBase>,a6
     a62:	2207           	move.l d7,d1
     a64:	240c           	move.l a4,d2
     a66:	7644           	moveq #68,d3
     a68:	d68f           	add.l sp,d3
     a6a:	4eae fe9e      	jsr -354(a6)
		for (int y = startY; y < (startY + height); y++)
     a6e:	5284           	addq.l #1,d4
     a70:	b88b           	cmp.l a3,d4
     a72:	66d0           	bne.s a44 <main+0x9d0>
	for (int x = startX; x < (startX + width); x++)
     a74:	5285           	addq.l #1,d5
     a76:	5886           	addq.l #4,d6
     a78:	ba8a           	cmp.l a2,d5
     a7a:	66c6           	bne.s a42 <main+0x9ce>
     a7c:	266f 0030      	movea.l 48(sp),a3
		}
	}
	Close(fh);
     a80:	2c79 0000 3bce 	movea.l 3bce <DOSBase>,a6
     a86:	2207           	move.l d7,d1
     a88:	4eae ffdc      	jsr -36(a6)
				menuNumber = item->NextSelect;
     a8c:	206f 002c      	movea.l 44(sp),a0
     a90:	3428 0020      	move.w 32(a0),d2
			while ((menuNumber != MENUNULL) && (AppRunning))
     a94:	0c42 ffff      	cmpi.w #-1,d2
     a98:	6600 feb8      	bne.w 952 <main+0x8de>
     a9c:	6000 f9b8      	bra.w 456 <main+0x3e2>
			GameRunning ? SetWindowTitles(GOLRenderData.MainWindow, "Running", -1) : SetWindowTitles(GOLRenderData.MainWindow, "Stopped", -1);
     aa0:	43f9 0000 18bc 	lea 18bc <PutChar+0x5c>,a1
     aa6:	347c ffff      	movea.w #-1,a2
     aaa:	4eae feec      	jsr -276(a6)
     aae:	6000 f9a6      	bra.w 456 <main+0x3e2>
				if ((menuNum == 0) && (itemNum == 3) && (subNum == 1))
     ab2:	0c42 0001      	cmpi.w #1,d2
     ab6:	6600 ff0a      	bne.w 9c2 <main+0x94e>
					SetWindowTitles(theWindow, (STRPTR) "Stopped", (STRPTR)-1);
     aba:	2c79 0000 3bda 	movea.l 3bda <IntuitionBase>,a6
     ac0:	204b           	movea.l a3,a0
     ac2:	43f9 0000 18bc 	lea 18bc <PutChar+0x5c>,a1
     ac8:	347c ffff      	movea.w #-1,a2
     acc:	4eae feec      	jsr -276(a6)
					GameRunning = FALSE;
     ad0:	4279 0000 3be0 	clr.w 3be0 <GameRunning>
				menuNumber = item->NextSelect;
     ad6:	206f 002c      	movea.l 44(sp),a0
     ada:	3428 0020      	move.w 32(a0),d2
			while ((menuNumber != MENUNULL) && (AppRunning))
     ade:	0c42 ffff      	cmpi.w #-1,d2
     ae2:	6600 fe6e      	bne.w 952 <main+0x8de>
     ae6:	6000 f96e      	bra.w 456 <main+0x3e2>
				if (!GameRunning)
     aea:	4a79 0000 3be0 	tst.w 3be0 <GameRunning>
     af0:	6600 fbe0      	bne.w 6d2 <main+0x65e>
					DrawActive = TRUE;
     af4:	33fc 0001 0000 	move.w #1,3bc8 <DrawActive>
     afa:	3bc8 
					ToggleCellStatus(coordX, coordY);
     afc:	2f0e           	move.l a6,-(sp)
     afe:	2f0a           	move.l a2,-(sp)
     b00:	4eb9 0000 0ffa 	jsr ffa <ToggleCellStatus>
					UpdateList[UpdateCnt].X = x;
     b06:	3239 0000 3bde 	move.w 3bde <UpdateCnt>,d1
     b0c:	7000           	moveq #0,d0
     b0e:	3001           	move.w d1,d0
     b10:	2240           	movea.l d0,a1
     b12:	d3c0           	adda.l d0,a1
     b14:	d3c0           	adda.l d0,a1
     b16:	d3c9           	adda.l a1,a1
     b18:	d3f9 0000 3bca 	adda.l 3bca <UpdateList>,a1
     b1e:	3282           	move.w d2,(a1)
					UpdateList[UpdateCnt].Y = y;
     b20:	3343 0002      	move.w d3,2(a1)
					UpdateList[UpdateCnt++].Status = GameMatrix.Playfield[x][y].Status;
     b24:	2055           	movea.l (a5),a0
     b26:	2002           	move.l d2,d0
     b28:	d082           	add.l d2,d0
     b2a:	d080           	add.l d0,d0
     b2c:	2070 0800      	movea.l (0,a0,d0.l),a0
     b30:	5241           	addq.w #1,d1
     b32:	33c1 0000 3bde 	move.w d1,3bde <UpdateCnt>
     b38:	4240           	clr.w d0
     b3a:	1030 3800      	move.b (0,a0,d3.l),d0
     b3e:	3340 0004      	move.w d0,4(a1)
     b42:	508f           	addq.l #8,sp
     b44:	6000 fb96      	bra.w 6dc <main+0x668>
					ClearPlayfield(GameMatrix.Playfield);
     b48:	2455           	movea.l (a5),a2
	for (int x = 0; x < GameMatrix.Columns; x++)
     b4a:	3439 0000 3c6e 	move.w 3c6e <GameMatrix+0xa>,d2
     b50:	674a           	beq.s b9c <main+0xb28>
		memset(pf[x], 0, GameMatrix.Rows * sizeof(GameOfLifeCell));
     b52:	7600           	moveq #0,d3
     b54:	3639 0000 3c6c 	move.w 3c6c <GameMatrix+0x8>,d3
     b5a:	0282 0000 ffff 	andi.l #65535,d2
     b60:	d482           	add.l d2,d2
     b62:	d482           	add.l d2,d2
     b64:	280a           	move.l a2,d4
     b66:	d882           	add.l d2,d4
     b68:	201a           	move.l (a2)+,d0
     b6a:	2f03           	move.l d3,-(sp)
     b6c:	42a7           	clr.l -(sp)
     b6e:	2f00           	move.l d0,-(sp)
     b70:	4eb9 0000 1544 	jsr 1544 <memset>
	for (int x = 0; x < GameMatrix.Columns; x++)
     b76:	4fef 000c      	lea 12(sp),sp
     b7a:	b5c4           	cmpa.l d4,a2
     b7c:	66ea           	bne.s b68 <main+0xaf4>
     b7e:	2479 0000 3c68 	movea.l 3c68 <GameMatrix+0x4>,a2
     b84:	d48a           	add.l a2,d2
		memset(pf[x], 0, GameMatrix.Rows * sizeof(GameOfLifeCell));
     b86:	201a           	move.l (a2)+,d0
     b88:	2f03           	move.l d3,-(sp)
     b8a:	42a7           	clr.l -(sp)
     b8c:	2f00           	move.l d0,-(sp)
     b8e:	4eb9 0000 1544 	jsr 1544 <memset>
	for (int x = 0; x < GameMatrix.Columns; x++)
     b94:	4fef 000c      	lea 12(sp),sp
     b98:	b48a           	cmp.l a2,d2
     b9a:	66ea           	bne.s b86 <main+0xb12>
					SetRast(GOLRenderData.MainWindow->RPort, 0);
     b9c:	2c79 0000 3be6 	movea.l 3be6 <GfxBase>,a6
     ba2:	2079 0000 3bee 	movea.l 3bee <GOLRenderData+0x4>,a0
     ba8:	2268 0032      	movea.l 50(a0),a1
     bac:	7000           	moveq #0,d0
     bae:	4eae ff16      	jsr -234(a6)
					SetRast(&GOLRenderData.Rastport, 0);
     bb2:	2c79 0000 3be6 	movea.l 3be6 <GfxBase>,a6
     bb8:	43f9 0000 3bfa 	lea 3bfa <GOLRenderData+0x10>,a1
     bbe:	7000           	moveq #0,d0
     bc0:	4eae ff16      	jsr -234(a6)
				menuNumber = item->NextSelect;
     bc4:	206f 002c      	movea.l 44(sp),a0
     bc8:	3428 0020      	move.w 32(a0),d2
			while ((menuNumber != MENUNULL) && (AppRunning))
     bcc:	0c42 ffff      	cmpi.w #-1,d2
     bd0:	6600 fd80      	bne.w 952 <main+0x8de>
     bd4:	6000 f880      	bra.w 456 <main+0x3e2>
	for (int entry = 0; entry < UpdateCnt; entry++)
     bd8:	7a00           	moveq #0,d5
		if (UpdateCnt > 0)
     bda:	7800           	moveq #0,d4
			SetAPen(&rd->Rastport, GameMatrix.ColorDead);
     bdc:	2c3c 0000 3bfa 	move.l #15354,d6
		int x = UpdateList[entry].X;
     be2:	2079 0000 3bca 	movea.l 3bca <UpdateList>,a0
     be8:	d1c4           	adda.l d4,a0
     bea:	7e00           	moveq #0,d7
     bec:	3e10           	move.w (a0),d7
		int y = UpdateList[entry].Y;
     bee:	7600           	moveq #0,d3
     bf0:	3628 0002      	move.w 2(a0),d3
			SetAPen(&rd->Rastport, GameMatrix.ColorAlive);
     bf4:	2c79 0000 3be6 	movea.l 3be6 <GfxBase>,a6
     bfa:	2246           	movea.l d6,a1
     bfc:	7000           	moveq #0,d0
		if (s)
     bfe:	4a68 0004      	tst.w 4(a0)
     c02:	6700 009a      	beq.w c9e <main+0xc2a>
			SetAPen(&rd->Rastport, GameMatrix.ColorAlive);
     c06:	3039 0000 3c70 	move.w 3c70 <GameMatrix+0xc>,d0
     c0c:	4eae feaa      	jsr -342(a6)
		RectFill(&rd->Rastport,
     c10:	7400           	moveq #0,d2
     c12:	3439 0000 3c74 	move.w 3c74 <GameMatrix+0x10>,d2
     c18:	2f02           	move.l d2,-(sp)
     c1a:	2047           	movea.l d7,a0
     c1c:	4868 ffff      	pea -1(a0)
     c20:	4eb9 0000 1758 	jsr 1758 <__mulsi3>
     c26:	508f           	addq.l #8,sp
     c28:	2440           	movea.l d0,a2
     c2a:	47ea 0001      	lea 1(a2),a3
     c2e:	7e00           	moveq #0,d7
     c30:	3e39 0000 3c76 	move.w 3c76 <GameMatrix+0x12>,d7
     c36:	2f07           	move.l d7,-(sp)
     c38:	2243           	movea.l d3,a1
     c3a:	4869 ffff      	pea -1(a1)
     c3e:	4eb9 0000 1758 	jsr 1758 <__mulsi3>
     c44:	508f           	addq.l #8,sp
     c46:	2600           	move.l d0,d3
     c48:	2c79 0000 3be6 	movea.l 3be6 <GfxBase>,a6
     c4e:	2246           	movea.l d6,a1
     c50:	200b           	move.l a3,d0
     c52:	2203           	move.l d3,d1
     c54:	5281           	addq.l #1,d1
     c56:	45f2 28ff      	lea (-1,a2,d2.l),a2
     c5a:	240a           	move.l a2,d2
     c5c:	2647           	movea.l d7,a3
     c5e:	47f3 38ff      	lea (-1,a3,d3.l),a3
     c62:	260b           	move.l a3,d3
     c64:	4eae fece      	jsr -306(a6)
	for (int entry = 0; entry < UpdateCnt; entry++)
     c68:	5285           	addq.l #1,d5
     c6a:	5c84           	addq.l #6,d4
     c6c:	7000           	moveq #0,d0
     c6e:	3039 0000 3bde 	move.w 3bde <UpdateCnt>,d0
     c74:	b085           	cmp.l d5,d0
     c76:	6f00 f8bc      	ble.w 534 <main+0x4c0>
		int x = UpdateList[entry].X;
     c7a:	2079 0000 3bca 	movea.l 3bca <UpdateList>,a0
     c80:	d1c4           	adda.l d4,a0
     c82:	7e00           	moveq #0,d7
     c84:	3e10           	move.w (a0),d7
		int y = UpdateList[entry].Y;
     c86:	7600           	moveq #0,d3
     c88:	3628 0002      	move.w 2(a0),d3
			SetAPen(&rd->Rastport, GameMatrix.ColorAlive);
     c8c:	2c79 0000 3be6 	movea.l 3be6 <GfxBase>,a6
     c92:	2246           	movea.l d6,a1
     c94:	7000           	moveq #0,d0
		if (s)
     c96:	4a68 0004      	tst.w 4(a0)
     c9a:	6600 ff6a      	bne.w c06 <main+0xb92>
			SetAPen(&rd->Rastport, GameMatrix.ColorDead);
     c9e:	3039 0000 3c72 	move.w 3c72 <GameMatrix+0xe>,d0
     ca4:	4eae feaa      	jsr -342(a6)
		RectFill(&rd->Rastport,
     ca8:	7400           	moveq #0,d2
     caa:	3439 0000 3c74 	move.w 3c74 <GameMatrix+0x10>,d2
     cb0:	2f02           	move.l d2,-(sp)
     cb2:	2047           	movea.l d7,a0
     cb4:	4868 ffff      	pea -1(a0)
     cb8:	4eb9 0000 1758 	jsr 1758 <__mulsi3>
     cbe:	508f           	addq.l #8,sp
     cc0:	2440           	movea.l d0,a2
     cc2:	47ea 0001      	lea 1(a2),a3
     cc6:	7e00           	moveq #0,d7
     cc8:	3e39 0000 3c76 	move.w 3c76 <GameMatrix+0x12>,d7
     cce:	2f07           	move.l d7,-(sp)
     cd0:	2243           	movea.l d3,a1
     cd2:	4869 ffff      	pea -1(a1)
     cd6:	4eb9 0000 1758 	jsr 1758 <__mulsi3>
     cdc:	508f           	addq.l #8,sp
     cde:	2600           	move.l d0,d3
     ce0:	2c79 0000 3be6 	movea.l 3be6 <GfxBase>,a6
     ce6:	2246           	movea.l d6,a1
     ce8:	200b           	move.l a3,d0
     cea:	2203           	move.l d3,d1
     cec:	5281           	addq.l #1,d1
     cee:	45f2 28ff      	lea (-1,a2,d2.l),a2
     cf2:	240a           	move.l a2,d2
     cf4:	2647           	movea.l d7,a3
     cf6:	47f3 38ff      	lea (-1,a3,d3.l),a3
     cfa:	260b           	move.l a3,d3
     cfc:	4eae fece      	jsr -306(a6)
	for (int entry = 0; entry < UpdateCnt; entry++)
     d00:	5285           	addq.l #1,d5
     d02:	5c84           	addq.l #6,d4
     d04:	7000           	moveq #0,d0
     d06:	3039 0000 3bde 	move.w 3bde <UpdateCnt>,d0
     d0c:	b085           	cmp.l d5,d0
     d0e:	6e00 ff6a      	bgt.w c7a <main+0xc06>
     d12:	6000 f820      	bra.w 534 <main+0x4c0>
			UpdateCnt = 0;
     d16:	4279 0000 3bde 	clr.w 3bde <UpdateCnt>
	GameOfLifeCell **pf = GameMatrix.Playfield;
     d1c:	2f55 0034      	move.l (a5),52(sp)
	GameOfLifeCell **pf_n1 = GameMatrix.Playfield_n1;
     d20:	2f79 0000 3c68 	move.l 3c68 <GameMatrix+0x4>,56(sp)
     d26:	0038 
	for (int x = 1; x < GameMatrix.Columns - 1; x++)
     d28:	7800           	moveq #0,d4
     d2a:	3839 0000 3c6e 	move.w 3c6e <GameMatrix+0xa>,d4
     d30:	7002           	moveq #2,d0
     d32:	b084           	cmp.l d4,d0
     d34:	6c00 0130      	bge.w e66 <main+0xdf2>
		for (int y = 1; y < GameMatrix.Rows - 1; y++)
     d38:	3f79 0000 3c6c 	move.w 3c6c <GameMatrix+0x8>,44(sp)
     d3e:	002c 
				UpdateList[UpdateCnt].X = x;
     d40:	2e39 0000 3bca 	move.l 3bca <UpdateList>,d7
     d46:	286f 0038      	movea.l 56(sp),a4
     d4a:	588c           	addq.l #4,a4
     d4c:	2c2f 0034      	move.l 52(sp),d6
     d50:	2204           	move.l d4,d1
     d52:	5381           	subq.l #1,d1
     d54:	2f41 0030      	move.l d1,48(sp)
     d58:	7a01           	moveq #1,d5
     d5a:	4242           	clr.w d2
     d5c:	7000           	moveq #0,d0
     d5e:	302f 002c      	move.w 44(sp),d0
     d62:	2240           	movea.l d0,a1
     d64:	5389           	subq.l #1,a1
		for (int y = 1; y < GameMatrix.Rows - 1; y++)
     d66:	0c6f 0002 002c 	cmpi.w #2,44(sp)
     d6c:	6300 0084      	bls.w df2 <main+0xd7e>
     d70:	2046           	movea.l d6,a0
     d72:	2c50           	movea.l (a0),a6
     d74:	2468 0008      	movea.l 8(a0),a2
     d78:	2068 0004      	movea.l 4(a0),a0
					if (pf[x + xi][y + yj].Status)
     d7c:	7001           	moveq #1,d0
     d7e:	4a1e           	tst.b (a6)+
     d80:	56c1           	sne d1
     d82:	4881           	ext.w d1
     d84:	4441           	neg.w d1
     d86:	4a16           	tst.b (a6)
     d88:	6702           	beq.s d8c <main+0xd18>
						neighbours++;
     d8a:	5241           	addq.w #1,d1
					if (pf[x + xi][y + yj].Status)
     d8c:	4a2e 0001      	tst.b 1(a6)
     d90:	6702           	beq.s d94 <main+0xd20>
						neighbours++;
     d92:	5241           	addq.w #1,d1
					if (pf[x + xi][y + yj].Status)
     d94:	4a18           	tst.b (a0)+
     d96:	6702           	beq.s d9a <main+0xd26>
						neighbours++;
     d98:	5241           	addq.w #1,d1
					if (pf[x + xi][y + yj].Status)
     d9a:	1610           	move.b (a0),d3
     d9c:	6702           	beq.s da0 <main+0xd2c>
						neighbours++;
     d9e:	5241           	addq.w #1,d1
					if (pf[x + xi][y + yj].Status)
     da0:	4a28 0001      	tst.b 1(a0)
     da4:	6600 012e      	bne.w ed4 <main+0xe60>
     da8:	4a1a           	tst.b (a2)+
     daa:	6702           	beq.s dae <main+0xd3a>
						neighbours++;
     dac:	5241           	addq.w #1,d1
					if (pf[x + xi][y + yj].Status)
     dae:	4a12           	tst.b (a2)
     db0:	6702           	beq.s db4 <main+0xd40>
						neighbours++;
     db2:	5241           	addq.w #1,d1
					if (pf[x + xi][y + yj].Status)
     db4:	4a2a 0001      	tst.b 1(a2)
     db8:	6702           	beq.s dbc <main+0xd48>
						neighbours++;
     dba:	5241           	addq.w #1,d1
			if (pf[x][y].Status)
     dbc:	4a03           	tst.b d3
     dbe:	6700 00ce      	beq.w e8e <main+0xe1a>
					pf_n1[x][y].Status = 0;
     dc2:	2654           	movea.l (a4),a3
     dc4:	d7c0           	adda.l d0,a3
				if (neighbours < 2 || neighbours > 3)
     dc6:	5741           	subq.w #3,d1
     dc8:	0c41 0001      	cmpi.w #1,d1
     dcc:	6300 00f8      	bls.w ec6 <main+0xe52>
					pf_n1[x][y].Status = 0;
     dd0:	4213           	clr.b (a3)
					UpdateList[UpdateCnt].X = x;
     dd2:	7200           	moveq #0,d1
     dd4:	3202           	move.w d2,d1
     dd6:	2641           	movea.l d1,a3
     dd8:	d7c1           	adda.l d1,a3
     dda:	d7c1           	adda.l d1,a3
     ddc:	d7cb           	adda.l a3,a3
     dde:	d7c7           	adda.l d7,a3
     de0:	3685           	move.w d5,(a3)
					UpdateList[UpdateCnt].Y = y;
     de2:	3740 0002      	move.w d0,2(a3)
					UpdateList[UpdateCnt].Status = pf_n1[x][y].Status;
     de6:	426b 0004      	clr.w 4(a3)
					UpdateCnt++;
     dea:	5242           	addq.w #1,d2
		for (int y = 1; y < GameMatrix.Rows - 1; y++)
     dec:	5280           	addq.l #1,d0
     dee:	b3c0           	cmpa.l d0,a1
     df0:	668c           	bne.s d7e <main+0xd0a>
	for (int x = 1; x < GameMatrix.Columns - 1; x++)
     df2:	5285           	addq.l #1,d5
     df4:	588c           	addq.l #4,a4
     df6:	5886           	addq.l #4,d6
     df8:	baaf 0030      	cmp.l 48(sp),d5
     dfc:	6600 ff68      	bne.w d66 <main+0xcf2>
     e00:	33c2 0000 3bde 	move.w d2,3bde <UpdateCnt>
	for (int col = 0; col < GameMatrix.Columns; col++)
     e06:	4a84           	tst.l d4
     e08:	6700 f724      	beq.w 52e <main+0x4ba>
		memcpy(pf[col], pf_n1[col], GameMatrix.Rows * sizeof(GameOfLifeCell));
     e0c:	7a00           	moveq #0,d5
     e0e:	3a2f 002c      	move.w 44(sp),d5
     e12:	266f 0038      	movea.l 56(sp),a3
     e16:	246f 0034      	movea.l 52(sp),a2
	for (int col = 0; col < GameMatrix.Columns; col++)
     e1a:	7600           	moveq #0,d3
     e1c:	49f9 0000 1612 	lea 1612 <memcpy>,a4
		memcpy(pf[col], pf_n1[col], GameMatrix.Rows * sizeof(GameOfLifeCell));
     e22:	221b           	move.l (a3)+,d1
     e24:	201a           	move.l (a2)+,d0
     e26:	2f05           	move.l d5,-(sp)
     e28:	2f01           	move.l d1,-(sp)
     e2a:	2f00           	move.l d0,-(sp)
     e2c:	4e94           	jsr (a4)
	for (int col = 0; col < GameMatrix.Columns; col++)
     e2e:	5283           	addq.l #1,d3
     e30:	4fef 000c      	lea 12(sp),sp
     e34:	b883           	cmp.l d3,d4
     e36:	6f00 f6f6      	ble.w 52e <main+0x4ba>
		memcpy(pf[col], pf_n1[col], GameMatrix.Rows * sizeof(GameOfLifeCell));
     e3a:	221b           	move.l (a3)+,d1
     e3c:	201a           	move.l (a2)+,d0
     e3e:	2f05           	move.l d5,-(sp)
     e40:	2f01           	move.l d1,-(sp)
     e42:	2f00           	move.l d0,-(sp)
     e44:	4e94           	jsr (a4)
	for (int col = 0; col < GameMatrix.Columns; col++)
     e46:	5283           	addq.l #1,d3
     e48:	4fef 000c      	lea 12(sp),sp
     e4c:	b883           	cmp.l d3,d4
     e4e:	6ed2           	bgt.s e22 <main+0xdae>
     e50:	6000 f6dc      	bra.w 52e <main+0x4ba>
     e54:	42af 003c      	clr.l 60(sp)
}
     e58:	202f 003c      	move.l 60(sp),d0
     e5c:	4cdf 7cfc      	movem.l (sp)+,d2-d7/a2-a6
     e60:	4fef 00bc      	lea 188(sp),sp
     e64:	4e75           	rts
	for (int col = 0; col < GameMatrix.Columns; col++)
     e66:	4a84           	tst.l d4
     e68:	6700 f6ca      	beq.w 534 <main+0x4c0>
		memcpy(pf[col], pf_n1[col], GameMatrix.Rows * sizeof(GameOfLifeCell));
     e6c:	3f79 0000 3c6c 	move.w 3c6c <GameMatrix+0x8>,44(sp)
     e72:	002c 
     e74:	4242           	clr.w d2
     e76:	7a00           	moveq #0,d5
     e78:	3a2f 002c      	move.w 44(sp),d5
     e7c:	266f 0038      	movea.l 56(sp),a3
     e80:	246f 0034      	movea.l 52(sp),a2
	for (int col = 0; col < GameMatrix.Columns; col++)
     e84:	7600           	moveq #0,d3
     e86:	49f9 0000 1612 	lea 1612 <memcpy>,a4
     e8c:	6094           	bra.s e22 <main+0xdae>
			else if (neighbours == 3)
     e8e:	0c41 0003      	cmpi.w #3,d1
     e92:	6600 ff58      	bne.w dec <main+0xd78>
				pf_n1[x][y].Status = 1;
     e96:	2654           	movea.l (a4),a3
     e98:	17bc 0001 0800 	move.b #1,(0,a3,d0.l)
				UpdateList[UpdateCnt].X = x;
     e9e:	7200           	moveq #0,d1
     ea0:	3202           	move.w d2,d1
     ea2:	2641           	movea.l d1,a3
     ea4:	d7c1           	adda.l d1,a3
     ea6:	d7c1           	adda.l d1,a3
     ea8:	d7cb           	adda.l a3,a3
     eaa:	d7c7           	adda.l d7,a3
     eac:	3685           	move.w d5,(a3)
				UpdateList[UpdateCnt].Y = y;
     eae:	3740 0002      	move.w d0,2(a3)
				UpdateList[UpdateCnt].Status = pf_n1[x][y].Status;
     eb2:	377c 0001 0004 	move.w #1,4(a3)
				UpdateCnt++;
     eb8:	5242           	addq.w #1,d2
		for (int y = 1; y < GameMatrix.Rows - 1; y++)
     eba:	5280           	addq.l #1,d0
     ebc:	b3c0           	cmpa.l d0,a1
     ebe:	6600 febe      	bne.w d7e <main+0xd0a>
     ec2:	6000 ff2e      	bra.w df2 <main+0xd7e>
					pf_n1[x][y].Status = pf[x][y].Status;
     ec6:	1683           	move.b d3,(a3)
		for (int y = 1; y < GameMatrix.Rows - 1; y++)
     ec8:	5280           	addq.l #1,d0
     eca:	b3c0           	cmpa.l d0,a1
     ecc:	6600 feb0      	bne.w d7e <main+0xd0a>
     ed0:	6000 ff20      	bra.w df2 <main+0xd7e>
						neighbours++;
     ed4:	5241           	addq.w #1,d1
     ed6:	6000 fed0      	bra.w da8 <main+0xd34>
     eda:	4e71           	nop

00000edc <AllocPlayfieldMem>:
{
     edc:	48e7 3822      	movem.l d2-d4/a2/a6,-(sp)
	if ((GameMatrix.Playfield = AllocMem(GameMatrix.Columns * sizeof(GameOfLifeCell *), MEMF_ANY | MEMF_CLEAR)) == NULL)
     ee0:	45f9 0000 3c64 	lea 3c64 <GameMatrix>,a2
     ee6:	7000           	moveq #0,d0
     ee8:	3039 0000 3c6e 	move.w 3c6e <GameMatrix+0xa>,d0
     eee:	2c79 0000 3bd2 	movea.l 3bd2 <SysBase>,a6
     ef4:	e588           	lsl.l #2,d0
     ef6:	7201           	moveq #1,d1
     ef8:	4841           	swap d1
     efa:	4eae ff3a      	jsr -198(a6)
     efe:	2480           	move.l d0,(a2)
     f00:	6700 00ba      	beq.w fbc <AllocPlayfieldMem+0xe0>
	if ((GameMatrix.Playfield_n1 = AllocMem(GameMatrix.Columns * sizeof(GameOfLifeCell *), MEMF_ANY | MEMF_CLEAR)) == NULL)
     f04:	7000           	moveq #0,d0
     f06:	3039 0000 3c6e 	move.w 3c6e <GameMatrix+0xa>,d0
     f0c:	2c79 0000 3bd2 	movea.l 3bd2 <SysBase>,a6
     f12:	e588           	lsl.l #2,d0
     f14:	7201           	moveq #1,d1
     f16:	4841           	swap d1
     f18:	4eae ff3a      	jsr -198(a6)
     f1c:	23c0 0000 3c68 	move.l d0,3c68 <GameMatrix+0x4>
     f22:	6700 0098      	beq.w fbc <AllocPlayfieldMem+0xe0>
	for (int i = 0; i < GameMatrix.Columns; i++)
     f26:	4a79 0000 3c6e 	tst.w 3c6e <GameMatrix+0xa>
     f2c:	6700 0096      	beq.w fc4 <AllocPlayfieldMem+0xe8>
     f30:	7400           	moveq #0,d2
     f32:	7600           	moveq #0,d3
		if ((GameMatrix.Playfield[i] = AllocMem(GameMatrix.Rows * sizeof(GameOfLifeCell), MEMF_ANY | MEMF_CLEAR)) == NULL)
     f34:	7801           	moveq #1,d4
     f36:	4844           	swap d4
     f38:	2c79 0000 3bd2 	movea.l 3bd2 <SysBase>,a6
     f3e:	7000           	moveq #0,d0
     f40:	3039 0000 3c6c 	move.w 3c6c <GameMatrix+0x8>,d0
     f46:	2204           	move.l d4,d1
     f48:	4eae ff3a      	jsr -198(a6)
     f4c:	2052           	movea.l (a2),a0
     f4e:	2180 2800      	move.l d0,(0,a0,d2.l)
     f52:	6768           	beq.s fbc <AllocPlayfieldMem+0xe0>
		if ((GameMatrix.Playfield_n1[i] = AllocMem(GameMatrix.Rows * sizeof(GameOfLifeCell), MEMF_ANY | MEMF_CLEAR)) == NULL)
     f54:	2c79 0000 3bd2 	movea.l 3bd2 <SysBase>,a6
     f5a:	7000           	moveq #0,d0
     f5c:	3039 0000 3c6c 	move.w 3c6c <GameMatrix+0x8>,d0
     f62:	2204           	move.l d4,d1
     f64:	4eae ff3a      	jsr -198(a6)
     f68:	2079 0000 3c68 	movea.l 3c68 <GameMatrix+0x4>,a0
     f6e:	2180 2800      	move.l d0,(0,a0,d2.l)
     f72:	6748           	beq.s fbc <AllocPlayfieldMem+0xe0>
	for (int i = 0; i < GameMatrix.Columns; i++)
     f74:	5283           	addq.l #1,d3
     f76:	7000           	moveq #0,d0
     f78:	3039 0000 3c6e 	move.w 3c6e <GameMatrix+0xa>,d0
     f7e:	5882           	addq.l #4,d2
     f80:	b083           	cmp.l d3,d0
     f82:	6eb4           	bgt.s f38 <AllocPlayfieldMem+0x5c>
	UpdateList = AllocMem(GameMatrix.Columns * GameMatrix.Rows * sizeof(UpdateListEntry), MEMF_ANY | MEMF_CLEAR);
     f84:	7200           	moveq #0,d1
     f86:	3239 0000 3c6c 	move.w 3c6c <GameMatrix+0x8>,d1
     f8c:	2f00           	move.l d0,-(sp)
     f8e:	2f01           	move.l d1,-(sp)
     f90:	4eb9 0000 1758 	jsr 1758 <__mulsi3>
     f96:	508f           	addq.l #8,sp
     f98:	2200           	move.l d0,d1
     f9a:	d281           	add.l d1,d1
     f9c:	d081           	add.l d1,d0
     f9e:	2c79 0000 3bd2 	movea.l 3bd2 <SysBase>,a6
     fa4:	d080           	add.l d0,d0
     fa6:	7201           	moveq #1,d1
     fa8:	4841           	swap d1
     faa:	4eae ff3a      	jsr -198(a6)
     fae:	23c0 0000 3bca 	move.l d0,3bca <UpdateList>
	return RETURN_OK;
     fb4:	7000           	moveq #0,d0
}
     fb6:	4cdf 441c      	movem.l (sp)+,d2-d4/a2/a6
     fba:	4e75           	rts
		return RETURN_FAIL;
     fbc:	7014           	moveq #20,d0
}
     fbe:	4cdf 441c      	movem.l (sp)+,d2-d4/a2/a6
     fc2:	4e75           	rts
	for (int i = 0; i < GameMatrix.Columns; i++)
     fc4:	7000           	moveq #0,d0
	UpdateList = AllocMem(GameMatrix.Columns * GameMatrix.Rows * sizeof(UpdateListEntry), MEMF_ANY | MEMF_CLEAR);
     fc6:	7200           	moveq #0,d1
     fc8:	3239 0000 3c6c 	move.w 3c6c <GameMatrix+0x8>,d1
     fce:	2f00           	move.l d0,-(sp)
     fd0:	2f01           	move.l d1,-(sp)
     fd2:	4eb9 0000 1758 	jsr 1758 <__mulsi3>
     fd8:	508f           	addq.l #8,sp
     fda:	2200           	move.l d0,d1
     fdc:	d281           	add.l d1,d1
     fde:	d081           	add.l d1,d0
     fe0:	2c79 0000 3bd2 	movea.l 3bd2 <SysBase>,a6
     fe6:	d080           	add.l d0,d0
     fe8:	7201           	moveq #1,d1
     fea:	4841           	swap d1
     fec:	4eae ff3a      	jsr -198(a6)
     ff0:	23c0 0000 3bca 	move.l d0,3bca <UpdateList>
	return RETURN_OK;
     ff6:	7000           	moveq #0,d0
     ff8:	60bc           	bra.s fb6 <AllocPlayfieldMem+0xda>

00000ffa <ToggleCellStatus>:
{
     ffa:	48e7 3020      	movem.l d2-d3/a2,-(sp)
     ffe:	262f 0014      	move.l 20(sp),d3
	int x = coordX / GameMatrix.CellSizeH + 1;
    1002:	7000           	moveq #0,d0
    1004:	3039 0000 3c74 	move.w 3c74 <GameMatrix+0x10>,d0
    100a:	45f9 0000 17d6 	lea 17d6 <__divsi3>,a2
    1010:	2f00           	move.l d0,-(sp)
    1012:	306f 0016      	movea.w 22(sp),a0
    1016:	2f08           	move.l a0,-(sp)
    1018:	4e92           	jsr (a2)
    101a:	508f           	addq.l #8,sp
    101c:	2400           	move.l d0,d2
    101e:	5282           	addq.l #1,d2
	if (!(x < 0 || x > GameMatrix.Columns - 2 || y < 0 || y > GameMatrix.Rows - 2))
    1020:	6b74           	bmi.s 1096 <ToggleCellStatus+0x9c>
    1022:	7000           	moveq #0,d0
    1024:	3039 0000 3c6e 	move.w 3c6e <GameMatrix+0xa>,d0
    102a:	5380           	subq.l #1,d0
    102c:	b480           	cmp.l d0,d2
    102e:	6c66           	bge.s 1096 <ToggleCellStatus+0x9c>
	int y = coordY / GameMatrix.CellSizeV + 1;
    1030:	7000           	moveq #0,d0
    1032:	3039 0000 3c76 	move.w 3c76 <GameMatrix+0x12>,d0
    1038:	2f00           	move.l d0,-(sp)
    103a:	3043           	movea.w d3,a0
    103c:	2f08           	move.l a0,-(sp)
    103e:	4e92           	jsr (a2)
    1040:	508f           	addq.l #8,sp
    1042:	5280           	addq.l #1,d0
	if (!(x < 0 || x > GameMatrix.Columns - 2 || y < 0 || y > GameMatrix.Rows - 2))
    1044:	6b50           	bmi.s 1096 <ToggleCellStatus+0x9c>
    1046:	7200           	moveq #0,d1
    1048:	3239 0000 3c6c 	move.w 3c6c <GameMatrix+0x8>,d1
    104e:	5381           	subq.l #1,d1
    1050:	b081           	cmp.l d1,d0
    1052:	6c42           	bge.s 1096 <ToggleCellStatus+0x9c>
		if (GameMatrix.Playfield[x][y].Status)
    1054:	2079 0000 3c64 	movea.l 3c64 <GameMatrix>,a0
    105a:	2202           	move.l d2,d1
    105c:	d282           	add.l d2,d1
    105e:	d281           	add.l d1,d1
    1060:	2270 1800      	movea.l (0,a0,d1.l),a1
    1064:	d3c0           	adda.l d0,a1
			UpdateList[UpdateCnt].X = x;
    1066:	3239 0000 3bde 	move.w 3bde <UpdateCnt>,d1
    106c:	7600           	moveq #0,d3
    106e:	3601           	move.w d1,d3
    1070:	2043           	movea.l d3,a0
    1072:	d1c3           	adda.l d3,a0
    1074:	d1c3           	adda.l d3,a0
    1076:	d1c8           	adda.l a0,a0
    1078:	d1f9 0000 3bca 	adda.l 3bca <UpdateList>,a0
			UpdateCnt++;
    107e:	5241           	addq.w #1,d1
		if (GameMatrix.Playfield[x][y].Status)
    1080:	4a11           	tst.b (a1)
    1082:	6718           	beq.s 109c <ToggleCellStatus+0xa2>
			GameMatrix.Playfield[x][y].Status = 0;
    1084:	4211           	clr.b (a1)
			UpdateList[UpdateCnt].X = x;
    1086:	3082           	move.w d2,(a0)
			UpdateList[UpdateCnt].Y = y;
    1088:	3140 0002      	move.w d0,2(a0)
			UpdateList[UpdateCnt].Status = 0;
    108c:	4268 0004      	clr.w 4(a0)
			UpdateCnt++;
    1090:	33c1 0000 3bde 	move.w d1,3bde <UpdateCnt>
}
    1096:	4cdf 040c      	movem.l (sp)+,d2-d3/a2
    109a:	4e75           	rts
			GameMatrix.Playfield[x][y].Status = 1;
    109c:	12bc 0001      	move.b #1,(a1)
			UpdateList[UpdateCnt].X = x;
    10a0:	3082           	move.w d2,(a0)
			UpdateList[UpdateCnt].Y = y;
    10a2:	3140 0002      	move.w d0,2(a0)
			UpdateList[UpdateCnt].Status = 1;
    10a6:	317c 0001 0004 	move.w #1,4(a0)
			UpdateCnt++;
    10ac:	33c1 0000 3bde 	move.w d1,3bde <UpdateCnt>
}
    10b2:	4cdf 040c      	movem.l (sp)+,d2-d3/a2
    10b6:	4e75           	rts

000010b8 <PrepareBackbuffer.constprop.0>:
int PrepareBackbuffer(RenderData *rd)
    10b8:	48e7 383e      	movem.l d2-d4/a2-a6,-(sp)
		if (rd->Backbuffer)
    10bc:	2679 0000 3c5e 	movea.l 3c5e <GOLRenderData+0x74>,a3
	if (rd->OutputSize.x != rd->BackbufferSize.x || rd->OutputSize.y != rd->BackbufferSize.y)
    10c2:	2039 0000 3bf2 	move.l 3bf2 <GOLRenderData+0x8>,d0
    10c8:	b0b9 0000 3bf6 	cmp.l 3bf6 <GOLRenderData+0xc>,d0
    10ce:	6700 0122      	beq.w 11f2 <PrepareBackbuffer.constprop.0+0x13a>
	if (GfxBase->LibNode.lib_Version < 39)
    10d2:	2c79 0000 3be6 	movea.l 3be6 <GfxBase>,a6
    10d8:	302e 0014      	move.w 20(a6),d0
		if (rd->Backbuffer)
    10dc:	b6fc 0000      	cmpa.w #0,a3
    10e0:	6770           	beq.s 1152 <PrepareBackbuffer.constprop.0+0x9a>
	if (GfxBase->LibNode.lib_Version < 39)
    10e2:	0c40 0026      	cmpi.w #38,d0
    10e6:	6200 0166      	bhi.w 124e <PrepareBackbuffer.constprop.0+0x196>
		width = bitmap->BytesPerRow * 8;
    10ea:	7800           	moveq #0,d4
    10ec:	3813           	move.w (a3),d4
    10ee:	e78c           	lsl.l #3,d4
		for (i = 0; i < bitmap->Depth; i++)
    10f0:	122b 0005      	move.b 5(a3),d1
    10f4:	673e           	beq.s 1134 <PrepareBackbuffer.constprop.0+0x7c>
    10f6:	4242           	clr.w d2
    10f8:	91c8           	suba.l a0,a0
    10fa:	d1c8           	adda.l a0,a0
    10fc:	d1c8           	adda.l a0,a0
    10fe:	45f3 8800      	lea (0,a3,a0.l),a2
			if (bitmap->Planes[i])
    1102:	206a 0008      	movea.l 8(a2),a0
    1106:	b0fc 0000      	cmpa.w #0,a0
    110a:	6700 0122      	beq.w 122e <PrepareBackbuffer.constprop.0+0x176>
				FreeRaster(bitmap->Planes[i], width, bitmap->Rows);
    110e:	2c79 0000 3be6 	movea.l 3be6 <GfxBase>,a6
    1114:	2004           	move.l d4,d0
    1116:	7200           	moveq #0,d1
    1118:	322b 0002      	move.w 2(a3),d1
    111c:	4eae fe0e      	jsr -498(a6)
				bitmap->Planes[i] = 0;
    1120:	42aa 0008      	clr.l 8(a2)
		for (i = 0; i < bitmap->Depth; i++)
    1124:	122b 0005      	move.b 5(a3),d1
    1128:	5242           	addq.w #1,d2
    112a:	3042           	movea.w d2,a0
    112c:	7600           	moveq #0,d3
    112e:	1601           	move.b d1,d3
    1130:	b1c3           	cmpa.l d3,a0
    1132:	6dc6           	blt.s 10fa <PrepareBackbuffer.constprop.0+0x42>
		FreeMem(bitmap, sizeof(struct BitMap));
    1134:	2c79 0000 3bd2 	movea.l 3bd2 <SysBase>,a6
    113a:	224b           	movea.l a3,a1
    113c:	7028           	moveq #40,d0
    113e:	4eae ff2e      	jsr -210(a6)
			rd->Backbuffer = 0;
    1142:	42b9 0000 3c5e 	clr.l 3c5e <GOLRenderData+0x74>
	if (GfxBase->LibNode.lib_Version < 39)
    1148:	2c79 0000 3be6 	movea.l 3be6 <GfxBase>,a6
    114e:	302e 0014      	move.w 20(a6),d0
		rd->Backbuffer = MyAllocBitMap(rd->OutputSize.x, rd->OutputSize.y, ScreenD, rd->MainWindow->RPort->BitMap);
    1152:	3879 0000 3bf4 	movea.w 3bf4 <GOLRenderData+0xa>,a4
    1158:	3a79 0000 3bf2 	movea.w 3bf2 <GOLRenderData+0x8>,a5
	if (GfxBase->LibNode.lib_Version < 39)
    115e:	0c40 0026      	cmpi.w #38,d0
    1162:	6200 009c      	bhi.w 1200 <PrepareBackbuffer.constprop.0+0x148>
				AllocMem(sizeof(struct BitMap), MEMF_ANY | MEMF_CLEAR);
    1166:	2c79 0000 3bd2 	movea.l 3bd2 <SysBase>,a6
    116c:	7028           	moveq #40,d0
    116e:	7201           	moveq #1,d1
    1170:	4841           	swap d1
    1172:	4eae ff3a      	jsr -198(a6)
    1176:	2640           	movea.l d0,a3
			if (bitmap)
    1178:	4a80           	tst.l d0
    117a:	6700 0182      	beq.w 12fe <PrepareBackbuffer.constprop.0+0x246>
				InitBitMap(bitmap, depth, width, height);
    117e:	2c79 0000 3be6 	movea.l 3be6 <GfxBase>,a6
    1184:	2040           	movea.l d0,a0
    1186:	7004           	moveq #4,d0
    1188:	220d           	move.l a5,d1
    118a:	240c           	move.l a4,d2
    118c:	4eae fe7a      	jsr -390(a6)
				for (i = 0; i < bitmap->Depth; i++)
    1190:	4a2b 0005      	tst.b 5(a3)
    1194:	6730           	beq.s 11c6 <PrepareBackbuffer.constprop.0+0x10e>
    1196:	4242           	clr.w d2
    1198:	95ca           	suba.l a2,a2
					bitmap->Planes[i] = AllocRaster(width, height);
    119a:	2c79 0000 3be6 	movea.l 3be6 <GfxBase>,a6
    11a0:	200d           	move.l a5,d0
    11a2:	220c           	move.l a4,d1
    11a4:	4eae fe14      	jsr -492(a6)
    11a8:	220a           	move.l a2,d1
    11aa:	5481           	addq.l #2,d1
    11ac:	d281           	add.l d1,d1
    11ae:	d281           	add.l d1,d1
    11b0:	2780 1800      	move.l d0,(0,a3,d1.l)
					if (!(bitmap->Planes[i]))
    11b4:	6700 00ba      	beq.w 1270 <PrepareBackbuffer.constprop.0+0x1b8>
    11b8:	5242           	addq.w #1,d2
				for (i = 0; i < bitmap->Depth; i++)
    11ba:	3442           	movea.w d2,a2
    11bc:	7000           	moveq #0,d0
    11be:	102b 0005      	move.b 5(a3),d0
    11c2:	b08a           	cmp.l a2,d0
    11c4:	6ed4           	bgt.s 119a <PrepareBackbuffer.constprop.0+0xe2>
		rd->Backbuffer = MyAllocBitMap(rd->OutputSize.x, rd->OutputSize.y, ScreenD, rd->MainWindow->RPort->BitMap);
    11c6:	23cb 0000 3c5e 	move.l a3,3c5e <GOLRenderData+0x74>
			rd->BackbufferSize = rd->OutputSize;
    11cc:	23f9 0000 3bf2 	move.l 3bf2 <GOLRenderData+0x8>,3bf6 <GOLRenderData+0xc>
    11d2:	0000 3bf6 
		InitRastPort(&rd->Rastport);
    11d6:	2c79 0000 3be6 	movea.l 3be6 <GfxBase>,a6
    11dc:	43f9 0000 3bfa 	lea 3bfa <GOLRenderData+0x10>,a1
    11e2:	4eae ff3a      	jsr -198(a6)
		rd->Rastport.BitMap = rd->Backbuffer;
    11e6:	2679 0000 3c5e 	movea.l 3c5e <GOLRenderData+0x74>,a3
    11ec:	23cb 0000 3bfe 	move.l a3,3bfe <GOLRenderData+0x14>
	result = rd->Backbuffer ? RETURN_OK : RETURN_ERROR;
    11f2:	b6fc 0000      	cmpa.w #0,a3
    11f6:	6770           	beq.s 1268 <PrepareBackbuffer.constprop.0+0x1b0>
    11f8:	7000           	moveq #0,d0
}
    11fa:	4cdf 7c1c      	movem.l (sp)+,d2-d4/a2-a6
    11fe:	4e75           	rts
		rd->Backbuffer = MyAllocBitMap(rd->OutputSize.x, rd->OutputSize.y, ScreenD, rd->MainWindow->RPort->BitMap);
    1200:	2079 0000 3bee 	movea.l 3bee <GOLRenderData+0x4>,a0
    1206:	2068 0032      	movea.l 50(a0),a0
		bitmap = AllocBitMap(width, height, depth, 0, likeBitMap);
    120a:	200d           	move.l a5,d0
    120c:	220c           	move.l a4,d1
    120e:	7404           	moveq #4,d2
    1210:	7600           	moveq #0,d3
    1212:	2068 0004      	movea.l 4(a0),a0
    1216:	4eae fc6a      	jsr -918(a6)
		rd->Backbuffer = MyAllocBitMap(rd->OutputSize.x, rd->OutputSize.y, ScreenD, rd->MainWindow->RPort->BitMap);
    121a:	23c0 0000 3c5e 	move.l d0,3c5e <GOLRenderData+0x74>
		if (rd->Backbuffer)
    1220:	67b4           	beq.s 11d6 <PrepareBackbuffer.constprop.0+0x11e>
			rd->BackbufferSize = rd->OutputSize;
    1222:	23f9 0000 3bf2 	move.l 3bf2 <GOLRenderData+0x8>,3bf6 <GOLRenderData+0xc>
    1228:	0000 3bf6 
    122c:	60a8           	bra.s 11d6 <PrepareBackbuffer.constprop.0+0x11e>
    122e:	5242           	addq.w #1,d2
		for (i = 0; i < bitmap->Depth; i++)
    1230:	3042           	movea.w d2,a0
    1232:	7000           	moveq #0,d0
    1234:	1001           	move.b d1,d0
    1236:	b088           	cmp.l a0,d0
    1238:	6e00 fec0      	bgt.w 10fa <PrepareBackbuffer.constprop.0+0x42>
		FreeMem(bitmap, sizeof(struct BitMap));
    123c:	2c79 0000 3bd2 	movea.l 3bd2 <SysBase>,a6
    1242:	224b           	movea.l a3,a1
    1244:	7028           	moveq #40,d0
    1246:	4eae ff2e      	jsr -210(a6)
    124a:	6000 fef6      	bra.w 1142 <PrepareBackbuffer.constprop.0+0x8a>
		FreeBitMap(bitmap);
    124e:	204b           	movea.l a3,a0
    1250:	4eae fc64      	jsr -924(a6)
			rd->Backbuffer = 0;
    1254:	42b9 0000 3c5e 	clr.l 3c5e <GOLRenderData+0x74>
	if (GfxBase->LibNode.lib_Version < 39)
    125a:	2c79 0000 3be6 	movea.l 3be6 <GfxBase>,a6
    1260:	302e 0014      	move.w 20(a6),d0
    1264:	6000 feec      	bra.w 1152 <PrepareBackbuffer.constprop.0+0x9a>
	result = rd->Backbuffer ? RETURN_OK : RETURN_ERROR;
    1268:	700a           	moveq #10,d0
}
    126a:	4cdf 7c1c      	movem.l (sp)+,d2-d4/a2-a6
    126e:	4e75           	rts
	if (GfxBase->LibNode.lib_Version < 39)
    1270:	2c79 0000 3be6 	movea.l 3be6 <GfxBase>,a6
    1276:	0c6e 0026 0014 	cmpi.w #38,20(a6)
    127c:	6200 00a6      	bhi.w 1324 <PrepareBackbuffer.constprop.0+0x26c>
		width = bitmap->BytesPerRow * 8;
    1280:	7800           	moveq #0,d4
    1282:	3813           	move.w (a3),d4
    1284:	e78c           	lsl.l #3,d4
		for (i = 0; i < bitmap->Depth; i++)
    1286:	122b 0005      	move.b 5(a3),d1
    128a:	673e           	beq.s 12ca <PrepareBackbuffer.constprop.0+0x212>
    128c:	4242           	clr.w d2
    128e:	91c8           	suba.l a0,a0
    1290:	d1c8           	adda.l a0,a0
    1292:	d1c8           	adda.l a0,a0
    1294:	45f3 8800      	lea (0,a3,a0.l),a2
			if (bitmap->Planes[i])
    1298:	206a 0008      	movea.l 8(a2),a0
    129c:	b0fc 0000      	cmpa.w #0,a0
    12a0:	6700 00ae      	beq.w 1350 <PrepareBackbuffer.constprop.0+0x298>
				FreeRaster(bitmap->Planes[i], width, bitmap->Rows);
    12a4:	2c79 0000 3be6 	movea.l 3be6 <GfxBase>,a6
    12aa:	2004           	move.l d4,d0
    12ac:	7200           	moveq #0,d1
    12ae:	322b 0002      	move.w 2(a3),d1
    12b2:	4eae fe0e      	jsr -498(a6)
				bitmap->Planes[i] = 0;
    12b6:	42aa 0008      	clr.l 8(a2)
		for (i = 0; i < bitmap->Depth; i++)
    12ba:	122b 0005      	move.b 5(a3),d1
    12be:	5242           	addq.w #1,d2
    12c0:	3042           	movea.w d2,a0
    12c2:	7600           	moveq #0,d3
    12c4:	1601           	move.b d1,d3
    12c6:	b1c3           	cmpa.l d3,a0
    12c8:	6dc6           	blt.s 1290 <PrepareBackbuffer.constprop.0+0x1d8>
		FreeMem(bitmap, sizeof(struct BitMap));
    12ca:	2c79 0000 3bd2 	movea.l 3bd2 <SysBase>,a6
    12d0:	224b           	movea.l a3,a1
    12d2:	7028           	moveq #40,d0
    12d4:	4eae ff2e      	jsr -210(a6)
		rd->Backbuffer = MyAllocBitMap(rd->OutputSize.x, rd->OutputSize.y, ScreenD, rd->MainWindow->RPort->BitMap);
    12d8:	42b9 0000 3c5e 	clr.l 3c5e <GOLRenderData+0x74>
		InitRastPort(&rd->Rastport);
    12de:	2c79 0000 3be6 	movea.l 3be6 <GfxBase>,a6
    12e4:	43f9 0000 3bfa 	lea 3bfa <GOLRenderData+0x10>,a1
    12ea:	4eae ff3a      	jsr -198(a6)
		rd->Rastport.BitMap = rd->Backbuffer;
    12ee:	2679 0000 3c5e 	movea.l 3c5e <GOLRenderData+0x74>,a3
    12f4:	23cb 0000 3bfe 	move.l a3,3bfe <GOLRenderData+0x14>
    12fa:	6000 fef6      	bra.w 11f2 <PrepareBackbuffer.constprop.0+0x13a>
		rd->Backbuffer = MyAllocBitMap(rd->OutputSize.x, rd->OutputSize.y, ScreenD, rd->MainWindow->RPort->BitMap);
    12fe:	42b9 0000 3c5e 	clr.l 3c5e <GOLRenderData+0x74>
		InitRastPort(&rd->Rastport);
    1304:	2c79 0000 3be6 	movea.l 3be6 <GfxBase>,a6
    130a:	43f9 0000 3bfa 	lea 3bfa <GOLRenderData+0x10>,a1
    1310:	4eae ff3a      	jsr -198(a6)
		rd->Rastport.BitMap = rd->Backbuffer;
    1314:	2679 0000 3c5e 	movea.l 3c5e <GOLRenderData+0x74>,a3
    131a:	23cb 0000 3bfe 	move.l a3,3bfe <GOLRenderData+0x14>
    1320:	6000 fed0      	bra.w 11f2 <PrepareBackbuffer.constprop.0+0x13a>
		FreeBitMap(bitmap);
    1324:	204b           	movea.l a3,a0
    1326:	4eae fc64      	jsr -924(a6)
		rd->Backbuffer = MyAllocBitMap(rd->OutputSize.x, rd->OutputSize.y, ScreenD, rd->MainWindow->RPort->BitMap);
    132a:	42b9 0000 3c5e 	clr.l 3c5e <GOLRenderData+0x74>
		InitRastPort(&rd->Rastport);
    1330:	2c79 0000 3be6 	movea.l 3be6 <GfxBase>,a6
    1336:	43f9 0000 3bfa 	lea 3bfa <GOLRenderData+0x10>,a1
    133c:	4eae ff3a      	jsr -198(a6)
		rd->Rastport.BitMap = rd->Backbuffer;
    1340:	2679 0000 3c5e 	movea.l 3c5e <GOLRenderData+0x74>,a3
    1346:	23cb 0000 3bfe 	move.l a3,3bfe <GOLRenderData+0x14>
    134c:	6000 fea4      	bra.w 11f2 <PrepareBackbuffer.constprop.0+0x13a>
    1350:	5242           	addq.w #1,d2
		for (i = 0; i < bitmap->Depth; i++)
    1352:	3042           	movea.w d2,a0
    1354:	7000           	moveq #0,d0
    1356:	1001           	move.b d1,d0
    1358:	b088           	cmp.l a0,d0
    135a:	6e00 ff34      	bgt.w 1290 <PrepareBackbuffer.constprop.0+0x1d8>
		FreeMem(bitmap, sizeof(struct BitMap));
    135e:	2c79 0000 3bd2 	movea.l 3bd2 <SysBase>,a6
    1364:	224b           	movea.l a3,a1
    1366:	7028           	moveq #40,d0
    1368:	4eae ff2e      	jsr -210(a6)
		rd->Backbuffer = MyAllocBitMap(rd->OutputSize.x, rd->OutputSize.y, ScreenD, rd->MainWindow->RPort->BitMap);
    136c:	42b9 0000 3c5e 	clr.l 3c5e <GOLRenderData+0x74>
    1372:	6000 ff6a      	bra.w 12de <PrepareBackbuffer.constprop.0+0x226>

00001376 <memset.constprop.0>:
	void* memset(void *dest, int val, unsigned long len)
    1376:	2f0a           	move.l a2,-(sp)
    1378:	2f02           	move.l d2,-(sp)
    137a:	202f 000c      	move.l 12(sp),d0
    137e:	206f 0014      	movea.l 20(sp),a0
	while(len-- > 0)
    1382:	43e8 ffff      	lea -1(a0),a1
    1386:	b0fc 0000      	cmpa.w #0,a0
    138a:	6700 0096      	beq.w 1422 <memset.constprop.0+0xac>
    138e:	2200           	move.l d0,d1
    1390:	4481           	neg.l d1
    1392:	7403           	moveq #3,d2
    1394:	c282           	and.l d2,d1
    1396:	7405           	moveq #5,d2
		*ptr++ = val;
    1398:	2440           	movea.l d0,a2
    139a:	b489           	cmp.l a1,d2
    139c:	6450           	bcc.s 13ee <memset.constprop.0+0x78>
    139e:	4a81           	tst.l d1
    13a0:	672c           	beq.s 13ce <memset.constprop.0+0x58>
    13a2:	421a           	clr.b (a2)+
	while(len-- > 0)
    13a4:	43e8 fffe      	lea -2(a0),a1
    13a8:	7401           	moveq #1,d2
    13aa:	b481           	cmp.l d1,d2
    13ac:	6720           	beq.s 13ce <memset.constprop.0+0x58>
		*ptr++ = val;
    13ae:	2440           	movea.l d0,a2
    13b0:	548a           	addq.l #2,a2
    13b2:	2240           	movea.l d0,a1
    13b4:	4229 0001      	clr.b 1(a1)
	while(len-- > 0)
    13b8:	43e8 fffd      	lea -3(a0),a1
    13bc:	7403           	moveq #3,d2
    13be:	b481           	cmp.l d1,d2
    13c0:	660c           	bne.s 13ce <memset.constprop.0+0x58>
		*ptr++ = val;
    13c2:	528a           	addq.l #1,a2
    13c4:	2240           	movea.l d0,a1
    13c6:	4229 0002      	clr.b 2(a1)
	while(len-- > 0)
    13ca:	43e8 fffc      	lea -4(a0),a1
    13ce:	2408           	move.l a0,d2
    13d0:	9481           	sub.l d1,d2
    13d2:	2040           	movea.l d0,a0
    13d4:	d1c1           	adda.l d1,a0
    13d6:	72fc           	moveq #-4,d1
    13d8:	c282           	and.l d2,d1
    13da:	d288           	add.l a0,d1
		*ptr++ = val;
    13dc:	4298           	clr.l (a0)+
    13de:	b1c1           	cmpa.l d1,a0
    13e0:	66fa           	bne.s 13dc <memset.constprop.0+0x66>
    13e2:	72fc           	moveq #-4,d1
    13e4:	c282           	and.l d2,d1
    13e6:	d5c1           	adda.l d1,a2
    13e8:	93c1           	suba.l d1,a1
    13ea:	b282           	cmp.l d2,d1
    13ec:	6734           	beq.s 1422 <memset.constprop.0+0xac>
    13ee:	4212           	clr.b (a2)
	while(len-- > 0)
    13f0:	b2fc 0000      	cmpa.w #0,a1
    13f4:	672c           	beq.s 1422 <memset.constprop.0+0xac>
		*ptr++ = val;
    13f6:	422a 0001      	clr.b 1(a2)
	while(len-- > 0)
    13fa:	7201           	moveq #1,d1
    13fc:	b289           	cmp.l a1,d1
    13fe:	6722           	beq.s 1422 <memset.constprop.0+0xac>
		*ptr++ = val;
    1400:	422a 0002      	clr.b 2(a2)
	while(len-- > 0)
    1404:	7402           	moveq #2,d2
    1406:	b489           	cmp.l a1,d2
    1408:	6718           	beq.s 1422 <memset.constprop.0+0xac>
		*ptr++ = val;
    140a:	422a 0003      	clr.b 3(a2)
	while(len-- > 0)
    140e:	7203           	moveq #3,d1
    1410:	b289           	cmp.l a1,d1
    1412:	670e           	beq.s 1422 <memset.constprop.0+0xac>
		*ptr++ = val;
    1414:	422a 0004      	clr.b 4(a2)
	while(len-- > 0)
    1418:	7404           	moveq #4,d2
    141a:	b489           	cmp.l a1,d2
    141c:	6704           	beq.s 1422 <memset.constprop.0+0xac>
		*ptr++ = val;
    141e:	422a 0005      	clr.b 5(a2)
}
    1422:	241f           	move.l (sp)+,d2
    1424:	245f           	movea.l (sp)+,a2
    1426:	4e75           	rts

00001428 <FreePlayfieldMem.isra.0>:
int FreePlayfieldMem()
    1428:	48e7 3022      	movem.l d2-d3/a2/a6,-(sp)
	for (int i = 0; i < GameMatrix.Columns; i++)
    142c:	4a79 0000 3c6e 	tst.w 3c6e <GameMatrix+0xa>
    1432:	6700 00a2      	beq.w 14d6 <FreePlayfieldMem.isra.0+0xae>
    1436:	7400           	moveq #0,d2
    1438:	7600           	moveq #0,d3
    143a:	45f9 0000 3c64 	lea 3c64 <GameMatrix>,a2
		FreeMem(GameMatrix.Playfield[i], GameMatrix.Rows * sizeof(GameOfLifeCell));
    1440:	2052           	movea.l (a2),a0
    1442:	2c79 0000 3bd2 	movea.l 3bd2 <SysBase>,a6
    1448:	2270 2800      	movea.l (0,a0,d2.l),a1
    144c:	7000           	moveq #0,d0
    144e:	3039 0000 3c6c 	move.w 3c6c <GameMatrix+0x8>,d0
    1454:	4eae ff2e      	jsr -210(a6)
		FreeMem(GameMatrix.Playfield_n1[i], GameMatrix.Rows * sizeof(GameOfLifeCell));
    1458:	2c79 0000 3bd2 	movea.l 3bd2 <SysBase>,a6
    145e:	2079 0000 3c68 	movea.l 3c68 <GameMatrix+0x4>,a0
    1464:	2270 2800      	movea.l (0,a0,d2.l),a1
    1468:	7000           	moveq #0,d0
    146a:	3039 0000 3c6c 	move.w 3c6c <GameMatrix+0x8>,d0
    1470:	4eae ff2e      	jsr -210(a6)
	for (int i = 0; i < GameMatrix.Columns; i++)
    1474:	5283           	addq.l #1,d3
    1476:	5882           	addq.l #4,d2
    1478:	7000           	moveq #0,d0
    147a:	3039 0000 3c6e 	move.w 3c6e <GameMatrix+0xa>,d0
    1480:	b083           	cmp.l d3,d0
    1482:	6ebc           	bgt.s 1440 <FreePlayfieldMem.isra.0+0x18>
	FreeMem(GameMatrix.Playfield, GameMatrix.Columns * sizeof(GameOfLifeCell*));
    1484:	2c79 0000 3bd2 	movea.l 3bd2 <SysBase>,a6
    148a:	2252           	movea.l (a2),a1
    148c:	e588           	lsl.l #2,d0
    148e:	4eae ff2e      	jsr -210(a6)
	FreeMem(GameMatrix.Playfield_n1, GameMatrix.Columns * sizeof(GameOfLifeCell*));
    1492:	7000           	moveq #0,d0
    1494:	3039 0000 3c6e 	move.w 3c6e <GameMatrix+0xa>,d0
    149a:	2c79 0000 3bd2 	movea.l 3bd2 <SysBase>,a6
    14a0:	2279 0000 3c68 	movea.l 3c68 <GameMatrix+0x4>,a1
    14a6:	e588           	lsl.l #2,d0
    14a8:	4eae ff2e      	jsr -210(a6)
	FreeMem(UpdateList, GameMatrix.Columns * GameMatrix.Rows * sizeof(UpdateListEntry));
    14ac:	3239 0000 3c6e 	move.w 3c6e <GameMatrix+0xa>,d1
    14b2:	c2f9 0000 3c6c 	mulu.w 3c6c <GameMatrix+0x8>,d1
    14b8:	2001           	move.l d1,d0
    14ba:	d081           	add.l d1,d0
    14bc:	d081           	add.l d1,d0
    14be:	2c79 0000 3bd2 	movea.l 3bd2 <SysBase>,a6
    14c4:	2279 0000 3bca 	movea.l 3bca <UpdateList>,a1
    14ca:	d080           	add.l d0,d0
    14cc:	4eae ff2e      	jsr -210(a6)
}
    14d0:	4cdf 440c      	movem.l (sp)+,d2-d3/a2/a6
    14d4:	4e75           	rts
    14d6:	45f9 0000 3c64 	lea 3c64 <GameMatrix>,a2
    14dc:	7000           	moveq #0,d0
	FreeMem(GameMatrix.Playfield, GameMatrix.Columns * sizeof(GameOfLifeCell*));
    14de:	2c79 0000 3bd2 	movea.l 3bd2 <SysBase>,a6
    14e4:	2252           	movea.l (a2),a1
    14e6:	e588           	lsl.l #2,d0
    14e8:	4eae ff2e      	jsr -210(a6)
	FreeMem(GameMatrix.Playfield_n1, GameMatrix.Columns * sizeof(GameOfLifeCell*));
    14ec:	7000           	moveq #0,d0
    14ee:	3039 0000 3c6e 	move.w 3c6e <GameMatrix+0xa>,d0
    14f4:	2c79 0000 3bd2 	movea.l 3bd2 <SysBase>,a6
    14fa:	2279 0000 3c68 	movea.l 3c68 <GameMatrix+0x4>,a1
    1500:	e588           	lsl.l #2,d0
    1502:	4eae ff2e      	jsr -210(a6)
	FreeMem(UpdateList, GameMatrix.Columns * GameMatrix.Rows * sizeof(UpdateListEntry));
    1506:	3239 0000 3c6e 	move.w 3c6e <GameMatrix+0xa>,d1
    150c:	c2f9 0000 3c6c 	mulu.w 3c6c <GameMatrix+0x8>,d1
    1512:	2001           	move.l d1,d0
    1514:	d081           	add.l d1,d0
    1516:	d081           	add.l d1,d0
    1518:	2c79 0000 3bd2 	movea.l 3bd2 <SysBase>,a6
    151e:	2279 0000 3bca 	movea.l 3bca <UpdateList>,a1
    1524:	d080           	add.l d0,d0
    1526:	4eae ff2e      	jsr -210(a6)
}
    152a:	4cdf 440c      	movem.l (sp)+,d2-d3/a2/a6
    152e:	4e75           	rts

00001530 <strlen>:
{
    1530:	206f 0004      	movea.l 4(sp),a0
	unsigned long t=0;
    1534:	7000           	moveq #0,d0
	while(*s++)
    1536:	4a10           	tst.b (a0)
    1538:	6708           	beq.s 1542 <strlen+0x12>
		t++;
    153a:	5280           	addq.l #1,d0
	while(*s++)
    153c:	4a30 0800      	tst.b (0,a0,d0.l)
    1540:	66f8           	bne.s 153a <strlen+0xa>
}
    1542:	4e75           	rts

00001544 <memset>:
{
    1544:	48e7 3f30      	movem.l d2-d7/a2-a3,-(sp)
    1548:	202f 0024      	move.l 36(sp),d0
    154c:	282f 0028      	move.l 40(sp),d4
    1550:	226f 002c      	movea.l 44(sp),a1
	while(len-- > 0)
    1554:	2a09           	move.l a1,d5
    1556:	5385           	subq.l #1,d5
    1558:	b2fc 0000      	cmpa.w #0,a1
    155c:	6700 00ae      	beq.w 160c <memset+0xc8>
		*ptr++ = val;
    1560:	1e04           	move.b d4,d7
    1562:	2200           	move.l d0,d1
    1564:	4481           	neg.l d1
    1566:	7403           	moveq #3,d2
    1568:	c282           	and.l d2,d1
    156a:	7c05           	moveq #5,d6
    156c:	2440           	movea.l d0,a2
    156e:	bc85           	cmp.l d5,d6
    1570:	646a           	bcc.s 15dc <memset+0x98>
    1572:	4a81           	tst.l d1
    1574:	6724           	beq.s 159a <memset+0x56>
    1576:	14c4           	move.b d4,(a2)+
	while(len-- > 0)
    1578:	5385           	subq.l #1,d5
    157a:	7401           	moveq #1,d2
    157c:	b481           	cmp.l d1,d2
    157e:	671a           	beq.s 159a <memset+0x56>
		*ptr++ = val;
    1580:	2440           	movea.l d0,a2
    1582:	548a           	addq.l #2,a2
    1584:	2040           	movea.l d0,a0
    1586:	1144 0001      	move.b d4,1(a0)
	while(len-- > 0)
    158a:	5385           	subq.l #1,d5
    158c:	7403           	moveq #3,d2
    158e:	b481           	cmp.l d1,d2
    1590:	6608           	bne.s 159a <memset+0x56>
		*ptr++ = val;
    1592:	528a           	addq.l #1,a2
    1594:	1144 0002      	move.b d4,2(a0)
	while(len-- > 0)
    1598:	5385           	subq.l #1,d5
    159a:	2609           	move.l a1,d3
    159c:	9681           	sub.l d1,d3
    159e:	7c00           	moveq #0,d6
    15a0:	1c04           	move.b d4,d6
    15a2:	2406           	move.l d6,d2
    15a4:	4842           	swap d2
    15a6:	4242           	clr.w d2
    15a8:	2042           	movea.l d2,a0
    15aa:	2404           	move.l d4,d2
    15ac:	e14a           	lsl.w #8,d2
    15ae:	4842           	swap d2
    15b0:	4242           	clr.w d2
    15b2:	e18e           	lsl.l #8,d6
    15b4:	2646           	movea.l d6,a3
    15b6:	2c08           	move.l a0,d6
    15b8:	8486           	or.l d6,d2
    15ba:	2c0b           	move.l a3,d6
    15bc:	8486           	or.l d6,d2
    15be:	1407           	move.b d7,d2
    15c0:	2040           	movea.l d0,a0
    15c2:	d1c1           	adda.l d1,a0
    15c4:	72fc           	moveq #-4,d1
    15c6:	c283           	and.l d3,d1
    15c8:	d288           	add.l a0,d1
		*ptr++ = val;
    15ca:	20c2           	move.l d2,(a0)+
	while(len-- > 0)
    15cc:	b1c1           	cmpa.l d1,a0
    15ce:	66fa           	bne.s 15ca <memset+0x86>
    15d0:	72fc           	moveq #-4,d1
    15d2:	c283           	and.l d3,d1
    15d4:	d5c1           	adda.l d1,a2
    15d6:	9a81           	sub.l d1,d5
    15d8:	b283           	cmp.l d3,d1
    15da:	6730           	beq.s 160c <memset+0xc8>
		*ptr++ = val;
    15dc:	1484           	move.b d4,(a2)
	while(len-- > 0)
    15de:	4a85           	tst.l d5
    15e0:	672a           	beq.s 160c <memset+0xc8>
		*ptr++ = val;
    15e2:	1544 0001      	move.b d4,1(a2)
	while(len-- > 0)
    15e6:	7201           	moveq #1,d1
    15e8:	b285           	cmp.l d5,d1
    15ea:	6720           	beq.s 160c <memset+0xc8>
		*ptr++ = val;
    15ec:	1544 0002      	move.b d4,2(a2)
	while(len-- > 0)
    15f0:	7402           	moveq #2,d2
    15f2:	b485           	cmp.l d5,d2
    15f4:	6716           	beq.s 160c <memset+0xc8>
		*ptr++ = val;
    15f6:	1544 0003      	move.b d4,3(a2)
	while(len-- > 0)
    15fa:	7c03           	moveq #3,d6
    15fc:	bc85           	cmp.l d5,d6
    15fe:	670c           	beq.s 160c <memset+0xc8>
		*ptr++ = val;
    1600:	1544 0004      	move.b d4,4(a2)
	while(len-- > 0)
    1604:	5985           	subq.l #4,d5
    1606:	6704           	beq.s 160c <memset+0xc8>
		*ptr++ = val;
    1608:	1544 0005      	move.b d4,5(a2)
}
    160c:	4cdf 0cfc      	movem.l (sp)+,d2-d7/a2-a3
    1610:	4e75           	rts

00001612 <memcpy>:
{
    1612:	48e7 3e00      	movem.l d2-d6,-(sp)
    1616:	202f 0018      	move.l 24(sp),d0
    161a:	222f 001c      	move.l 28(sp),d1
    161e:	262f 0020      	move.l 32(sp),d3
	while(len--)
    1622:	2803           	move.l d3,d4
    1624:	5384           	subq.l #1,d4
    1626:	4a83           	tst.l d3
    1628:	675e           	beq.s 1688 <memcpy+0x76>
    162a:	2041           	movea.l d1,a0
    162c:	5288           	addq.l #1,a0
    162e:	2400           	move.l d0,d2
    1630:	9488           	sub.l a0,d2
    1632:	7a02           	moveq #2,d5
    1634:	ba82           	cmp.l d2,d5
    1636:	55c2           	sc.s d2
    1638:	4402           	neg.b d2
    163a:	7c08           	moveq #8,d6
    163c:	bc84           	cmp.l d4,d6
    163e:	55c5           	sc.s d5
    1640:	4405           	neg.b d5
    1642:	c405           	and.b d5,d2
    1644:	6748           	beq.s 168e <memcpy+0x7c>
    1646:	2400           	move.l d0,d2
    1648:	8481           	or.l d1,d2
    164a:	7a03           	moveq #3,d5
    164c:	c485           	and.l d5,d2
    164e:	663e           	bne.s 168e <memcpy+0x7c>
    1650:	2041           	movea.l d1,a0
    1652:	2240           	movea.l d0,a1
    1654:	74fc           	moveq #-4,d2
    1656:	c483           	and.l d3,d2
    1658:	d481           	add.l d1,d2
		*d++ = *s++;
    165a:	22d8           	move.l (a0)+,(a1)+
	while(len--)
    165c:	b488           	cmp.l a0,d2
    165e:	66fa           	bne.s 165a <memcpy+0x48>
    1660:	74fc           	moveq #-4,d2
    1662:	c483           	and.l d3,d2
    1664:	2040           	movea.l d0,a0
    1666:	d1c2           	adda.l d2,a0
    1668:	d282           	add.l d2,d1
    166a:	9882           	sub.l d2,d4
    166c:	b483           	cmp.l d3,d2
    166e:	6718           	beq.s 1688 <memcpy+0x76>
		*d++ = *s++;
    1670:	2241           	movea.l d1,a1
    1672:	1091           	move.b (a1),(a0)
	while(len--)
    1674:	4a84           	tst.l d4
    1676:	6710           	beq.s 1688 <memcpy+0x76>
		*d++ = *s++;
    1678:	1169 0001 0001 	move.b 1(a1),1(a0)
	while(len--)
    167e:	5384           	subq.l #1,d4
    1680:	6706           	beq.s 1688 <memcpy+0x76>
		*d++ = *s++;
    1682:	1169 0002 0002 	move.b 2(a1),2(a0)
}
    1688:	4cdf 007c      	movem.l (sp)+,d2-d6
    168c:	4e75           	rts
    168e:	2240           	movea.l d0,a1
    1690:	d283           	add.l d3,d1
		*d++ = *s++;
    1692:	12e8 ffff      	move.b -1(a0),(a1)+
	while(len--)
    1696:	b288           	cmp.l a0,d1
    1698:	67ee           	beq.s 1688 <memcpy+0x76>
    169a:	5288           	addq.l #1,a0
    169c:	60f4           	bra.s 1692 <memcpy+0x80>

0000169e <memmove>:
{
    169e:	48e7 3c20      	movem.l d2-d5/a2,-(sp)
    16a2:	202f 0018      	move.l 24(sp),d0
    16a6:	222f 001c      	move.l 28(sp),d1
    16aa:	242f 0020      	move.l 32(sp),d2
		while (len--)
    16ae:	2242           	movea.l d2,a1
    16b0:	5389           	subq.l #1,a1
	if (d < s) {
    16b2:	b280           	cmp.l d0,d1
    16b4:	636c           	bls.s 1722 <memmove+0x84>
		while (len--)
    16b6:	4a82           	tst.l d2
    16b8:	6762           	beq.s 171c <memmove+0x7e>
    16ba:	2441           	movea.l d1,a2
    16bc:	528a           	addq.l #1,a2
    16be:	2600           	move.l d0,d3
    16c0:	968a           	sub.l a2,d3
    16c2:	7802           	moveq #2,d4
    16c4:	b883           	cmp.l d3,d4
    16c6:	55c3           	sc.s d3
    16c8:	4403           	neg.b d3
    16ca:	7a08           	moveq #8,d5
    16cc:	ba89           	cmp.l a1,d5
    16ce:	55c4           	sc.s d4
    16d0:	4404           	neg.b d4
    16d2:	c604           	and.b d4,d3
    16d4:	6770           	beq.s 1746 <memmove+0xa8>
    16d6:	2600           	move.l d0,d3
    16d8:	8681           	or.l d1,d3
    16da:	7803           	moveq #3,d4
    16dc:	c684           	and.l d4,d3
    16de:	6666           	bne.s 1746 <memmove+0xa8>
    16e0:	2041           	movea.l d1,a0
    16e2:	2440           	movea.l d0,a2
    16e4:	76fc           	moveq #-4,d3
    16e6:	c682           	and.l d2,d3
    16e8:	d681           	add.l d1,d3
			*d++ = *s++;
    16ea:	24d8           	move.l (a0)+,(a2)+
		while (len--)
    16ec:	b688           	cmp.l a0,d3
    16ee:	66fa           	bne.s 16ea <memmove+0x4c>
    16f0:	76fc           	moveq #-4,d3
    16f2:	c682           	and.l d2,d3
    16f4:	2440           	movea.l d0,a2
    16f6:	d5c3           	adda.l d3,a2
    16f8:	2041           	movea.l d1,a0
    16fa:	d1c3           	adda.l d3,a0
    16fc:	93c3           	suba.l d3,a1
    16fe:	b682           	cmp.l d2,d3
    1700:	671a           	beq.s 171c <memmove+0x7e>
			*d++ = *s++;
    1702:	1490           	move.b (a0),(a2)
		while (len--)
    1704:	b2fc 0000      	cmpa.w #0,a1
    1708:	6712           	beq.s 171c <memmove+0x7e>
			*d++ = *s++;
    170a:	1568 0001 0001 	move.b 1(a0),1(a2)
		while (len--)
    1710:	7a01           	moveq #1,d5
    1712:	ba89           	cmp.l a1,d5
    1714:	6706           	beq.s 171c <memmove+0x7e>
			*d++ = *s++;
    1716:	1568 0002 0002 	move.b 2(a0),2(a2)
}
    171c:	4cdf 043c      	movem.l (sp)+,d2-d5/a2
    1720:	4e75           	rts
		const char *lasts = s + (len - 1);
    1722:	41f1 1800      	lea (0,a1,d1.l),a0
		char *lastd = d + (len - 1);
    1726:	d3c0           	adda.l d0,a1
		while (len--)
    1728:	4a82           	tst.l d2
    172a:	67f0           	beq.s 171c <memmove+0x7e>
    172c:	2208           	move.l a0,d1
    172e:	9282           	sub.l d2,d1
			*lastd-- = *lasts--;
    1730:	1290           	move.b (a0),(a1)
		while (len--)
    1732:	5388           	subq.l #1,a0
    1734:	5389           	subq.l #1,a1
    1736:	b288           	cmp.l a0,d1
    1738:	67e2           	beq.s 171c <memmove+0x7e>
			*lastd-- = *lasts--;
    173a:	1290           	move.b (a0),(a1)
		while (len--)
    173c:	5388           	subq.l #1,a0
    173e:	5389           	subq.l #1,a1
    1740:	b288           	cmp.l a0,d1
    1742:	66ec           	bne.s 1730 <memmove+0x92>
    1744:	60d6           	bra.s 171c <memmove+0x7e>
    1746:	2240           	movea.l d0,a1
    1748:	d282           	add.l d2,d1
			*d++ = *s++;
    174a:	12ea ffff      	move.b -1(a2),(a1)+
		while (len--)
    174e:	b28a           	cmp.l a2,d1
    1750:	67ca           	beq.s 171c <memmove+0x7e>
    1752:	528a           	addq.l #1,a2
    1754:	60f4           	bra.s 174a <memmove+0xac>
    1756:	4e71           	nop

00001758 <__mulsi3>:
	.text
	FUNC(__mulsi3)
	.globl	SYM (__mulsi3)
SYM (__mulsi3):
	.cfi_startproc
	movew	sp@(4), d0	/* x0 -> d0 */
    1758:	302f 0004      	move.w 4(sp),d0
	muluw	sp@(10), d0	/* x0*y1 */
    175c:	c0ef 000a      	mulu.w 10(sp),d0
	movew	sp@(6), d1	/* x1 -> d1 */
    1760:	322f 0006      	move.w 6(sp),d1
	muluw	sp@(8), d1	/* x1*y0 */
    1764:	c2ef 0008      	mulu.w 8(sp),d1
	addw	d1, d0
    1768:	d041           	add.w d1,d0
	swap	d0
    176a:	4840           	swap d0
	clrw	d0
    176c:	4240           	clr.w d0
	movew	sp@(6), d1	/* x1 -> d1 */
    176e:	322f 0006      	move.w 6(sp),d1
	muluw	sp@(10), d1	/* x1*y1 */
    1772:	c2ef 000a      	mulu.w 10(sp),d1
	addl	d1, d0
    1776:	d081           	add.l d1,d0
	rts
    1778:	4e75           	rts

0000177a <__udivsi3>:
	.text
	FUNC(__udivsi3)
	.globl	SYM (__udivsi3)
SYM (__udivsi3):
	.cfi_startproc
	movel	d2, sp@-
    177a:	2f02           	move.l d2,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	sp@(12), d1	/* d1 = divisor */
    177c:	222f 000c      	move.l 12(sp),d1
	movel	sp@(8), d0	/* d0 = dividend */
    1780:	202f 0008      	move.l 8(sp),d0

	cmpl	IMM (0x10000), d1 /* divisor >= 2 ^ 16 ?   */
    1784:	0c81 0001 0000 	cmpi.l #65536,d1
	jcc	3f		/* then try next algorithm */
    178a:	6416           	bcc.s 17a2 <__udivsi3+0x28>
	movel	d0, d2
    178c:	2400           	move.l d0,d2
	clrw	d2
    178e:	4242           	clr.w d2
	swap	d2
    1790:	4842           	swap d2
	divu	d1, d2          /* high quotient in lower word */
    1792:	84c1           	divu.w d1,d2
	movew	d2, d0		/* save high quotient */
    1794:	3002           	move.w d2,d0
	swap	d0
    1796:	4840           	swap d0
	movew	sp@(10), d2	/* get low dividend + high rest */
    1798:	342f 000a      	move.w 10(sp),d2
	divu	d1, d2		/* low quotient */
    179c:	84c1           	divu.w d1,d2
	movew	d2, d0
    179e:	3002           	move.w d2,d0
	jra	6f
    17a0:	6030           	bra.s 17d2 <__udivsi3+0x58>

3:	movel	d1, d2		/* use d2 as divisor backup */
    17a2:	2401           	move.l d1,d2
4:	lsrl	IMM (1), d1	/* shift divisor */
    17a4:	e289           	lsr.l #1,d1
	lsrl	IMM (1), d0	/* shift dividend */
    17a6:	e288           	lsr.l #1,d0
	cmpl	IMM (0x10000), d1 /* still divisor >= 2 ^ 16 ?  */
    17a8:	0c81 0001 0000 	cmpi.l #65536,d1
	jcc	4b
    17ae:	64f4           	bcc.s 17a4 <__udivsi3+0x2a>
	divu	d1, d0		/* now we have 16-bit divisor */
    17b0:	80c1           	divu.w d1,d0
	andl	IMM (0xffff), d0 /* mask out divisor, ignore remainder */
    17b2:	0280 0000 ffff 	andi.l #65535,d0

/* Multiply the 16-bit tentative quotient with the 32-bit divisor.  Because of
   the operand ranges, this might give a 33-bit product.  If this product is
   greater than the dividend, the tentative quotient was too large. */
	movel	d2, d1
    17b8:	2202           	move.l d2,d1
	mulu	d0, d1		/* low part, 32 bits */
    17ba:	c2c0           	mulu.w d0,d1
	swap	d2
    17bc:	4842           	swap d2
	mulu	d0, d2		/* high part, at most 17 bits */
    17be:	c4c0           	mulu.w d0,d2
	swap	d2		/* align high part with low part */
    17c0:	4842           	swap d2
	tstw	d2		/* high part 17 bits? */
    17c2:	4a42           	tst.w d2
	jne	5f		/* if 17 bits, quotient was too large */
    17c4:	660a           	bne.s 17d0 <__udivsi3+0x56>
	addl	d2, d1		/* add parts */
    17c6:	d282           	add.l d2,d1
	jcs	5f		/* if sum is 33 bits, quotient was too large */
    17c8:	6506           	bcs.s 17d0 <__udivsi3+0x56>
	cmpl	sp@(8), d1	/* compare the sum with the dividend */
    17ca:	b2af 0008      	cmp.l 8(sp),d1
	jls	6f		/* if sum > dividend, quotient was too large */
    17ce:	6302           	bls.s 17d2 <__udivsi3+0x58>
5:	subql	IMM (1), d0	/* adjust quotient */
    17d0:	5380           	subq.l #1,d0

6:	movel	sp@+, d2
    17d2:	241f           	move.l (sp)+,d2
	.cfi_adjust_cfa_offset -4
	rts
    17d4:	4e75           	rts

000017d6 <__divsi3>:
	.text
	FUNC(__divsi3)
	.globl	SYM (__divsi3)
SYM (__divsi3):
	.cfi_startproc
	movel	d2, sp@-
    17d6:	2f02           	move.l d2,-(sp)
	.cfi_adjust_cfa_offset 4

	moveq	IMM (1), d2	/* sign of result stored in d2 (=1 or =-1) */
    17d8:	7401           	moveq #1,d2
	movel	sp@(12), d1	/* d1 = divisor */
    17da:	222f 000c      	move.l 12(sp),d1
	jpl	1f
    17de:	6a04           	bpl.s 17e4 <__divsi3+0xe>
	negl	d1
    17e0:	4481           	neg.l d1
	negb	d2		/* change sign because divisor <0  */
    17e2:	4402           	neg.b d2
1:	movel	sp@(8), d0	/* d0 = dividend */
    17e4:	202f 0008      	move.l 8(sp),d0
	jpl	2f
    17e8:	6a04           	bpl.s 17ee <__divsi3+0x18>
	negl	d0
    17ea:	4480           	neg.l d0
	negb	d2
    17ec:	4402           	neg.b d2

2:	movel	d1, sp@-
    17ee:	2f01           	move.l d1,-(sp)
	movel	d0, sp@-
    17f0:	2f00           	move.l d0,-(sp)
	PICCALL	SYM (__udivsi3)	/* divide abs(dividend) by abs(divisor) */
    17f2:	6186           	bsr.s 177a <__udivsi3>
	addql	IMM (8), sp
    17f4:	508f           	addq.l #8,sp

	tstb	d2
    17f6:	4a02           	tst.b d2
	jpl	3f
    17f8:	6a02           	bpl.s 17fc <__divsi3+0x26>
	negl	d0
    17fa:	4480           	neg.l d0

3:	movel	sp@+, d2
    17fc:	241f           	move.l (sp)+,d2
	.cfi_adjust_cfa_offset -4
	rts
    17fe:	4e75           	rts

00001800 <__modsi3>:
	.text
	FUNC(__modsi3)
	.globl	SYM (__modsi3)
SYM (__modsi3):
	.cfi_startproc
	movel	sp@(8), d1	/* d1 = divisor */
    1800:	222f 0008      	move.l 8(sp),d1
	movel	sp@(4), d0	/* d0 = dividend */
    1804:	202f 0004      	move.l 4(sp),d0
	movel	d1, sp@-
    1808:	2f01           	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    180a:	2f00           	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	PICCALL	SYM (__divsi3)
    180c:	61c8           	bsr.s 17d6 <__divsi3>
	addql	IMM (8), sp
    180e:	508f           	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(8), d1	/* d1 = divisor */
    1810:	222f 0008      	move.l 8(sp),d1
	movel	d1, sp@-
    1814:	2f01           	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    1816:	2f00           	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	PICCALL	SYM (__mulsi3)	/* d0 = (a/b)*b */
    1818:	6100 ff3e      	bsr.w 1758 <__mulsi3>
	addql	IMM (8), sp
    181c:	508f           	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(4), d1	/* d1 = dividend */
    181e:	222f 0004      	move.l 4(sp),d1
	subl	d0, d1		/* d1 = a - (a/b)*b */
    1822:	9280           	sub.l d0,d1
	movel	d1, d0
    1824:	2001           	move.l d1,d0
	rts
    1826:	4e75           	rts

00001828 <__umodsi3>:
	.text
	FUNC(__umodsi3)
	.globl	SYM (__umodsi3)
SYM (__umodsi3):
	.cfi_startproc
	movel	sp@(8), d1	/* d1 = divisor */
    1828:	222f 0008      	move.l 8(sp),d1
	movel	sp@(4), d0	/* d0 = dividend */
    182c:	202f 0004      	move.l 4(sp),d0
	movel	d1, sp@-
    1830:	2f01           	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    1832:	2f00           	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	PICCALL	SYM (__udivsi3)
    1834:	6100 ff44      	bsr.w 177a <__udivsi3>
	addql	IMM (8), sp
    1838:	508f           	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(8), d1	/* d1 = divisor */
    183a:	222f 0008      	move.l 8(sp),d1
	movel	d1, sp@-
    183e:	2f01           	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    1840:	2f00           	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	PICCALL	SYM (__mulsi3)	/* d0 = (a/b)*b */
    1842:	6100 ff14      	bsr.w 1758 <__mulsi3>
	addql	IMM (8), sp
    1846:	508f           	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(4), d1	/* d1 = dividend */
    1848:	222f 0004      	move.l 4(sp),d1
	subl	d0, d1		/* d1 = a - (a/b)*b */
    184c:	9280           	sub.l d0,d1
	movel	d1, d0
    184e:	2001           	move.l d1,d0
	rts
    1850:	4e75           	rts

00001852 <KPutCharX>:
	FUNC(KPutCharX)
	.globl	SYM (KPutCharX)

SYM(KPutCharX):
	.cfi_startproc
    move.l  a6, -(sp)
    1852:	2f0e           	move.l a6,-(sp)
	.cfi_adjust_cfa_offset 4
    move.l  4.w, a6
    1854:	2c78 0004      	movea.l 4 <_start+0x4>,a6
    jsr     -0x204(a6)
    1858:	4eae fdfc      	jsr -516(a6)
    movea.l (sp)+, a6
    185c:	2c5f           	movea.l (sp)+,a6
	.cfi_adjust_cfa_offset -4
    rts
    185e:	4e75           	rts

00001860 <PutChar>:
	FUNC(PutChar)
	.globl	SYM (PutChar)

SYM(PutChar):
	.cfi_startproc
	move.b d0, (a3)+
    1860:	16c0           	move.b d0,(a3)+
	rts
    1862:	4e75           	rts
