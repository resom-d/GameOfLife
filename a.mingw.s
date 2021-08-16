
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
       4:	263c 0000 377c 	move.l #14204,d3
       a:	0483 0000 377c 	subi.l #14204,d3
      10:	e483           	asr.l #2,d3
	for (i = 0; i < count; i++)
      12:	6712           	beq.s 26 <_start+0x26>
      14:	45f9 0000 377c 	lea 377c <GolMainMenu>,a2
      1a:	7400           	moveq #0,d2
		__preinit_array_start[i]();
      1c:	205a           	movea.l (a2)+,a0
      1e:	4e90           	jsr (a0)
	for (i = 0; i < count; i++)
      20:	5282           	addq.l #1,d2
      22:	b483           	cmp.l d3,d2
      24:	66f6           	bne.s 1c <_start+0x1c>

	count = __init_array_end - __init_array_start;
      26:	263c 0000 377c 	move.l #14204,d3
      2c:	0483 0000 377c 	subi.l #14204,d3
      32:	e483           	asr.l #2,d3
	for (i = 0; i < count; i++)
      34:	6712           	beq.s 48 <_start+0x48>
      36:	45f9 0000 377c 	lea 377c <GolMainMenu>,a2
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
      4e:	243c 0000 377c 	move.l #14204,d2
      54:	0482 0000 377c 	subi.l #14204,d2
      5a:	e482           	asr.l #2,d2
	for (i = count; i > 0; i--)
      5c:	6710           	beq.s 6e <_start+0x6e>
      5e:	45f9 0000 377c 	lea 377c <GolMainMenu>,a2
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
      74:	4fef ff48      	lea -184(sp),sp
      78:	48e7 3f3e      	movem.l d2-d7/a2-a6,-(sp)
	GameMatrix.ColorAlive = 4;
	GameMatrix.ColorDead = 0;
	GameMatrix.Columns = 100;
	GameMatrix.Rows = 40;
      7c:	23fc 0028 0064 	move.l #2621540,3a34 <GameMatrix+0x8>
      82:	0000 3a34 
      86:	23fc 0004 0000 	move.l #262144,3a38 <GameMatrix+0xc>
      8c:	0000 3a38 
      90:	23fc 0005 0005 	move.l #327685,3a3c <GameMatrix+0x10>
      96:	0000 3a3c 
	return RETURN_OK;
}

