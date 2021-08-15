
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
       4:	263c 0000 348c 	move.l #13452,d3
       a:	0483 0000 348c 	subi.l #13452,d3
      10:	e483           	asr.l #2,d3
	for (i = 0; i < count; i++)
      12:	6712           	beq.s 26 <_start+0x26>
      14:	45f9 0000 348c 	lea 348c <GolMainMenu>,a2
      1a:	7400           	moveq #0,d2
		__preinit_array_start[i]();
      1c:	205a           	movea.l (a2)+,a0
      1e:	4e90           	jsr (a0)
	for (i = 0; i < count; i++)
      20:	5282           	addq.l #1,d2
      22:	b483           	cmp.l d3,d2
      24:	66f6           	bne.s 1c <_start+0x1c>

	count = __init_array_end - __init_array_start;
      26:	263c 0000 348c 	move.l #13452,d3
      2c:	0483 0000 348c 	subi.l #13452,d3
      32:	e483           	asr.l #2,d3
	for (i = 0; i < count; i++)
      34:	6712           	beq.s 48 <_start+0x48>
      36:	45f9 0000 348c 	lea 348c <GolMainMenu>,a2
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
      4e:	243c 0000 348c 	move.l #13452,d2
      54:	0482 0000 348c 	subi.l #13452,d2
      5a:	e482           	asr.l #2,d2
	for (i = count; i > 0; i--)
      5c:	6710           	beq.s 6e <_start+0x6e>
      5e:	45f9 0000 348c 	lea 348c <GolMainMenu>,a2
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
	GameMatrix.ColorDead = 15;
	GameMatrix.Columns = 100;
	GameMatrix.Rows = 40;
      7c:	23fc 0028 0064 	move.l #2621540,36d4 <GameMatrix+0x8>
      82:	0000 36d4 
      86:	23fc 0004 000f 	move.l #262159,36d8 <GameMatrix+0xc>
      8c:	0000 36d8 
      90:	23fc 0005 0005 	move.l #327685,36dc <GameMatrix+0x10>
      96:	0000 36dc 
	return RETURN_OK;
}

int StartApp()
{
	SysBase = *((struct ExecBase **)4UL);
      9a:	2c78 0004      	movea.l 4 <_start+0x4>,a6
      9e:	23ce 0000 36ba 	move.l a6,36ba <SysBase>
	custom = (struct Custom *)0xdff000;
	unsigned int pens[] = {~0};
      a4:	70ff           	moveq #-1,d0
      a6:	2f40 003c      	move.l d0,60(sp)
	APTR *my_VisualInfo;
	
	if ((DOSBase = (struct DosLibrary *)OpenLibrary((CONST_STRPTR) "dos.library", 0)))
      aa:	43f9 0000 1358 	lea 1358 <PutChar+0x4>,a1
      b0:	7000           	moveq #0,d0
      b2:	4eae fdd8      	jsr -552(a6)
      b6:	23c0 0000 36a4 	move.l d0,36a4 <DOSBase>
      bc:	6700 064e      	beq.w 70c <main+0x698>
	{
		if ((GfxBase = (struct GfxBase *)OpenLibrary((CONST_STRPTR) "graphics.library", 0)))
      c0:	2c79 0000 36ba 	movea.l 36ba <SysBase>,a6
      c6:	43f9 0000 1364 	lea 1364 <PutChar+0x10>,a1
      cc:	7000           	moveq #0,d0
      ce:	4eae fdd8      	jsr -552(a6)
      d2:	23c0 0000 36a0 	move.l d0,36a0 <GfxBase>
      d8:	6700 0632      	beq.w 70c <main+0x698>
		{
			if ((IntuitionBase = (struct IntuitionBase *)OpenLibrary((CONST_STRPTR) "intuition.library", 0)))
      dc:	2c79 0000 36ba 	movea.l 36ba <SysBase>,a6
      e2:	43f9 0000 1375 	lea 1375 <PutChar+0x21>,a1
      e8:	7000           	moveq #0,d0
      ea:	4eae fdd8      	jsr -552(a6)
      ee:	2c40           	movea.l d0,a6
      f0:	23c0 0000 36a8 	move.l d0,36a8 <IntuitionBase>
      f6:	6700 0614      	beq.w 70c <main+0x698>
			{
				if ((GolScreen = (struct Screen *)OpenScreenTags(NULL,
      fa:	2f7c 8000 003a 	move.l #-2147483590,64(sp)
     100:	0040 
     102:	703c           	moveq #60,d0
     104:	d08f           	add.l sp,d0
     106:	2f40 0044      	move.l d0,68(sp)
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
     130:	7001           	moveq #1,d0
     132:	2f40 005c      	move.l d0,92(sp)
     136:	2f7c 8000 0028 	move.l #-2147483608,96(sp)
     13c:	0060 
     13e:	2f7c 0000 1387 	move.l #4999,100(sp)
     144:	0064 
     146:	2f7c 8000 002d 	move.l #-2147483603,104(sp)
     14c:	0068 
     14e:	700f           	moveq #15,d0
     150:	2f40 006c      	move.l d0,108(sp)
     154:	2f7c 8000 0026 	move.l #-2147483610,112(sp)
     15a:	0070 
     15c:	7001           	moveq #1,d0
     15e:	2f40 0074      	move.l d0,116(sp)
     162:	2f7c 8000 0027 	move.l #-2147483609,120(sp)
     168:	0078 
     16a:	42af 007c      	clr.l 124(sp)
     16e:	42af 0080      	clr.l 128(sp)
     172:	91c8           	suba.l a0,a0
     174:	43ef 0040      	lea 64(sp),a1
     178:	4eae fd9c      	jsr -612(a6)
     17c:	23c0 0000 3698 	move.l d0,3698 <GolScreen>
     182:	6700 0588      	beq.w 70c <main+0x698>
																 SA_DetailPen, 1,
																 SA_BlockPen, 0,
																 TAG_END)))
				{

					if ((GadToolsBase = (struct Library *)OpenLibrary((CONST_STRPTR) "gadtools.library", 0)))
     186:	2c79 0000 36ba 	movea.l 36ba <SysBase>,a6
     18c:	43f9 0000 139f 	lea 139f <PutChar+0x4b>,a1
     192:	7000           	moveq #0,d0
     194:	4eae fdd8      	jsr -552(a6)
     198:	23c0 0000 369c 	move.l d0,369c <GadToolsBase>
     19e:	6700 056c      	beq.w 70c <main+0x698>
					{
						if ((GolMainWindow = (struct Window *)OpenWindowTags(NULL,
     1a2:	2f7c 8000 0070 	move.l #-2147483536,64(sp)
     1a8:	0040 
     1aa:	2479 0000 3698 	movea.l 3698 <GolScreen>,a2
     1b0:	2f4a 0044      	move.l a2,68(sp)
     1b4:	2f7c 8000 0064 	move.l #-2147483548,72(sp)
     1ba:	0048 
     1bc:	42af 004c      	clr.l 76(sp)
     1c0:	2f7c 8000 0065 	move.l #-2147483547,80(sp)
     1c6:	0050 
     1c8:	102a 001e      	move.b 30(a2),d0
     1cc:	4880           	ext.w d0
     1ce:	48c0           	ext.l d0
     1d0:	5280           	addq.l #1,d0
     1d2:	2f40 0054      	move.l d0,84(sp)
     1d6:	2f7c 8000 0066 	move.l #-2147483546,88(sp)
     1dc:	0058 
     1de:	102a 0024      	move.b 36(a2),d0
     1e2:	4880           	ext.w d0
     1e4:	3a40           	movea.w d0,a5
     1e6:	102a 0025      	move.b 37(a2),d0
     1ea:	4880           	ext.w d0
     1ec:	3840           	movea.w d0,a4
     1ee:	7000           	moveq #0,d0
     1f0:	3039 0000 36d6 	move.w 36d6 <GameMatrix+0xa>,d0
     1f6:	7200           	moveq #0,d1
     1f8:	3239 0000 36dc 	move.w 36dc <GameMatrix+0x10>,d1
     1fe:	2f01           	move.l d1,-(sp)
     200:	2040           	movea.l d0,a0
     202:	4868 ffff      	pea -1(a0)
     206:	4eb9 0000 124c 	jsr 124c <__mulsi3>
     20c:	508f           	addq.l #8,sp
     20e:	41f5 0800      	lea (0,a5,d0.l),a0
     212:	41f4 8810      	lea (16,a4,a0.l),a0
     216:	2f48 005c      	move.l a0,92(sp)
     21a:	2f7c 8000 0067 	move.l #-2147483545,96(sp)
     220:	0060 
     222:	102a 0023      	move.b 35(a2),d0
     226:	4880           	ext.w d0
     228:	3640           	movea.w d0,a3
     22a:	102a 0026      	move.b 38(a2),d0
     22e:	4880           	ext.w d0
     230:	3440           	movea.w d0,a2
     232:	7000           	moveq #0,d0
     234:	3039 0000 36d4 	move.w 36d4 <GameMatrix+0x8>,d0
     23a:	7200           	moveq #0,d1
     23c:	3239 0000 36de 	move.w 36de <GameMatrix+0x12>,d1
     242:	2f01           	move.l d1,-(sp)
     244:	2240           	movea.l d0,a1
     246:	4869 ffff      	pea -1(a1)
     24a:	4eb9 0000 124c 	jsr 124c <__mulsi3>
     250:	508f           	addq.l #8,sp
     252:	41f3 0800      	lea (0,a3,d0.l),a0
     256:	41f2 8810      	lea (16,a2,a0.l),a0
     25a:	2f48 0064      	move.l a0,100(sp)
     25e:	2f7c 8000 0074 	move.l #-2147483532,104(sp)
     264:	0068 
     266:	203c 0000 0280 	move.l #640,d0
     26c:	908d           	sub.l a5,d0
     26e:	908c           	sub.l a4,d0
     270:	2f40 006c      	move.l d0,108(sp)
     274:	2f7c 8000 0075 	move.l #-2147483531,112(sp)
     27a:	0070 
     27c:	203c 0000 0100 	move.l #256,d0
     282:	908b           	sub.l a3,d0
     284:	908a           	sub.l a2,d0
     286:	2f40 0074      	move.l d0,116(sp)
     28a:	2f7c 8000 006e 	move.l #-2147483538,120(sp)
     290:	0078 
     292:	2f7c 0000 13b0 	move.l #5040,124(sp)
     298:	007c 
     29a:	2f7c 8000 0083 	move.l #-2147483517,128(sp)
     2a0:	0080 
     2a2:	7001           	moveq #1,d0
     2a4:	2f40 0084      	move.l d0,132(sp)
     2a8:	2f7c 8000 0084 	move.l #-2147483516,136(sp)
     2ae:	0088 
     2b0:	2f40 008c      	move.l d0,140(sp)
     2b4:	2f7c 8000 0081 	move.l #-2147483519,144(sp)
     2ba:	0090 
     2bc:	2f40 0094      	move.l d0,148(sp)
     2c0:	2f7c 8000 0082 	move.l #-2147483518,152(sp)
     2c6:	0098 
     2c8:	2f40 009c      	move.l d0,156(sp)
     2cc:	2f7c 8000 0091 	move.l #-2147483503,160(sp)
     2d2:	00a0 
     2d4:	2f40 00a4      	move.l d0,164(sp)
     2d8:	2f7c 8000 0086 	move.l #-2147483514,168(sp)
     2de:	00a8 
     2e0:	2f40 00ac      	move.l d0,172(sp)
     2e4:	2f7c 8000 0093 	move.l #-2147483501,176(sp)
     2ea:	00b0 
     2ec:	2f40 00b4      	move.l d0,180(sp)
     2f0:	2f7c 8000 0089 	move.l #-2147483511,184(sp)
     2f6:	00b8 
     2f8:	2f40 00bc      	move.l d0,188(sp)
     2fc:	2f7c 8000 006f 	move.l #-2147483537,192(sp)
     302:	00c0 
     304:	2f7c 0000 13b8 	move.l #5048,196(sp)
     30a:	00c4 
     30c:	2f7c 8000 006a 	move.l #-2147483542,200(sp)
     312:	00c8 
     314:	2f7c 0000 031c 	move.l #796,204(sp)
     31a:	00cc 
     31c:	2f7c 8000 0068 	move.l #-2147483544,208(sp)
     322:	00d0 
     324:	7004           	moveq #4,d0
     326:	2f40 00d4      	move.l d0,212(sp)
     32a:	2f7c 8000 0069 	move.l #-2147483543,216(sp)
     330:	00d8 
     332:	7008           	moveq #8,d0
     334:	2f40 00dc      	move.l d0,220(sp)
     338:	42af 00e0      	clr.l 224(sp)
     33c:	2c79 0000 36a8 	movea.l 36a8 <IntuitionBase>,a6
     342:	91c8           	suba.l a0,a0
     344:	43ef 0040      	lea 64(sp),a1
     348:	4eae fda2      	jsr -606(a6)
     34c:	23c0 0000 36c6 	move.l d0,36c6 <GolMainWindow>
     352:	6700 03b8      	beq.w 70c <main+0x698>
	if ((GameMatrix.Playfield = AllocMem(GameMatrix.Columns * sizeof(GameOfLifeCell *), MEMF_ANY | MEMF_CLEAR)) == NULL)
     356:	7000           	moveq #0,d0
     358:	3039 0000 36d6 	move.w 36d6 <GameMatrix+0xa>,d0
     35e:	2c79 0000 36ba 	movea.l 36ba <SysBase>,a6
     364:	e588           	lsl.l #2,d0
     366:	7201           	moveq #1,d1
     368:	4841           	swap d1
     36a:	4eae ff3a      	jsr -198(a6)
     36e:	41f9 0000 36cc 	lea 36cc <GameMatrix>,a0
     374:	2080           	move.l d0,(a0)
     376:	6700 0394      	beq.w 70c <main+0x698>
	if ((GameMatrix.Playfield_n1 = AllocMem(GameMatrix.Columns * sizeof(GameOfLifeCell *), MEMF_ANY | MEMF_CLEAR)) == NULL)
     37a:	7000           	moveq #0,d0
     37c:	3039 0000 36d6 	move.w 36d6 <GameMatrix+0xa>,d0
     382:	2c79 0000 36ba 	movea.l 36ba <SysBase>,a6
     388:	e588           	lsl.l #2,d0
     38a:	7201           	moveq #1,d1
     38c:	4841           	swap d1
     38e:	4eae ff3a      	jsr -198(a6)
     392:	23c0 0000 36d0 	move.l d0,36d0 <GameMatrix+0x4>
     398:	6700 0372      	beq.w 70c <main+0x698>
	for (int i = 0; i < GameMatrix.Columns; i++)
     39c:	4a79 0000 36d6 	tst.w 36d6 <GameMatrix+0xa>
     3a2:	6700 08e6      	beq.w c8a <main+0xc16>
     3a6:	7400           	moveq #0,d2
     3a8:	7600           	moveq #0,d3
		if ((GameMatrix.Playfield[i] = AllocMem(GameMatrix.Rows * sizeof(GameOfLifeCell), MEMF_ANY | MEMF_CLEAR)) == NULL)
     3aa:	7801           	moveq #1,d4
     3ac:	4844           	swap d4
     3ae:	2c79 0000 36ba 	movea.l 36ba <SysBase>,a6
     3b4:	7000           	moveq #0,d0
     3b6:	3039 0000 36d4 	move.w 36d4 <GameMatrix+0x8>,d0
     3bc:	2204           	move.l d4,d1
     3be:	4eae ff3a      	jsr -198(a6)
     3c2:	43f9 0000 36cc 	lea 36cc <GameMatrix>,a1
     3c8:	2051           	movea.l (a1),a0
     3ca:	2180 2800      	move.l d0,(0,a0,d2.l)
     3ce:	6700 033c      	beq.w 70c <main+0x698>
		if ((GameMatrix.Playfield_n1[i] = AllocMem(GameMatrix.Rows * sizeof(GameOfLifeCell), MEMF_ANY | MEMF_CLEAR)) == NULL)
     3d2:	2c79 0000 36ba 	movea.l 36ba <SysBase>,a6
     3d8:	7000           	moveq #0,d0
     3da:	3039 0000 36d4 	move.w 36d4 <GameMatrix+0x8>,d0
     3e0:	2204           	move.l d4,d1
     3e2:	4eae ff3a      	jsr -198(a6)
     3e6:	2079 0000 36d0 	movea.l 36d0 <GameMatrix+0x4>,a0
     3ec:	2180 2800      	move.l d0,(0,a0,d2.l)
     3f0:	6700 031a      	beq.w 70c <main+0x698>
	for (int i = 0; i < GameMatrix.Columns; i++)
     3f4:	5283           	addq.l #1,d3
     3f6:	7000           	moveq #0,d0
     3f8:	3039 0000 36d6 	move.w 36d6 <GameMatrix+0xa>,d0
     3fe:	5882           	addq.l #4,d2
     400:	b083           	cmp.l d3,d0
     402:	6eaa           	bgt.s 3ae <main+0x33a>
	UpdateList = AllocMem(GameMatrix.Columns * GameMatrix.Rows * sizeof(UpdateListEntry), MEMF_ANY | MEMF_CLEAR);
     404:	7200           	moveq #0,d1
     406:	3239 0000 36d4 	move.w 36d4 <GameMatrix+0x8>,d1
     40c:	2f00           	move.l d0,-(sp)
     40e:	2f01           	move.l d1,-(sp)
     410:	4eb9 0000 124c 	jsr 124c <__mulsi3>
     416:	508f           	addq.l #8,sp
     418:	2200           	move.l d0,d1
     41a:	d281           	add.l d1,d1
     41c:	d081           	add.l d1,d0
     41e:	2c79 0000 36ba 	movea.l 36ba <SysBase>,a6
     424:	d080           	add.l d0,d0
     426:	7201           	moveq #1,d1
     428:	4841           	swap d1
     42a:	4eae ff3a      	jsr -198(a6)
     42e:	23c0 0000 36b4 	move.l d0,36b4 <UpdateList>
	AlterWinBitmap = AllocBitMap(640,256,BMF_CLEAR|BMF_DISPLAYABLE|BMF_INTERLEAVED,0,NULL);
     434:	2c79 0000 36a0 	movea.l 36a0 <GfxBase>,a6
     43a:	203c 0000 0280 	move.l #640,d0
     440:	223c 0000 0100 	move.l #256,d1
     446:	7407           	moveq #7,d2
     448:	7600           	moveq #0,d3
     44a:	91c8           	suba.l a0,a0
     44c:	4eae fc6a      	jsr -918(a6)
																			 TAG_END)))

						{
							if (AllocatePlayfieldMem() != RETURN_OK)
								return RETURN_FAIL;
							my_VisualInfo = GetVisualInfo(GolMainWindow->WScreen, TAG_END);
     450:	42af 0040      	clr.l 64(sp)
     454:	2c79 0000 369c 	movea.l 369c <GadToolsBase>,a6
     45a:	2079 0000 36c6 	movea.l 36c6 <GolMainWindow>,a0
     460:	2068 002e      	movea.l 46(a0),a0
     464:	43ef 0040      	lea 64(sp),a1
     468:	4eae ff82      	jsr -126(a6)
     46c:	2400           	move.l d0,d2
							MainMenuStrip = CreateMenus(GolMainMenu, TAG_END);
     46e:	42af 0040      	clr.l 64(sp)
     472:	2c79 0000 369c 	movea.l 369c <GadToolsBase>,a6
     478:	41f9 0000 348c 	lea 348c <GolMainMenu>,a0
     47e:	43ef 0040      	lea 64(sp),a1
     482:	4eae ffd0      	jsr -48(a6)
     486:	2040           	movea.l d0,a0
     488:	23c0 0000 36c2 	move.l d0,36c2 <MainMenuStrip>
							LayoutMenus(MainMenuStrip, my_VisualInfo, TAG_END);
     48e:	42af 0040      	clr.l 64(sp)
     492:	2c79 0000 369c 	movea.l 369c <GadToolsBase>,a6
     498:	2242           	movea.l d2,a1
     49a:	45ef 0040      	lea 64(sp),a2
     49e:	4eae ffbe      	jsr -66(a6)
							SetMenuStrip(GolMainWindow, MainMenuStrip);
     4a2:	2c79 0000 36a8 	movea.l 36a8 <IntuitionBase>,a6
     4a8:	2079 0000 36c6 	movea.l 36c6 <GolMainWindow>,a0
     4ae:	2279 0000 36c2 	movea.l 36c2 <MainMenuStrip>,a1
     4b4:	4eae fef8      	jsr -264(a6)
	   InitArea(RPortAreaInfo, RPortFillAreaBuffer,(RPortFillAreaSize*2/5));
	   GOlRastport->AreaInfo = RPortAreaInfo;
	   GOlRastport->BitMap = AlterWinBitmap; 
	   OrgWinBitmap = GolMainWindow->RPort->BitMap; */
	
	DrawAllCells(GolMainWindow->RPort);
     4b8:	2079 0000 36c6 	movea.l 36c6 <GolMainWindow>,a0
     4be:	2f28 0032      	move.l 50(a0),-(sp)
     4c2:	4eb9 0000 0e16 	jsr e16 <DrawAllCells>
	
	while (AppRunning)
     4c8:	588f           	addq.l #4,sp
     4ca:	4a79 0000 3694 	tst.w 3694 <AppRunning>
     4d0:	6700 06d6      	beq.w ba8 <main+0xb34>
	{
		EventLoop(GolMainWindow, MainMenuStrip);
     4d4:	2f79 0000 36c2 	move.l 36c2 <MainMenuStrip>,44(sp)
     4da:	002c 
     4dc:	2a79 0000 36c6 	movea.l 36c6 <GolMainWindow>,a5
	USHORT subNum;
	struct MenuItem *item;
	WORD coordX, coordY;
	int x, y;

	if (!GameRunning)
     4e2:	4a79 0000 36c0 	tst.w 36c0 <GameRunning>
     4e8:	6606           	bne.s 4f0 <main+0x47c>
		UpdateCnt = 0;
     4ea:	4279 0000 36be 	clr.w 36be <UpdateCnt>
	/* There may be more than one message, so keep processing messages until there are no more. */
	while ((message = (struct IntuiMessage *)GetMsg(theWindow->UserPort)))
     4f0:	2c79 0000 36ba 	movea.l 36ba <SysBase>,a6
     4f6:	206d 0056      	movea.l 86(a5),a0
     4fa:	4eae fe8c      	jsr -372(a6)
     4fe:	2440           	movea.l d0,a2
     500:	4a80           	tst.l d0
     502:	6700 00b0      	beq.w 5b4 <main+0x540>
	{
		/* Copy the necessary information from the message. */
		msg_class = message->Class;
     506:	242a 0014      	move.l 20(a2),d2
		msg_code = message->Code;
     50a:	382a 0018      	move.w 24(a2),d4
		coordX = message->MouseX - theWindow->BorderLeft;
     50e:	102d 0036      	move.b 54(a5),d0
     512:	4880           	ext.w d0
     514:	362a 0020      	move.w 32(a2),d3
     518:	9640           	sub.w d0,d3
		coordY = message->MouseY - theWindow->BorderTop;
     51a:	102d 0037      	move.b 55(a5),d0
     51e:	4880           	ext.w d0
     520:	3a2a 0022      	move.w 34(a2),d5
     524:	9a40           	sub.w d0,d5

		/* Reply as soon as possible. */
		ReplyMsg((struct Message *)message);
     526:	2c79 0000 36ba 	movea.l 36ba <SysBase>,a6
     52c:	224a           	movea.l a2,a1
     52e:	4eae fe86      	jsr -378(a6)

		/* Take the proper action in response to the message. */
		switch (msg_class)
     532:	7010           	moveq #16,d0
     534:	b082           	cmp.l d2,d0
     536:	6700 01fe      	beq.w 736 <main+0x6c2>
     53a:	6500 01dc      	bcs.w 718 <main+0x6a4>
     53e:	7004           	moveq #4,d0
     540:	b082           	cmp.l d2,d0
     542:	6700 025c      	beq.w 7a0 <main+0x72c>
     546:	5182           	subq.l #8,d2
     548:	66a6           	bne.s 4f0 <main+0x47c>
				DrawActive = FALSE;
				break;
			}
		case IDCMP_MOUSEMOVE: /* The position of the mouse has changed. */
			x = (coordX / GameMatrix.CellSizeH) + 1;
			y = (coordY / GameMatrix.CellSizeV) + 1;
     54a:	3645           	movea.w d5,a3
			x = (coordX / GameMatrix.CellSizeH) + 1;
     54c:	3443           	movea.w d3,a2
     54e:	7000           	moveq #0,d0
     550:	3039 0000 36dc 	move.w 36dc <GameMatrix+0x10>,d0
     556:	49f9 0000 12ca 	lea 12ca <__divsi3>,a4
     55c:	2f00           	move.l d0,-(sp)
     55e:	2f0a           	move.l a2,-(sp)
     560:	4e94           	jsr (a4)
     562:	508f           	addq.l #8,sp
     564:	2400           	move.l d0,d2
     566:	5282           	addq.l #1,d2
			y = (coordY / GameMatrix.CellSizeV) + 1;
     568:	7000           	moveq #0,d0
     56a:	3039 0000 36de 	move.w 36de <GameMatrix+0x12>,d0
     570:	2f00           	move.l d0,-(sp)
     572:	2f0b           	move.l a3,-(sp)
     574:	4e94           	jsr (a4)
     576:	508f           	addq.l #8,sp
     578:	2600           	move.l d0,d3
     57a:	5283           	addq.l #1,d3
     57c:	0c44 0068      	cmpi.w #104,d4
     580:	6700 03cc      	beq.w 94e <main+0x8da>
     584:	0c44 00e8      	cmpi.w #232,d4
     588:	6600 01de      	bne.w 768 <main+0x6f4>
				DrawActive = FALSE;
     58c:	4279 0000 36b8 	clr.w 36b8 <DrawActive>
			if (DrawActive && (x != OldSelectX || y != OldSelectY))
			{
				ToggleCellStatus(coordX, coordY);
			}
			OldSelectX = x;
     592:	23c2 0000 36b0 	move.l d2,36b0 <OldSelectX>
			OldSelectY = y;
     598:	23c3 0000 36ac 	move.l d3,36ac <OldSelectY>
	while ((message = (struct IntuiMessage *)GetMsg(theWindow->UserPort)))
     59e:	2c79 0000 36ba 	movea.l 36ba <SysBase>,a6
     5a4:	206d 0056      	movea.l 86(a5),a0
     5a8:	4eae fe8c      	jsr -372(a6)
     5ac:	2440           	movea.l d0,a2
     5ae:	4a80           	tst.l d0
     5b0:	6600 ff54      	bne.w 506 <main+0x492>
		if (GameRunning)
     5b4:	4a79 0000 36c0 	tst.w 36c0 <GameRunning>
     5ba:	6600 046c      	bne.w a28 <main+0x9b4>
	}
}

void DrawCells(struct RastPort *rPort, BOOL forceFull)
{
	for (int entry = 0; entry < UpdateCnt; entry++)
     5be:	3639 0000 36be 	move.w 36be <UpdateCnt>,d3
		DrawCells(GolMainWindow->RPort, FALSE);
     5c4:	2079 0000 36c6 	movea.l 36c6 <GolMainWindow>,a0
     5ca:	2a28 0032      	move.l 50(a0),d5
	for (int entry = 0; entry < UpdateCnt; entry++)
     5ce:	4a43           	tst.w d3
     5d0:	6700 fef8      	beq.w 4ca <main+0x456>
     5d4:	7c00           	moveq #0,d6
     5d6:	7800           	moveq #0,d4
	{
		int x = UpdateList[entry].X;
     5d8:	2079 0000 36b4 	movea.l 36b4 <UpdateList>,a0
     5de:	d1c6           	adda.l d6,a0
     5e0:	7e00           	moveq #0,d7
     5e2:	3e10           	move.w (a0),d7
		int y = UpdateList[entry].Y;
     5e4:	7600           	moveq #0,d3
     5e6:	3628 0002      	move.w 2(a0),d3
		int s = UpdateList[entry].Status;

		if (s)
			SetAPen(rPort, GameMatrix.ColorAlive);
     5ea:	2c79 0000 36a0 	movea.l 36a0 <GfxBase>,a6
     5f0:	2245           	movea.l d5,a1
     5f2:	7000           	moveq #0,d0
		if (s)
     5f4:	4a68 0004      	tst.w 4(a0)
     5f8:	6700 009a      	beq.w 694 <main+0x620>
			SetAPen(rPort, GameMatrix.ColorAlive);
     5fc:	3039 0000 36d8 	move.w 36d8 <GameMatrix+0xc>,d0
     602:	4eae feaa      	jsr -342(a6)
		else
			SetAPen(rPort, GameMatrix.ColorDead);

		RectFill(rPort,
     606:	7400           	moveq #0,d2
     608:	3439 0000 36dc 	move.w 36dc <GameMatrix+0x10>,d2
     60e:	2f02           	move.l d2,-(sp)
     610:	2047           	movea.l d7,a0
     612:	4868 ffff      	pea -1(a0)
     616:	4eb9 0000 124c 	jsr 124c <__mulsi3>
     61c:	508f           	addq.l #8,sp
     61e:	2440           	movea.l d0,a2
     620:	47ea 0001      	lea 1(a2),a3
     624:	7e00           	moveq #0,d7
     626:	3e39 0000 36de 	move.w 36de <GameMatrix+0x12>,d7
     62c:	2f07           	move.l d7,-(sp)
     62e:	2243           	movea.l d3,a1
     630:	4869 ffff      	pea -1(a1)
     634:	4eb9 0000 124c 	jsr 124c <__mulsi3>
     63a:	508f           	addq.l #8,sp
     63c:	2600           	move.l d0,d3
     63e:	2c79 0000 36a0 	movea.l 36a0 <GfxBase>,a6
     644:	2245           	movea.l d5,a1
     646:	200b           	move.l a3,d0
     648:	2203           	move.l d3,d1
     64a:	5281           	addq.l #1,d1
     64c:	45f2 28ff      	lea (-1,a2,d2.l),a2
     650:	240a           	move.l a2,d2
     652:	2847           	movea.l d7,a4
     654:	49f4 38ff      	lea (-1,a4,d3.l),a4
     658:	260c           	move.l a4,d3
     65a:	4eae fece      	jsr -306(a6)
	for (int entry = 0; entry < UpdateCnt; entry++)
     65e:	5284           	addq.l #1,d4
     660:	5c86           	addq.l #6,d6
     662:	7000           	moveq #0,d0
     664:	3039 0000 36be 	move.w 36be <UpdateCnt>,d0
     66a:	b084           	cmp.l d4,d0
     66c:	6f00 fe5c      	ble.w 4ca <main+0x456>
		int x = UpdateList[entry].X;
     670:	2079 0000 36b4 	movea.l 36b4 <UpdateList>,a0
     676:	d1c6           	adda.l d6,a0
     678:	7e00           	moveq #0,d7
     67a:	3e10           	move.w (a0),d7
		int y = UpdateList[entry].Y;
     67c:	7600           	moveq #0,d3
     67e:	3628 0002      	move.w 2(a0),d3
			SetAPen(rPort, GameMatrix.ColorAlive);
     682:	2c79 0000 36a0 	movea.l 36a0 <GfxBase>,a6
     688:	2245           	movea.l d5,a1
     68a:	7000           	moveq #0,d0
		if (s)
     68c:	4a68 0004      	tst.w 4(a0)
     690:	6600 ff6a      	bne.w 5fc <main+0x588>
			SetAPen(rPort, GameMatrix.ColorDead);
     694:	3039 0000 36da 	move.w 36da <GameMatrix+0xe>,d0
     69a:	4eae feaa      	jsr -342(a6)
		RectFill(rPort,
     69e:	7400           	moveq #0,d2
     6a0:	3439 0000 36dc 	move.w 36dc <GameMatrix+0x10>,d2
     6a6:	2f02           	move.l d2,-(sp)
     6a8:	2047           	movea.l d7,a0
     6aa:	4868 ffff      	pea -1(a0)
     6ae:	4eb9 0000 124c 	jsr 124c <__mulsi3>
     6b4:	508f           	addq.l #8,sp
     6b6:	2440           	movea.l d0,a2
     6b8:	47ea 0001      	lea 1(a2),a3
     6bc:	7e00           	moveq #0,d7
     6be:	3e39 0000 36de 	move.w 36de <GameMatrix+0x12>,d7
     6c4:	2f07           	move.l d7,-(sp)
     6c6:	2243           	movea.l d3,a1
     6c8:	4869 ffff      	pea -1(a1)
     6cc:	4eb9 0000 124c 	jsr 124c <__mulsi3>
     6d2:	508f           	addq.l #8,sp
     6d4:	2600           	move.l d0,d3
     6d6:	2c79 0000 36a0 	movea.l 36a0 <GfxBase>,a6
     6dc:	2245           	movea.l d5,a1
     6de:	200b           	move.l a3,d0
     6e0:	2203           	move.l d3,d1
     6e2:	5281           	addq.l #1,d1
     6e4:	45f2 28ff      	lea (-1,a2,d2.l),a2
     6e8:	240a           	move.l a2,d2
     6ea:	2847           	movea.l d7,a4
     6ec:	49f4 38ff      	lea (-1,a4,d3.l),a4
     6f0:	260c           	move.l a4,d3
     6f2:	4eae fece      	jsr -306(a6)
	for (int entry = 0; entry < UpdateCnt; entry++)
     6f6:	5284           	addq.l #1,d4
     6f8:	5c86           	addq.l #6,d6
     6fa:	7000           	moveq #0,d0
     6fc:	3039 0000 36be 	move.w 36be <UpdateCnt>,d0
     702:	b084           	cmp.l d4,d0
     704:	6e00 ff6a      	bgt.w 670 <main+0x5fc>
     708:	6000 fdc0      	bra.w 4ca <main+0x456>
		return RETURN_FAIL;
     70c:	7014           	moveq #20,d0
}
     70e:	4cdf 7cfc      	movem.l (sp)+,d2-d7/a2-a6
     712:	4fef 00b8      	lea 184(sp),sp
     716:	4e75           	rts
		switch (msg_class)
     718:	0c82 0000 0100 	cmpi.l #256,d2
     71e:	6700 0090      	beq.w 7b0 <main+0x73c>
     722:	0c82 0000 0200 	cmpi.l #512,d2
     728:	6600 fdc6      	bne.w 4f0 <main+0x47c>
			AppRunning = FALSE;
     72c:	4279 0000 3694 	clr.w 3694 <AppRunning>
			break;
     732:	6000 fdbc      	bra.w 4f0 <main+0x47c>
			y = (coordY / GameMatrix.CellSizeV) + 1;
     736:	3645           	movea.w d5,a3
			x = (coordX / GameMatrix.CellSizeH) + 1;
     738:	3443           	movea.w d3,a2
     73a:	7000           	moveq #0,d0
     73c:	3039 0000 36dc 	move.w 36dc <GameMatrix+0x10>,d0
     742:	49f9 0000 12ca 	lea 12ca <__divsi3>,a4
     748:	2f00           	move.l d0,-(sp)
     74a:	2f0a           	move.l a2,-(sp)
     74c:	4e94           	jsr (a4)
     74e:	508f           	addq.l #8,sp
     750:	2400           	move.l d0,d2
     752:	5282           	addq.l #1,d2
			y = (coordY / GameMatrix.CellSizeV) + 1;
     754:	7000           	moveq #0,d0
     756:	3039 0000 36de 	move.w 36de <GameMatrix+0x12>,d0
     75c:	2f00           	move.l d0,-(sp)
     75e:	2f0b           	move.l a3,-(sp)
     760:	4e94           	jsr (a4)
     762:	508f           	addq.l #8,sp
     764:	2600           	move.l d0,d3
     766:	5283           	addq.l #1,d3
			if (DrawActive && (x != OldSelectX || y != OldSelectY))
     768:	4a79 0000 36b8 	tst.w 36b8 <DrawActive>
     76e:	6700 fe22      	beq.w 592 <main+0x51e>
     772:	b4b9 0000 36b0 	cmp.l 36b0 <OldSelectX>,d2
     778:	660a           	bne.s 784 <main+0x710>
     77a:	b6b9 0000 36ac 	cmp.l 36ac <OldSelectY>,d3
     780:	6700 fe10      	beq.w 592 <main+0x51e>
				ToggleCellStatus(coordX, coordY);
     784:	2f0b           	move.l a3,-(sp)
     786:	2f0a           	move.l a2,-(sp)
     788:	4eb9 0000 0d58 	jsr d58 <ToggleCellStatus>
     78e:	508f           	addq.l #8,sp
			OldSelectX = x;
     790:	23c2 0000 36b0 	move.l d2,36b0 <OldSelectX>
			OldSelectY = y;
     796:	23c3 0000 36ac 	move.l d3,36ac <OldSelectY>
			break;
     79c:	6000 fe00      	bra.w 59e <main+0x52a>
			DrawAllCells(theWindow->RPort);
     7a0:	2f2d 0032      	move.l 50(a5),-(sp)
     7a4:	4eb9 0000 0e16 	jsr e16 <DrawAllCells>
     7aa:	588f           	addq.l #4,sp
     7ac:	6000 fd42      	bra.w 4f0 <main+0x47c>
			menuNumber = message->Code;
     7b0:	342a 0018      	move.w 24(a2),d2
			while ((menuNumber != MENUNULL) && (AppRunning))
     7b4:	0c42 ffff      	cmpi.w #-1,d2
     7b8:	6700 fd36      	beq.w 4f0 <main+0x47c>
					SetWindowTitles(theWindow, (STRPTR) "Running", (STRPTR)-1);
     7bc:	2e3c 0000 13d1 	move.l #5073,d7
}

int SavePlayfield(CONST_STRPTR file, int startX, int startY, int width, int height)
{
	BPTR fh;
	fh=Open(file,MODE_NEWFILE);
     7c2:	49f9 0000 13d9 	lea 13d9 <PutChar+0x85>,a4
			while ((menuNumber != MENUNULL) && (AppRunning))
     7c8:	4a79 0000 3694 	tst.w 3694 <AppRunning>
     7ce:	6700 fd20      	beq.w 4f0 <main+0x47c>
				item = ItemAddress(theMenu, menuNumber);
     7d2:	2c79 0000 36a8 	movea.l 36a8 <IntuitionBase>,a6
     7d8:	206f 002c      	movea.l 44(sp),a0
     7dc:	3002           	move.w d2,d0
     7de:	4eae ff70      	jsr -144(a6)
     7e2:	2640           	movea.l d0,a3
				menuNum = MENUNUM(menuNumber);
     7e4:	3002           	move.w d2,d0
     7e6:	0240 001f      	andi.w #31,d0
				if ((menuNum == 0) && (itemNum == 5))
     7ea:	6646           	bne.s 832 <main+0x7be>
				itemNum = ITEMNUM(menuNumber);
     7ec:	3002           	move.w d2,d0
     7ee:	ea48           	lsr.w #5,d0
     7f0:	0240 003f      	andi.w #63,d0
				if ((menuNum == 0) && (itemNum == 5))
     7f4:	0c40 0005      	cmpi.w #5,d0
     7f8:	6746           	beq.s 840 <main+0x7cc>
				if ((menuNum == 0) && (itemNum == 1))
     7fa:	0c40 0001      	cmpi.w #1,d0
     7fe:	6768           	beq.s 868 <main+0x7f4>
				if ((menuNum == 0) && (itemNum == 3) && (subNum == 2))
     800:	0c40 0003      	cmpi.w #3,d0
     804:	662c           	bne.s 832 <main+0x7be>
				subNum = SUBNUM(menuNumber);
     806:	700b           	moveq #11,d0
     808:	e06a           	lsr.w d0,d2
				if ((menuNum == 0) && (itemNum == 3) && (subNum == 2))
     80a:	0c42 0002      	cmpi.w #2,d2
     80e:	6700 01a2      	beq.w 9b2 <main+0x93e>
				if ((menuNum == 0) && (itemNum == 3) && (subNum == 0))
     812:	4a42           	tst.w d2
     814:	6600 0104      	bne.w 91a <main+0x8a6>
					SetWindowTitles(theWindow, (STRPTR) "Running", (STRPTR)-1);
     818:	2c79 0000 36a8 	movea.l 36a8 <IntuitionBase>,a6
     81e:	204d           	movea.l a5,a0
     820:	2247           	movea.l d7,a1
     822:	347c ffff      	movea.w #-1,a2
     826:	4eae feec      	jsr -276(a6)
					GameRunning = TRUE;
     82a:	33fc 0001 0000 	move.w #1,36c0 <GameRunning>
     830:	36c0 
				menuNumber = item->NextSelect;
     832:	342b 0020      	move.w 32(a3),d2
			while ((menuNumber != MENUNULL) && (AppRunning))
     836:	0c42 ffff      	cmpi.w #-1,d2
     83a:	668c           	bne.s 7c8 <main+0x754>
     83c:	6000 fcb2      	bra.w 4f0 <main+0x47c>
					AppRunning = FALSE;
     840:	4279 0000 3694 	clr.w 3694 <AppRunning>
					SetWindowTitles(theWindow, (STRPTR) "Running", (STRPTR)-1);
     846:	2c79 0000 36a8 	movea.l 36a8 <IntuitionBase>,a6
     84c:	204d           	movea.l a5,a0
     84e:	2247           	movea.l d7,a1
     850:	347c ffff      	movea.w #-1,a2
     854:	4eae feec      	jsr -276(a6)
				menuNumber = item->NextSelect;
     858:	342b 0020      	move.w 32(a3),d2
			while ((menuNumber != MENUNULL) && (AppRunning))
     85c:	0c42 ffff      	cmpi.w #-1,d2
     860:	6600 ff66      	bne.w 7c8 <main+0x754>
     864:	6000 fc8a      	bra.w 4f0 <main+0x47c>
					SavePlayfield((CONST_STRPTR) "test.gold", 1, 1, GameMatrix.Columns - 1, GameMatrix.Rows - 1);
     868:	7c00           	moveq #0,d6
     86a:	3c39 0000 36d4 	move.w 36d4 <GameMatrix+0x8>,d6
     870:	7000           	moveq #0,d0
     872:	3039 0000 36d6 	move.w 36d6 <GameMatrix+0xa>,d0
     878:	2f40 0030      	move.l d0,48(sp)
	fh=Open(file,MODE_NEWFILE);
     87c:	2c79 0000 36a4 	movea.l 36a4 <DOSBase>,a6
     882:	220c           	move.l a4,d1
     884:	243c 0000 03ee 	move.l #1006,d2
     88a:	4eae ffe2      	jsr -30(a6)
     88e:	2800           	move.l d0,d4
	LONG args[3];
	for (int x = startX; x < (startX + width); x++)
     890:	7001           	moveq #1,d0
     892:	b0af 0030      	cmp.l 48(sp),d0
     896:	6c66           	bge.s 8fe <main+0x88a>
     898:	b086           	cmp.l d6,d0
     89a:	6c62           	bge.s 8fe <main+0x88a>
     89c:	347c 0004      	movea.w #4,a2
     8a0:	7001           	moveq #1,d0
     8a2:	2f40 0034      	move.l d0,52(sp)
	{
		for (int y = startY; y < (startY + height); y++)
     8a6:	7a01           	moveq #1,d5
     8a8:	2f4d 0038      	move.l a5,56(sp)
     8ac:	2a6f 0034      	movea.l 52(sp),a5
		{
			args[0]=x;
     8b0:	2f4d 0040      	move.l a5,64(sp)
			args[1]=y;
     8b4:	2f45 0044      	move.l d5,68(sp)
			args[2]=GameMatrix.Playfield[x][y].Status;
     8b8:	43f9 0000 36cc 	lea 36cc <GameMatrix>,a1
     8be:	2051           	movea.l (a1),a0
     8c0:	2070 a800      	movea.l (0,a0,a2.l),a0
     8c4:	7000           	moveq #0,d0
     8c6:	1030 5800      	move.b (0,a0,d5.l),d0
     8ca:	2f40 0048      	move.l d0,72(sp)
			VFPrintf(fh, (CONST_STRPTR) "%d,%d,%d\n", args);
     8ce:	2c79 0000 36a4 	movea.l 36a4 <DOSBase>,a6
     8d4:	2204           	move.l d4,d1
     8d6:	243c 0000 13e3 	move.l #5091,d2
     8dc:	7640           	moveq #64,d3
     8de:	d68f           	add.l sp,d3
     8e0:	4eae fe9e      	jsr -354(a6)
		for (int y = startY; y < (startY + height); y++)
     8e4:	5285           	addq.l #1,d5
     8e6:	ba86           	cmp.l d6,d5
     8e8:	66c6           	bne.s 8b0 <main+0x83c>
	for (int x = startX; x < (startX + width); x++)
     8ea:	2a6f 0038      	movea.l 56(sp),a5
     8ee:	52af 0034      	addq.l #1,52(sp)
     8f2:	588a           	addq.l #4,a2
     8f4:	202f 0030      	move.l 48(sp),d0
     8f8:	b0af 0034      	cmp.l 52(sp),d0
     8fc:	66a8           	bne.s 8a6 <main+0x832>
						
		}
	}
	Close(fh);
     8fe:	2c79 0000 36a4 	movea.l 36a4 <DOSBase>,a6
     904:	2204           	move.l d4,d1
     906:	4eae ffdc      	jsr -36(a6)
				menuNumber = item->NextSelect;
     90a:	342b 0020      	move.w 32(a3),d2
			while ((menuNumber != MENUNULL) && (AppRunning))
     90e:	0c42 ffff      	cmpi.w #-1,d2
     912:	6600 feb4      	bne.w 7c8 <main+0x754>
     916:	6000 fbd8      	bra.w 4f0 <main+0x47c>
				if ((menuNum == 0) && (itemNum == 3) && (subNum == 1))
     91a:	0c42 0001      	cmpi.w #1,d2
     91e:	6600 ff12      	bne.w 832 <main+0x7be>
					SetWindowTitles(theWindow, (STRPTR) "Stopped", (STRPTR)-1);
     922:	2c79 0000 36a8 	movea.l 36a8 <IntuitionBase>,a6
     928:	204d           	movea.l a5,a0
     92a:	43f9 0000 13b0 	lea 13b0 <PutChar+0x5c>,a1
     930:	347c ffff      	movea.w #-1,a2
     934:	4eae feec      	jsr -276(a6)
					GameRunning = FALSE;
     938:	4279 0000 36c0 	clr.w 36c0 <GameRunning>
				menuNumber = item->NextSelect;
     93e:	342b 0020      	move.w 32(a3),d2
			while ((menuNumber != MENUNULL) && (AppRunning))
     942:	0c42 ffff      	cmpi.w #-1,d2
     946:	6600 fe80      	bne.w 7c8 <main+0x754>
     94a:	6000 fba4      	bra.w 4f0 <main+0x47c>
				if (!GameRunning)
     94e:	4a79 0000 36c0 	tst.w 36c0 <GameRunning>
     954:	6600 fe12      	bne.w 768 <main+0x6f4>
					DrawActive = TRUE;
     958:	33fc 0001 0000 	move.w #1,36b8 <DrawActive>
     95e:	36b8 
					ToggleCellStatus(coordX, coordY);
     960:	2f0b           	move.l a3,-(sp)
     962:	2f0a           	move.l a2,-(sp)
     964:	4eb9 0000 0d58 	jsr d58 <ToggleCellStatus>
					UpdateList[UpdateCnt].X = x;
     96a:	3239 0000 36be 	move.w 36be <UpdateCnt>,d1
     970:	7000           	moveq #0,d0
     972:	3001           	move.w d1,d0
     974:	2040           	movea.l d0,a0
     976:	d1c0           	adda.l d0,a0
     978:	d1c0           	adda.l d0,a0
     97a:	d1c8           	adda.l a0,a0
     97c:	d1f9 0000 36b4 	adda.l 36b4 <UpdateList>,a0
     982:	3082           	move.w d2,(a0)
					UpdateList[UpdateCnt].Y = y;
     984:	3143 0002      	move.w d3,2(a0)
					UpdateList[UpdateCnt++].Status = GameMatrix.Playfield[x][y].Status;
     988:	49f9 0000 36cc 	lea 36cc <GameMatrix>,a4
     98e:	2254           	movea.l (a4),a1
     990:	2002           	move.l d2,d0
     992:	d082           	add.l d2,d0
     994:	d080           	add.l d0,d0
     996:	2271 0800      	movea.l (0,a1,d0.l),a1
     99a:	5241           	addq.w #1,d1
     99c:	33c1 0000 36be 	move.w d1,36be <UpdateCnt>
     9a2:	4240           	clr.w d0
     9a4:	1031 3800      	move.b (0,a1,d3.l),d0
     9a8:	3140 0004      	move.w d0,4(a0)
     9ac:	508f           	addq.l #8,sp
     9ae:	6000 fdc2      	bra.w 772 <main+0x6fe>
					ClearPlayfield(GameMatrix.Playfield);
     9b2:	41f9 0000 36cc 	lea 36cc <GameMatrix>,a0
     9b8:	2450           	movea.l (a0),a2
	for (int x = 0; x < GameMatrix.Columns; x++)
     9ba:	3439 0000 36d6 	move.w 36d6 <GameMatrix+0xa>,d2
     9c0:	674a           	beq.s a0c <main+0x998>
		memset(pf[x], 0, GameMatrix.Rows * sizeof(GameOfLifeCell));
     9c2:	7600           	moveq #0,d3
     9c4:	3639 0000 36d4 	move.w 36d4 <GameMatrix+0x8>,d3
     9ca:	0282 0000 ffff 	andi.l #65535,d2
     9d0:	d482           	add.l d2,d2
     9d2:	d482           	add.l d2,d2
     9d4:	280a           	move.l a2,d4
     9d6:	d882           	add.l d2,d4
     9d8:	201a           	move.l (a2)+,d0
     9da:	2f03           	move.l d3,-(sp)
     9dc:	42a7           	clr.l -(sp)
     9de:	2f00           	move.l d0,-(sp)
     9e0:	4eb9 0000 103a 	jsr 103a <memset>
	for (int x = 0; x < GameMatrix.Columns; x++)
     9e6:	4fef 000c      	lea 12(sp),sp
     9ea:	b5c4           	cmpa.l d4,a2
     9ec:	66ea           	bne.s 9d8 <main+0x964>
     9ee:	2479 0000 36d0 	movea.l 36d0 <GameMatrix+0x4>,a2
     9f4:	d48a           	add.l a2,d2
		memset(pf[x], 0, GameMatrix.Rows * sizeof(GameOfLifeCell));
     9f6:	201a           	move.l (a2)+,d0
     9f8:	2f03           	move.l d3,-(sp)
     9fa:	42a7           	clr.l -(sp)
     9fc:	2f00           	move.l d0,-(sp)
     9fe:	4eb9 0000 103a 	jsr 103a <memset>
	for (int x = 0; x < GameMatrix.Columns; x++)
     a04:	4fef 000c      	lea 12(sp),sp
     a08:	b5c2           	cmpa.l d2,a2
     a0a:	66ea           	bne.s 9f6 <main+0x982>
					DrawAllCells(theWindow->RPort);
     a0c:	2f2d 0032      	move.l 50(a5),-(sp)
     a10:	4eb9 0000 0e16 	jsr e16 <DrawAllCells>
     a16:	588f           	addq.l #4,sp
				menuNumber = item->NextSelect;
     a18:	342b 0020      	move.w 32(a3),d2
			while ((menuNumber != MENUNULL) && (AppRunning))
     a1c:	0c42 ffff      	cmpi.w #-1,d2
     a20:	6600 fda6      	bne.w 7c8 <main+0x754>
     a24:	6000 faca      	bra.w 4f0 <main+0x47c>
			UpdateCnt = 0;
     a28:	4279 0000 36be 	clr.w 36be <UpdateCnt>
	GameOfLifeCell **pf = GameMatrix.Playfield;
     a2e:	43f9 0000 36cc 	lea 36cc <GameMatrix>,a1
     a34:	2f51 0030      	move.l (a1),48(sp)
	GameOfLifeCell **pf_n1 = GameMatrix.Playfield_n1;
     a38:	2f79 0000 36d0 	move.l 36d0 <GameMatrix+0x4>,52(sp)
     a3e:	0034 
	for (int x = 1; x < GameMatrix.Columns - 1; x++)
     a40:	7e00           	moveq #0,d7
     a42:	3e39 0000 36d6 	move.w 36d6 <GameMatrix+0xa>,d7
     a48:	7002           	moveq #2,d0
     a4a:	b087           	cmp.l d7,d0
     a4c:	6c00 0208      	bge.w c56 <main+0xbe2>
		for (int y = 1; y < GameMatrix.Rows - 1; y++)
     a50:	3f79 0000 36d4 	move.w 36d4 <GameMatrix+0x8>,44(sp)
     a56:	002c 
				UpdateList[UpdateCnt].X = x;
     a58:	2c39 0000 36b4 	move.l 36b4 <UpdateList>,d6
     a5e:	246f 0034      	movea.l 52(sp),a2
     a62:	588a           	addq.l #4,a2
     a64:	2a6f 0030      	movea.l 48(sp),a5
     a68:	2c47           	movea.l d7,a6
     a6a:	538e           	subq.l #1,a6
     a6c:	7a01           	moveq #1,d5
     a6e:	4243           	clr.w d3
     a70:	7800           	moveq #0,d4
     a72:	382f 002c      	move.w 44(sp),d4
     a76:	5384           	subq.l #1,d4
		for (int y = 1; y < GameMatrix.Rows - 1; y++)
     a78:	0c6f 0002 002c 	cmpi.w #2,44(sp)
     a7e:	6300 0082      	bls.w b02 <main+0xa8e>
     a82:	2855           	movea.l (a5),a4
     a84:	226d 0008      	movea.l 8(a5),a1
     a88:	206d 0004      	movea.l 4(a5),a0
					if (pf[x + xi][y + yj].Status)
     a8c:	7001           	moveq #1,d0
     a8e:	4a1c           	tst.b (a4)+
     a90:	56c1           	sne d1
     a92:	4881           	ext.w d1
     a94:	4441           	neg.w d1
     a96:	4a14           	tst.b (a4)
     a98:	6702           	beq.s a9c <main+0xa28>
						neighbours++;
     a9a:	5241           	addq.w #1,d1
					if (pf[x + xi][y + yj].Status)
     a9c:	4a2c 0001      	tst.b 1(a4)
     aa0:	6702           	beq.s aa4 <main+0xa30>
						neighbours++;
     aa2:	5241           	addq.w #1,d1
					if (pf[x + xi][y + yj].Status)
     aa4:	4a18           	tst.b (a0)+
     aa6:	6702           	beq.s aaa <main+0xa36>
						neighbours++;
     aa8:	5241           	addq.w #1,d1
					if (pf[x + xi][y + yj].Status)
     aaa:	1410           	move.b (a0),d2
     aac:	6702           	beq.s ab0 <main+0xa3c>
						neighbours++;
     aae:	5241           	addq.w #1,d1
					if (pf[x + xi][y + yj].Status)
     ab0:	4a28 0001      	tst.b 1(a0)
     ab4:	6702           	beq.s ab8 <main+0xa44>
						neighbours++;
     ab6:	5241           	addq.w #1,d1
					if (pf[x + xi][y + yj].Status)
     ab8:	4a19           	tst.b (a1)+
     aba:	6702           	beq.s abe <main+0xa4a>
						neighbours++;
     abc:	5241           	addq.w #1,d1
					if (pf[x + xi][y + yj].Status)
     abe:	4a11           	tst.b (a1)
     ac0:	6702           	beq.s ac4 <main+0xa50>
						neighbours++;
     ac2:	5241           	addq.w #1,d1
					if (pf[x + xi][y + yj].Status)
     ac4:	4a29 0001      	tst.b 1(a1)
     ac8:	6702           	beq.s acc <main+0xa58>
						neighbours++;
     aca:	5241           	addq.w #1,d1
			if (pf[x][y].Status)
     acc:	4a02           	tst.b d2
     ace:	6700 0094      	beq.w b64 <main+0xaf0>
					pf_n1[x][y].Status = 0;
     ad2:	2652           	movea.l (a2),a3
     ad4:	d7c0           	adda.l d0,a3
				if (neighbours < 2 || neighbours > 3)
     ad6:	5741           	subq.w #3,d1
     ad8:	0c41 0001      	cmpi.w #1,d1
     adc:	6300 00bc      	bls.w b9a <main+0xb26>
					pf_n1[x][y].Status = 0;
     ae0:	4213           	clr.b (a3)
					UpdateList[UpdateCnt].X = x;
     ae2:	7200           	moveq #0,d1
     ae4:	3203           	move.w d3,d1
     ae6:	2641           	movea.l d1,a3
     ae8:	d7c1           	adda.l d1,a3
     aea:	d7c1           	adda.l d1,a3
     aec:	d7cb           	adda.l a3,a3
     aee:	d7c6           	adda.l d6,a3
     af0:	3685           	move.w d5,(a3)
					UpdateList[UpdateCnt].Y = y;
     af2:	3740 0002      	move.w d0,2(a3)
					UpdateList[UpdateCnt].Status = pf_n1[x][y].Status;
     af6:	426b 0004      	clr.w 4(a3)
					UpdateCnt++;
     afa:	5243           	addq.w #1,d3
		for (int y = 1; y < GameMatrix.Rows - 1; y++)
     afc:	5280           	addq.l #1,d0
     afe:	b084           	cmp.l d4,d0
     b00:	668c           	bne.s a8e <main+0xa1a>
	for (int x = 1; x < GameMatrix.Columns - 1; x++)
     b02:	5285           	addq.l #1,d5
     b04:	588a           	addq.l #4,a2
     b06:	588d           	addq.l #4,a5
     b08:	ba8e           	cmp.l a6,d5
     b0a:	6600 ff6c      	bne.w a78 <main+0xa04>
     b0e:	33c3 0000 36be 	move.w d3,36be <UpdateCnt>
	for (int col = 0; col < GameMatrix.Columns; col++)
     b14:	4a87           	tst.l d7
     b16:	6700 faac      	beq.w 5c4 <main+0x550>
		memcpy(pf[col], pf_n1[col], GameMatrix.Rows * sizeof(GameOfLifeCell));
     b1a:	7800           	moveq #0,d4
     b1c:	3839 0000 36d4 	move.w 36d4 <GameMatrix+0x8>,d4
     b22:	246f 0034      	movea.l 52(sp),a2
     b26:	266f 0030      	movea.l 48(sp),a3
     b2a:	de87           	add.l d7,d7
     b2c:	de87           	add.l d7,d7
     b2e:	de8a           	add.l a2,d7
     b30:	49f9 0000 1108 	lea 1108 <memcpy>,a4
     b36:	221a           	move.l (a2)+,d1
     b38:	201b           	move.l (a3)+,d0
     b3a:	2f04           	move.l d4,-(sp)
     b3c:	2f01           	move.l d1,-(sp)
     b3e:	2f00           	move.l d0,-(sp)
     b40:	4e94           	jsr (a4)
	for (int col = 0; col < GameMatrix.Columns; col++)
     b42:	4fef 000c      	lea 12(sp),sp
     b46:	be8a           	cmp.l a2,d7
     b48:	6700 fa7a      	beq.w 5c4 <main+0x550>
		memcpy(pf[col], pf_n1[col], GameMatrix.Rows * sizeof(GameOfLifeCell));
     b4c:	221a           	move.l (a2)+,d1
     b4e:	201b           	move.l (a3)+,d0
     b50:	2f04           	move.l d4,-(sp)
     b52:	2f01           	move.l d1,-(sp)
     b54:	2f00           	move.l d0,-(sp)
     b56:	4e94           	jsr (a4)
	for (int col = 0; col < GameMatrix.Columns; col++)
     b58:	4fef 000c      	lea 12(sp),sp
     b5c:	be8a           	cmp.l a2,d7
     b5e:	66d6           	bne.s b36 <main+0xac2>
     b60:	6000 fa62      	bra.w 5c4 <main+0x550>
			else if (neighbours == 3)
     b64:	0c41 0003      	cmpi.w #3,d1
     b68:	6692           	bne.s afc <main+0xa88>
				pf_n1[x][y].Status = 1;
     b6a:	2652           	movea.l (a2),a3
     b6c:	17bc 0001 0800 	move.b #1,(0,a3,d0.l)
				UpdateList[UpdateCnt].X = x;
     b72:	7200           	moveq #0,d1
     b74:	3203           	move.w d3,d1
     b76:	2641           	movea.l d1,a3
     b78:	d7c1           	adda.l d1,a3
     b7a:	d7c1           	adda.l d1,a3
     b7c:	d7cb           	adda.l a3,a3
     b7e:	d7c6           	adda.l d6,a3
     b80:	3685           	move.w d5,(a3)
				UpdateList[UpdateCnt].Y = y;
     b82:	3740 0002      	move.w d0,2(a3)
				UpdateList[UpdateCnt].Status = pf_n1[x][y].Status;
     b86:	377c 0001 0004 	move.w #1,4(a3)
				UpdateCnt++;
     b8c:	5243           	addq.w #1,d3
		for (int y = 1; y < GameMatrix.Rows - 1; y++)
     b8e:	5280           	addq.l #1,d0
     b90:	b084           	cmp.l d4,d0
     b92:	6600 fefa      	bne.w a8e <main+0xa1a>
     b96:	6000 ff6a      	bra.w b02 <main+0xa8e>
					pf_n1[x][y].Status = pf[x][y].Status;
     b9a:	1682           	move.b d2,(a3)
		for (int y = 1; y < GameMatrix.Rows - 1; y++)
     b9c:	5280           	addq.l #1,d0
     b9e:	b084           	cmp.l d4,d0
     ba0:	6600 feec      	bne.w a8e <main+0xa1a>
     ba4:	6000 ff5c      	bra.w b02 <main+0xa8e>
	FreeMem((APTR)GameMatrix.Playfield, GameMatrix.Rows * GameMatrix.Columns * sizeof(GameOfLifeCell));
     ba8:	2c79 0000 36ba 	movea.l 36ba <SysBase>,a6
     bae:	49f9 0000 36cc 	lea 36cc <GameMatrix>,a4
     bb4:	2254           	movea.l (a4),a1
     bb6:	3039 0000 36d4 	move.w 36d4 <GameMatrix+0x8>,d0
     bbc:	c0f9 0000 36d6 	mulu.w 36d6 <GameMatrix+0xa>,d0
     bc2:	4eae ff2e      	jsr -210(a6)
	if (GolMainWindow)
     bc6:	2079 0000 36c6 	movea.l 36c6 <GolMainWindow>,a0
     bcc:	b0fc 0000      	cmpa.w #0,a0
     bd0:	670a           	beq.s bdc <main+0xb68>
		CloseWindow(GolMainWindow);
     bd2:	2c79 0000 36a8 	movea.l 36a8 <IntuitionBase>,a6
     bd8:	4eae ffb8      	jsr -72(a6)
	if (GadToolsBase)
     bdc:	2279 0000 369c 	movea.l 369c <GadToolsBase>,a1
     be2:	b2fc 0000      	cmpa.w #0,a1
     be6:	670a           	beq.s bf2 <main+0xb7e>
		CloseLibrary((struct Library *)GadToolsBase);
     be8:	2c79 0000 36ba 	movea.l 36ba <SysBase>,a6
     bee:	4eae fe62      	jsr -414(a6)
	if (GolScreen)
     bf2:	2079 0000 3698 	movea.l 3698 <GolScreen>,a0
     bf8:	b0fc 0000      	cmpa.w #0,a0
     bfc:	670a           	beq.s c08 <main+0xb94>
		CloseScreen(GolScreen);
     bfe:	2c79 0000 36a8 	movea.l 36a8 <IntuitionBase>,a6
     c04:	4eae ffbe      	jsr -66(a6)
	if (GfxBase)
     c08:	2279 0000 36a0 	movea.l 36a0 <GfxBase>,a1
     c0e:	b2fc 0000      	cmpa.w #0,a1
     c12:	670a           	beq.s c1e <main+0xbaa>
		CloseLibrary((struct Library *)GfxBase);
     c14:	2c79 0000 36ba 	movea.l 36ba <SysBase>,a6
     c1a:	4eae fe62      	jsr -414(a6)
	if (IntuitionBase)
     c1e:	2279 0000 36a8 	movea.l 36a8 <IntuitionBase>,a1
     c24:	b2fc 0000      	cmpa.w #0,a1
     c28:	670a           	beq.s c34 <main+0xbc0>
		CloseLibrary((struct Library *)IntuitionBase);
     c2a:	2c79 0000 36ba 	movea.l 36ba <SysBase>,a6
     c30:	4eae fe62      	jsr -414(a6)
	if (DOSBase)
     c34:	2279 0000 36a4 	movea.l 36a4 <DOSBase>,a1
     c3a:	b2fc 0000      	cmpa.w #0,a1
     c3e:	673e           	beq.s c7e <main+0xc0a>
		CloseLibrary((struct Library *)DOSBase);
     c40:	2c79 0000 36ba 	movea.l 36ba <SysBase>,a6
     c46:	4eae fe62      	jsr -414(a6)
     c4a:	7000           	moveq #0,d0
}
     c4c:	4cdf 7cfc      	movem.l (sp)+,d2-d7/a2-a6
     c50:	4fef 00b8      	lea 184(sp),sp
     c54:	4e75           	rts
	for (int col = 0; col < GameMatrix.Columns; col++)
     c56:	4243           	clr.w d3
     c58:	4a87           	tst.l d7
     c5a:	6700 f86e      	beq.w 4ca <main+0x456>
		memcpy(pf[col], pf_n1[col], GameMatrix.Rows * sizeof(GameOfLifeCell));
     c5e:	7800           	moveq #0,d4
     c60:	3839 0000 36d4 	move.w 36d4 <GameMatrix+0x8>,d4
     c66:	246f 0034      	movea.l 52(sp),a2
     c6a:	266f 0030      	movea.l 48(sp),a3
     c6e:	de87           	add.l d7,d7
     c70:	de87           	add.l d7,d7
     c72:	de8a           	add.l a2,d7
     c74:	49f9 0000 1108 	lea 1108 <memcpy>,a4
     c7a:	6000 feba      	bra.w b36 <main+0xac2>
     c7e:	7000           	moveq #0,d0
}
     c80:	4cdf 7cfc      	movem.l (sp)+,d2-d7/a2-a6
     c84:	4fef 00b8      	lea 184(sp),sp
     c88:	4e75           	rts
	for (int i = 0; i < GameMatrix.Columns; i++)
     c8a:	7000           	moveq #0,d0
	UpdateList = AllocMem(GameMatrix.Columns * GameMatrix.Rows * sizeof(UpdateListEntry), MEMF_ANY | MEMF_CLEAR);
     c8c:	7200           	moveq #0,d1
     c8e:	3239 0000 36d4 	move.w 36d4 <GameMatrix+0x8>,d1
     c94:	2f00           	move.l d0,-(sp)
     c96:	2f01           	move.l d1,-(sp)
     c98:	4eb9 0000 124c 	jsr 124c <__mulsi3>
     c9e:	508f           	addq.l #8,sp
     ca0:	2200           	move.l d0,d1
     ca2:	d281           	add.l d1,d1
     ca4:	d081           	add.l d1,d0
     ca6:	2c79 0000 36ba 	movea.l 36ba <SysBase>,a6
     cac:	d080           	add.l d0,d0
     cae:	7201           	moveq #1,d1
     cb0:	4841           	swap d1
     cb2:	4eae ff3a      	jsr -198(a6)
     cb6:	23c0 0000 36b4 	move.l d0,36b4 <UpdateList>
	AlterWinBitmap = AllocBitMap(640,256,BMF_CLEAR|BMF_DISPLAYABLE|BMF_INTERLEAVED,0,NULL);
     cbc:	2c79 0000 36a0 	movea.l 36a0 <GfxBase>,a6
     cc2:	203c 0000 0280 	move.l #640,d0
     cc8:	223c 0000 0100 	move.l #256,d1
     cce:	7407           	moveq #7,d2
     cd0:	7600           	moveq #0,d3
     cd2:	91c8           	suba.l a0,a0
     cd4:	4eae fc6a      	jsr -918(a6)
							my_VisualInfo = GetVisualInfo(GolMainWindow->WScreen, TAG_END);
     cd8:	42af 0040      	clr.l 64(sp)
     cdc:	2c79 0000 369c 	movea.l 369c <GadToolsBase>,a6
     ce2:	2079 0000 36c6 	movea.l 36c6 <GolMainWindow>,a0
     ce8:	2068 002e      	movea.l 46(a0),a0
     cec:	43ef 0040      	lea 64(sp),a1
     cf0:	4eae ff82      	jsr -126(a6)
     cf4:	2400           	move.l d0,d2
							MainMenuStrip = CreateMenus(GolMainMenu, TAG_END);
     cf6:	42af 0040      	clr.l 64(sp)
     cfa:	2c79 0000 369c 	movea.l 369c <GadToolsBase>,a6
     d00:	41f9 0000 348c 	lea 348c <GolMainMenu>,a0
     d06:	43ef 0040      	lea 64(sp),a1
     d0a:	4eae ffd0      	jsr -48(a6)
     d0e:	2040           	movea.l d0,a0
     d10:	23c0 0000 36c2 	move.l d0,36c2 <MainMenuStrip>
							LayoutMenus(MainMenuStrip, my_VisualInfo, TAG_END);
     d16:	42af 0040      	clr.l 64(sp)
     d1a:	2c79 0000 369c 	movea.l 369c <GadToolsBase>,a6
     d20:	2242           	movea.l d2,a1
     d22:	45ef 0040      	lea 64(sp),a2
     d26:	4eae ffbe      	jsr -66(a6)
							SetMenuStrip(GolMainWindow, MainMenuStrip);
     d2a:	2c79 0000 36a8 	movea.l 36a8 <IntuitionBase>,a6
     d30:	2079 0000 36c6 	movea.l 36c6 <GolMainWindow>,a0
     d36:	2279 0000 36c2 	movea.l 36c2 <MainMenuStrip>,a1
     d3c:	4eae fef8      	jsr -264(a6)
	DrawAllCells(GolMainWindow->RPort);
     d40:	2079 0000 36c6 	movea.l 36c6 <GolMainWindow>,a0
     d46:	2f28 0032      	move.l 50(a0),-(sp)
     d4a:	4eb9 0000 0e16 	jsr e16 <DrawAllCells>
	while (AppRunning)
     d50:	588f           	addq.l #4,sp
     d52:	6000 f776      	bra.w 4ca <main+0x456>
     d56:	4e71           	nop

00000d58 <ToggleCellStatus>:
{
     d58:	48e7 3020      	movem.l d2-d3/a2,-(sp)
     d5c:	262f 0014      	move.l 20(sp),d3
	int x = coordX / GameMatrix.CellSizeH + 1;
     d60:	7000           	moveq #0,d0
     d62:	3039 0000 36dc 	move.w 36dc <GameMatrix+0x10>,d0
     d68:	45f9 0000 12ca 	lea 12ca <__divsi3>,a2
     d6e:	2f00           	move.l d0,-(sp)
     d70:	306f 0016      	movea.w 22(sp),a0
     d74:	2f08           	move.l a0,-(sp)
     d76:	4e92           	jsr (a2)
     d78:	508f           	addq.l #8,sp
     d7a:	2400           	move.l d0,d2
     d7c:	5282           	addq.l #1,d2
	if (!(x < 0 || x > GameMatrix.Columns - 2 || y < 0 || y > GameMatrix.Rows-2))
     d7e:	6b74           	bmi.s df4 <ToggleCellStatus+0x9c>
     d80:	7000           	moveq #0,d0
     d82:	3039 0000 36d6 	move.w 36d6 <GameMatrix+0xa>,d0
     d88:	5380           	subq.l #1,d0
     d8a:	b480           	cmp.l d0,d2
     d8c:	6c66           	bge.s df4 <ToggleCellStatus+0x9c>
	int y = coordY / GameMatrix.CellSizeV + 1;
     d8e:	7000           	moveq #0,d0
     d90:	3039 0000 36de 	move.w 36de <GameMatrix+0x12>,d0
     d96:	2f00           	move.l d0,-(sp)
     d98:	3043           	movea.w d3,a0
     d9a:	2f08           	move.l a0,-(sp)
     d9c:	4e92           	jsr (a2)
     d9e:	508f           	addq.l #8,sp
     da0:	5280           	addq.l #1,d0
	if (!(x < 0 || x > GameMatrix.Columns - 2 || y < 0 || y > GameMatrix.Rows-2))
     da2:	6b50           	bmi.s df4 <ToggleCellStatus+0x9c>
     da4:	7200           	moveq #0,d1
     da6:	3239 0000 36d4 	move.w 36d4 <GameMatrix+0x8>,d1
     dac:	5381           	subq.l #1,d1
     dae:	b081           	cmp.l d1,d0
     db0:	6c42           	bge.s df4 <ToggleCellStatus+0x9c>
		if (GameMatrix.Playfield[x][y].Status)
     db2:	2079 0000 36cc 	movea.l 36cc <GameMatrix>,a0
     db8:	2202           	move.l d2,d1
     dba:	d282           	add.l d2,d1
     dbc:	d281           	add.l d1,d1
     dbe:	2270 1800      	movea.l (0,a0,d1.l),a1
     dc2:	d3c0           	adda.l d0,a1
			UpdateList[UpdateCnt].X = x;
     dc4:	3239 0000 36be 	move.w 36be <UpdateCnt>,d1
     dca:	7600           	moveq #0,d3
     dcc:	3601           	move.w d1,d3
     dce:	2043           	movea.l d3,a0
     dd0:	d1c3           	adda.l d3,a0
     dd2:	d1c3           	adda.l d3,a0
     dd4:	d1c8           	adda.l a0,a0
     dd6:	d1f9 0000 36b4 	adda.l 36b4 <UpdateList>,a0
			UpdateCnt++;
     ddc:	5241           	addq.w #1,d1
		if (GameMatrix.Playfield[x][y].Status)
     dde:	4a11           	tst.b (a1)
     de0:	6718           	beq.s dfa <ToggleCellStatus+0xa2>
			GameMatrix.Playfield[x][y].Status = 0;
     de2:	4211           	clr.b (a1)
			UpdateList[UpdateCnt].X = x;
     de4:	3082           	move.w d2,(a0)
			UpdateList[UpdateCnt].Y = y;
     de6:	3140 0002      	move.w d0,2(a0)
			UpdateList[UpdateCnt].Status = 0;
     dea:	4268 0004      	clr.w 4(a0)
			UpdateCnt++;
     dee:	33c1 0000 36be 	move.w d1,36be <UpdateCnt>
}
     df4:	4cdf 040c      	movem.l (sp)+,d2-d3/a2
     df8:	4e75           	rts
			GameMatrix.Playfield[x][y].Status = 1;
     dfa:	12bc 0001      	move.b #1,(a1)
			UpdateList[UpdateCnt].X = x;
     dfe:	3082           	move.w d2,(a0)
			UpdateList[UpdateCnt].Y = y;
     e00:	3140 0002      	move.w d0,2(a0)
			UpdateList[UpdateCnt].Status = 1;
     e04:	317c 0001 0004 	move.w #1,4(a0)
			UpdateCnt++;
     e0a:	33c1 0000 36be 	move.w d1,36be <UpdateCnt>
}
     e10:	4cdf 040c      	movem.l (sp)+,d2-d3/a2
     e14:	4e75           	rts

00000e16 <DrawAllCells>:
	
	return RETURN_OK;
}

void DrawAllCells(struct RastPort *rPort)
{
     e16:	518f           	subq.l #8,sp
     e18:	48e7 3f3e      	movem.l d2-d7/a2-a6,-(sp)
     e1c:	2a2f 0038      	move.l 56(sp),d5
	//SetFillPattern(theWindow->RPort);
	for (int y = 1; y < GameMatrix.Rows - 1; y++)
     e20:	0c79 0002 0000 	cmpi.w #2,36d4 <GameMatrix+0x8>
     e26:	36d4 
     e28:	6300 00d0      	bls.w efa <DrawAllCells+0xe4>
	{
		for (int x = 1; x < GameMatrix.Columns - 1; x++)
     e2c:	3239 0000 36d6 	move.w 36d6 <GameMatrix+0xa>,d1
	for (int y = 1; y < GameMatrix.Rows - 1; y++)
     e32:	7001           	moveq #1,d0
     e34:	2f40 002c      	move.l d0,44(sp)
     e38:	49f9 0000 36cc 	lea 36cc <GameMatrix>,a4
     e3e:	47f9 0000 124c 	lea 124c <__mulsi3>,a3
		for (int x = 1; x < GameMatrix.Columns - 1; x++)
     e44:	0c41 0002      	cmpi.w #2,d1
     e48:	6300 00b0      	bls.w efa <DrawAllCells+0xe4>
     e4c:	202f 002c      	move.l 44(sp),d0
     e50:	5380           	subq.l #1,d0
     e52:	2f40 0030      	move.l d0,48(sp)
     e56:	7804           	moveq #4,d4
     e58:	347c 0001      	movea.w #1,a2
		{
			if (GameMatrix.Playfield[x][y].Status)
				SetAPen(rPort, GameMatrix.ColorAlive);
     e5c:	2c79 0000 36a0 	movea.l 36a0 <GfxBase>,a6
			if (GameMatrix.Playfield[x][y].Status)
     e62:	2054           	movea.l (a4),a0
     e64:	2070 4800      	movea.l (0,a0,d4.l),a0
     e68:	202f 002c      	move.l 44(sp),d0
				SetAPen(rPort, GameMatrix.ColorAlive);
     e6c:	2245           	movea.l d5,a1
			if (GameMatrix.Playfield[x][y].Status)
     e6e:	4a30 0800      	tst.b (0,a0,d0.l)
     e72:	6700 008e      	beq.w f02 <DrawAllCells+0xec>
				SetAPen(rPort, GameMatrix.ColorAlive);
     e76:	7000           	moveq #0,d0
     e78:	3039 0000 36d8 	move.w 36d8 <GameMatrix+0xc>,d0
     e7e:	4eae feaa      	jsr -342(a6)
			else
				SetAPen(rPort, GameMatrix.ColorDead);

			RectFill(rPort,
     e82:	7400           	moveq #0,d2
     e84:	3439 0000 36dc 	move.w 36dc <GameMatrix+0x10>,d2
     e8a:	2f02           	move.l d2,-(sp)
     e8c:	486a ffff      	pea -1(a2)
     e90:	4e93           	jsr (a3)
     e92:	508f           	addq.l #8,sp
     e94:	2a40           	movea.l d0,a5
     e96:	2c00           	move.l d0,d6
     e98:	5286           	addq.l #1,d6
     e9a:	7e00           	moveq #0,d7
     e9c:	3e39 0000 36de 	move.w 36de <GameMatrix+0x12>,d7
     ea2:	2f2f 0030      	move.l 48(sp),-(sp)
     ea6:	2f07           	move.l d7,-(sp)
     ea8:	4e93           	jsr (a3)
     eaa:	508f           	addq.l #8,sp
     eac:	2600           	move.l d0,d3
     eae:	2c79 0000 36a0 	movea.l 36a0 <GfxBase>,a6
     eb4:	2245           	movea.l d5,a1
     eb6:	2006           	move.l d6,d0
     eb8:	2203           	move.l d3,d1
     eba:	5281           	addq.l #1,d1
     ebc:	4bf5 28ff      	lea (-1,a5,d2.l),a5
     ec0:	240d           	move.l a5,d2
     ec2:	2047           	movea.l d7,a0
     ec4:	41f0 38ff      	lea (-1,a0,d3.l),a0
     ec8:	2608           	move.l a0,d3
     eca:	4eae fece      	jsr -306(a6)
		for (int x = 1; x < GameMatrix.Columns - 1; x++)
     ece:	528a           	addq.l #1,a2
     ed0:	3239 0000 36d6 	move.w 36d6 <GameMatrix+0xa>,d1
     ed6:	5884           	addq.l #4,d4
     ed8:	7000           	moveq #0,d0
     eda:	3001           	move.w d1,d0
     edc:	5380           	subq.l #1,d0
     ede:	b5c0           	cmpa.l d0,a2
     ee0:	6d00 ff7a      	blt.w e5c <DrawAllCells+0x46>
	for (int y = 1; y < GameMatrix.Rows - 1; y++)
     ee4:	52af 002c      	addq.l #1,44(sp)
     ee8:	7000           	moveq #0,d0
     eea:	3039 0000 36d4 	move.w 36d4 <GameMatrix+0x8>,d0
     ef0:	5380           	subq.l #1,d0
     ef2:	b0af 002c      	cmp.l 44(sp),d0
     ef6:	6e00 ff4c      	bgt.w e44 <DrawAllCells+0x2e>
					 (y -1) * GameMatrix.CellSizeV +1,
					 (x - 1) * GameMatrix.CellSizeH + GameMatrix.CellSizeH - 1,
					 (y-1) * GameMatrix.CellSizeV + GameMatrix.CellSizeV - 1);
		}
	}
}
     efa:	4cdf 7cfc      	movem.l (sp)+,d2-d7/a2-a6
     efe:	508f           	addq.l #8,sp
     f00:	4e75           	rts
				SetAPen(rPort, GameMatrix.ColorDead);
     f02:	7000           	moveq #0,d0
     f04:	3039 0000 36da 	move.w 36da <GameMatrix+0xe>,d0
     f0a:	4eae feaa      	jsr -342(a6)
			RectFill(rPort,
     f0e:	7400           	moveq #0,d2
     f10:	3439 0000 36dc 	move.w 36dc <GameMatrix+0x10>,d2
     f16:	2f02           	move.l d2,-(sp)
     f18:	486a ffff      	pea -1(a2)
     f1c:	4e93           	jsr (a3)
     f1e:	508f           	addq.l #8,sp
     f20:	2a40           	movea.l d0,a5
     f22:	2c00           	move.l d0,d6
     f24:	5286           	addq.l #1,d6
     f26:	7e00           	moveq #0,d7
     f28:	3e39 0000 36de 	move.w 36de <GameMatrix+0x12>,d7
     f2e:	2f2f 0030      	move.l 48(sp),-(sp)
     f32:	2f07           	move.l d7,-(sp)
     f34:	4e93           	jsr (a3)
     f36:	508f           	addq.l #8,sp
     f38:	2600           	move.l d0,d3
     f3a:	2c79 0000 36a0 	movea.l 36a0 <GfxBase>,a6
     f40:	2245           	movea.l d5,a1
     f42:	2006           	move.l d6,d0
     f44:	2203           	move.l d3,d1
     f46:	5281           	addq.l #1,d1
     f48:	4bf5 28ff      	lea (-1,a5,d2.l),a5
     f4c:	240d           	move.l a5,d2
     f4e:	2047           	movea.l d7,a0
     f50:	41f0 38ff      	lea (-1,a0,d3.l),a0
     f54:	2608           	move.l a0,d3
     f56:	4eae fece      	jsr -306(a6)
		for (int x = 1; x < GameMatrix.Columns - 1; x++)
     f5a:	528a           	addq.l #1,a2
     f5c:	3239 0000 36d6 	move.w 36d6 <GameMatrix+0xa>,d1
     f62:	5884           	addq.l #4,d4
     f64:	7000           	moveq #0,d0
     f66:	3001           	move.w d1,d0
     f68:	5380           	subq.l #1,d0
     f6a:	b5c0           	cmpa.l d0,a2
     f6c:	6d00 feee      	blt.w e5c <DrawAllCells+0x46>
     f70:	6000 ff72      	bra.w ee4 <DrawAllCells+0xce>

00000f74 <memset.constprop.0>:
	void* memset(void *dest, int val, unsigned long len)
     f74:	2f0a           	move.l a2,-(sp)
     f76:	2f02           	move.l d2,-(sp)
     f78:	202f 000c      	move.l 12(sp),d0
     f7c:	206f 0014      	movea.l 20(sp),a0
	while(len-- > 0)
     f80:	43e8 ffff      	lea -1(a0),a1
     f84:	b0fc 0000      	cmpa.w #0,a0
     f88:	6700 0096      	beq.w 1020 <memset.constprop.0+0xac>
     f8c:	2200           	move.l d0,d1
     f8e:	4481           	neg.l d1
     f90:	7403           	moveq #3,d2
     f92:	c282           	and.l d2,d1
     f94:	7405           	moveq #5,d2
		*ptr++ = val;
     f96:	2440           	movea.l d0,a2
     f98:	b489           	cmp.l a1,d2
     f9a:	6450           	bcc.s fec <memset.constprop.0+0x78>
     f9c:	4a81           	tst.l d1
     f9e:	672c           	beq.s fcc <memset.constprop.0+0x58>
     fa0:	421a           	clr.b (a2)+
	while(len-- > 0)
     fa2:	43e8 fffe      	lea -2(a0),a1
     fa6:	7401           	moveq #1,d2
     fa8:	b481           	cmp.l d1,d2
     faa:	6720           	beq.s fcc <memset.constprop.0+0x58>
		*ptr++ = val;
     fac:	2440           	movea.l d0,a2
     fae:	548a           	addq.l #2,a2
     fb0:	2240           	movea.l d0,a1
     fb2:	4229 0001      	clr.b 1(a1)
	while(len-- > 0)
     fb6:	43e8 fffd      	lea -3(a0),a1
     fba:	7403           	moveq #3,d2
     fbc:	b481           	cmp.l d1,d2
     fbe:	660c           	bne.s fcc <memset.constprop.0+0x58>
		*ptr++ = val;
     fc0:	528a           	addq.l #1,a2
     fc2:	2240           	movea.l d0,a1
     fc4:	4229 0002      	clr.b 2(a1)
	while(len-- > 0)
     fc8:	43e8 fffc      	lea -4(a0),a1
     fcc:	2408           	move.l a0,d2
     fce:	9481           	sub.l d1,d2
     fd0:	2040           	movea.l d0,a0
     fd2:	d1c1           	adda.l d1,a0
     fd4:	72fc           	moveq #-4,d1
     fd6:	c282           	and.l d2,d1
     fd8:	d288           	add.l a0,d1
		*ptr++ = val;
     fda:	4298           	clr.l (a0)+
     fdc:	b1c1           	cmpa.l d1,a0
     fde:	66fa           	bne.s fda <memset.constprop.0+0x66>
     fe0:	72fc           	moveq #-4,d1
     fe2:	c282           	and.l d2,d1
     fe4:	d5c1           	adda.l d1,a2
     fe6:	93c1           	suba.l d1,a1
     fe8:	b282           	cmp.l d2,d1
     fea:	6734           	beq.s 1020 <memset.constprop.0+0xac>
     fec:	4212           	clr.b (a2)
	while(len-- > 0)
     fee:	b2fc 0000      	cmpa.w #0,a1
     ff2:	672c           	beq.s 1020 <memset.constprop.0+0xac>
		*ptr++ = val;
     ff4:	422a 0001      	clr.b 1(a2)
	while(len-- > 0)
     ff8:	7201           	moveq #1,d1
     ffa:	b289           	cmp.l a1,d1
     ffc:	6722           	beq.s 1020 <memset.constprop.0+0xac>
		*ptr++ = val;
     ffe:	422a 0002      	clr.b 2(a2)
	while(len-- > 0)
    1002:	7402           	moveq #2,d2
    1004:	b489           	cmp.l a1,d2
    1006:	6718           	beq.s 1020 <memset.constprop.0+0xac>
		*ptr++ = val;
    1008:	422a 0003      	clr.b 3(a2)
	while(len-- > 0)
    100c:	7203           	moveq #3,d1
    100e:	b289           	cmp.l a1,d1
    1010:	670e           	beq.s 1020 <memset.constprop.0+0xac>
		*ptr++ = val;
    1012:	422a 0004      	clr.b 4(a2)
	while(len-- > 0)
    1016:	7404           	moveq #4,d2
    1018:	b489           	cmp.l a1,d2
    101a:	6704           	beq.s 1020 <memset.constprop.0+0xac>
		*ptr++ = val;
    101c:	422a 0005      	clr.b 5(a2)
}
    1020:	241f           	move.l (sp)+,d2
    1022:	245f           	movea.l (sp)+,a2
    1024:	4e75           	rts

00001026 <strlen>:
{
    1026:	206f 0004      	movea.l 4(sp),a0
	unsigned long t=0;
    102a:	7000           	moveq #0,d0
	while(*s++)
    102c:	4a10           	tst.b (a0)
    102e:	6708           	beq.s 1038 <strlen+0x12>
		t++;
    1030:	5280           	addq.l #1,d0
	while(*s++)
    1032:	4a30 0800      	tst.b (0,a0,d0.l)
    1036:	66f8           	bne.s 1030 <strlen+0xa>
}
    1038:	4e75           	rts

0000103a <memset>:
{
    103a:	48e7 3f30      	movem.l d2-d7/a2-a3,-(sp)
    103e:	202f 0024      	move.l 36(sp),d0
    1042:	282f 0028      	move.l 40(sp),d4
    1046:	226f 002c      	movea.l 44(sp),a1
	while(len-- > 0)
    104a:	2a09           	move.l a1,d5
    104c:	5385           	subq.l #1,d5
    104e:	b2fc 0000      	cmpa.w #0,a1
    1052:	6700 00ae      	beq.w 1102 <memset+0xc8>
		*ptr++ = val;
    1056:	1e04           	move.b d4,d7
    1058:	2200           	move.l d0,d1
    105a:	4481           	neg.l d1
    105c:	7403           	moveq #3,d2
    105e:	c282           	and.l d2,d1
    1060:	7c05           	moveq #5,d6
    1062:	2440           	movea.l d0,a2
    1064:	bc85           	cmp.l d5,d6
    1066:	646a           	bcc.s 10d2 <memset+0x98>
    1068:	4a81           	tst.l d1
    106a:	6724           	beq.s 1090 <memset+0x56>
    106c:	14c4           	move.b d4,(a2)+
	while(len-- > 0)
    106e:	5385           	subq.l #1,d5
    1070:	7401           	moveq #1,d2
    1072:	b481           	cmp.l d1,d2
    1074:	671a           	beq.s 1090 <memset+0x56>
		*ptr++ = val;
    1076:	2440           	movea.l d0,a2
    1078:	548a           	addq.l #2,a2
    107a:	2040           	movea.l d0,a0
    107c:	1144 0001      	move.b d4,1(a0)
	while(len-- > 0)
    1080:	5385           	subq.l #1,d5
    1082:	7403           	moveq #3,d2
    1084:	b481           	cmp.l d1,d2
    1086:	6608           	bne.s 1090 <memset+0x56>
		*ptr++ = val;
    1088:	528a           	addq.l #1,a2
    108a:	1144 0002      	move.b d4,2(a0)
	while(len-- > 0)
    108e:	5385           	subq.l #1,d5
    1090:	2609           	move.l a1,d3
    1092:	9681           	sub.l d1,d3
    1094:	7c00           	moveq #0,d6
    1096:	1c04           	move.b d4,d6
    1098:	2406           	move.l d6,d2
    109a:	4842           	swap d2
    109c:	4242           	clr.w d2
    109e:	2042           	movea.l d2,a0
    10a0:	2404           	move.l d4,d2
    10a2:	e14a           	lsl.w #8,d2
    10a4:	4842           	swap d2
    10a6:	4242           	clr.w d2
    10a8:	e18e           	lsl.l #8,d6
    10aa:	2646           	movea.l d6,a3
    10ac:	2c08           	move.l a0,d6
    10ae:	8486           	or.l d6,d2
    10b0:	2c0b           	move.l a3,d6
    10b2:	8486           	or.l d6,d2
    10b4:	1407           	move.b d7,d2
    10b6:	2040           	movea.l d0,a0
    10b8:	d1c1           	adda.l d1,a0
    10ba:	72fc           	moveq #-4,d1
    10bc:	c283           	and.l d3,d1
    10be:	d288           	add.l a0,d1
		*ptr++ = val;
    10c0:	20c2           	move.l d2,(a0)+
	while(len-- > 0)
    10c2:	b1c1           	cmpa.l d1,a0
    10c4:	66fa           	bne.s 10c0 <memset+0x86>
    10c6:	72fc           	moveq #-4,d1
    10c8:	c283           	and.l d3,d1
    10ca:	d5c1           	adda.l d1,a2
    10cc:	9a81           	sub.l d1,d5
    10ce:	b283           	cmp.l d3,d1
    10d0:	6730           	beq.s 1102 <memset+0xc8>
		*ptr++ = val;
    10d2:	1484           	move.b d4,(a2)
	while(len-- > 0)
    10d4:	4a85           	tst.l d5
    10d6:	672a           	beq.s 1102 <memset+0xc8>
		*ptr++ = val;
    10d8:	1544 0001      	move.b d4,1(a2)
	while(len-- > 0)
    10dc:	7201           	moveq #1,d1
    10de:	b285           	cmp.l d5,d1
    10e0:	6720           	beq.s 1102 <memset+0xc8>
		*ptr++ = val;
    10e2:	1544 0002      	move.b d4,2(a2)
	while(len-- > 0)
    10e6:	7402           	moveq #2,d2
    10e8:	b485           	cmp.l d5,d2
    10ea:	6716           	beq.s 1102 <memset+0xc8>
		*ptr++ = val;
    10ec:	1544 0003      	move.b d4,3(a2)
	while(len-- > 0)
    10f0:	7c03           	moveq #3,d6
    10f2:	bc85           	cmp.l d5,d6
    10f4:	670c           	beq.s 1102 <memset+0xc8>
		*ptr++ = val;
    10f6:	1544 0004      	move.b d4,4(a2)
	while(len-- > 0)
    10fa:	5985           	subq.l #4,d5
    10fc:	6704           	beq.s 1102 <memset+0xc8>
		*ptr++ = val;
    10fe:	1544 0005      	move.b d4,5(a2)
}
    1102:	4cdf 0cfc      	movem.l (sp)+,d2-d7/a2-a3
    1106:	4e75           	rts

00001108 <memcpy>:
{
    1108:	48e7 3e00      	movem.l d2-d6,-(sp)
    110c:	202f 0018      	move.l 24(sp),d0
    1110:	222f 001c      	move.l 28(sp),d1
    1114:	262f 0020      	move.l 32(sp),d3
	while(len--)
    1118:	2803           	move.l d3,d4
    111a:	5384           	subq.l #1,d4
    111c:	4a83           	tst.l d3
    111e:	675e           	beq.s 117e <memcpy+0x76>
    1120:	2041           	movea.l d1,a0
    1122:	5288           	addq.l #1,a0
    1124:	2400           	move.l d0,d2
    1126:	9488           	sub.l a0,d2
    1128:	7a02           	moveq #2,d5
    112a:	ba82           	cmp.l d2,d5
    112c:	55c2           	sc.s d2
    112e:	4402           	neg.b d2
    1130:	7c08           	moveq #8,d6
    1132:	bc84           	cmp.l d4,d6
    1134:	55c5           	sc.s d5
    1136:	4405           	neg.b d5
    1138:	c405           	and.b d5,d2
    113a:	6748           	beq.s 1184 <memcpy+0x7c>
    113c:	2400           	move.l d0,d2
    113e:	8481           	or.l d1,d2
    1140:	7a03           	moveq #3,d5
    1142:	c485           	and.l d5,d2
    1144:	663e           	bne.s 1184 <memcpy+0x7c>
    1146:	2041           	movea.l d1,a0
    1148:	2240           	movea.l d0,a1
    114a:	74fc           	moveq #-4,d2
    114c:	c483           	and.l d3,d2
    114e:	d481           	add.l d1,d2
		*d++ = *s++;
    1150:	22d8           	move.l (a0)+,(a1)+
	while(len--)
    1152:	b488           	cmp.l a0,d2
    1154:	66fa           	bne.s 1150 <memcpy+0x48>
    1156:	74fc           	moveq #-4,d2
    1158:	c483           	and.l d3,d2
    115a:	2040           	movea.l d0,a0
    115c:	d1c2           	adda.l d2,a0
    115e:	d282           	add.l d2,d1
    1160:	9882           	sub.l d2,d4
    1162:	b483           	cmp.l d3,d2
    1164:	6718           	beq.s 117e <memcpy+0x76>
		*d++ = *s++;
    1166:	2241           	movea.l d1,a1
    1168:	1091           	move.b (a1),(a0)
	while(len--)
    116a:	4a84           	tst.l d4
    116c:	6710           	beq.s 117e <memcpy+0x76>
		*d++ = *s++;
    116e:	1169 0001 0001 	move.b 1(a1),1(a0)
	while(len--)
    1174:	5384           	subq.l #1,d4
    1176:	6706           	beq.s 117e <memcpy+0x76>
		*d++ = *s++;
    1178:	1169 0002 0002 	move.b 2(a1),2(a0)
}
    117e:	4cdf 007c      	movem.l (sp)+,d2-d6
    1182:	4e75           	rts
    1184:	2240           	movea.l d0,a1
    1186:	d283           	add.l d3,d1
		*d++ = *s++;
    1188:	12e8 ffff      	move.b -1(a0),(a1)+
	while(len--)
    118c:	b288           	cmp.l a0,d1
    118e:	67ee           	beq.s 117e <memcpy+0x76>
    1190:	5288           	addq.l #1,a0
    1192:	60f4           	bra.s 1188 <memcpy+0x80>

00001194 <memmove>:
{
    1194:	48e7 3c20      	movem.l d2-d5/a2,-(sp)
    1198:	202f 0018      	move.l 24(sp),d0
    119c:	222f 001c      	move.l 28(sp),d1
    11a0:	242f 0020      	move.l 32(sp),d2
		while (len--)
    11a4:	2242           	movea.l d2,a1
    11a6:	5389           	subq.l #1,a1
	if (d < s) {
    11a8:	b280           	cmp.l d0,d1
    11aa:	636c           	bls.s 1218 <memmove+0x84>
		while (len--)
    11ac:	4a82           	tst.l d2
    11ae:	6762           	beq.s 1212 <memmove+0x7e>
    11b0:	2441           	movea.l d1,a2
    11b2:	528a           	addq.l #1,a2
    11b4:	2600           	move.l d0,d3
    11b6:	968a           	sub.l a2,d3
    11b8:	7802           	moveq #2,d4
    11ba:	b883           	cmp.l d3,d4
    11bc:	55c3           	sc.s d3
    11be:	4403           	neg.b d3
    11c0:	7a08           	moveq #8,d5
    11c2:	ba89           	cmp.l a1,d5
    11c4:	55c4           	sc.s d4
    11c6:	4404           	neg.b d4
    11c8:	c604           	and.b d4,d3
    11ca:	6770           	beq.s 123c <memmove+0xa8>
    11cc:	2600           	move.l d0,d3
    11ce:	8681           	or.l d1,d3
    11d0:	7803           	moveq #3,d4
    11d2:	c684           	and.l d4,d3
    11d4:	6666           	bne.s 123c <memmove+0xa8>
    11d6:	2041           	movea.l d1,a0
    11d8:	2440           	movea.l d0,a2
    11da:	76fc           	moveq #-4,d3
    11dc:	c682           	and.l d2,d3
    11de:	d681           	add.l d1,d3
			*d++ = *s++;
    11e0:	24d8           	move.l (a0)+,(a2)+
		while (len--)
    11e2:	b688           	cmp.l a0,d3
    11e4:	66fa           	bne.s 11e0 <memmove+0x4c>
    11e6:	76fc           	moveq #-4,d3
    11e8:	c682           	and.l d2,d3
    11ea:	2440           	movea.l d0,a2
    11ec:	d5c3           	adda.l d3,a2
    11ee:	2041           	movea.l d1,a0
    11f0:	d1c3           	adda.l d3,a0
    11f2:	93c3           	suba.l d3,a1
    11f4:	b682           	cmp.l d2,d3
    11f6:	671a           	beq.s 1212 <memmove+0x7e>
			*d++ = *s++;
    11f8:	1490           	move.b (a0),(a2)
		while (len--)
    11fa:	b2fc 0000      	cmpa.w #0,a1
    11fe:	6712           	beq.s 1212 <memmove+0x7e>
			*d++ = *s++;
    1200:	1568 0001 0001 	move.b 1(a0),1(a2)
		while (len--)
    1206:	7a01           	moveq #1,d5
    1208:	ba89           	cmp.l a1,d5
    120a:	6706           	beq.s 1212 <memmove+0x7e>
			*d++ = *s++;
    120c:	1568 0002 0002 	move.b 2(a0),2(a2)
}
    1212:	4cdf 043c      	movem.l (sp)+,d2-d5/a2
    1216:	4e75           	rts
		const char *lasts = s + (len - 1);
    1218:	41f1 1800      	lea (0,a1,d1.l),a0
		char *lastd = d + (len - 1);
    121c:	d3c0           	adda.l d0,a1
		while (len--)
    121e:	4a82           	tst.l d2
    1220:	67f0           	beq.s 1212 <memmove+0x7e>
    1222:	2208           	move.l a0,d1
    1224:	9282           	sub.l d2,d1
			*lastd-- = *lasts--;
    1226:	1290           	move.b (a0),(a1)
		while (len--)
    1228:	5388           	subq.l #1,a0
    122a:	5389           	subq.l #1,a1
    122c:	b288           	cmp.l a0,d1
    122e:	67e2           	beq.s 1212 <memmove+0x7e>
			*lastd-- = *lasts--;
    1230:	1290           	move.b (a0),(a1)
		while (len--)
    1232:	5388           	subq.l #1,a0
    1234:	5389           	subq.l #1,a1
    1236:	b288           	cmp.l a0,d1
    1238:	66ec           	bne.s 1226 <memmove+0x92>
    123a:	60d6           	bra.s 1212 <memmove+0x7e>
    123c:	2240           	movea.l d0,a1
    123e:	d282           	add.l d2,d1
			*d++ = *s++;
    1240:	12ea ffff      	move.b -1(a2),(a1)+
		while (len--)
    1244:	b28a           	cmp.l a2,d1
    1246:	67ca           	beq.s 1212 <memmove+0x7e>
    1248:	528a           	addq.l #1,a2
    124a:	60f4           	bra.s 1240 <memmove+0xac>

0000124c <__mulsi3>:
	.text
	FUNC(__mulsi3)
	.globl	SYM (__mulsi3)
SYM (__mulsi3):
	.cfi_startproc
	movew	sp@(4), d0	/* x0 -> d0 */
    124c:	302f 0004      	move.w 4(sp),d0
	muluw	sp@(10), d0	/* x0*y1 */
    1250:	c0ef 000a      	mulu.w 10(sp),d0
	movew	sp@(6), d1	/* x1 -> d1 */
    1254:	322f 0006      	move.w 6(sp),d1
	muluw	sp@(8), d1	/* x1*y0 */
    1258:	c2ef 0008      	mulu.w 8(sp),d1
	addw	d1, d0
    125c:	d041           	add.w d1,d0
	swap	d0
    125e:	4840           	swap d0
	clrw	d0
    1260:	4240           	clr.w d0
	movew	sp@(6), d1	/* x1 -> d1 */
    1262:	322f 0006      	move.w 6(sp),d1
	muluw	sp@(10), d1	/* x1*y1 */
    1266:	c2ef 000a      	mulu.w 10(sp),d1
	addl	d1, d0
    126a:	d081           	add.l d1,d0
	rts
    126c:	4e75           	rts

0000126e <__udivsi3>:
	.text
	FUNC(__udivsi3)
	.globl	SYM (__udivsi3)
SYM (__udivsi3):
	.cfi_startproc
	movel	d2, sp@-
    126e:	2f02           	move.l d2,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	sp@(12), d1	/* d1 = divisor */
    1270:	222f 000c      	move.l 12(sp),d1
	movel	sp@(8), d0	/* d0 = dividend */
    1274:	202f 0008      	move.l 8(sp),d0

	cmpl	IMM (0x10000), d1 /* divisor >= 2 ^ 16 ?   */
    1278:	0c81 0001 0000 	cmpi.l #65536,d1
	jcc	3f		/* then try next algorithm */
    127e:	6416           	bcc.s 1296 <__udivsi3+0x28>
	movel	d0, d2
    1280:	2400           	move.l d0,d2
	clrw	d2
    1282:	4242           	clr.w d2
	swap	d2
    1284:	4842           	swap d2
	divu	d1, d2          /* high quotient in lower word */
    1286:	84c1           	divu.w d1,d2
	movew	d2, d0		/* save high quotient */
    1288:	3002           	move.w d2,d0
	swap	d0
    128a:	4840           	swap d0
	movew	sp@(10), d2	/* get low dividend + high rest */
    128c:	342f 000a      	move.w 10(sp),d2
	divu	d1, d2		/* low quotient */
    1290:	84c1           	divu.w d1,d2
	movew	d2, d0
    1292:	3002           	move.w d2,d0
	jra	6f
    1294:	6030           	bra.s 12c6 <__udivsi3+0x58>

3:	movel	d1, d2		/* use d2 as divisor backup */
    1296:	2401           	move.l d1,d2
4:	lsrl	IMM (1), d1	/* shift divisor */
    1298:	e289           	lsr.l #1,d1
	lsrl	IMM (1), d0	/* shift dividend */
    129a:	e288           	lsr.l #1,d0
	cmpl	IMM (0x10000), d1 /* still divisor >= 2 ^ 16 ?  */
    129c:	0c81 0001 0000 	cmpi.l #65536,d1
	jcc	4b
    12a2:	64f4           	bcc.s 1298 <__udivsi3+0x2a>
	divu	d1, d0		/* now we have 16-bit divisor */
    12a4:	80c1           	divu.w d1,d0
	andl	IMM (0xffff), d0 /* mask out divisor, ignore remainder */
    12a6:	0280 0000 ffff 	andi.l #65535,d0

/* Multiply the 16-bit tentative quotient with the 32-bit divisor.  Because of
   the operand ranges, this might give a 33-bit product.  If this product is
   greater than the dividend, the tentative quotient was too large. */
	movel	d2, d1
    12ac:	2202           	move.l d2,d1
	mulu	d0, d1		/* low part, 32 bits */
    12ae:	c2c0           	mulu.w d0,d1
	swap	d2
    12b0:	4842           	swap d2
	mulu	d0, d2		/* high part, at most 17 bits */
    12b2:	c4c0           	mulu.w d0,d2
	swap	d2		/* align high part with low part */
    12b4:	4842           	swap d2
	tstw	d2		/* high part 17 bits? */
    12b6:	4a42           	tst.w d2
	jne	5f		/* if 17 bits, quotient was too large */
    12b8:	660a           	bne.s 12c4 <__udivsi3+0x56>
	addl	d2, d1		/* add parts */
    12ba:	d282           	add.l d2,d1
	jcs	5f		/* if sum is 33 bits, quotient was too large */
    12bc:	6506           	bcs.s 12c4 <__udivsi3+0x56>
	cmpl	sp@(8), d1	/* compare the sum with the dividend */
    12be:	b2af 0008      	cmp.l 8(sp),d1
	jls	6f		/* if sum > dividend, quotient was too large */
    12c2:	6302           	bls.s 12c6 <__udivsi3+0x58>
5:	subql	IMM (1), d0	/* adjust quotient */
    12c4:	5380           	subq.l #1,d0

6:	movel	sp@+, d2
    12c6:	241f           	move.l (sp)+,d2
	.cfi_adjust_cfa_offset -4
	rts
    12c8:	4e75           	rts

000012ca <__divsi3>:
	.text
	FUNC(__divsi3)
	.globl	SYM (__divsi3)
SYM (__divsi3):
	.cfi_startproc
	movel	d2, sp@-
    12ca:	2f02           	move.l d2,-(sp)
	.cfi_adjust_cfa_offset 4

	moveq	IMM (1), d2	/* sign of result stored in d2 (=1 or =-1) */
    12cc:	7401           	moveq #1,d2
	movel	sp@(12), d1	/* d1 = divisor */
    12ce:	222f 000c      	move.l 12(sp),d1
	jpl	1f
    12d2:	6a04           	bpl.s 12d8 <__divsi3+0xe>
	negl	d1
    12d4:	4481           	neg.l d1
	negb	d2		/* change sign because divisor <0  */
    12d6:	4402           	neg.b d2
1:	movel	sp@(8), d0	/* d0 = dividend */
    12d8:	202f 0008      	move.l 8(sp),d0
	jpl	2f
    12dc:	6a04           	bpl.s 12e2 <__divsi3+0x18>
	negl	d0
    12de:	4480           	neg.l d0
	negb	d2
    12e0:	4402           	neg.b d2

2:	movel	d1, sp@-
    12e2:	2f01           	move.l d1,-(sp)
	movel	d0, sp@-
    12e4:	2f00           	move.l d0,-(sp)
	PICCALL	SYM (__udivsi3)	/* divide abs(dividend) by abs(divisor) */
    12e6:	6186           	bsr.s 126e <__udivsi3>
	addql	IMM (8), sp
    12e8:	508f           	addq.l #8,sp

	tstb	d2
    12ea:	4a02           	tst.b d2
	jpl	3f
    12ec:	6a02           	bpl.s 12f0 <__divsi3+0x26>
	negl	d0
    12ee:	4480           	neg.l d0

3:	movel	sp@+, d2
    12f0:	241f           	move.l (sp)+,d2
	.cfi_adjust_cfa_offset -4
	rts
    12f2:	4e75           	rts

000012f4 <__modsi3>:
	.text
	FUNC(__modsi3)
	.globl	SYM (__modsi3)
SYM (__modsi3):
	.cfi_startproc
	movel	sp@(8), d1	/* d1 = divisor */
    12f4:	222f 0008      	move.l 8(sp),d1
	movel	sp@(4), d0	/* d0 = dividend */
    12f8:	202f 0004      	move.l 4(sp),d0
	movel	d1, sp@-
    12fc:	2f01           	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    12fe:	2f00           	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	PICCALL	SYM (__divsi3)
    1300:	61c8           	bsr.s 12ca <__divsi3>
	addql	IMM (8), sp
    1302:	508f           	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(8), d1	/* d1 = divisor */
    1304:	222f 0008      	move.l 8(sp),d1
	movel	d1, sp@-
    1308:	2f01           	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    130a:	2f00           	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	PICCALL	SYM (__mulsi3)	/* d0 = (a/b)*b */
    130c:	6100 ff3e      	bsr.w 124c <__mulsi3>
	addql	IMM (8), sp
    1310:	508f           	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(4), d1	/* d1 = dividend */
    1312:	222f 0004      	move.l 4(sp),d1
	subl	d0, d1		/* d1 = a - (a/b)*b */
    1316:	9280           	sub.l d0,d1
	movel	d1, d0
    1318:	2001           	move.l d1,d0
	rts
    131a:	4e75           	rts

0000131c <__umodsi3>:
	.text
	FUNC(__umodsi3)
	.globl	SYM (__umodsi3)
SYM (__umodsi3):
	.cfi_startproc
	movel	sp@(8), d1	/* d1 = divisor */
    131c:	222f 0008      	move.l 8(sp),d1
	movel	sp@(4), d0	/* d0 = dividend */
    1320:	202f 0004      	move.l 4(sp),d0
	movel	d1, sp@-
    1324:	2f01           	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    1326:	2f00           	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	PICCALL	SYM (__udivsi3)
    1328:	6100 ff44      	bsr.w 126e <__udivsi3>
	addql	IMM (8), sp
    132c:	508f           	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(8), d1	/* d1 = divisor */
    132e:	222f 0008      	move.l 8(sp),d1
	movel	d1, sp@-
    1332:	2f01           	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    1334:	2f00           	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	PICCALL	SYM (__mulsi3)	/* d0 = (a/b)*b */
    1336:	6100 ff14      	bsr.w 124c <__mulsi3>
	addql	IMM (8), sp
    133a:	508f           	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(4), d1	/* d1 = dividend */
    133c:	222f 0004      	move.l 4(sp),d1
	subl	d0, d1		/* d1 = a - (a/b)*b */
    1340:	9280           	sub.l d0,d1
	movel	d1, d0
    1342:	2001           	move.l d1,d0
	rts
    1344:	4e75           	rts

00001346 <KPutCharX>:
	FUNC(KPutCharX)
	.globl	SYM (KPutCharX)

SYM(KPutCharX):
	.cfi_startproc
    move.l  a6, -(sp)
    1346:	2f0e           	move.l a6,-(sp)
	.cfi_adjust_cfa_offset 4
    move.l  4.w, a6
    1348:	2c78 0004      	movea.l 4 <_start+0x4>,a6
    jsr     -0x204(a6)
    134c:	4eae fdfc      	jsr -516(a6)
    movea.l (sp)+, a6
    1350:	2c5f           	movea.l (sp)+,a6
	.cfi_adjust_cfa_offset -4
    rts
    1352:	4e75           	rts

00001354 <PutChar>:
	FUNC(PutChar)
	.globl	SYM (PutChar)

SYM(PutChar):
	.cfi_startproc
	move.b d0, (a3)+
    1354:	16c0           	move.b d0,(a3)+
	rts
    1356:	4e75           	rts