int StartApp()
{
	SysBase = *((struct ExecBase **)4UL);
      9a:	2c78 0004      	movea.l 4 <_start+0x4>,a6
      9e:	23ce 0000 39a2 	move.l a6,39a2 <SysBase>
	custom = (struct Custom *)0xdff000;
	unsigned int pens[] = {~0};
      a4:	70ff           	moveq #-1,d0
      a6:	2f40 003c      	move.l d0,60(sp)
	APTR *my_VisualInfo;

	if ((DOSBase = (struct DosLibrary *)OpenLibrary((CONST_STRPTR) "dos.library", 0)))
      aa:	43f9 0000 1614 	lea 1614 <PutChar+0x4>,a1
      b0:	7000           	moveq #0,d0
      b2:	4eae fdd8      	jsr -552(a6)
      b6:	23c0 0000 3996 	move.l d0,3996 <DOSBase>
      bc:	6700 062e      	beq.w 6ec <main+0x678>
	{
		if ((GfxBase = (struct GfxBase *)OpenLibrary((CONST_STRPTR) "graphics.library", 0)))
      c0:	2c79 0000 39a2 	movea.l 39a2 <SysBase>,a6
      c6:	43f9 0000 1620 	lea 1620 <PutChar+0x10>,a1
      cc:	7000           	moveq #0,d0
      ce:	4eae fdd8      	jsr -552(a6)
      d2:	23c0 0000 39ae 	move.l d0,39ae <GfxBase>
      d8:	6700 0612      	beq.w 6ec <main+0x678>
		{
			if ((IntuitionBase = (struct IntuitionBase *)OpenLibrary((CONST_STRPTR) "intuition.library", 0)))
      dc:	2c79 0000 39a2 	movea.l 39a2 <SysBase>,a6
      e2:	43f9 0000 1631 	lea 1631 <PutChar+0x21>,a1
      e8:	7000           	moveq #0,d0
      ea:	4eae fdd8      	jsr -552(a6)
      ee:	2c40           	movea.l d0,a6
      f0:	23c0 0000 399e 	move.l d0,399e <IntuitionBase>
      f6:	6700 05f4      	beq.w 6ec <main+0x678>
			{
				if ((GOLRenderData.Screen = (struct Screen *)OpenScreenTags(NULL,
      fa:	2f7c 8000 003a 	move.l #-2147483590,64(sp)
     100:	0040 
     102:	723c           	moveq #60,d1
     104:	d28f           	add.l sp,d1
     106:	2f41 0044      	move.l d1,68(sp)
     10a:	2f7c 8000 0032 	move.l #-2147483598,72(sp)
     110:	0048 
     112:	2f7c 0000 8000 	move.l #32768,76(sp)
     118:	004c 
     11a:	2f7c 8000 0025 	move.l #-2147483611,80(sp)
     120:	0050 
     122:	7004           	moveq #4,d0
     124:	2f40 0054      	move.l d0,84(sp)
     128:	2f7c 8000 003b 	move.l #-2147483589,88(sp)
     12e:	0058 
     130:	7201           	moveq #1,d1
     132:	2f41 005c      	move.l d1,92(sp)
     136:	2f7c 8000 0028 	move.l #-2147483608,96(sp)
     13c:	0060 
     13e:	2f7c 0000 1643 	move.l #5699,100(sp)
     144:	0064 
     146:	2f7c 8000 002d 	move.l #-2147483603,104(sp)
     14c:	0068 
     14e:	700f           	moveq #15,d0
     150:	2f40 006c      	move.l d0,108(sp)
     154:	2f7c 8000 0026 	move.l #-2147483610,112(sp)
     15a:	0070 
     15c:	2f41 0074      	move.l d1,116(sp)
     160:	2f7c 8000 0027 	move.l #-2147483609,120(sp)
     166:	0078 
     168:	42af 007c      	clr.l 124(sp)
     16c:	42af 0080      	clr.l 128(sp)
     170:	91c8           	suba.l a0,a0
     172:	43ef 0040      	lea 64(sp),a1
     176:	4eae fd9c      	jsr -612(a6)
     17a:	41f9 0000 39b2 	lea 39b2 <GOLRenderData>,a0
     180:	2080           	move.l d0,(a0)
     182:	6700 0568      	beq.w 6ec <main+0x678>
																			SA_DetailPen, 1,
																			SA_BlockPen, 0,
																			TAG_END)))
				{

					if ((GadToolsBase = (struct Library *)OpenLibrary((CONST_STRPTR) "gadtools.library", 0)))
     186:	2c79 0000 39a2 	movea.l 39a2 <SysBase>,a6
     18c:	43f9 0000 165b 	lea 165b <PutChar+0x4b>,a1
     192:	7000           	moveq #0,d0
     194:	4eae fdd8      	jsr -552(a6)
     198:	23c0 0000 399a 	move.l d0,399a <GadToolsBase>
     19e:	6700 054c      	beq.w 6ec <main+0x678>
					{
						if ((GOLRenderData.MainWindow = (struct Window *)OpenWindowTags(NULL,
     1a2:	2f7c 8000 0070 	move.l #-2147483536,64(sp)
     1a8:	0040 
     1aa:	43f9 0000 39b2 	lea 39b2 <GOLRenderData>,a1
     1b0:	2451           	movea.l (a1),a2
     1b2:	2f4a 0044      	move.l a2,68(sp)
     1b6:	2f7c 8000 0064 	move.l #-2147483548,72(sp)
     1bc:	0048 
     1be:	42af 004c      	clr.l 76(sp)
     1c2:	2f7c 8000 0065 	move.l #-2147483547,80(sp)
     1c8:	0050 
     1ca:	102a 001e      	move.b 30(a2),d0
     1ce:	4880           	ext.w d0
     1d0:	48c0           	ext.l d0
     1d2:	5280           	addq.l #1,d0
     1d4:	2f40 0054      	move.l d0,84(sp)
     1d8:	2f7c 8000 0066 	move.l #-2147483546,88(sp)
     1de:	0058 
     1e0:	102a 0024      	move.b 36(a2),d0
     1e4:	4880           	ext.w d0
     1e6:	3a40           	movea.w d0,a5
     1e8:	102a 0025      	move.b 37(a2),d0
     1ec:	4880           	ext.w d0
     1ee:	3840           	movea.w d0,a4
     1f0:	7000           	moveq #0,d0
     1f2:	3039 0000 3a36 	move.w 3a36 <GameMatrix+0xa>,d0
     1f8:	7200           	moveq #0,d1
     1fa:	3239 0000 3a3c 	move.w 3a3c <GameMatrix+0x10>,d1
     200:	2f01           	move.l d1,-(sp)
     202:	2040           	movea.l d0,a0
     204:	4868 ffff      	pea -1(a0)
     208:	4eb9 0000 1508 	jsr 1508 <__mulsi3>
     20e:	508f           	addq.l #8,sp
     210:	41f5 0800      	lea (0,a5,d0.l),a0
     214:	41f4 8810      	lea (16,a4,a0.l),a0
     218:	2f48 005c      	move.l a0,92(sp)
     21c:	2f7c 8000 0067 	move.l #-2147483545,96(sp)
     222:	0060 
     224:	102a 0023      	move.b 35(a2),d0
     228:	4880           	ext.w d0
     22a:	3640           	movea.w d0,a3
     22c:	102a 0026      	move.b 38(a2),d0
     230:	4880           	ext.w d0
     232:	3440           	movea.w d0,a2
     234:	7000           	moveq #0,d0
     236:	3039 0000 3a34 	move.w 3a34 <GameMatrix+0x8>,d0
     23c:	7200           	moveq #0,d1
     23e:	3239 0000 3a3e 	move.w 3a3e <GameMatrix+0x12>,d1
     244:	2f01           	move.l d1,-(sp)
     246:	2240           	movea.l d0,a1
     248:	4869 ffff      	pea -1(a1)
     24c:	4eb9 0000 1508 	jsr 1508 <__mulsi3>
     252:	508f           	addq.l #8,sp
     254:	41f3 0800      	lea (0,a3,d0.l),a0
     258:	41f2 8810      	lea (16,a2,a0.l),a0
     25c:	2f48 0064      	move.l a0,100(sp)
     260:	2f7c 8000 0074 	move.l #-2147483532,104(sp)
     266:	0068 
     268:	203c 0000 0280 	move.l #640,d0
     26e:	908d           	sub.l a5,d0
     270:	908c           	sub.l a4,d0
     272:	2f40 006c      	move.l d0,108(sp)
     276:	2f7c 8000 0075 	move.l #-2147483531,112(sp)
     27c:	0070 
     27e:	203c 0000 0100 	move.l #256,d0
     284:	908b           	sub.l a3,d0
     286:	908a           	sub.l a2,d0
     288:	2f40 0074      	move.l d0,116(sp)
     28c:	2f7c 8000 006e 	move.l #-2147483538,120(sp)
     292:	0078 
     294:	2f7c 0000 166c 	move.l #5740,124(sp)
     29a:	007c 
     29c:	2f7c 8000 0083 	move.l #-2147483517,128(sp)
     2a2:	0080 
     2a4:	7001           	moveq #1,d0
     2a6:	2f40 0084      	move.l d0,132(sp)
     2aa:	2f7c 8000 0084 	move.l #-2147483516,136(sp)
     2b0:	0088 
     2b2:	2f40 008c      	move.l d0,140(sp)
     2b6:	2f7c 8000 0081 	move.l #-2147483519,144(sp)
     2bc:	0090 
     2be:	2f40 0094      	move.l d0,148(sp)
     2c2:	2f7c 8000 0082 	move.l #-2147483518,152(sp)
     2c8:	0098 
     2ca:	2f40 009c      	move.l d0,156(sp)
     2ce:	2f7c 8000 0091 	move.l #-2147483503,160(sp)
     2d4:	00a0 
     2d6:	2f40 00a4      	move.l d0,164(sp)
     2da:	2f7c 8000 0086 	move.l #-2147483514,168(sp)
     2e0:	00a8 
     2e2:	2f40 00ac      	move.l d0,172(sp)
     2e6:	2f7c 8000 0093 	move.l #-2147483501,176(sp)
     2ec:	00b0 
     2ee:	2f40 00b4      	move.l d0,180(sp)
     2f2:	2f7c 8000 0089 	move.l #-2147483511,184(sp)
     2f8:	00b8 
     2fa:	2f40 00bc      	move.l d0,188(sp)
     2fe:	2f7c 8000 006f 	move.l #-2147483537,192(sp)
     304:	00c0 
     306:	2f7c 0000 1674 	move.l #5748,196(sp)
     30c:	00c4 
     30e:	2f7c 8000 006a 	move.l #-2147483542,200(sp)
     314:	00c8 
     316:	2f7c 0000 031e 	move.l #798,204(sp)
     31c:	00cc 
     31e:	2f7c 8000 0068 	move.l #-2147483544,208(sp)
     324:	00d0 
     326:	7204           	moveq #4,d1
     328:	2f41 00d4      	move.l d1,212(sp)
     32c:	2f7c 8000 0069 	move.l #-2147483543,216(sp)
     332:	00d8 
     334:	7008           	moveq #8,d0
     336:	2f40 00dc      	move.l d0,220(sp)
     33a:	42af 00e0      	clr.l 224(sp)
     33e:	2c79 0000 399e 	movea.l 399e <IntuitionBase>,a6
     344:	91c8           	suba.l a0,a0
     346:	43ef 0040      	lea 64(sp),a1
     34a:	4eae fda2      	jsr -606(a6)
     34e:	23c0 0000 39b6 	move.l d0,39b6 <GOLRenderData+0x4>
     354:	6700 0396      	beq.w 6ec <main+0x678>
	if ((GameMatrix.Playfield = AllocMem(GameMatrix.Columns * sizeof(GameOfLifeCell *), MEMF_ANY | MEMF_CLEAR)) == NULL)
     358:	7000           	moveq #0,d0
     35a:	3039 0000 3a36 	move.w 3a36 <GameMatrix+0xa>,d0
     360:	2c79 0000 39a2 	movea.l 39a2 <SysBase>,a6
     366:	e588           	lsl.l #2,d0
     368:	7201           	moveq #1,d1
     36a:	4841           	swap d1
     36c:	4eae ff3a      	jsr -198(a6)
     370:	41f9 0000 3a2c 	lea 3a2c <GameMatrix>,a0
     376:	2080           	move.l d0,(a0)
     378:	6700 0372      	beq.w 6ec <main+0x678>
	if ((GameMatrix.Playfield_n1 = AllocMem(GameMatrix.Columns * sizeof(GameOfLifeCell *), MEMF_ANY | MEMF_CLEAR)) == NULL)
     37c:	7000           	moveq #0,d0
     37e:	3039 0000 3a36 	move.w 3a36 <GameMatrix+0xa>,d0
     384:	2c79 0000 39a2 	movea.l 39a2 <SysBase>,a6
     38a:	e588           	lsl.l #2,d0
     38c:	7201           	moveq #1,d1
     38e:	4841           	swap d1
     390:	4eae ff3a      	jsr -198(a6)
     394:	23c0 0000 3a30 	move.l d0,3a30 <GameMatrix+0x4>
     39a:	6700 0350      	beq.w 6ec <main+0x678>
	for (int i = 0; i < GameMatrix.Columns; i++)
     39e:	4a79 0000 3a36 	tst.w 3a36 <GameMatrix+0xa>
     3a4:	6700 0aba      	beq.w e60 <main+0xdec>
     3a8:	7400           	moveq #0,d2
     3aa:	7600           	moveq #0,d3
		if ((GameMatrix.Playfield[i] = AllocMem(GameMatrix.Rows * sizeof(GameOfLifeCell), MEMF_ANY | MEMF_CLEAR)) == NULL)
     3ac:	7801           	moveq #1,d4
     3ae:	4844           	swap d4
     3b0:	2c79 0000 39a2 	movea.l 39a2 <SysBase>,a6
     3b6:	7000           	moveq #0,d0
     3b8:	3039 0000 3a34 	move.w 3a34 <GameMatrix+0x8>,d0
     3be:	2204           	move.l d4,d1
     3c0:	4eae ff3a      	jsr -198(a6)
     3c4:	43f9 0000 3a2c 	lea 3a2c <GameMatrix>,a1
     3ca:	2051           	movea.l (a1),a0
     3cc:	2180 2800      	move.l d0,(0,a0,d2.l)
     3d0:	6700 031a      	beq.w 6ec <main+0x678>
		if ((GameMatrix.Playfield_n1[i] = AllocMem(GameMatrix.Rows * sizeof(GameOfLifeCell), MEMF_ANY | MEMF_CLEAR)) == NULL)
     3d4:	2c79 0000 39a2 	movea.l 39a2 <SysBase>,a6
     3da:	7000           	moveq #0,d0
     3dc:	3039 0000 3a34 	move.w 3a34 <GameMatrix+0x8>,d0
     3e2:	2204           	move.l d4,d1
     3e4:	4eae ff3a      	jsr -198(a6)
     3e8:	2079 0000 3a30 	movea.l 3a30 <GameMatrix+0x4>,a0
     3ee:	2180 2800      	move.l d0,(0,a0,d2.l)
     3f2:	6700 02f8      	beq.w 6ec <main+0x678>
	for (int i = 0; i < GameMatrix.Columns; i++)
     3f6:	5283           	addq.l #1,d3
     3f8:	7000           	moveq #0,d0
     3fa:	3039 0000 3a36 	move.w 3a36 <GameMatrix+0xa>,d0
     400:	5882           	addq.l #4,d2
     402:	b083           	cmp.l d3,d0
     404:	6eaa           	bgt.s 3b0 <main+0x33c>
	UpdateList = AllocMem(GameMatrix.Columns * GameMatrix.Rows * sizeof(UpdateListEntry), MEMF_ANY | MEMF_CLEAR);
     406:	7200           	moveq #0,d1
     408:	3239 0000 3a34 	move.w 3a34 <GameMatrix+0x8>,d1
     40e:	2f00           	move.l d0,-(sp)
     410:	2f01           	move.l d1,-(sp)
     412:	4eb9 0000 1508 	jsr 1508 <__mulsi3>
     418:	508f           	addq.l #8,sp
     41a:	2200           	move.l d0,d1
     41c:	d281           	add.l d1,d1
     41e:	d081           	add.l d1,d0
     420:	2c79 0000 39a2 	movea.l 39a2 <SysBase>,a6
     426:	d080           	add.l d0,d0
     428:	7201           	moveq #1,d1
     42a:	4841           	swap d1
     42c:	4eae ff3a      	jsr -198(a6)
     430:	23c0 0000 3992 	move.l d0,3992 <UpdateList>

void ComputeOutputSize(RenderData *rd)
{
	/* our output size is simply the window's size minus its borders */
	rd->OutputSize.x =
		rd->MainWindow->Width - rd->MainWindow->BorderLeft - rd->MainWindow->BorderRight;
     436:	2079 0000 39b6 	movea.l 39b6 <GOLRenderData+0x4>,a0
     43c:	1028 0036      	move.b 54(a0),d0
     440:	4880           	ext.w d0
     442:	1228 0038      	move.b 56(a0),d1
     446:	4881           	ext.w d1
     448:	d041           	add.w d1,d0
     44a:	3868 0008      	movea.w 8(a0),a4
     44e:	98c0           	suba.w d0,a4
     450:	33cc 0000 39ba 	move.w a4,39ba <GOLRenderData+0x8>
	rd->OutputSize.y =
		rd->MainWindow->Height - rd->MainWindow->BorderTop - rd->MainWindow->BorderBottom;
     456:	1028 0037      	move.b 55(a0),d0
     45a:	4880           	ext.w d0
     45c:	1228 0039      	move.b 57(a0),d1
     460:	4881           	ext.w d1
     462:	d041           	add.w d1,d0
     464:	3228 000a      	move.w 10(a0),d1
     468:	9240           	sub.w d0,d1
     46a:	33c1 0000 39bc 	move.w d1,39bc <GOLRenderData+0xa>
							my_VisualInfo = GetVisualInfo(GOLRenderData.MainWindow->WScreen, TAG_END);
     470:	42af 0040      	clr.l 64(sp)
     474:	2c79 0000 399a 	movea.l 399a <GadToolsBase>,a6
     47a:	2068 002e      	movea.l 46(a0),a0
     47e:	43ef 0040      	lea 64(sp),a1
     482:	4eae ff82      	jsr -126(a6)
     486:	2400           	move.l d0,d2
							MainMenuStrip = CreateMenus(GolMainMenu, TAG_END);
     488:	42af 0040      	clr.l 64(sp)
     48c:	2c79 0000 399a 	movea.l 399a <GadToolsBase>,a6
     492:	41f9 0000 377c 	lea 377c <GolMainMenu>,a0
     498:	43ef 0040      	lea 64(sp),a1
     49c:	4eae ffd0      	jsr -48(a6)
     4a0:	2040           	movea.l d0,a0
     4a2:	23c0 0000 39aa 	move.l d0,39aa <MainMenuStrip>
							LayoutMenus(MainMenuStrip, my_VisualInfo, TAG_END);
     4a8:	42af 0040      	clr.l 64(sp)
     4ac:	2c79 0000 399a 	movea.l 399a <GadToolsBase>,a6
     4b2:	2242           	movea.l d2,a1
     4b4:	45ef 0040      	lea 64(sp),a2
     4b8:	4eae ffbe      	jsr -66(a6)
							SetMenuStrip(GOLRenderData.MainWindow, MainMenuStrip);
     4bc:	2c79 0000 399e 	movea.l 399e <IntuitionBase>,a6
     4c2:	2079 0000 39b6 	movea.l 39b6 <GOLRenderData+0x4>,a0
     4c8:	2279 0000 39aa 	movea.l 39aa <MainMenuStrip>,a1
     4ce:	4eae fef8      	jsr -264(a6)
	if(PrepareBackbuffer(&GOLRenderData) != RETURN_OK) return RETURN_FAIL;	
     4d2:	4eb9 0000 0f72 	jsr f72 <PrepareBackbuffer.constprop.0>
     4d8:	2f40 0038      	move.l d0,56(sp)
     4dc:	6600 0970      	bne.w e4e <main+0xdda>
	SetRast(GOLRenderData.MainWindow->RPort, 0);
     4e0:	2c79 0000 39ae 	movea.l 39ae <GfxBase>,a6
     4e6:	2079 0000 39b6 	movea.l 39b6 <GOLRenderData+0x4>,a0
     4ec:	2268 0032      	movea.l 50(a0),a1
     4f0:	4eae ff16      	jsr -234(a6)
	while (AppRunning)
     4f4:	4a79 0000 3984 	tst.w 3984 <AppRunning>
     4fa:	6700 013c      	beq.w 638 <main+0x5c4>
		EventLoop(GOLRenderData.MainWindow, MainMenuStrip);
     4fe:	2f79 0000 39aa 	move.l 39aa <MainMenuStrip>,52(sp)
     504:	0034 
     506:	2a79 0000 39b6 	movea.l 39b6 <GOLRenderData+0x4>,a5
	if (!GameRunning)
     50c:	4a79 0000 39a8 	tst.w 39a8 <GameRunning>
     512:	6606           	bne.s 51a <main+0x4a6>
		UpdateCnt = 0;
     514:	4279 0000 39a6 	clr.w 39a6 <UpdateCnt>
	while ((message = (struct IntuiMessage *)GetMsg(theWindow->UserPort)))
     51a:	2c79 0000 39a2 	movea.l 39a2 <SysBase>,a6
     520:	206d 0056      	movea.l 86(a5),a0
     524:	4eae fe8c      	jsr -372(a6)
     528:	2440           	movea.l d0,a2
     52a:	4a80           	tst.l d0
     52c:	6700 00b4      	beq.w 5e2 <main+0x56e>
		msg_class = message->Class;
     530:	242a 0014      	move.l 20(a2),d2
		msg_code = message->Code;
     534:	382a 0018      	move.w 24(a2),d4
		coordX = message->MouseX - theWindow->BorderLeft;
     538:	102d 0036      	move.b 54(a5),d0
     53c:	4880           	ext.w d0
     53e:	3a2a 0020      	move.w 32(a2),d5
     542:	9a40           	sub.w d0,d5
		coordY = message->MouseY - theWindow->BorderTop;
     544:	102d 0037      	move.b 55(a5),d0
     548:	4880           	ext.w d0
     54a:	362a 0022      	move.w 34(a2),d3
     54e:	9640           	sub.w d0,d3
		ReplyMsg((struct Message *)message);
     550:	2c79 0000 39a2 	movea.l 39a2 <SysBase>,a6
     556:	224a           	movea.l a2,a1
     558:	4eae fe86      	jsr -378(a6)
		switch (msg_class)
     55c:	7010           	moveq #16,d0
     55e:	b082           	cmp.l d2,d0
     560:	6700 0200      	beq.w 762 <main+0x6ee>
     564:	6500 01de      	bcs.w 744 <main+0x6d0>
     568:	7204           	moveq #4,d1
     56a:	b282           	cmp.l d2,d1
     56c:	6700 025e      	beq.w 7cc <main+0x758>
     570:	7008           	moveq #8,d0
     572:	b082           	cmp.l d2,d0
     574:	6600 018a      	bne.w 700 <main+0x68c>
			x = (coordX / GameMatrix.CellSizeH) + 1;
     578:	3445           	movea.w d5,a2
			y = (coordY / GameMatrix.CellSizeV) + 1;
     57a:	3643           	movea.w d3,a3
			x = (coordX / GameMatrix.CellSizeH) + 1;
     57c:	7000           	moveq #0,d0
     57e:	3039 0000 3a3c 	move.w 3a3c <GameMatrix+0x10>,d0
     584:	49f9 0000 1586 	lea 1586 <__divsi3>,a4
     58a:	2f00           	move.l d0,-(sp)
     58c:	2f0a           	move.l a2,-(sp)
     58e:	4e94           	jsr (a4)
     590:	508f           	addq.l #8,sp
     592:	2400           	move.l d0,d2
     594:	5282           	addq.l #1,d2
			y = (coordY / GameMatrix.CellSizeV) + 1;
     596:	7000           	moveq #0,d0
     598:	3039 0000 3a3e 	move.w 3a3e <GameMatrix+0x12>,d0
     59e:	2f00           	move.l d0,-(sp)
     5a0:	2f0b           	move.l a3,-(sp)
     5a2:	4e94           	jsr (a4)
     5a4:	508f           	addq.l #8,sp
     5a6:	2600           	move.l d0,d3
     5a8:	5283           	addq.l #1,d3
     5aa:	0c44 0068      	cmpi.w #104,d4
     5ae:	6700 0516      	beq.w ac6 <main+0xa52>
     5b2:	0c44 00e8      	cmpi.w #232,d4
     5b6:	6600 01dc      	bne.w 794 <main+0x720>
				DrawActive = FALSE;
     5ba:	4279 0000 3990 	clr.w 3990 <DrawActive>
			OldSelectX = x;
     5c0:	23c2 0000 398c 	move.l d2,398c <OldSelectX>
			OldSelectY = y;
     5c6:	23c3 0000 3988 	move.l d3,3988 <OldSelectY>
	while ((message = (struct IntuiMessage *)GetMsg(theWindow->UserPort)))
     5cc:	2c79 0000 39a2 	movea.l 39a2 <SysBase>,a6
     5d2:	206d 0056      	movea.l 86(a5),a0
     5d6:	4eae fe8c      	jsr -372(a6)
     5da:	2440           	movea.l d0,a2
     5dc:	4a80           	tst.l d0
     5de:	6600 ff50      	bne.w 530 <main+0x4bc>
			WaitTOF();
     5e2:	2c79 0000 39ae 	movea.l 39ae <GfxBase>,a6
		if (GameRunning)
     5e8:	4a79 0000 39a8 	tst.w 39a8 <GameRunning>
     5ee:	6600 070a      	bne.w cfa <main+0xc86>
		if (UpdateCnt > 0)
     5f2:	3439 0000 39a6 	move.w 39a6 <UpdateCnt>,d2
     5f8:	4a42           	tst.w d2
     5fa:	6600 05c0      	bne.w bbc <main+0xb48>
	BltBitMapRastPort(rd->Backbuffer,
     5fe:	2079 0000 3a26 	movea.l 3a26 <GOLRenderData+0x74>,a0
     604:	7000           	moveq #0,d0
     606:	7200           	moveq #0,d1
     608:	2279 0000 39b6 	movea.l 39b6 <GOLRenderData+0x4>,a1
     60e:	2269 0032      	movea.l 50(a1),a1
     612:	7400           	moveq #0,d2
     614:	7600           	moveq #0,d3
     616:	3839 0000 39ba 	move.w 39ba <GOLRenderData+0x8>,d4
     61c:	48c4           	ext.l d4
     61e:	3a39 0000 39bc 	move.w 39bc <GOLRenderData+0xa>,d5
     624:	48c5           	ext.l d5
     626:	7c3f           	moveq #63,d6
     628:	4606           	not.b d6
     62a:	4eae fda2      	jsr -606(a6)
	while (AppRunning)
     62e:	4a79 0000 3984 	tst.w 3984 <AppRunning>
     634:	6600 fec8      	bne.w 4fe <main+0x48a>
	FreeMem((APTR)GameMatrix.Playfield, GameMatrix.Rows * GameMatrix.Columns * sizeof(GameOfLifeCell));
     638:	2c79 0000 39a2 	movea.l 39a2 <SysBase>,a6
     63e:	41f9 0000 3a2c 	lea 3a2c <GameMatrix>,a0
     644:	2250           	movea.l (a0),a1
     646:	3039 0000 3a34 	move.w 3a34 <GameMatrix+0x8>,d0
     64c:	c0f9 0000 3a36 	mulu.w 3a36 <GameMatrix+0xa>,d0
     652:	4eae ff2e      	jsr -210(a6)
	if (GOLRenderData.MainWindow)
     656:	2079 0000 39b6 	movea.l 39b6 <GOLRenderData+0x4>,a0
     65c:	b0fc 0000      	cmpa.w #0,a0
     660:	670a           	beq.s 66c <main+0x5f8>
		CloseWindow(GOLRenderData.MainWindow);
     662:	2c79 0000 399e 	movea.l 399e <IntuitionBase>,a6
     668:	4eae ffb8      	jsr -72(a6)
	if (GadToolsBase)
     66c:	2279 0000 399a 	movea.l 399a <GadToolsBase>,a1
     672:	b2fc 0000      	cmpa.w #0,a1
     676:	670a           	beq.s 682 <main+0x60e>
		CloseLibrary((struct Library *)GadToolsBase);
     678:	2c79 0000 39a2 	movea.l 39a2 <SysBase>,a6
     67e:	4eae fe62      	jsr -414(a6)
	if (GOLRenderData.Screen)
     682:	43f9 0000 39b2 	lea 39b2 <GOLRenderData>,a1
     688:	2051           	movea.l (a1),a0
     68a:	b0fc 0000      	cmpa.w #0,a0
     68e:	670a           	beq.s 69a <main+0x626>
		CloseScreen(GOLRenderData.Screen);
     690:	2c79 0000 399e 	movea.l 399e <IntuitionBase>,a6
     696:	4eae ffbe      	jsr -66(a6)
	if (GfxBase)
     69a:	2279 0000 39ae 	movea.l 39ae <GfxBase>,a1
     6a0:	b2fc 0000      	cmpa.w #0,a1
     6a4:	670a           	beq.s 6b0 <main+0x63c>
		CloseLibrary((struct Library *)GfxBase);
     6a6:	2c79 0000 39a2 	movea.l 39a2 <SysBase>,a6
     6ac:	4eae fe62      	jsr -414(a6)
	if (IntuitionBase)
     6b0:	2279 0000 399e 	movea.l 399e <IntuitionBase>,a1
     6b6:	b2fc 0000      	cmpa.w #0,a1
     6ba:	670a           	beq.s 6c6 <main+0x652>
		CloseLibrary((struct Library *)IntuitionBase);
     6bc:	2c79 0000 39a2 	movea.l 39a2 <SysBase>,a6
     6c2:	4eae fe62      	jsr -414(a6)
	if (DOSBase)
     6c6:	2279 0000 3996 	movea.l 3996 <DOSBase>,a1
     6cc:	b2fc 0000      	cmpa.w #0,a1
     6d0:	6700 077c      	beq.w e4e <main+0xdda>
		CloseLibrary((struct Library *)DOSBase);
     6d4:	2c79 0000 39a2 	movea.l 39a2 <SysBase>,a6
     6da:	4eae fe62      	jsr -414(a6)
}
     6de:	202f 0038      	move.l 56(sp),d0
     6e2:	4cdf 7cfc      	movem.l (sp)+,d2-d7/a2-a6
     6e6:	4fef 00b8      	lea 184(sp),sp
     6ea:	4e75           	rts
		return RETURN_FAIL;
     6ec:	7014           	moveq #20,d0
     6ee:	2f40 0038      	move.l d0,56(sp)
}
     6f2:	202f 0038      	move.l 56(sp),d0
     6f6:	4cdf 7cfc      	movem.l (sp)+,d2-d7/a2-a6
     6fa:	4fef 00b8      	lea 184(sp),sp
     6fe:	4e75           	rts
		switch (msg_class)
     700:	5582           	subq.l #2,d2
     702:	6600 fe16      	bne.w 51a <main+0x4a6>
		rd->MainWindow->Width - rd->MainWindow->BorderLeft - rd->MainWindow->BorderRight;
     706:	2079 0000 39b6 	movea.l 39b6 <GOLRenderData+0x4>,a0
     70c:	1028 0036      	move.b 54(a0),d0
     710:	4880           	ext.w d0
     712:	1228 0038      	move.b 56(a0),d1
     716:	4881           	ext.w d1
     718:	d041           	add.w d1,d0
     71a:	3268 0008      	movea.w 8(a0),a1
     71e:	92c0           	suba.w d0,a1
     720:	33c9 0000 39ba 	move.w a1,39ba <GOLRenderData+0x8>
		rd->MainWindow->Height - rd->MainWindow->BorderTop - rd->MainWindow->BorderBottom;
     726:	1028 0037      	move.b 55(a0),d0
     72a:	4880           	ext.w d0
     72c:	1228 0039      	move.b 57(a0),d1
     730:	4881           	ext.w d1
     732:	d041           	add.w d1,d0
     734:	3068 000a      	movea.w 10(a0),a0
     738:	90c0           	suba.w d0,a0
     73a:	33c8 0000 39bc 	move.w a0,39bc <GOLRenderData+0xa>
     740:	6000 fdd8      	bra.w 51a <main+0x4a6>
		switch (msg_class)
     744:	0c82 0000 0100 	cmpi.l #256,d2
     74a:	6700 01ea      	beq.w 936 <main+0x8c2>
     74e:	0c82 0000 0200 	cmpi.l #512,d2
     754:	6600 fdc4      	bne.w 51a <main+0x4a6>
			AppRunning = FALSE;
     758:	4279 0000 3984 	clr.w 3984 <AppRunning>
			break;
     75e:	6000 fdba      	bra.w 51a <main+0x4a6>
			x = (coordX / GameMatrix.CellSizeH) + 1;
     762:	3445           	movea.w d5,a2
			y = (coordY / GameMatrix.CellSizeV) + 1;
     764:	3643           	movea.w d3,a3
			x = (coordX / GameMatrix.CellSizeH) + 1;
     766:	7000           	moveq #0,d0
     768:	3039 0000 3a3c 	move.w 3a3c <GameMatrix+0x10>,d0
     76e:	49f9 0000 1586 	lea 1586 <__divsi3>,a4
     774:	2f00           	move.l d0,-(sp)
     776:	2f0a           	move.l a2,-(sp)
     778:	4e94           	jsr (a4)
     77a:	508f           	addq.l #8,sp
     77c:	2400           	move.l d0,d2
     77e:	5282           	addq.l #1,d2
			y = (coordY / GameMatrix.CellSizeV) + 1;
     780:	7000           	moveq #0,d0
     782:	3039 0000 3a3e 	move.w 3a3e <GameMatrix+0x12>,d0
     788:	2f00           	move.l d0,-(sp)
     78a:	2f0b           	move.l a3,-(sp)
     78c:	4e94           	jsr (a4)
     78e:	508f           	addq.l #8,sp
     790:	2600           	move.l d0,d3
     792:	5283           	addq.l #1,d3
			if (DrawActive && (x != OldSelectX || y != OldSelectY))
     794:	4a79 0000 3990 	tst.w 3990 <DrawActive>
     79a:	6700 fe24      	beq.w 5c0 <main+0x54c>
     79e:	b4b9 0000 398c 	cmp.l 398c <OldSelectX>,d2
     7a4:	660a           	bne.s 7b0 <main+0x73c>
     7a6:	b6b9 0000 3988 	cmp.l 3988 <OldSelectY>,d3
     7ac:	6700 fe12      	beq.w 5c0 <main+0x54c>
				ToggleCellStatus(coordX, coordY);
     7b0:	2f0b           	move.l a3,-(sp)
     7b2:	2f0a           	move.l a2,-(sp)
     7b4:	4eb9 0000 0eb4 	jsr eb4 <ToggleCellStatus>
     7ba:	508f           	addq.l #8,sp
			OldSelectX = x;
     7bc:	23c2 0000 398c 	move.l d2,398c <OldSelectX>
			OldSelectY = y;
     7c2:	23c3 0000 3988 	move.l d3,3988 <OldSelectY>
			break;
     7c8:	6000 fe02      	bra.w 5cc <main+0x558>
			SetWindowTitles(GOLRenderData.MainWindow, "Reconfiguring Memory...", (char*)-1);
     7cc:	2c79 0000 399e 	movea.l 399e <IntuitionBase>,a6
     7d2:	2079 0000 39b6 	movea.l 39b6 <GOLRenderData+0x4>,a0
     7d8:	43f9 0000 168d 	lea 168d <PutChar+0x7d>,a1
     7de:	347c ffff      	movea.w #-1,a2
     7e2:	4eae feec      	jsr -276(a6)
			result = PrepareBackbuffer(&GOLRenderData);	
     7e6:	4eb9 0000 0f72 	jsr f72 <PrepareBackbuffer.constprop.0>
			SetRast(&GOLRenderData.Rastport, 0);
     7ec:	2c79 0000 39ae 	movea.l 39ae <GfxBase>,a6
     7f2:	43f9 0000 39c2 	lea 39c2 <GOLRenderData+0x10>,a1
     7f8:	7000           	moveq #0,d0
     7fa:	4eae ff16      	jsr -234(a6)
	for (int y = 1; y < GameMatrix.Rows - 1; y++)
     7fe:	0c79 0002 0000 	cmpi.w #2,3a34 <GameMatrix+0x8>
     804:	3a34 
     806:	6300 00cc      	bls.w 8d4 <main+0x860>
		for (int x = 1; x < GameMatrix.Columns - 1; x++)
     80a:	3239 0000 3a36 	move.w 3a36 <GameMatrix+0xa>,d1
	for (int y = 1; y < GameMatrix.Rows - 1; y++)
     810:	7801           	moveq #1,d4
				SetAPen(&rd->Rastport, GameMatrix.ColorDead);
     812:	2a3c 0000 39c2 	move.l #14786,d5
     818:	2f4d 002c      	move.l a5,44(sp)
		for (int x = 1; x < GameMatrix.Columns - 1; x++)
     81c:	0c41 0002      	cmpi.w #2,d1
     820:	6300 00ae      	bls.w 8d0 <main+0x85c>
     824:	2e04           	move.l d4,d7
     826:	5387           	subq.l #1,d7
     828:	7c04           	moveq #4,d6
     82a:	347c 0001      	movea.w #1,a2
				SetAPen(&rd->Rastport, GameMatrix.ColorAlive);
     82e:	2c79 0000 39ae 	movea.l 39ae <GfxBase>,a6
			if (GameMatrix.Playfield[x][y].Status)
     834:	49f9 0000 3a2c 	lea 3a2c <GameMatrix>,a4
     83a:	2054           	movea.l (a4),a0
     83c:	2070 6800      	movea.l (0,a0,d6.l),a0
				SetAPen(&rd->Rastport, GameMatrix.ColorAlive);
     840:	2245           	movea.l d5,a1
     842:	7000           	moveq #0,d0
			if (GameMatrix.Playfield[x][y].Status)
     844:	4a30 4800      	tst.b (0,a0,d4.l)
     848:	6700 00de      	beq.w 928 <main+0x8b4>
				SetAPen(&rd->Rastport, GameMatrix.ColorAlive);
     84c:	3039 0000 3a38 	move.w 3a38 <GameMatrix+0xc>,d0
     852:	4eae feaa      	jsr -342(a6)
			RectFill(&rd->Rastport,
     856:	7400           	moveq #0,d2
     858:	3439 0000 3a3c 	move.w 3a3c <GameMatrix+0x10>,d2
     85e:	2f02           	move.l d2,-(sp)
     860:	486a ffff      	pea -1(a2)
     864:	4eb9 0000 1508 	jsr 1508 <__mulsi3>
     86a:	508f           	addq.l #8,sp
     86c:	2640           	movea.l d0,a3
     86e:	4beb 0001      	lea 1(a3),a5
     872:	7000           	moveq #0,d0
     874:	3039 0000 3a3e 	move.w 3a3e <GameMatrix+0x12>,d0
     87a:	2840           	movea.l d0,a4
     87c:	2f07           	move.l d7,-(sp)
     87e:	2f0c           	move.l a4,-(sp)
     880:	4eb9 0000 1508 	jsr 1508 <__mulsi3>
     886:	508f           	addq.l #8,sp
     888:	2600           	move.l d0,d3
     88a:	2c79 0000 39ae 	movea.l 39ae <GfxBase>,a6
     890:	2245           	movea.l d5,a1
     892:	200d           	move.l a5,d0
     894:	2203           	move.l d3,d1
     896:	5281           	addq.l #1,d1
     898:	47f3 28ff      	lea (-1,a3,d2.l),a3
     89c:	240b           	move.l a3,d2
     89e:	49f4 38ff      	lea (-1,a4,d3.l),a4
     8a2:	260c           	move.l a4,d3
     8a4:	4eae fece      	jsr -306(a6)
		for (int x = 1; x < GameMatrix.Columns - 1; x++)
     8a8:	528a           	addq.l #1,a2
     8aa:	3239 0000 3a36 	move.w 3a36 <GameMatrix+0xa>,d1
     8b0:	5886           	addq.l #4,d6
     8b2:	7000           	moveq #0,d0
     8b4:	3001           	move.w d1,d0
     8b6:	5380           	subq.l #1,d0
     8b8:	b08a           	cmp.l a2,d0
     8ba:	6e00 ff72      	bgt.w 82e <main+0x7ba>
	for (int y = 1; y < GameMatrix.Rows - 1; y++)
     8be:	5284           	addq.l #1,d4
     8c0:	7000           	moveq #0,d0
     8c2:	3039 0000 3a34 	move.w 3a34 <GameMatrix+0x8>,d0
     8c8:	5380           	subq.l #1,d0
     8ca:	b084           	cmp.l d4,d0
     8cc:	6e00 ff4e      	bgt.w 81c <main+0x7a8>
     8d0:	2a6f 002c      	movea.l 44(sp),a5
	BltBitMapRastPort(rd->Backbuffer,
     8d4:	2c79 0000 39ae 	movea.l 39ae <GfxBase>,a6
     8da:	2079 0000 3a26 	movea.l 3a26 <GOLRenderData+0x74>,a0
     8e0:	7000           	moveq #0,d0
     8e2:	7200           	moveq #0,d1
     8e4:	2279 0000 39b6 	movea.l 39b6 <GOLRenderData+0x4>,a1
     8ea:	2269 0032      	movea.l 50(a1),a1
     8ee:	7400           	moveq #0,d2
     8f0:	7600           	moveq #0,d3
     8f2:	3839 0000 39ba 	move.w 39ba <GOLRenderData+0x8>,d4
     8f8:	48c4           	ext.l d4
     8fa:	3a39 0000 39bc 	move.w 39bc <GOLRenderData+0xa>,d5
     900:	48c5           	ext.l d5
     902:	7c3f           	moveq #63,d6
     904:	4606           	not.b d6
     906:	4eae fda2      	jsr -606(a6)
			SetWindowTitles(GOLRenderData.MainWindow, "Reconfiguring Memory Done", (STRPTR)-1);
     90a:	2c79 0000 399e 	movea.l 399e <IntuitionBase>,a6
     910:	2079 0000 39b6 	movea.l 39b6 <GOLRenderData+0x4>,a0
     916:	43f9 0000 16a5 	lea 16a5 <PutChar+0x95>,a1
     91c:	347c ffff      	movea.w #-1,a2
     920:	4eae feec      	jsr -276(a6)
			break;
     924:	6000 fbf4      	bra.w 51a <main+0x4a6>
				SetAPen(&rd->Rastport, GameMatrix.ColorDead);
     928:	3039 0000 3a3a 	move.w 3a3a <GameMatrix+0xe>,d0
     92e:	4eae feaa      	jsr -342(a6)
     932:	6000 ff22      	bra.w 856 <main+0x7e2>
			menuNumber = message->Code;
     936:	342a 0018      	move.w 24(a2),d2
			while ((menuNumber != MENUNULL) && (AppRunning))
     93a:	0c42 ffff      	cmpi.w #-1,d2
     93e:	6700 fbda      	beq.w 51a <main+0x4a6>
					SetWindowTitles(theWindow, (STRPTR) "Running", (STRPTR)-1);
     942:	49f9 0000 16bf 	lea 16bf <PutChar+0xaf>,a4
     948:	2c2f 0034      	move.l 52(sp),d6
			while ((menuNumber != MENUNULL) && (AppRunning))
     94c:	4a79 0000 3984 	tst.w 3984 <AppRunning>
     952:	6700 fbc6      	beq.w 51a <main+0x4a6>
				item = ItemAddress(theMenu, menuNumber);
     956:	2c79 0000 399e 	movea.l 399e <IntuitionBase>,a6
     95c:	2046           	movea.l d6,a0
     95e:	3002           	move.w d2,d0
     960:	4eae ff70      	jsr -144(a6)
     964:	2640           	movea.l d0,a3
				menuNum = MENUNUM(menuNumber);
     966:	3002           	move.w d2,d0
     968:	0240 001f      	andi.w #31,d0
				if ((menuNum == 0) && (itemNum == 5))
     96c:	6646           	bne.s 9b4 <main+0x940>
				itemNum = ITEMNUM(menuNumber);
     96e:	3002           	move.w d2,d0
     970:	ea48           	lsr.w #5,d0
     972:	0240 003f      	andi.w #63,d0
				if ((menuNum == 0) && (itemNum == 5))
     976:	0c40 0005      	cmpi.w #5,d0
     97a:	6746           	beq.s 9c2 <main+0x94e>
				if ((menuNum == 0) && (itemNum == 1))
     97c:	0c40 0001      	cmpi.w #1,d0
     980:	6768           	beq.s 9ea <main+0x976>
				if ((menuNum == 0) && (itemNum == 3) && (subNum == 2))
     982:	0c40 0003      	cmpi.w #3,d0
     986:	662c           	bne.s 9b4 <main+0x940>
				subNum = SUBNUM(menuNumber);
     988:	700b           	moveq #11,d0
     98a:	e06a           	lsr.w d0,d2
				if ((menuNum == 0) && (itemNum == 3) && (subNum == 2))
     98c:	0c42 0002      	cmpi.w #2,d2
     990:	6700 0198      	beq.w b2a <main+0xab6>
				if ((menuNum == 0) && (itemNum == 3) && (subNum == 0))
     994:	4a42           	tst.w d2
     996:	6600 00fa      	bne.w a92 <main+0xa1e>
					SetWindowTitles(theWindow, (STRPTR) "Running", (STRPTR)-1);
     99a:	2c79 0000 399e 	movea.l 399e <IntuitionBase>,a6
     9a0:	204d           	movea.l a5,a0
     9a2:	224c           	movea.l a4,a1
     9a4:	347c ffff      	movea.w #-1,a2
     9a8:	4eae feec      	jsr -276(a6)
					GameRunning = TRUE;
     9ac:	33fc 0001 0000 	move.w #1,39a8 <GameRunning>
     9b2:	39a8 
				menuNumber = item->NextSelect;
     9b4:	342b 0020      	move.w 32(a3),d2
			while ((menuNumber != MENUNULL) && (AppRunning))
     9b8:	0c42 ffff      	cmpi.w #-1,d2
     9bc:	668e           	bne.s 94c <main+0x8d8>
     9be:	6000 fb5a      	bra.w 51a <main+0x4a6>
					AppRunning = FALSE;
     9c2:	4279 0000 3984 	clr.w 3984 <AppRunning>
					SetWindowTitles(theWindow, (STRPTR) "Running", (STRPTR)-1);
     9c8:	2c79 0000 399e 	movea.l 399e <IntuitionBase>,a6
     9ce:	204d           	movea.l a5,a0
     9d0:	224c           	movea.l a4,a1
     9d2:	347c ffff      	movea.w #-1,a2
     9d6:	4eae feec      	jsr -276(a6)
				menuNumber = item->NextSelect;
     9da:	342b 0020      	move.w 32(a3),d2
			while ((menuNumber != MENUNULL) && (AppRunning))
     9de:	0c42 ffff      	cmpi.w #-1,d2
     9e2:	6600 ff68      	bne.w 94c <main+0x8d8>
     9e6:	6000 fb32      	bra.w 51a <main+0x4a6>
					SavePlayfield((CONST_STRPTR) "test.gold", 1, 1, GameMatrix.Columns - 1, GameMatrix.Rows - 1);
     9ea:	7000           	moveq #0,d0
     9ec:	3039 0000 3a34 	move.w 3a34 <GameMatrix+0x8>,d0
     9f2:	2f40 0030      	move.l d0,48(sp)
     9f6:	7200           	moveq #0,d1
     9f8:	3239 0000 3a36 	move.w 3a36 <GameMatrix+0xa>,d1
     9fe:	2f41 002c      	move.l d1,44(sp)
	fh = Open(file, MODE_NEWFILE);
     a02:	2c79 0000 3996 	movea.l 3996 <DOSBase>,a6
     a08:	223c 0000 16c7 	move.l #5831,d1
     a0e:	243c 0000 03ee 	move.l #1006,d2
     a14:	4eae ffe2      	jsr -30(a6)
     a18:	2e00           	move.l d0,d7
	for (int x = startX; x < (startX + width); x++)
     a1a:	7001           	moveq #1,d0
     a1c:	b0af 002c      	cmp.l 44(sp),d0
     a20:	6c54           	bge.s a76 <main+0xa02>
     a22:	b0af 0030      	cmp.l 48(sp),d0
     a26:	6c4e           	bge.s a76 <main+0xa02>
     a28:	347c 0004      	movea.w #4,a2
     a2c:	7a01           	moveq #1,d5
		for (int y = startY; y < (startY + height); y++)
     a2e:	7801           	moveq #1,d4
			args[0] = x;
     a30:	2f45 0040      	move.l d5,64(sp)
			args[1] = y;
     a34:	2f44 0044      	move.l d4,68(sp)
			args[2] = GameMatrix.Playfield[x][y].Status;
     a38:	43f9 0000 3a2c 	lea 3a2c <GameMatrix>,a1
     a3e:	2051           	movea.l (a1),a0
     a40:	2070 a800      	movea.l (0,a0,a2.l),a0
     a44:	7000           	moveq #0,d0
     a46:	1030 4800      	move.b (0,a0,d4.l),d0
     a4a:	2f40 0048      	move.l d0,72(sp)
			VFPrintf(fh, (CONST_STRPTR) "%d,%d,%d\n", args);
     a4e:	2c79 0000 3996 	movea.l 3996 <DOSBase>,a6
     a54:	2207           	move.l d7,d1
     a56:	243c 0000 16d1 	move.l #5841,d2
     a5c:	7640           	moveq #64,d3
     a5e:	d68f           	add.l sp,d3
     a60:	4eae fe9e      	jsr -354(a6)
		for (int y = startY; y < (startY + height); y++)
     a64:	5284           	addq.l #1,d4
     a66:	b8af 0030      	cmp.l 48(sp),d4
     a6a:	66c4           	bne.s a30 <main+0x9bc>
	for (int x = startX; x < (startX + width); x++)
     a6c:	5285           	addq.l #1,d5
     a6e:	588a           	addq.l #4,a2
     a70:	baaf 002c      	cmp.l 44(sp),d5
     a74:	66b8           	bne.s a2e <main+0x9ba>
	Close(fh);
     a76:	2c79 0000 3996 	movea.l 3996 <DOSBase>,a6
     a7c:	2207           	move.l d7,d1
     a7e:	4eae ffdc      	jsr -36(a6)
				menuNumber = item->NextSelect;
     a82:	342b 0020      	move.w 32(a3),d2
			while ((menuNumber != MENUNULL) && (AppRunning))
     a86:	0c42 ffff      	cmpi.w #-1,d2
     a8a:	6600 fec0      	bne.w 94c <main+0x8d8>
     a8e:	6000 fa8a      	bra.w 51a <main+0x4a6>
				if ((menuNum == 0) && (itemNum == 3) && (subNum == 1))
     a92:	0c42 0001      	cmpi.w #1,d2
     a96:	6600 ff1c      	bne.w 9b4 <main+0x940>
					SetWindowTitles(theWindow, (STRPTR) "Stopped", (STRPTR)-1);
     a9a:	2c79 0000 399e 	movea.l 399e <IntuitionBase>,a6
     aa0:	204d           	movea.l a5,a0
     aa2:	43f9 0000 166c 	lea 166c <PutChar+0x5c>,a1
     aa8:	347c ffff      	movea.w #-1,a2
     aac:	4eae feec      	jsr -276(a6)
					GameRunning = FALSE;
     ab0:	4279 0000 39a8 	clr.w 39a8 <GameRunning>
				menuNumber = item->NextSelect;
     ab6:	342b 0020      	move.w 32(a3),d2
			while ((menuNumber != MENUNULL) && (AppRunning))
     aba:	0c42 ffff      	cmpi.w #-1,d2
     abe:	6600 fe8c      	bne.w 94c <main+0x8d8>
     ac2:	6000 fa56      	bra.w 51a <main+0x4a6>
				if (!GameRunning)
     ac6:	4a79 0000 39a8 	tst.w 39a8 <GameRunning>
     acc:	6600 fcc6      	bne.w 794 <main+0x720>
					DrawActive = TRUE;
     ad0:	33fc 0001 0000 	move.w #1,3990 <DrawActive>
     ad6:	3990 
					ToggleCellStatus(coordX, coordY);
     ad8:	2f0b           	move.l a3,-(sp)
     ada:	2f0a           	move.l a2,-(sp)
     adc:	4eb9 0000 0eb4 	jsr eb4 <ToggleCellStatus>
					UpdateList[UpdateCnt].X = x;
     ae2:	3239 0000 39a6 	move.w 39a6 <UpdateCnt>,d1
     ae8:	7000           	moveq #0,d0
     aea:	3001           	move.w d1,d0
     aec:	2040           	movea.l d0,a0
     aee:	d1c0           	adda.l d0,a0
     af0:	d1c0           	adda.l d0,a0
     af2:	d1c8           	adda.l a0,a0
     af4:	d1f9 0000 3992 	adda.l 3992 <UpdateList>,a0
     afa:	3082           	move.w d2,(a0)
					UpdateList[UpdateCnt].Y = y;
     afc:	3143 0002      	move.w d3,2(a0)
					UpdateList[UpdateCnt++].Status = GameMatrix.Playfield[x][y].Status;
     b00:	49f9 0000 3a2c 	lea 3a2c <GameMatrix>,a4
     b06:	2254           	movea.l (a4),a1
     b08:	2002           	move.l d2,d0
     b0a:	d082           	add.l d2,d0
     b0c:	d080           	add.l d0,d0
     b0e:	2271 0800      	movea.l (0,a1,d0.l),a1
     b12:	5241           	addq.w #1,d1
     b14:	33c1 0000 39a6 	move.w d1,39a6 <UpdateCnt>
     b1a:	4240           	clr.w d0
     b1c:	1031 3800      	move.b (0,a1,d3.l),d0
     b20:	3140 0004      	move.w d0,4(a0)
     b24:	508f           	addq.l #8,sp
     b26:	6000 fc76      	bra.w 79e <main+0x72a>
					ClearPlayfield(GameMatrix.Playfield);
     b2a:	41f9 0000 3a2c 	lea 3a2c <GameMatrix>,a0
     b30:	2450           	movea.l (a0),a2
	for (int x = 0; x < GameMatrix.Columns; x++)
     b32:	3439 0000 3a36 	move.w 3a36 <GameMatrix+0xa>,d2
     b38:	674a           	beq.s b84 <main+0xb10>
		memset(pf[x], 0, GameMatrix.Rows * sizeof(GameOfLifeCell));
     b3a:	7600           	moveq #0,d3
     b3c:	3639 0000 3a34 	move.w 3a34 <GameMatrix+0x8>,d3
     b42:	0282 0000 ffff 	andi.l #65535,d2
     b48:	d482           	add.l d2,d2
     b4a:	d482           	add.l d2,d2
     b4c:	280a           	move.l a2,d4
     b4e:	d882           	add.l d2,d4
     b50:	201a           	move.l (a2)+,d0
     b52:	2f03           	move.l d3,-(sp)
     b54:	42a7           	clr.l -(sp)
     b56:	2f00           	move.l d0,-(sp)
     b58:	4eb9 0000 12f6 	jsr 12f6 <memset>
	for (int x = 0; x < GameMatrix.Columns; x++)
     b5e:	4fef 000c      	lea 12(sp),sp
     b62:	b5c4           	cmpa.l d4,a2
     b64:	66ea           	bne.s b50 <main+0xadc>
     b66:	2479 0000 3a30 	movea.l 3a30 <GameMatrix+0x4>,a2
     b6c:	d48a           	add.l a2,d2
		memset(pf[x], 0, GameMatrix.Rows * sizeof(GameOfLifeCell));
     b6e:	201a           	move.l (a2)+,d0
     b70:	2f03           	move.l d3,-(sp)
     b72:	42a7           	clr.l -(sp)
     b74:	2f00           	move.l d0,-(sp)
     b76:	4eb9 0000 12f6 	jsr 12f6 <memset>
	for (int x = 0; x < GameMatrix.Columns; x++)
     b7c:	4fef 000c      	lea 12(sp),sp
     b80:	b5c2           	cmpa.l d2,a2
     b82:	66ea           	bne.s b6e <main+0xafa>
					SetRast(GOLRenderData.MainWindow->RPort, 0);
     b84:	2c79 0000 39ae 	movea.l 39ae <GfxBase>,a6
     b8a:	2079 0000 39b6 	movea.l 39b6 <GOLRenderData+0x4>,a0
     b90:	2268 0032      	movea.l 50(a0),a1
     b94:	7000           	moveq #0,d0
     b96:	4eae ff16      	jsr -234(a6)
					SetRast(&GOLRenderData.Rastport, 0);
     b9a:	2c79 0000 39ae 	movea.l 39ae <GfxBase>,a6
     ba0:	43f9 0000 39c2 	lea 39c2 <GOLRenderData+0x10>,a1
     ba6:	7000           	moveq #0,d0
     ba8:	4eae ff16      	jsr -234(a6)
				menuNumber = item->NextSelect;
     bac:	342b 0020      	move.w 32(a3),d2
			while ((menuNumber != MENUNULL) && (AppRunning))
     bb0:	0c42 ffff      	cmpi.w #-1,d2
     bb4:	6600 fd96      	bne.w 94c <main+0x8d8>
     bb8:	6000 f960      	bra.w 51a <main+0x4a6>
	for (int entry = 0; entry < UpdateCnt; entry++)
     bbc:	7a00           	moveq #0,d5
		if (UpdateCnt > 0)
     bbe:	7800           	moveq #0,d4
			SetAPen(&rd->Rastport, GameMatrix.ColorDead);
     bc0:	2c3c 0000 39c2 	move.l #14786,d6
		int x = UpdateList[entry].X;
     bc6:	2079 0000 3992 	movea.l 3992 <UpdateList>,a0
     bcc:	d1c4           	adda.l d4,a0
     bce:	7e00           	moveq #0,d7
     bd0:	3e10           	move.w (a0),d7
		int y = UpdateList[entry].Y;
     bd2:	7600           	moveq #0,d3
     bd4:	3628 0002      	move.w 2(a0),d3
			SetAPen(&rd->Rastport, GameMatrix.ColorAlive);
     bd8:	2246           	movea.l d6,a1
     bda:	7000           	moveq #0,d0
		if (s)
     bdc:	4a68 0004      	tst.w 4(a0)
     be0:	6700 009a      	beq.w c7c <main+0xc08>
			SetAPen(&rd->Rastport, GameMatrix.ColorAlive);
     be4:	3039 0000 3a38 	move.w 3a38 <GameMatrix+0xc>,d0
     bea:	4eae feaa      	jsr -342(a6)
		RectFill(&rd->Rastport,
     bee:	7400           	moveq #0,d2
     bf0:	3439 0000 3a3c 	move.w 3a3c <GameMatrix+0x10>,d2
     bf6:	2f02           	move.l d2,-(sp)
     bf8:	2047           	movea.l d7,a0
     bfa:	4868 ffff      	pea -1(a0)
     bfe:	4eb9 0000 1508 	jsr 1508 <__mulsi3>
     c04:	508f           	addq.l #8,sp
     c06:	2440           	movea.l d0,a2
     c08:	47ea 0001      	lea 1(a2),a3
     c0c:	7e00           	moveq #0,d7
     c0e:	3e39 0000 3a3e 	move.w 3a3e <GameMatrix+0x12>,d7
     c14:	2f07           	move.l d7,-(sp)
     c16:	2243           	movea.l d3,a1
     c18:	4869 ffff      	pea -1(a1)
     c1c:	4eb9 0000 1508 	jsr 1508 <__mulsi3>
     c22:	508f           	addq.l #8,sp
     c24:	2600           	move.l d0,d3
     c26:	2c79 0000 39ae 	movea.l 39ae <GfxBase>,a6
     c2c:	2246           	movea.l d6,a1
     c2e:	200b           	move.l a3,d0
     c30:	2203           	move.l d3,d1
     c32:	5281           	addq.l #1,d1
     c34:	45f2 28ff      	lea (-1,a2,d2.l),a2
     c38:	240a           	move.l a2,d2
     c3a:	2847           	movea.l d7,a4
     c3c:	49f4 38ff      	lea (-1,a4,d3.l),a4
     c40:	260c           	move.l a4,d3
     c42:	4eae fece      	jsr -306(a6)
	for (int entry = 0; entry < UpdateCnt; entry++)
     c46:	5285           	addq.l #1,d5
     c48:	5c84           	addq.l #6,d4
     c4a:	7000           	moveq #0,d0
     c4c:	3039 0000 39a6 	move.w 39a6 <UpdateCnt>,d0
			SetAPen(&rd->Rastport, GameMatrix.ColorAlive);
     c52:	2c79 0000 39ae 	movea.l 39ae <GfxBase>,a6
	for (int entry = 0; entry < UpdateCnt; entry++)
     c58:	b085           	cmp.l d5,d0
     c5a:	6f00 f9a2      	ble.w 5fe <main+0x58a>
		int x = UpdateList[entry].X;
     c5e:	2079 0000 3992 	movea.l 3992 <UpdateList>,a0
     c64:	d1c4           	adda.l d4,a0
     c66:	7e00           	moveq #0,d7
     c68:	3e10           	move.w (a0),d7
		int y = UpdateList[entry].Y;
     c6a:	7600           	moveq #0,d3
     c6c:	3628 0002      	move.w 2(a0),d3
			SetAPen(&rd->Rastport, GameMatrix.ColorAlive);
     c70:	2246           	movea.l d6,a1
     c72:	7000           	moveq #0,d0
		if (s)
     c74:	4a68 0004      	tst.w 4(a0)
     c78:	6600 ff6a      	bne.w be4 <main+0xb70>
			SetAPen(&rd->Rastport, GameMatrix.ColorDead);
     c7c:	3039 0000 3a3a 	move.w 3a3a <GameMatrix+0xe>,d0
     c82:	4eae feaa      	jsr -342(a6)
		RectFill(&rd->Rastport,
     c86:	7400           	moveq #0,d2
     c88:	3439 0000 3a3c 	move.w 3a3c <GameMatrix+0x10>,d2
     c8e:	2f02           	move.l d2,-(sp)
     c90:	2047           	movea.l d7,a0
     c92:	4868 ffff      	pea -1(a0)
     c96:	4eb9 0000 1508 	jsr 1508 <__mulsi3>
     c9c:	508f           	addq.l #8,sp
     c9e:	2440           	movea.l d0,a2
     ca0:	47ea 0001      	lea 1(a2),a3
     ca4:	7e00           	moveq #0,d7
     ca6:	3e39 0000 3a3e 	move.w 3a3e <GameMatrix+0x12>,d7
     cac:	2f07           	move.l d7,-(sp)
     cae:	2243           	movea.l d3,a1
     cb0:	4869 ffff      	pea -1(a1)
     cb4:	4eb9 0000 1508 	jsr 1508 <__mulsi3>
     cba:	508f           	addq.l #8,sp
     cbc:	2600           	move.l d0,d3
     cbe:	2c79 0000 39ae 	movea.l 39ae <GfxBase>,a6
     cc4:	2246           	movea.l d6,a1
     cc6:	200b           	move.l a3,d0
     cc8:	2203           	move.l d3,d1
     cca:	5281           	addq.l #1,d1
     ccc:	45f2 28ff      	lea (-1,a2,d2.l),a2
     cd0:	240a           	move.l a2,d2
     cd2:	2847           	movea.l d7,a4
     cd4:	49f4 38ff      	lea (-1,a4,d3.l),a4
     cd8:	260c           	move.l a4,d3
     cda:	4eae fece      	jsr -306(a6)
	for (int entry = 0; entry < UpdateCnt; entry++)
     cde:	5285           	addq.l #1,d5
     ce0:	5c84           	addq.l #6,d4
     ce2:	7000           	moveq #0,d0
     ce4:	3039 0000 39a6 	move.w 39a6 <UpdateCnt>,d0
			SetAPen(&rd->Rastport, GameMatrix.ColorAlive);
     cea:	2c79 0000 39ae 	movea.l 39ae <GfxBase>,a6
	for (int entry = 0; entry < UpdateCnt; entry++)
     cf0:	b085           	cmp.l d5,d0
     cf2:	6e00 ff6a      	bgt.w c5e <main+0xbea>
     cf6:	6000 f906      	bra.w 5fe <main+0x58a>
			UpdateCnt = 0;
     cfa:	4279 0000 39a6 	clr.w 39a6 <UpdateCnt>
			WaitTOF();
     d00:	4eae fef2      	jsr -270(a6)
	GameOfLifeCell **pf = GameMatrix.Playfield;
     d04:	43f9 0000 3a2c 	lea 3a2c <GameMatrix>,a1
     d0a:	2f51 0030      	move.l (a1),48(sp)
	GameOfLifeCell **pf_n1 = GameMatrix.Playfield_n1;
     d0e:	2f79 0000 3a30 	move.l 3a30 <GameMatrix+0x4>,52(sp)
     d14:	0034 
	for (int x = 1; x < GameMatrix.Columns - 1; x++)
     d16:	7c00           	moveq #0,d6
     d18:	3c39 0000 3a36 	move.w 3a36 <GameMatrix+0xa>,d6
     d1e:	7002           	moveq #2,d0
     d20:	b086           	cmp.l d6,d0
     d22:	6c00 0122      	bge.w e46 <main+0xdd2>
		for (int y = 1; y < GameMatrix.Rows - 1; y++)
     d26:	3e39 0000 3a34 	move.w 3a34 <GameMatrix+0x8>,d7
				UpdateList[UpdateCnt].X = x;
     d2c:	2a39 0000 3992 	move.l 3992 <UpdateList>,d5
     d32:	3439 0000 39a6 	move.w 39a6 <UpdateCnt>,d2
     d38:	246f 0034      	movea.l 52(sp),a2
     d3c:	588a           	addq.l #4,a2
     d3e:	2a6f 0030      	movea.l 48(sp),a5
     d42:	2206           	move.l d6,d1
     d44:	5381           	subq.l #1,d1
     d46:	2f41 002c      	move.l d1,44(sp)
     d4a:	7801           	moveq #1,d4
     d4c:	7000           	moveq #0,d0
     d4e:	3007           	move.w d7,d0
     d50:	2240           	movea.l d0,a1
     d52:	5389           	subq.l #1,a1
		for (int y = 1; y < GameMatrix.Rows - 1; y++)
     d54:	0c47 0002      	cmpi.w #2,d7
     d58:	6300 0082      	bls.w ddc <main+0xd68>
     d5c:	2c55           	movea.l (a5),a6
     d5e:	286d 0008      	movea.l 8(a5),a4
     d62:	206d 0004      	movea.l 4(a5),a0
					if (pf[x + xi][y + yj].Status)
     d66:	7001           	moveq #1,d0
     d68:	4a1e           	tst.b (a6)+
     d6a:	56c1           	sne d1
     d6c:	4881           	ext.w d1
     d6e:	4441           	neg.w d1
     d70:	4a16           	tst.b (a6)
     d72:	6702           	beq.s d76 <main+0xd02>
						neighbours++;
     d74:	5241           	addq.w #1,d1
					if (pf[x + xi][y + yj].Status)
     d76:	4a2e 0001      	tst.b 1(a6)
     d7a:	6600 00ea      	bne.w e66 <main+0xdf2>
     d7e:	4a18           	tst.b (a0)+
     d80:	6702           	beq.s d84 <main+0xd10>
						neighbours++;
     d82:	5241           	addq.w #1,d1
					if (pf[x + xi][y + yj].Status)
     d84:	1610           	move.b (a0),d3
     d86:	6702           	beq.s d8a <main+0xd16>
						neighbours++;
     d88:	5241           	addq.w #1,d1
					if (pf[x + xi][y + yj].Status)
     d8a:	4a28 0001      	tst.b 1(a0)
     d8e:	6702           	beq.s d92 <main+0xd1e>
						neighbours++;
     d90:	5241           	addq.w #1,d1
					if (pf[x + xi][y + yj].Status)
     d92:	4a1c           	tst.b (a4)+
     d94:	6702           	beq.s d98 <main+0xd24>
						neighbours++;
     d96:	5241           	addq.w #1,d1
					if (pf[x + xi][y + yj].Status)
     d98:	4a14           	tst.b (a4)
     d9a:	6702           	beq.s d9e <main+0xd2a>
						neighbours++;
     d9c:	5241           	addq.w #1,d1
					if (pf[x + xi][y + yj].Status)
     d9e:	4a2c 0001      	tst.b 1(a4)
     da2:	6702           	beq.s da6 <main+0xd32>
						neighbours++;
     da4:	5241           	addq.w #1,d1
			if (pf[x][y].Status)
     da6:	4a03           	tst.b d3
     da8:	6700 00c2      	beq.w e6c <main+0xdf8>
					pf_n1[x][y].Status = 0;
     dac:	2652           	movea.l (a2),a3
     dae:	d7c0           	adda.l d0,a3
				if (neighbours < 2 || neighbours > 3)
     db0:	5741           	subq.w #3,d1
     db2:	0c41 0001      	cmpi.w #1,d1
     db6:	6300 00ec      	bls.w ea4 <main+0xe30>
					pf_n1[x][y].Status = 0;
     dba:	4213           	clr.b (a3)
					UpdateList[UpdateCnt].X = x;
     dbc:	7200           	moveq #0,d1
     dbe:	3202           	move.w d2,d1
     dc0:	2641           	movea.l d1,a3
     dc2:	d7c1           	adda.l d1,a3
     dc4:	d7c1           	adda.l d1,a3
     dc6:	d7cb           	adda.l a3,a3
     dc8:	d7c5           	adda.l d5,a3
     dca:	3684           	move.w d4,(a3)
					UpdateList[UpdateCnt].Y = y;
     dcc:	3740 0002      	move.w d0,2(a3)
					UpdateList[UpdateCnt].Status = pf_n1[x][y].Status;
     dd0:	426b 0004      	clr.w 4(a3)
					UpdateCnt++;
     dd4:	5242           	addq.w #1,d2
		for (int y = 1; y < GameMatrix.Rows - 1; y++)
     dd6:	5280           	addq.l #1,d0
     dd8:	b089           	cmp.l a1,d0
     dda:	668c           	bne.s d68 <main+0xcf4>
	for (int x = 1; x < GameMatrix.Columns - 1; x++)
     ddc:	5284           	addq.l #1,d4
     dde:	588a           	addq.l #4,a2
     de0:	588d           	addq.l #4,a5
     de2:	b8af 002c      	cmp.l 44(sp),d4
     de6:	6600 ff6c      	bne.w d54 <main+0xce0>
     dea:	33c2 0000 39a6 	move.w d2,39a6 <UpdateCnt>
			SetAPen(&rd->Rastport, GameMatrix.ColorAlive);
     df0:	2c79 0000 39ae 	movea.l 39ae <GfxBase>,a6
	for (int col = 0; col < GameMatrix.Columns; col++)
     df6:	4a86           	tst.l d6
     df8:	6700 f7fe      	beq.w 5f8 <main+0x584>
		memcpy(pf[col], pf_n1[col], GameMatrix.Rows * sizeof(GameOfLifeCell));
     dfc:	7800           	moveq #0,d4
     dfe:	3839 0000 3a34 	move.w 3a34 <GameMatrix+0x8>,d4
     e04:	246f 0034      	movea.l 52(sp),a2
     e08:	266f 0030      	movea.l 48(sp),a3
     e0c:	dc86           	add.l d6,d6
     e0e:	dc86           	add.l d6,d6
     e10:	dc8a           	add.l a2,d6
     e12:	49f9 0000 13c4 	lea 13c4 <memcpy>,a4
     e18:	221a           	move.l (a2)+,d1
     e1a:	201b           	move.l (a3)+,d0
     e1c:	2f04           	move.l d4,-(sp)
     e1e:	2f01           	move.l d1,-(sp)
     e20:	2f00           	move.l d0,-(sp)
     e22:	4e94           	jsr (a4)
	for (int col = 0; col < GameMatrix.Columns; col++)
     e24:	4fef 000c      	lea 12(sp),sp
     e28:	b5c6           	cmpa.l d6,a2
     e2a:	6700 f7cc      	beq.w 5f8 <main+0x584>
		memcpy(pf[col], pf_n1[col], GameMatrix.Rows * sizeof(GameOfLifeCell));
     e2e:	221a           	move.l (a2)+,d1
     e30:	201b           	move.l (a3)+,d0
     e32:	2f04           	move.l d4,-(sp)
     e34:	2f01           	move.l d1,-(sp)
     e36:	2f00           	move.l d0,-(sp)
     e38:	4e94           	jsr (a4)
	for (int col = 0; col < GameMatrix.Columns; col++)
     e3a:	4fef 000c      	lea 12(sp),sp
     e3e:	b5c6           	cmpa.l d6,a2
     e40:	66d6           	bne.s e18 <main+0xda4>
     e42:	6000 f7b4      	bra.w 5f8 <main+0x584>
		if (UpdateCnt > 0)
     e46:	3439 0000 39a6 	move.w 39a6 <UpdateCnt>,d2
     e4c:	60a2           	bra.s df0 <main+0xd7c>
     e4e:	42af 0038      	clr.l 56(sp)
}
     e52:	202f 0038      	move.l 56(sp),d0
     e56:	4cdf 7cfc      	movem.l (sp)+,d2-d7/a2-a6
     e5a:	4fef 00b8      	lea 184(sp),sp
     e5e:	4e75           	rts
	for (int i = 0; i < GameMatrix.Columns; i++)
     e60:	7000           	moveq #0,d0
     e62:	6000 f5a2      	bra.w 406 <main+0x392>
						neighbours++;
     e66:	5241           	addq.w #1,d1
     e68:	6000 ff14      	bra.w d7e <main+0xd0a>
			else if (neighbours == 3)
     e6c:	0c41 0003      	cmpi.w #3,d1
     e70:	6600 ff64      	bne.w dd6 <main+0xd62>
				pf_n1[x][y].Status = 1;
     e74:	2652           	movea.l (a2),a3
     e76:	17bc 0001 0800 	move.b #1,(0,a3,d0.l)
				UpdateList[UpdateCnt].X = x;
     e7c:	7200           	moveq #0,d1
     e7e:	3202           	move.w d2,d1
     e80:	2641           	movea.l d1,a3
     e82:	d7c1           	adda.l d1,a3
     e84:	d7c1           	adda.l d1,a3
     e86:	d7cb           	adda.l a3,a3
     e88:	d7c5           	adda.l d5,a3
     e8a:	3684           	move.w d4,(a3)
				UpdateList[UpdateCnt].Y = y;
     e8c:	3740 0002      	move.w d0,2(a3)
				UpdateList[UpdateCnt].Status = pf_n1[x][y].Status;
     e90:	377c 0001 0004 	move.w #1,4(a3)
				UpdateCnt++;
     e96:	5242           	addq.w #1,d2
		for (int y = 1; y < GameMatrix.Rows - 1; y++)
     e98:	5280           	addq.l #1,d0
     e9a:	b089           	cmp.l a1,d0
     e9c:	6600 feca      	bne.w d68 <main+0xcf4>
     ea0:	6000 ff3a      	bra.w ddc <main+0xd68>
					pf_n1[x][y].Status = pf[x][y].Status;
     ea4:	1683           	move.b d3,(a3)
		for (int y = 1; y < GameMatrix.Rows - 1; y++)
     ea6:	5280           	addq.l #1,d0
     ea8:	b089           	cmp.l a1,d0
     eaa:	6600 febc      	bne.w d68 <main+0xcf4>
     eae:	6000 ff2c      	bra.w ddc <main+0xd68>
     eb2:	4e71           	nop

00000eb4 <ToggleCellStatus>:
{
     eb4:	48e7 3020      	movem.l d2-d3/a2,-(sp)
     eb8:	262f 0014      	move.l 20(sp),d3
	int x = coordX / GameMatrix.CellSizeH + 1;
     ebc:	7000           	moveq #0,d0
     ebe:	3039 0000 3a3c 	move.w 3a3c <GameMatrix+0x10>,d0
     ec4:	45f9 0000 1586 	lea 1586 <__divsi3>,a2
     eca:	2f00           	move.l d0,-(sp)
     ecc:	306f 0016      	movea.w 22(sp),a0
     ed0:	2f08           	move.l a0,-(sp)
     ed2:	4e92           	jsr (a2)
     ed4:	508f           	addq.l #8,sp
     ed6:	2400           	move.l d0,d2
     ed8:	5282           	addq.l #1,d2
	if (!(x < 0 || x > GameMatrix.Columns - 2 || y < 0 || y > GameMatrix.Rows - 2))
     eda:	6b74           	bmi.s f50 <ToggleCellStatus+0x9c>
     edc:	7000           	moveq #0,d0
     ede:	3039 0000 3a36 	move.w 3a36 <GameMatrix+0xa>,d0
     ee4:	5380           	subq.l #1,d0
     ee6:	b480           	cmp.l d0,d2
     ee8:	6c66           	bge.s f50 <ToggleCellStatus+0x9c>
	int y = coordY / GameMatrix.CellSizeV + 1;
     eea:	7000           	moveq #0,d0
     eec:	3039 0000 3a3e 	move.w 3a3e <GameMatrix+0x12>,d0
     ef2:	2f00           	move.l d0,-(sp)
     ef4:	3043           	movea.w d3,a0
     ef6:	2f08           	move.l a0,-(sp)
     ef8:	4e92           	jsr (a2)
     efa:	508f           	addq.l #8,sp
     efc:	5280           	addq.l #1,d0
	if (!(x < 0 || x > GameMatrix.Columns - 2 || y < 0 || y > GameMatrix.Rows - 2))
     efe:	6b50           	bmi.s f50 <ToggleCellStatus+0x9c>
     f00:	7200           	moveq #0,d1
     f02:	3239 0000 3a34 	move.w 3a34 <GameMatrix+0x8>,d1
     f08:	5381           	subq.l #1,d1
     f0a:	b081           	cmp.l d1,d0
     f0c:	6c42           	bge.s f50 <ToggleCellStatus+0x9c>
		if (GameMatrix.Playfield[x][y].Status)
     f0e:	2079 0000 3a2c 	movea.l 3a2c <GameMatrix>,a0
     f14:	2202           	move.l d2,d1
     f16:	d282           	add.l d2,d1
     f18:	d281           	add.l d1,d1
     f1a:	2270 1800      	movea.l (0,a0,d1.l),a1
     f1e:	d3c0           	adda.l d0,a1
			UpdateList[UpdateCnt].X = x;
     f20:	3239 0000 39a6 	move.w 39a6 <UpdateCnt>,d1
     f26:	7600           	moveq #0,d3
     f28:	3601           	move.w d1,d3
     f2a:	2043           	movea.l d3,a0
     f2c:	d1c3           	adda.l d3,a0
     f2e:	d1c3           	adda.l d3,a0
     f30:	d1c8           	adda.l a0,a0
     f32:	d1f9 0000 3992 	adda.l 3992 <UpdateList>,a0
			UpdateCnt++;
     f38:	5241           	addq.w #1,d1
		if (GameMatrix.Playfield[x][y].Status)
     f3a:	4a11           	tst.b (a1)
     f3c:	6718           	beq.s f56 <ToggleCellStatus+0xa2>
			GameMatrix.Playfield[x][y].Status = 0;
     f3e:	4211           	clr.b (a1)
			UpdateList[UpdateCnt].X = x;
     f40:	3082           	move.w d2,(a0)
			UpdateList[UpdateCnt].Y = y;
     f42:	3140 0002      	move.w d0,2(a0)
			UpdateList[UpdateCnt].Status = 0;
     f46:	4268 0004      	clr.w 4(a0)
			UpdateCnt++;
     f4a:	33c1 0000 39a6 	move.w d1,39a6 <UpdateCnt>
}
     f50:	4cdf 040c      	movem.l (sp)+,d2-d3/a2
     f54:	4e75           	rts
			GameMatrix.Playfield[x][y].Status = 1;
     f56:	12bc 0001      	move.b #1,(a1)
			UpdateList[UpdateCnt].X = x;
     f5a:	3082           	move.w d2,(a0)
			UpdateList[UpdateCnt].Y = y;
     f5c:	3140 0002      	move.w d0,2(a0)
			UpdateList[UpdateCnt].Status = 1;
     f60:	317c 0001 0004 	move.w #1,4(a0)
			UpdateCnt++;
     f66:	33c1 0000 39a6 	move.w d1,39a6 <UpdateCnt>
}
     f6c:	4cdf 040c      	movem.l (sp)+,d2-d3/a2
     f70:	4e75           	rts

00000f72 <PrepareBackbuffer.constprop.0>:
}

int PrepareBackbuffer(RenderData *rd)
     f72:	48e7 383e      	movem.l d2-d4/a2-a6,-(sp)
	int result;

	if (rd->OutputSize.x != rd->BackbufferSize.x || rd->OutputSize.y != rd->BackbufferSize.y)
	{
		/* if output size changed free our current bitmap... */
		if (rd->Backbuffer)
     f76:	2679 0000 3a26 	movea.l 3a26 <GOLRenderData+0x74>,a3
	if (rd->OutputSize.x != rd->BackbufferSize.x || rd->OutputSize.y != rd->BackbufferSize.y)
     f7c:	2039 0000 39ba 	move.l 39ba <GOLRenderData+0x8>,d0
     f82:	b0b9 0000 39be 	cmp.l 39be <GOLRenderData+0xc>,d0
     f88:	6700 0122      	beq.w 10ac <PrepareBackbuffer.constprop.0+0x13a>
	if (GfxBase->LibNode.lib_Version < 39)
     f8c:	2c79 0000 39ae 	movea.l 39ae <GfxBase>,a6
     f92:	302e 0014      	move.w 20(a6),d0
		if (rd->Backbuffer)
     f96:	b6fc 0000      	cmpa.w #0,a3
     f9a:	6770           	beq.s 100c <PrepareBackbuffer.constprop.0+0x9a>
	if (GfxBase->LibNode.lib_Version < 39)
     f9c:	0c40 0026      	cmpi.w #38,d0
     fa0:	6200 0166      	bhi.w 1108 <PrepareBackbuffer.constprop.0+0x196>
		width = bitmap->BytesPerRow * 8;
     fa4:	7800           	moveq #0,d4
     fa6:	3813           	move.w (a3),d4
     fa8:	e78c           	lsl.l #3,d4
		for (i = 0; i < bitmap->Depth; i++)
     faa:	122b 0005      	move.b 5(a3),d1
     fae:	673e           	beq.s fee <PrepareBackbuffer.constprop.0+0x7c>
     fb0:	4242           	clr.w d2
     fb2:	91c8           	suba.l a0,a0
     fb4:	d1c8           	adda.l a0,a0
     fb6:	d1c8           	adda.l a0,a0
     fb8:	45f3 8800      	lea (0,a3,a0.l),a2
			if (bitmap->Planes[i])
     fbc:	206a 0008      	movea.l 8(a2),a0
     fc0:	b0fc 0000      	cmpa.w #0,a0
     fc4:	6700 0122      	beq.w 10e8 <PrepareBackbuffer.constprop.0+0x176>
				FreeRaster(bitmap->Planes[i], width, bitmap->Rows);
     fc8:	2c79 0000 39ae 	movea.l 39ae <GfxBase>,a6
     fce:	2004           	move.l d4,d0
     fd0:	7200           	moveq #0,d1
     fd2:	322b 0002      	move.w 2(a3),d1
     fd6:	4eae fe0e      	jsr -498(a6)
				bitmap->Planes[i] = 0;
     fda:	42aa 0008      	clr.l 8(a2)
		for (i = 0; i < bitmap->Depth; i++)
     fde:	122b 0005      	move.b 5(a3),d1
     fe2:	5242           	addq.w #1,d2
     fe4:	3042           	movea.w d2,a0
     fe6:	7600           	moveq #0,d3
     fe8:	1601           	move.b d1,d3
     fea:	b1c3           	cmpa.l d3,a0
     fec:	6dc6           	blt.s fb4 <PrepareBackbuffer.constprop.0+0x42>
		FreeMem(bitmap, sizeof(struct BitMap));
     fee:	2c79 0000 39a2 	movea.l 39a2 <SysBase>,a6
     ff4:	224b           	movea.l a3,a1
     ff6:	7028           	moveq #40,d0
     ff8:	4eae ff2e      	jsr -210(a6)
		{
			MyFreeBitMap(rd->Backbuffer);
			rd->Backbuffer = 0;
     ffc:	42b9 0000 3a26 	clr.l 3a26 <GOLRenderData+0x74>
	if (GfxBase->LibNode.lib_Version < 39)
    1002:	2c79 0000 39ae 	movea.l 39ae <GfxBase>,a6
    1008:	302e 0014      	move.w 20(a6),d0
		}

		/* ... allocate a new one... */
		rd->Backbuffer = MyAllocBitMap(rd->OutputSize.x, rd->OutputSize.y, ScreenD, rd->MainWindow->RPort->BitMap);
    100c:	3879 0000 39bc 	movea.w 39bc <GOLRenderData+0xa>,a4
    1012:	3a79 0000 39ba 	movea.w 39ba <GOLRenderData+0x8>,a5
	if (GfxBase->LibNode.lib_Version < 39)
    1018:	0c40 0026      	cmpi.w #38,d0
    101c:	6200 009c      	bhi.w 10ba <PrepareBackbuffer.constprop.0+0x148>
				AllocMem(sizeof(struct BitMap), MEMF_ANY | MEMF_CLEAR);
    1020:	2c79 0000 39a2 	movea.l 39a2 <SysBase>,a6
    1026:	7028           	moveq #40,d0
    1028:	7201           	moveq #1,d1
    102a:	4841           	swap d1
    102c:	4eae ff3a      	jsr -198(a6)
    1030:	2640           	movea.l d0,a3
			if (bitmap)
    1032:	4a80           	tst.l d0
    1034:	6700 0182      	beq.w 11b8 <PrepareBackbuffer.constprop.0+0x246>
				InitBitMap(bitmap, depth, width, height);
    1038:	2c79 0000 39ae 	movea.l 39ae <GfxBase>,a6
    103e:	2040           	movea.l d0,a0
    1040:	7004           	moveq #4,d0
    1042:	220d           	move.l a5,d1
    1044:	240c           	move.l a4,d2
    1046:	4eae fe7a      	jsr -390(a6)
				for (i = 0; i < bitmap->Depth; i++)
    104a:	4a2b 0005      	tst.b 5(a3)
    104e:	6730           	beq.s 1080 <PrepareBackbuffer.constprop.0+0x10e>
    1050:	4242           	clr.w d2
    1052:	95ca           	suba.l a2,a2
					bitmap->Planes[i] = AllocRaster(width, height);
    1054:	2c79 0000 39ae 	movea.l 39ae <GfxBase>,a6
    105a:	200d           	move.l a5,d0
    105c:	220c           	move.l a4,d1
    105e:	4eae fe14      	jsr -492(a6)
    1062:	220a           	move.l a2,d1
    1064:	5481           	addq.l #2,d1
    1066:	d281           	add.l d1,d1
    1068:	d281           	add.l d1,d1
    106a:	2780 1800      	move.l d0,(0,a3,d1.l)
					if (!(bitmap->Planes[i]))
    106e:	6700 00ba      	beq.w 112a <PrepareBackbuffer.constprop.0+0x1b8>
    1072:	5242           	addq.w #1,d2
				for (i = 0; i < bitmap->Depth; i++)
    1074:	3442           	movea.w d2,a2
    1076:	7000           	moveq #0,d0
    1078:	102b 0005      	move.b 5(a3),d0
    107c:	b08a           	cmp.l a2,d0
    107e:	6ed4           	bgt.s 1054 <PrepareBackbuffer.constprop.0+0xe2>
		rd->Backbuffer = MyAllocBitMap(rd->OutputSize.x, rd->OutputSize.y, ScreenD, rd->MainWindow->RPort->BitMap);
    1080:	23cb 0000 3a26 	move.l a3,3a26 <GOLRenderData+0x74>
		if (rd->Backbuffer)
		{
			/* and on success remember its size */
			rd->BackbufferSize = rd->OutputSize;
    1086:	23f9 0000 39ba 	move.l 39ba <GOLRenderData+0x8>,39be <GOLRenderData+0xc>
    108c:	0000 39be 
		}

		/* link the bitmap into our render port */
		InitRastPort(&rd->Rastport);
    1090:	2c79 0000 39ae 	movea.l 39ae <GfxBase>,a6
    1096:	43f9 0000 39c2 	lea 39c2 <GOLRenderData+0x10>,a1
    109c:	4eae ff3a      	jsr -198(a6)
		rd->Rastport.BitMap = rd->Backbuffer;
    10a0:	2679 0000 3a26 	movea.l 3a26 <GOLRenderData+0x74>,a3
    10a6:	23cb 0000 39c6 	move.l a3,39c6 <GOLRenderData+0x14>
	}

	result = rd->Backbuffer ? RETURN_OK : RETURN_ERROR;
    10ac:	b6fc 0000      	cmpa.w #0,a3
    10b0:	6770           	beq.s 1122 <PrepareBackbuffer.constprop.0+0x1b0>
    10b2:	7000           	moveq #0,d0

	return result;
    10b4:	4cdf 7c1c      	movem.l (sp)+,d2-d4/a2-a6
    10b8:	4e75           	rts
		rd->Backbuffer = MyAllocBitMap(rd->OutputSize.x, rd->OutputSize.y, ScreenD, rd->MainWindow->RPort->BitMap);
    10ba:	2079 0000 39b6 	movea.l 39b6 <GOLRenderData+0x4>,a0
    10c0:	2068 0032      	movea.l 50(a0),a0
		bitmap = AllocBitMap(width, height, depth, 0, likeBitMap);
    10c4:	200d           	move.l a5,d0
    10c6:	220c           	move.l a4,d1
    10c8:	7404           	moveq #4,d2
    10ca:	7600           	moveq #0,d3
    10cc:	2068 0004      	movea.l 4(a0),a0
    10d0:	4eae fc6a      	jsr -918(a6)
		rd->Backbuffer = MyAllocBitMap(rd->OutputSize.x, rd->OutputSize.y, ScreenD, rd->MainWindow->RPort->BitMap);
    10d4:	23c0 0000 3a26 	move.l d0,3a26 <GOLRenderData+0x74>
		if (rd->Backbuffer)
    10da:	67b4           	beq.s 1090 <PrepareBackbuffer.constprop.0+0x11e>
			rd->BackbufferSize = rd->OutputSize;
    10dc:	23f9 0000 39ba 	move.l 39ba <GOLRenderData+0x8>,39be <GOLRenderData+0xc>
    10e2:	0000 39be 
    10e6:	60a8           	bra.s 1090 <PrepareBackbuffer.constprop.0+0x11e>
    10e8:	5242           	addq.w #1,d2
		for (i = 0; i < bitmap->Depth; i++)
    10ea:	3042           	movea.w d2,a0
    10ec:	7000           	moveq #0,d0
    10ee:	1001           	move.b d1,d0
    10f0:	b088           	cmp.l a0,d0
    10f2:	6e00 fec0      	bgt.w fb4 <PrepareBackbuffer.constprop.0+0x42>
		FreeMem(bitmap, sizeof(struct BitMap));
    10f6:	2c79 0000 39a2 	movea.l 39a2 <SysBase>,a6
    10fc:	224b           	movea.l a3,a1
    10fe:	7028           	moveq #40,d0
    1100:	4eae ff2e      	jsr -210(a6)
    1104:	6000 fef6      	bra.w ffc <PrepareBackbuffer.constprop.0+0x8a>
		FreeBitMap(bitmap);
    1108:	204b           	movea.l a3,a0
    110a:	4eae fc64      	jsr -924(a6)
			rd->Backbuffer = 0;
    110e:	42b9 0000 3a26 	clr.l 3a26 <GOLRenderData+0x74>
	if (GfxBase->LibNode.lib_Version < 39)
    1114:	2c79 0000 39ae 	movea.l 39ae <GfxBase>,a6
    111a:	302e 0014      	move.w 20(a6),d0
    111e:	6000 feec      	bra.w 100c <PrepareBackbuffer.constprop.0+0x9a>
	result = rd->Backbuffer ? RETURN_OK : RETURN_ERROR;
    1122:	700a           	moveq #10,d0
    1124:	4cdf 7c1c      	movem.l (sp)+,d2-d4/a2-a6
    1128:	4e75           	rts
	if (GfxBase->LibNode.lib_Version < 39)
    112a:	2c79 0000 39ae 	movea.l 39ae <GfxBase>,a6
    1130:	0c6e 0026 0014 	cmpi.w #38,20(a6)
    1136:	6200 00a6      	bhi.w 11de <PrepareBackbuffer.constprop.0+0x26c>
		width = bitmap->BytesPerRow * 8;
    113a:	7800           	moveq #0,d4
    113c:	3813           	move.w (a3),d4
    113e:	e78c           	lsl.l #3,d4
		for (i = 0; i < bitmap->Depth; i++)
    1140:	122b 0005      	move.b 5(a3),d1
    1144:	673e           	beq.s 1184 <PrepareBackbuffer.constprop.0+0x212>
    1146:	4242           	clr.w d2
    1148:	91c8           	suba.l a0,a0
    114a:	d1c8           	adda.l a0,a0
    114c:	d1c8           	adda.l a0,a0
    114e:	45f3 8800      	lea (0,a3,a0.l),a2
			if (bitmap->Planes[i])
    1152:	206a 0008      	movea.l 8(a2),a0
    1156:	b0fc 0000      	cmpa.w #0,a0
    115a:	6700 00ae      	beq.w 120a <PrepareBackbuffer.constprop.0+0x298>
				FreeRaster(bitmap->Planes[i], width, bitmap->Rows);
    115e:	2c79 0000 39ae 	movea.l 39ae <GfxBase>,a6
    1164:	2004           	move.l d4,d0
    1166:	7200           	moveq #0,d1
    1168:	322b 0002      	move.w 2(a3),d1
    116c:	4eae fe0e      	jsr -498(a6)
				bitmap->Planes[i] = 0;
    1170:	42aa 0008      	clr.l 8(a2)
		for (i = 0; i < bitmap->Depth; i++)
    1174:	122b 0005      	move.b 5(a3),d1
    1178:	5242           	addq.w #1,d2
    117a:	3042           	movea.w d2,a0
    117c:	7600           	moveq #0,d3
    117e:	1601           	move.b d1,d3
    1180:	b1c3           	cmpa.l d3,a0
    1182:	6dc6           	blt.s 114a <PrepareBackbuffer.constprop.0+0x1d8>
		FreeMem(bitmap, sizeof(struct BitMap));
    1184:	2c79 0000 39a2 	movea.l 39a2 <SysBase>,a6
    118a:	224b           	movea.l a3,a1
    118c:	7028           	moveq #40,d0
    118e:	4eae ff2e      	jsr -210(a6)
		rd->Backbuffer = MyAllocBitMap(rd->OutputSize.x, rd->OutputSize.y, ScreenD, rd->MainWindow->RPort->BitMap);
    1192:	42b9 0000 3a26 	clr.l 3a26 <GOLRenderData+0x74>
		InitRastPort(&rd->Rastport);
    1198:	2c79 0000 39ae 	movea.l 39ae <GfxBase>,a6
    119e:	43f9 0000 39c2 	lea 39c2 <GOLRenderData+0x10>,a1
    11a4:	4eae ff3a      	jsr -198(a6)
		rd->Rastport.BitMap = rd->Backbuffer;
    11a8:	2679 0000 3a26 	movea.l 3a26 <GOLRenderData+0x74>,a3
    11ae:	23cb 0000 39c6 	move.l a3,39c6 <GOLRenderData+0x14>
    11b4:	6000 fef6      	bra.w 10ac <PrepareBackbuffer.constprop.0+0x13a>
		rd->Backbuffer = MyAllocBitMap(rd->OutputSize.x, rd->OutputSize.y, ScreenD, rd->MainWindow->RPort->BitMap);
    11b8:	42b9 0000 3a26 	clr.l 3a26 <GOLRenderData+0x74>
		InitRastPort(&rd->Rastport);
    11be:	2c79 0000 39ae 	movea.l 39ae <GfxBase>,a6
    11c4:	43f9 0000 39c2 	lea 39c2 <GOLRenderData+0x10>,a1
    11ca:	4eae ff3a      	jsr -198(a6)
		rd->Rastport.BitMap = rd->Backbuffer;
    11ce:	2679 0000 3a26 	movea.l 3a26 <GOLRenderData+0x74>,a3
    11d4:	23cb 0000 39c6 	move.l a3,39c6 <GOLRenderData+0x14>
    11da:	6000 fed0      	bra.w 10ac <PrepareBackbuffer.constprop.0+0x13a>
		FreeBitMap(bitmap);
    11de:	204b           	movea.l a3,a0
    11e0:	4eae fc64      	jsr -924(a6)
		rd->Backbuffer = MyAllocBitMap(rd->OutputSize.x, rd->OutputSize.y, ScreenD, rd->MainWindow->RPort->BitMap);
    11e4:	42b9 0000 3a26 	clr.l 3a26 <GOLRenderData+0x74>
		InitRastPort(&rd->Rastport);
    11ea:	2c79 0000 39ae 	movea.l 39ae <GfxBase>,a6
    11f0:	43f9 0000 39c2 	lea 39c2 <GOLRenderData+0x10>,a1
    11f6:	4eae ff3a      	jsr -198(a6)
		rd->Rastport.BitMap = rd->Backbuffer;
    11fa:	2679 0000 3a26 	movea.l 3a26 <GOLRenderData+0x74>,a3
    1200:	23cb 0000 39c6 	move.l a3,39c6 <GOLRenderData+0x14>
    1206:	6000 fea4      	bra.w 10ac <PrepareBackbuffer.constprop.0+0x13a>
    120a:	5242           	addq.w #1,d2
		for (i = 0; i < bitmap->Depth; i++)
    120c:	3042           	movea.w d2,a0
    120e:	7000           	moveq #0,d0
    1210:	1001           	move.b d1,d0
    1212:	b088           	cmp.l a0,d0
    1214:	6e00 ff34      	bgt.w 114a <PrepareBackbuffer.constprop.0+0x1d8>
		FreeMem(bitmap, sizeof(struct BitMap));
    1218:	2c79 0000 39a2 	movea.l 39a2 <SysBase>,a6
    121e:	224b           	movea.l a3,a1
    1220:	7028           	moveq #40,d0
    1222:	4eae ff2e      	jsr -210(a6)
		rd->Backbuffer = MyAllocBitMap(rd->OutputSize.x, rd->OutputSize.y, ScreenD, rd->MainWindow->RPort->BitMap);
    1226:	42b9 0000 3a26 	clr.l 3a26 <GOLRenderData+0x74>
    122c:	6000 ff6a      	bra.w 1198 <PrepareBackbuffer.constprop.0+0x226>

00001230 <memset.constprop.0>:
	void* memset(void *dest, int val, unsigned long len)
    1230:	2f0a           	move.l a2,-(sp)
    1232:	2f02           	move.l d2,-(sp)
    1234:	202f 000c      	move.l 12(sp),d0
    1238:	206f 0014      	movea.l 20(sp),a0
	while(len-- > 0)
    123c:	43e8 ffff      	lea -1(a0),a1
    1240:	b0fc 0000      	cmpa.w #0,a0
    1244:	6700 0096      	beq.w 12dc <memset.constprop.0+0xac>
    1248:	2200           	move.l d0,d1
    124a:	4481           	neg.l d1
    124c:	7403           	moveq #3,d2
    124e:	c282           	and.l d2,d1
    1250:	7405           	moveq #5,d2
		*ptr++ = val;
    1252:	2440           	movea.l d0,a2
    1254:	b489           	cmp.l a1,d2
    1256:	6450           	bcc.s 12a8 <memset.constprop.0+0x78>
    1258:	4a81           	tst.l d1
    125a:	672c           	beq.s 1288 <memset.constprop.0+0x58>
    125c:	421a           	clr.b (a2)+
	while(len-- > 0)
    125e:	43e8 fffe      	lea -2(a0),a1
    1262:	7401           	moveq #1,d2
    1264:	b481           	cmp.l d1,d2
    1266:	6720           	beq.s 1288 <memset.constprop.0+0x58>
		*ptr++ = val;
    1268:	2440           	movea.l d0,a2
    126a:	548a           	addq.l #2,a2
    126c:	2240           	movea.l d0,a1
    126e:	4229 0001      	clr.b 1(a1)
	while(len-- > 0)
    1272:	43e8 fffd      	lea -3(a0),a1
    1276:	7403           	moveq #3,d2
    1278:	b481           	cmp.l d1,d2
    127a:	660c           	bne.s 1288 <memset.constprop.0+0x58>
		*ptr++ = val;
    127c:	528a           	addq.l #1,a2
    127e:	2240           	movea.l d0,a1
    1280:	4229 0002      	clr.b 2(a1)
	while(len-- > 0)
    1284:	43e8 fffc      	lea -4(a0),a1
    1288:	2408           	move.l a0,d2
    128a:	9481           	sub.l d1,d2
    128c:	2040           	movea.l d0,a0
    128e:	d1c1           	adda.l d1,a0
    1290:	72fc           	moveq #-4,d1
    1292:	c282           	and.l d2,d1
    1294:	d288           	add.l a0,d1
		*ptr++ = val;
    1296:	4298           	clr.l (a0)+
    1298:	b1c1           	cmpa.l d1,a0
    129a:	66fa           	bne.s 1296 <memset.constprop.0+0x66>
    129c:	72fc           	moveq #-4,d1
    129e:	c282           	and.l d2,d1
    12a0:	d5c1           	adda.l d1,a2
    12a2:	93c1           	suba.l d1,a1
    12a4:	b282           	cmp.l d2,d1
    12a6:	6734           	beq.s 12dc <memset.constprop.0+0xac>
    12a8:	4212           	clr.b (a2)
	while(len-- > 0)
    12aa:	b2fc 0000      	cmpa.w #0,a1
    12ae:	672c           	beq.s 12dc <memset.constprop.0+0xac>
		*ptr++ = val;
    12b0:	422a 0001      	clr.b 1(a2)
	while(len-- > 0)
    12b4:	7201           	moveq #1,d1
    12b6:	b289           	cmp.l a1,d1
    12b8:	6722           	beq.s 12dc <memset.constprop.0+0xac>
		*ptr++ = val;
    12ba:	422a 0002      	clr.b 2(a2)
	while(len-- > 0)
    12be:	7402           	moveq #2,d2
    12c0:	b489           	cmp.l a1,d2
    12c2:	6718           	beq.s 12dc <memset.constprop.0+0xac>
		*ptr++ = val;
    12c4:	422a 0003      	clr.b 3(a2)
	while(len-- > 0)
    12c8:	7203           	moveq #3,d1
    12ca:	b289           	cmp.l a1,d1
    12cc:	670e           	beq.s 12dc <memset.constprop.0+0xac>
		*ptr++ = val;
    12ce:	422a 0004      	clr.b 4(a2)
	while(len-- > 0)
    12d2:	7404           	moveq #4,d2
    12d4:	b489           	cmp.l a1,d2
    12d6:	6704           	beq.s 12dc <memset.constprop.0+0xac>
		*ptr++ = val;
    12d8:	422a 0005      	clr.b 5(a2)
}
    12dc:	241f           	move.l (sp)+,d2
    12de:	245f           	movea.l (sp)+,a2
    12e0:	4e75           	rts

000012e2 <strlen>:
{
    12e2:	206f 0004      	movea.l 4(sp),a0
	unsigned long t=0;
    12e6:	7000           	moveq #0,d0
	while(*s++)
    12e8:	4a10           	tst.b (a0)
    12ea:	6708           	beq.s 12f4 <strlen+0x12>
		t++;
    12ec:	5280           	addq.l #1,d0
	while(*s++)
    12ee:	4a30 0800      	tst.b (0,a0,d0.l)
    12f2:	66f8           	bne.s 12ec <strlen+0xa>
}
    12f4:	4e75           	rts

000012f6 <memset>:
{
    12f6:	48e7 3f30      	movem.l d2-d7/a2-a3,-(sp)
    12fa:	202f 0024      	move.l 36(sp),d0
    12fe:	282f 0028      	move.l 40(sp),d4
    1302:	226f 002c      	movea.l 44(sp),a1
	while(len-- > 0)
    1306:	2a09           	move.l a1,d5
    1308:	5385           	subq.l #1,d5
    130a:	b2fc 0000      	cmpa.w #0,a1
    130e:	6700 00ae      	beq.w 13be <memset+0xc8>
		*ptr++ = val;
    1312:	1e04           	move.b d4,d7
    1314:	2200           	move.l d0,d1
    1316:	4481           	neg.l d1
    1318:	7403           	moveq #3,d2
    131a:	c282           	and.l d2,d1
    131c:	7c05           	moveq #5,d6
    131e:	2440           	movea.l d0,a2
    1320:	bc85           	cmp.l d5,d6
    1322:	646a           	bcc.s 138e <memset+0x98>
    1324:	4a81           	tst.l d1
    1326:	6724           	beq.s 134c <memset+0x56>
    1328:	14c4           	move.b d4,(a2)+
	while(len-- > 0)
    132a:	5385           	subq.l #1,d5
    132c:	7401           	moveq #1,d2
    132e:	b481           	cmp.l d1,d2
    1330:	671a           	beq.s 134c <memset+0x56>
		*ptr++ = val;
    1332:	2440           	movea.l d0,a2
    1334:	548a           	addq.l #2,a2
    1336:	2040           	movea.l d0,a0
    1338:	1144 0001      	move.b d4,1(a0)
	while(len-- > 0)
    133c:	5385           	subq.l #1,d5
    133e:	7403           	moveq #3,d2
    1340:	b481           	cmp.l d1,d2
    1342:	6608           	bne.s 134c <memset+0x56>
		*ptr++ = val;
    1344:	528a           	addq.l #1,a2
    1346:	1144 0002      	move.b d4,2(a0)
	while(len-- > 0)
    134a:	5385           	subq.l #1,d5
    134c:	2609           	move.l a1,d3
    134e:	9681           	sub.l d1,d3
    1350:	7c00           	moveq #0,d6
    1352:	1c04           	move.b d4,d6
    1354:	2406           	move.l d6,d2
    1356:	4842           	swap d2
    1358:	4242           	clr.w d2
    135a:	2042           	movea.l d2,a0
    135c:	2404           	move.l d4,d2
    135e:	e14a           	lsl.w #8,d2
    1360:	4842           	swap d2
    1362:	4242           	clr.w d2
    1364:	e18e           	lsl.l #8,d6
    1366:	2646           	movea.l d6,a3
    1368:	2c08           	move.l a0,d6
    136a:	8486           	or.l d6,d2
    136c:	2c0b           	move.l a3,d6
    136e:	8486           	or.l d6,d2
    1370:	1407           	move.b d7,d2
    1372:	2040           	movea.l d0,a0
    1374:	d1c1           	adda.l d1,a0
    1376:	72fc           	moveq #-4,d1
    1378:	c283           	and.l d3,d1
    137a:	d288           	add.l a0,d1
		*ptr++ = val;
    137c:	20c2           	move.l d2,(a0)+
	while(len-- > 0)
    137e:	b1c1           	cmpa.l d1,a0
    1380:	66fa           	bne.s 137c <memset+0x86>
    1382:	72fc           	moveq #-4,d1
    1384:	c283           	and.l d3,d1
    1386:	d5c1           	adda.l d1,a2
    1388:	9a81           	sub.l d1,d5
    138a:	b283           	cmp.l d3,d1
    138c:	6730           	beq.s 13be <memset+0xc8>
		*ptr++ = val;
    138e:	1484           	move.b d4,(a2)
	while(len-- > 0)
    1390:	4a85           	tst.l d5
    1392:	672a           	beq.s 13be <memset+0xc8>
		*ptr++ = val;
    1394:	1544 0001      	move.b d4,1(a2)
	while(len-- > 0)
    1398:	7201           	moveq #1,d1
    139a:	b285           	cmp.l d5,d1
    139c:	6720           	beq.s 13be <memset+0xc8>
		*ptr++ = val;
    139e:	1544 0002      	move.b d4,2(a2)
	while(len-- > 0)
    13a2:	7402           	moveq #2,d2
    13a4:	b485           	cmp.l d5,d2
    13a6:	6716           	beq.s 13be <memset+0xc8>
		*ptr++ = val;
    13a8:	1544 0003      	move.b d4,3(a2)
	while(len-- > 0)
    13ac:	7c03           	moveq #3,d6
    13ae:	bc85           	cmp.l d5,d6
    13b0:	670c           	beq.s 13be <memset+0xc8>
		*ptr++ = val;
    13b2:	1544 0004      	move.b d4,4(a2)
	while(len-- > 0)
    13b6:	5985           	subq.l #4,d5
    13b8:	6704           	beq.s 13be <memset+0xc8>
		*ptr++ = val;
    13ba:	1544 0005      	move.b d4,5(a2)
}
    13be:	4cdf 0cfc      	movem.l (sp)+,d2-d7/a2-a3
    13c2:	4e75           	rts

000013c4 <memcpy>:
{
    13c4:	48e7 3e00      	movem.l d2-d6,-(sp)
    13c8:	202f 0018      	move.l 24(sp),d0
    13cc:	222f 001c      	move.l 28(sp),d1
    13d0:	262f 0020      	move.l 32(sp),d3
	while(len--)
    13d4:	2803           	move.l d3,d4
    13d6:	5384           	subq.l #1,d4
    13d8:	4a83           	tst.l d3
    13da:	675e           	beq.s 143a <memcpy+0x76>
    13dc:	2041           	movea.l d1,a0
    13de:	5288           	addq.l #1,a0
    13e0:	2400           	move.l d0,d2
    13e2:	9488           	sub.l a0,d2
    13e4:	7a02           	moveq #2,d5
    13e6:	ba82           	cmp.l d2,d5
    13e8:	55c2           	sc.s d2
    13ea:	4402           	neg.b d2
    13ec:	7c08           	moveq #8,d6
    13ee:	bc84           	cmp.l d4,d6
    13f0:	55c5           	sc.s d5
    13f2:	4405           	neg.b d5
    13f4:	c405           	and.b d5,d2
    13f6:	6748           	beq.s 1440 <memcpy+0x7c>
    13f8:	2400           	move.l d0,d2
    13fa:	8481           	or.l d1,d2
    13fc:	7a03           	moveq #3,d5
    13fe:	c485           	and.l d5,d2
    1400:	663e           	bne.s 1440 <memcpy+0x7c>
    1402:	2041           	movea.l d1,a0
    1404:	2240           	movea.l d0,a1
    1406:	74fc           	moveq #-4,d2
    1408:	c483           	and.l d3,d2
    140a:	d481           	add.l d1,d2
		*d++ = *s++;
    140c:	22d8           	move.l (a0)+,(a1)+
	while(len--)
    140e:	b488           	cmp.l a0,d2
    1410:	66fa           	bne.s 140c <memcpy+0x48>
    1412:	74fc           	moveq #-4,d2
    1414:	c483           	and.l d3,d2
    1416:	2040           	movea.l d0,a0
    1418:	d1c2           	adda.l d2,a0
    141a:	d282           	add.l d2,d1
    141c:	9882           	sub.l d2,d4
    141e:	b483           	cmp.l d3,d2
    1420:	6718           	beq.s 143a <memcpy+0x76>
		*d++ = *s++;
    1422:	2241           	movea.l d1,a1
    1424:	1091           	move.b (a1),(a0)
	while(len--)
    1426:	4a84           	tst.l d4
    1428:	6710           	beq.s 143a <memcpy+0x76>
		*d++ = *s++;
    142a:	1169 0001 0001 	move.b 1(a1),1(a0)
	while(len--)
    1430:	5384           	subq.l #1,d4
    1432:	6706           	beq.s 143a <memcpy+0x76>
		*d++ = *s++;
    1434:	1169 0002 0002 	move.b 2(a1),2(a0)
}
    143a:	4cdf 007c      	movem.l (sp)+,d2-d6
    143e:	4e75           	rts
    1440:	2240           	movea.l d0,a1
    1442:	d283           	add.l d3,d1
		*d++ = *s++;
    1444:	12e8 ffff      	move.b -1(a0),(a1)+
	while(len--)
    1448:	b288           	cmp.l a0,d1
    144a:	67ee           	beq.s 143a <memcpy+0x76>
    144c:	5288           	addq.l #1,a0
    144e:	60f4           	bra.s 1444 <memcpy+0x80>

00001450 <memmove>:
{
    1450:	48e7 3c20      	movem.l d2-d5/a2,-(sp)
    1454:	202f 0018      	move.l 24(sp),d0
    1458:	222f 001c      	move.l 28(sp),d1
    145c:	242f 0020      	move.l 32(sp),d2
		while (len--)
    1460:	2242           	movea.l d2,a1
    1462:	5389           	subq.l #1,a1
	if (d < s) {
    1464:	b280           	cmp.l d0,d1
    1466:	636c           	bls.s 14d4 <memmove+0x84>
		while (len--)
    1468:	4a82           	tst.l d2
    146a:	6762           	beq.s 14ce <memmove+0x7e>
    146c:	2441           	movea.l d1,a2
    146e:	528a           	addq.l #1,a2
    1470:	2600           	move.l d0,d3
    1472:	968a           	sub.l a2,d3
    1474:	7802           	moveq #2,d4
    1476:	b883           	cmp.l d3,d4
    1478:	55c3           	sc.s d3
    147a:	4403           	neg.b d3
    147c:	7a08           	moveq #8,d5
    147e:	ba89           	cmp.l a1,d5
    1480:	55c4           	sc.s d4
    1482:	4404           	neg.b d4
    1484:	c604           	and.b d4,d3
    1486:	6770           	beq.s 14f8 <memmove+0xa8>
    1488:	2600           	move.l d0,d3
    148a:	8681           	or.l d1,d3
    148c:	7803           	moveq #3,d4
    148e:	c684           	and.l d4,d3
    1490:	6666           	bne.s 14f8 <memmove+0xa8>
    1492:	2041           	movea.l d1,a0
    1494:	2440           	movea.l d0,a2
    1496:	76fc           	moveq #-4,d3
    1498:	c682           	and.l d2,d3
    149a:	d681           	add.l d1,d3
			*d++ = *s++;
    149c:	24d8           	move.l (a0)+,(a2)+
		while (len--)
    149e:	b688           	cmp.l a0,d3
    14a0:	66fa           	bne.s 149c <memmove+0x4c>
    14a2:	76fc           	moveq #-4,d3
    14a4:	c682           	and.l d2,d3
    14a6:	2440           	movea.l d0,a2
    14a8:	d5c3           	adda.l d3,a2
    14aa:	2041           	movea.l d1,a0
    14ac:	d1c3           	adda.l d3,a0
    14ae:	93c3           	suba.l d3,a1
    14b0:	b682           	cmp.l d2,d3
    14b2:	671a           	beq.s 14ce <memmove+0x7e>
			*d++ = *s++;
    14b4:	1490           	move.b (a0),(a2)
		while (len--)
    14b6:	b2fc 0000      	cmpa.w #0,a1
    14ba:	6712           	beq.s 14ce <memmove+0x7e>
			*d++ = *s++;
    14bc:	1568 0001 0001 	move.b 1(a0),1(a2)
		while (len--)
    14c2:	7a01           	moveq #1,d5
    14c4:	ba89           	cmp.l a1,d5
    14c6:	6706           	beq.s 14ce <memmove+0x7e>
			*d++ = *s++;
    14c8:	1568 0002 0002 	move.b 2(a0),2(a2)
}
    14ce:	4cdf 043c      	movem.l (sp)+,d2-d5/a2
    14d2:	4e75           	rts
		const char *lasts = s + (len - 1);
    14d4:	41f1 1800      	lea (0,a1,d1.l),a0
		char *lastd = d + (len - 1);
    14d8:	d3c0           	adda.l d0,a1
		while (len--)
    14da:	4a82           	tst.l d2
    14dc:	67f0           	beq.s 14ce <memmove+0x7e>
    14de:	2208           	move.l a0,d1
    14e0:	9282           	sub.l d2,d1
			*lastd-- = *lasts--;
    14e2:	1290           	move.b (a0),(a1)
		while (len--)
    14e4:	5388           	subq.l #1,a0
    14e6:	5389           	subq.l #1,a1
    14e8:	b288           	cmp.l a0,d1
    14ea:	67e2           	beq.s 14ce <memmove+0x7e>
			*lastd-- = *lasts--;
    14ec:	1290           	move.b (a0),(a1)
		while (len--)
    14ee:	5388           	subq.l #1,a0
    14f0:	5389           	subq.l #1,a1
    14f2:	b288           	cmp.l a0,d1
    14f4:	66ec           	bne.s 14e2 <memmove+0x92>
    14f6:	60d6           	bra.s 14ce <memmove+0x7e>
    14f8:	2240           	movea.l d0,a1
    14fa:	d282           	add.l d2,d1
			*d++ = *s++;
    14fc:	12ea ffff      	move.b -1(a2),(a1)+
		while (len--)
    1500:	b28a           	cmp.l a2,d1
    1502:	67ca           	beq.s 14ce <memmove+0x7e>
    1504:	528a           	addq.l #1,a2
    1506:	60f4           	bra.s 14fc <memmove+0xac>

00001508 <__mulsi3>:
	.text
	FUNC(__mulsi3)
	.globl	SYM (__mulsi3)
SYM (__mulsi3):
	.cfi_startproc
	movew	sp@(4), d0	/* x0 -> d0 */
    1508:	302f 0004      	move.w 4(sp),d0
	muluw	sp@(10), d0	/* x0*y1 */
    150c:	c0ef 000a      	mulu.w 10(sp),d0
	movew	sp@(6), d1	/* x1 -> d1 */
    1510:	322f 0006      	move.w 6(sp),d1
	muluw	sp@(8), d1	/* x1*y0 */
    1514:	c2ef 0008      	mulu.w 8(sp),d1
	addw	d1, d0
    1518:	d041           	add.w d1,d0
	swap	d0
    151a:	4840           	swap d0
	clrw	d0
    151c:	4240           	clr.w d0
	movew	sp@(6), d1	/* x1 -> d1 */
    151e:	322f 0006      	move.w 6(sp),d1
	muluw	sp@(10), d1	/* x1*y1 */
    1522:	c2ef 000a      	mulu.w 10(sp),d1
	addl	d1, d0
    1526:	d081           	add.l d1,d0
	rts
    1528:	4e75           	rts

0000152a <__udivsi3>:
	.text
	FUNC(__udivsi3)
	.globl	SYM (__udivsi3)
SYM (__udivsi3):
	.cfi_startproc
	movel	d2, sp@-
    152a:	2f02           	move.l d2,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	sp@(12), d1	/* d1 = divisor */
    152c:	222f 000c      	move.l 12(sp),d1
	movel	sp@(8), d0	/* d0 = dividend */
    1530:	202f 0008      	move.l 8(sp),d0

	cmpl	IMM (0x10000), d1 /* divisor >= 2 ^ 16 ?   */
    1534:	0c81 0001 0000 	cmpi.l #65536,d1
	jcc	3f		/* then try next algorithm */
    153a:	6416           	bcc.s 1552 <__udivsi3+0x28>
	movel	d0, d2
    153c:	2400           	move.l d0,d2
	clrw	d2
    153e:	4242           	clr.w d2
	swap	d2
    1540:	4842           	swap d2
	divu	d1, d2          /* high quotient in lower word */
    1542:	84c1           	divu.w d1,d2
	movew	d2, d0		/* save high quotient */
    1544:	3002           	move.w d2,d0
	swap	d0
    1546:	4840           	swap d0
	movew	sp@(10), d2	/* get low dividend + high rest */
    1548:	342f 000a      	move.w 10(sp),d2
	divu	d1, d2		/* low quotient */
    154c:	84c1           	divu.w d1,d2
	movew	d2, d0
    154e:	3002           	move.w d2,d0
	jra	6f
    1550:	6030           	bra.s 1582 <__udivsi3+0x58>

3:	movel	d1, d2		/* use d2 as divisor backup */
    1552:	2401           	move.l d1,d2
4:	lsrl	IMM (1), d1	/* shift divisor */
    1554:	e289           	lsr.l #1,d1
	lsrl	IMM (1), d0	/* shift dividend */
    1556:	e288           	lsr.l #1,d0
	cmpl	IMM (0x10000), d1 /* still divisor >= 2 ^ 16 ?  */
    1558:	0c81 0001 0000 	cmpi.l #65536,d1
	jcc	4b
    155e:	64f4           	bcc.s 1554 <__udivsi3+0x2a>
	divu	d1, d0		/* now we have 16-bit divisor */
    1560:	80c1           	divu.w d1,d0
	andl	IMM (0xffff), d0 /* mask out divisor, ignore remainder */
    1562:	0280 0000 ffff 	andi.l #65535,d0

/* Multiply the 16-bit tentative quotient with the 32-bit divisor.  Because of
   the operand ranges, this might give a 33-bit product.  If this product is
   greater than the dividend, the tentative quotient was too large. */
	movel	d2, d1
    1568:	2202           	move.l d2,d1
	mulu	d0, d1		/* low part, 32 bits */
    156a:	c2c0           	mulu.w d0,d1
	swap	d2
    156c:	4842           	swap d2
	mulu	d0, d2		/* high part, at most 17 bits */
    156e:	c4c0           	mulu.w d0,d2
	swap	d2		/* align high part with low part */
    1570:	4842           	swap d2
	tstw	d2		/* high part 17 bits? */
    1572:	4a42           	tst.w d2
	jne	5f		/* if 17 bits, quotient was too large */
    1574:	660a           	bne.s 1580 <__udivsi3+0x56>
	addl	d2, d1		/* add parts */
    1576:	d282           	add.l d2,d1
	jcs	5f		/* if sum is 33 bits, quotient was too large */
    1578:	6506           	bcs.s 1580 <__udivsi3+0x56>
	cmpl	sp@(8), d1	/* compare the sum with the dividend */
    157a:	b2af 0008      	cmp.l 8(sp),d1
	jls	6f		/* if sum > dividend, quotient was too large */
    157e:	6302           	bls.s 1582 <__udivsi3+0x58>
5:	subql	IMM (1), d0	/* adjust quotient */
    1580:	5380           	subq.l #1,d0

6:	movel	sp@+, d2
    1582:	241f           	move.l (sp)+,d2
	.cfi_adjust_cfa_offset -4
	rts
    1584:	4e75           	rts

00001586 <__divsi3>:
	.text
	FUNC(__divsi3)
	.globl	SYM (__divsi3)
SYM (__divsi3):
	.cfi_startproc
	movel	d2, sp@-
    1586:	2f02           	move.l d2,-(sp)
	.cfi_adjust_cfa_offset 4

	moveq	IMM (1), d2	/* sign of result stored in d2 (=1 or =-1) */
    1588:	7401           	moveq #1,d2
	movel	sp@(12), d1	/* d1 = divisor */
    158a:	222f 000c      	move.l 12(sp),d1
	jpl	1f
    158e:	6a04           	bpl.s 1594 <__divsi3+0xe>
	negl	d1
    1590:	4481           	neg.l d1
	negb	d2		/* change sign because divisor <0  */
    1592:	4402           	neg.b d2
1:	movel	sp@(8), d0	/* d0 = dividend */
    1594:	202f 0008      	move.l 8(sp),d0
	jpl	2f
    1598:	6a04           	bpl.s 159e <__divsi3+0x18>
	negl	d0
    159a:	4480           	neg.l d0
	negb	d2
    159c:	4402           	neg.b d2

2:	movel	d1, sp@-
    159e:	2f01           	move.l d1,-(sp)
	movel	d0, sp@-
    15a0:	2f00           	move.l d0,-(sp)
	PICCALL	SYM (__udivsi3)	/* divide abs(dividend) by abs(divisor) */
    15a2:	6186           	bsr.s 152a <__udivsi3>
	addql	IMM (8), sp
    15a4:	508f           	addq.l #8,sp

	tstb	d2
    15a6:	4a02           	tst.b d2
	jpl	3f
    15a8:	6a02           	bpl.s 15ac <__divsi3+0x26>
	negl	d0
    15aa:	4480           	neg.l d0

3:	movel	sp@+, d2
    15ac:	241f           	move.l (sp)+,d2
	.cfi_adjust_cfa_offset -4
	rts
    15ae:	4e75           	rts

000015b0 <__modsi3>:
	.text
	FUNC(__modsi3)
	.globl	SYM (__modsi3)
SYM (__modsi3):
	.cfi_startproc
	movel	sp@(8), d1	/* d1 = divisor */
    15b0:	222f 0008      	move.l 8(sp),d1
	movel	sp@(4), d0	/* d0 = dividend */
    15b4:	202f 0004      	move.l 4(sp),d0
	movel	d1, sp@-
    15b8:	2f01           	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    15ba:	2f00           	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	PICCALL	SYM (__divsi3)
    15bc:	61c8           	bsr.s 1586 <__divsi3>
	addql	IMM (8), sp
    15be:	508f           	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(8), d1	/* d1 = divisor */
    15c0:	222f 0008      	move.l 8(sp),d1
	movel	d1, sp@-
    15c4:	2f01           	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    15c6:	2f00           	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	PICCALL	SYM (__mulsi3)	/* d0 = (a/b)*b */
    15c8:	6100 ff3e      	bsr.w 1508 <__mulsi3>
	addql	IMM (8), sp
    15cc:	508f           	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(4), d1	/* d1 = dividend */
    15ce:	222f 0004      	move.l 4(sp),d1
	subl	d0, d1		/* d1 = a - (a/b)*b */
    15d2:	9280           	sub.l d0,d1
	movel	d1, d0
    15d4:	2001           	move.l d1,d0
	rts
    15d6:	4e75           	rts

000015d8 <__umodsi3>:
	.text
	FUNC(__umodsi3)
	.globl	SYM (__umodsi3)
SYM (__umodsi3):
	.cfi_startproc
	movel	sp@(8), d1	/* d1 = divisor */
    15d8:	222f 0008      	move.l 8(sp),d1
	movel	sp@(4), d0	/* d0 = dividend */
    15dc:	202f 0004      	move.l 4(sp),d0
	movel	d1, sp@-
    15e0:	2f01           	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    15e2:	2f00           	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	PICCALL	SYM (__udivsi3)
    15e4:	6100 ff44      	bsr.w 152a <__udivsi3>
	addql	IMM (8), sp
    15e8:	508f           	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(8), d1	/* d1 = divisor */
    15ea:	222f 0008      	move.l 8(sp),d1
	movel	d1, sp@-
    15ee:	2f01           	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    15f0:	2f00           	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	PICCALL	SYM (__mulsi3)	/* d0 = (a/b)*b */
    15f2:	6100 ff14      	bsr.w 1508 <__mulsi3>
	addql	IMM (8), sp
    15f6:	508f           	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(4), d1	/* d1 = dividend */
    15f8:	222f 0004      	move.l 4(sp),d1
	subl	d0, d1		/* d1 = a - (a/b)*b */
    15fc:	9280           	sub.l d0,d1
	movel	d1, d0
    15fe:	2001           	move.l d1,d0
	rts
    1600:	4e75           	rts

00001602 <KPutCharX>:
	FUNC(KPutCharX)
	.globl	SYM (KPutCharX)

SYM(KPutCharX):
	.cfi_startproc
    move.l  a6, -(sp)
    1602:	2f0e           	move.l a6,-(sp)
	.cfi_adjust_cfa_offset 4
    move.l  4.w, a6
    1604:	2c78 0004      	movea.l 4 <_start+0x4>,a6
    jsr     -0x204(a6)
    1608:	4eae fdfc      	jsr -516(a6)
    movea.l (sp)+, a6
    160c:	2c5f           	movea.l (sp)+,a6
	.cfi_adjust_cfa_offset -4
    rts
    160e:	4e75           	rts

00001610 <PutChar>:
	FUNC(PutChar)
	.globl	SYM (PutChar)

SYM(PutChar):
	.cfi_startproc
	move.b d0, (a3)+
    1610:	16c0           	move.b d0,(a3)+
	rts
    1612:	4e75           	rts
