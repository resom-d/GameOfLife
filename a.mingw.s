
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
       4:	263c 0000 3387 	move.l #13191,d3
       a:	0483 0000 3387 	subi.l #13191,d3
      10:	e483           	asr.l #2,d3
	for (i = 0; i < count; i++)
      12:	6712           	beq.s 26 <_start+0x26>
      14:	45f9 0000 3387 	lea 3387 <__fini_array_end>,a2
      1a:	7400           	moveq #0,d2
		__preinit_array_start[i]();
      1c:	205a           	movea.l (a2)+,a0
      1e:	4e90           	jsr (a0)
	for (i = 0; i < count; i++)
      20:	5282           	addq.l #1,d2
      22:	b483           	cmp.l d3,d2
      24:	66f6           	bne.s 1c <_start+0x1c>

	count = __init_array_end - __init_array_start;
      26:	263c 0000 3387 	move.l #13191,d3
      2c:	0483 0000 3387 	subi.l #13191,d3
      32:	e483           	asr.l #2,d3
	for (i = 0; i < count; i++)
      34:	6712           	beq.s 48 <_start+0x48>
      36:	45f9 0000 3387 	lea 3387 <__fini_array_end>,a2
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
      4e:	243c 0000 3387 	move.l #13191,d2
      54:	0482 0000 3387 	subi.l #13191,d2
      5a:	e482           	asr.l #2,d2
	for (i = count; i > 0; i--)
      5c:	6710           	beq.s 6e <_start+0x6e>
      5e:	45f9 0000 3387 	lea 3387 <__fini_array_end>,a2
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
      74:	4fef ff3c      	lea -196(sp),sp
      78:	48e7 3f3e      	movem.l d2-d7/a2-a6,-(sp)
	GameMatrix.ColorAlive = 14;
	GameMatrix.ColorDead = 15;
	GameMatrix.Columns = 100;
	GameMatrix.Rows = 40;
      7c:	23fc 0028 0064 	move.l #2621540,3530 <GameMatrix+0x8>
      82:	0000 3530 
      86:	23fc 000e 000f 	move.l #917519,3534 <GameMatrix+0xc>
      8c:	0000 3534 
      90:	23fc 0005 0005 	move.l #327685,3538 <GameMatrix+0x10>
      96:	0000 3538 
	return RETURN_OK;
}

int StartApp()
{
	SysBase = *((struct ExecBase **)4UL);
      9a:	2c78 0004      	movea.l 4 <_start+0x4>,a6
      9e:	23ce 0000 3516 	move.l a6,3516 <SysBase>
	custom = (struct Custom *)0xdff000;
	unsigned int pens[] = {~0};
      a4:	70ff           	moveq #-1,d0
      a6:	2f40 0048      	move.l d0,72(sp)

	APTR *my_VisualInfo;

	if ((DOSBase = (struct DosLibrary *)OpenLibrary((CONST_STRPTR) "dos.library", 0)))
      aa:	43f9 0000 1294 	lea 1294 <PutChar+0x4>,a1
      b0:	7000           	moveq #0,d0
      b2:	4eae fdd8      	jsr -552(a6)
      b6:	23c0 0000 3500 	move.l d0,3500 <DOSBase>
      bc:	6700 05a8      	beq.w 666 <main+0x5f2>
	{
		if ((GfxBase = (struct GfxBase *)OpenLibrary((CONST_STRPTR) "graphics.library", 0)))
      c0:	2c79 0000 3516 	movea.l 3516 <SysBase>,a6
      c6:	43f9 0000 12a0 	lea 12a0 <PutChar+0x10>,a1
      cc:	7000           	moveq #0,d0
      ce:	4eae fdd8      	jsr -552(a6)
      d2:	23c0 0000 34f4 	move.l d0,34f4 <GfxBase>
      d8:	6700 058c      	beq.w 666 <main+0x5f2>
		{
			if ((IntuitionBase = (struct IntuitionBase *)OpenLibrary((CONST_STRPTR) "intuition.library", 0)))
      dc:	2c79 0000 3516 	movea.l 3516 <SysBase>,a6
      e2:	43f9 0000 12b1 	lea 12b1 <PutChar+0x21>,a1
      e8:	7000           	moveq #0,d0
      ea:	4eae fdd8      	jsr -552(a6)
      ee:	2c40           	movea.l d0,a6
      f0:	23c0 0000 3504 	move.l d0,3504 <IntuitionBase>
      f6:	6700 056e      	beq.w 666 <main+0x5f2>
			{
				if ((GolScreen = (struct Screen *)OpenScreenTags(NULL,
      fa:	2f7c 8000 003a 	move.l #-2147483590,76(sp)
     100:	004c 
     102:	7048           	moveq #72,d0
     104:	d08f           	add.l sp,d0
     106:	2f40 0050      	move.l d0,80(sp)
     10a:	2f7c 8000 0032 	move.l #-2147483598,84(sp)
     110:	0054 
     112:	2f7c 0000 8000 	move.l #32768,88(sp)
     118:	0058 
     11a:	2f7c 8000 0025 	move.l #-2147483611,92(sp)
     120:	005c 
     122:	7004           	moveq #4,d0
     124:	2f40 0060      	move.l d0,96(sp)
     128:	2f7c 8000 0028 	move.l #-2147483608,100(sp)
     12e:	0064 
     130:	2f7c 0000 12c3 	move.l #4803,104(sp)
     136:	0068 
     138:	2f7c 8000 002d 	move.l #-2147483603,108(sp)
     13e:	006c 
     140:	700f           	moveq #15,d0
     142:	2f40 0070      	move.l d0,112(sp)
     146:	2f7c 8000 0026 	move.l #-2147483610,116(sp)
     14c:	0074 
     14e:	7004           	moveq #4,d0
     150:	2f40 0078      	move.l d0,120(sp)
     154:	2f7c 8000 0027 	move.l #-2147483609,124(sp)
     15a:	007c 
     15c:	7008           	moveq #8,d0
     15e:	2f40 0080      	move.l d0,128(sp)
     162:	42af 0084      	clr.l 132(sp)
     166:	91c8           	suba.l a0,a0
     168:	43ef 004c      	lea 76(sp),a1
     16c:	4eae fd9c      	jsr -612(a6)
     170:	23c0 0000 34f8 	move.l d0,34f8 <GolScreen>
     176:	6700 04ee      	beq.w 666 <main+0x5f2>
																 SA_DetailPen, 4,
																 SA_BlockPen, 8,
																 TAG_END)))
				{

					if ((GadToolsBase = (struct Library *)OpenLibrary((CONST_STRPTR) "gadtools.library", 0)))
     17a:	2c79 0000 3516 	movea.l 3516 <SysBase>,a6
     180:	43f9 0000 12db 	lea 12db <PutChar+0x4b>,a1
     186:	7000           	moveq #0,d0
     188:	4eae fdd8      	jsr -552(a6)
     18c:	23c0 0000 34fc 	move.l d0,34fc <GadToolsBase>
     192:	6700 04d2      	beq.w 666 <main+0x5f2>
					{
						if ((GolMainWindow = (struct Window *)OpenWindowTags(NULL,
     196:	2f7c 8000 0070 	move.l #-2147483536,76(sp)
     19c:	004c 
     19e:	2479 0000 34f8 	movea.l 34f8 <GolScreen>,a2
     1a4:	2f4a 0050      	move.l a2,80(sp)
     1a8:	2f7c 8000 0064 	move.l #-2147483548,84(sp)
     1ae:	0054 
     1b0:	42af 0058      	clr.l 88(sp)
     1b4:	2f7c 8000 0065 	move.l #-2147483547,92(sp)
     1ba:	005c 
     1bc:	102a 001e      	move.b 30(a2),d0
     1c0:	4880           	ext.w d0
     1c2:	48c0           	ext.l d0
     1c4:	5280           	addq.l #1,d0
     1c6:	2f40 0060      	move.l d0,96(sp)
     1ca:	2f7c 8000 0066 	move.l #-2147483546,100(sp)
     1d0:	0064 
     1d2:	102a 0024      	move.b 36(a2),d0
     1d6:	4880           	ext.w d0
     1d8:	3c40           	movea.w d0,a6
     1da:	102a 0025      	move.b 37(a2),d0
     1de:	4880           	ext.w d0
     1e0:	3a40           	movea.w d0,a5
     1e2:	7000           	moveq #0,d0
     1e4:	3039 0000 3532 	move.w 3532 <GameMatrix+0xa>,d0
     1ea:	7200           	moveq #0,d1
     1ec:	3239 0000 3538 	move.w 3538 <GameMatrix+0x10>,d1
     1f2:	47f9 0000 1188 	lea 1188 <__mulsi3>,a3
     1f8:	2f01           	move.l d1,-(sp)
     1fa:	2040           	movea.l d0,a0
     1fc:	4868 ffff      	pea -1(a0)
     200:	4e93           	jsr (a3)
     202:	508f           	addq.l #8,sp
     204:	41f6 0800      	lea (0,a6,d0.l),a0
     208:	41f5 8810      	lea (16,a5,a0.l),a0
     20c:	2f48 0068      	move.l a0,104(sp)
     210:	2f7c 8000 0067 	move.l #-2147483545,108(sp)
     216:	006c 
     218:	102a 0023      	move.b 35(a2),d0
     21c:	4880           	ext.w d0
     21e:	3840           	movea.w d0,a4
     220:	102a 0026      	move.b 38(a2),d0
     224:	4880           	ext.w d0
     226:	3440           	movea.w d0,a2
     228:	7000           	moveq #0,d0
     22a:	3039 0000 3530 	move.w 3530 <GameMatrix+0x8>,d0
     230:	7200           	moveq #0,d1
     232:	3239 0000 353a 	move.w 353a <GameMatrix+0x12>,d1
     238:	2f01           	move.l d1,-(sp)
     23a:	2240           	movea.l d0,a1
     23c:	4869 ffff      	pea -1(a1)
     240:	4e93           	jsr (a3)
     242:	508f           	addq.l #8,sp
     244:	41f4 0800      	lea (0,a4,d0.l),a0
     248:	41f2 8810      	lea (16,a2,a0.l),a0
     24c:	2f48 0070      	move.l a0,112(sp)
     250:	2f7c 8000 0074 	move.l #-2147483532,116(sp)
     256:	0074 
     258:	203c 0000 0280 	move.l #640,d0
     25e:	908e           	sub.l a6,d0
     260:	908d           	sub.l a5,d0
     262:	2f40 0078      	move.l d0,120(sp)
     266:	2f7c 8000 0075 	move.l #-2147483531,124(sp)
     26c:	007c 
     26e:	203c 0000 0100 	move.l #256,d0
     274:	908c           	sub.l a4,d0
     276:	908a           	sub.l a2,d0
     278:	2f40 0080      	move.l d0,128(sp)
     27c:	2f7c 8000 006e 	move.l #-2147483538,132(sp)
     282:	0084 
     284:	2f7c 0000 12ec 	move.l #4844,136(sp)
     28a:	0088 
     28c:	2f7c 8000 0083 	move.l #-2147483517,140(sp)
     292:	008c 
     294:	7001           	moveq #1,d0
     296:	2f40 0090      	move.l d0,144(sp)
     29a:	2f7c 8000 0084 	move.l #-2147483516,148(sp)
     2a0:	0094 
     2a2:	2f40 0098      	move.l d0,152(sp)
     2a6:	2f7c 8000 0081 	move.l #-2147483519,156(sp)
     2ac:	009c 
     2ae:	2f40 00a0      	move.l d0,160(sp)
     2b2:	2f7c 8000 0082 	move.l #-2147483518,164(sp)
     2b8:	00a4 
     2ba:	2f40 00a8      	move.l d0,168(sp)
     2be:	2f7c 8000 0091 	move.l #-2147483503,172(sp)
     2c4:	00ac 
     2c6:	2f40 00b0      	move.l d0,176(sp)
     2ca:	2f7c 8000 0086 	move.l #-2147483514,180(sp)
     2d0:	00b4 
     2d2:	2f40 00b8      	move.l d0,184(sp)
     2d6:	2f7c 8000 0093 	move.l #-2147483501,188(sp)
     2dc:	00bc 
     2de:	2f40 00c0      	move.l d0,192(sp)
     2e2:	2f7c 8000 0089 	move.l #-2147483511,196(sp)
     2e8:	00c4 
     2ea:	2f40 00c8      	move.l d0,200(sp)
     2ee:	2f7c 8000 006f 	move.l #-2147483537,204(sp)
     2f4:	00cc 
     2f6:	2f7c 0000 12f4 	move.l #4852,208(sp)
     2fc:	00d0 
     2fe:	2f7c 8000 006a 	move.l #-2147483542,212(sp)
     304:	00d4 
     306:	2f7c 0000 031c 	move.l #796,216(sp)
     30c:	00d8 
     30e:	2f7c 8000 0068 	move.l #-2147483544,220(sp)
     314:	00dc 
     316:	42af 00e0      	clr.l 224(sp)
     31a:	2f7c 8000 0069 	move.l #-2147483543,228(sp)
     320:	00e4 
     322:	42af 00e8      	clr.l 232(sp)
     326:	42af 00ec      	clr.l 236(sp)
     32a:	2c79 0000 3504 	movea.l 3504 <IntuitionBase>,a6
     330:	91c8           	suba.l a0,a0
     332:	43ef 004c      	lea 76(sp),a1
     336:	4eae fda2      	jsr -606(a6)
     33a:	23c0 0000 3522 	move.l d0,3522 <GolMainWindow>
     340:	6700 0324      	beq.w 666 <main+0x5f2>
	if ((GameMatrix.Playfield = AllocMem(GameMatrix.Columns * sizeof(GameOfLifeCell *), MEMF_ANY | MEMF_CLEAR)) == NULL)
     344:	7000           	moveq #0,d0
     346:	3039 0000 3532 	move.w 3532 <GameMatrix+0xa>,d0
     34c:	2c79 0000 3516 	movea.l 3516 <SysBase>,a6
     352:	e588           	lsl.l #2,d0
     354:	7201           	moveq #1,d1
     356:	4841           	swap d1
     358:	4eae ff3a      	jsr -198(a6)
     35c:	41f9 0000 3528 	lea 3528 <GameMatrix>,a0
     362:	2080           	move.l d0,(a0)
     364:	6700 0300      	beq.w 666 <main+0x5f2>
	if ((GameMatrix.Playfield_n1 = AllocMem(GameMatrix.Columns * sizeof(GameOfLifeCell *), MEMF_ANY | MEMF_CLEAR)) == NULL)
     368:	7000           	moveq #0,d0
     36a:	3039 0000 3532 	move.w 3532 <GameMatrix+0xa>,d0
     370:	2c79 0000 3516 	movea.l 3516 <SysBase>,a6
     376:	e588           	lsl.l #2,d0
     378:	7201           	moveq #1,d1
     37a:	4841           	swap d1
     37c:	4eae ff3a      	jsr -198(a6)
     380:	23c0 0000 352c 	move.l d0,352c <GameMatrix+0x4>
     386:	6700 02de      	beq.w 666 <main+0x5f2>
	for (int i = 0; i < GameMatrix.Columns; i++)
     38a:	4a79 0000 3532 	tst.w 3532 <GameMatrix+0xa>
     390:	6700 079e      	beq.w b30 <main+0xabc>
     394:	7400           	moveq #0,d2
     396:	7600           	moveq #0,d3
		if ((GameMatrix.Playfield[i] = AllocMem(GameMatrix.Rows * sizeof(GameOfLifeCell), MEMF_ANY | MEMF_CLEAR)) == NULL)
     398:	7801           	moveq #1,d4
     39a:	4844           	swap d4
     39c:	7000           	moveq #0,d0
     39e:	3039 0000 3530 	move.w 3530 <GameMatrix+0x8>,d0
     3a4:	2c79 0000 3516 	movea.l 3516 <SysBase>,a6
     3aa:	e588           	lsl.l #2,d0
     3ac:	2204           	move.l d4,d1
     3ae:	4eae ff3a      	jsr -198(a6)
     3b2:	43f9 0000 3528 	lea 3528 <GameMatrix>,a1
     3b8:	2051           	movea.l (a1),a0
     3ba:	2180 2800      	move.l d0,(0,a0,d2.l)
     3be:	6700 02a6      	beq.w 666 <main+0x5f2>
		if ((GameMatrix.Playfield_n1[i] = AllocMem(GameMatrix.Rows * sizeof(GameOfLifeCell), MEMF_ANY | MEMF_CLEAR)) == NULL)
     3c2:	7000           	moveq #0,d0
     3c4:	3039 0000 3530 	move.w 3530 <GameMatrix+0x8>,d0
     3ca:	2c79 0000 3516 	movea.l 3516 <SysBase>,a6
     3d0:	e588           	lsl.l #2,d0
     3d2:	2204           	move.l d4,d1
     3d4:	4eae ff3a      	jsr -198(a6)
     3d8:	2079 0000 352c 	movea.l 352c <GameMatrix+0x4>,a0
     3de:	2180 2800      	move.l d0,(0,a0,d2.l)
     3e2:	6700 0282      	beq.w 666 <main+0x5f2>
	for (int i = 0; i < GameMatrix.Columns; i++)
     3e6:	5283           	addq.l #1,d3
     3e8:	7000           	moveq #0,d0
     3ea:	3039 0000 3532 	move.w 3532 <GameMatrix+0xa>,d0
     3f0:	5882           	addq.l #4,d2
     3f2:	b083           	cmp.l d3,d0
     3f4:	6ea6           	bgt.s 39c <main+0x328>
	UpdateList = AllocMem(GameMatrix.Columns * GameMatrix.Rows * sizeof(UpdateListEntry), MEMF_ANY | MEMF_CLEAR);
     3f6:	7200           	moveq #0,d1
     3f8:	3239 0000 3530 	move.w 3530 <GameMatrix+0x8>,d1
     3fe:	2f00           	move.l d0,-(sp)
     400:	2f01           	move.l d1,-(sp)
     402:	4e93           	jsr (a3)
     404:	508f           	addq.l #8,sp
     406:	2200           	move.l d0,d1
     408:	d281           	add.l d1,d1
     40a:	d081           	add.l d1,d0
     40c:	2c79 0000 3516 	movea.l 3516 <SysBase>,a6
     412:	d080           	add.l d0,d0
     414:	7201           	moveq #1,d1
     416:	4841           	swap d1
     418:	4eae ff3a      	jsr -198(a6)
     41c:	23c0 0000 3510 	move.l d0,3510 <UpdateList>
																			 TAG_END)))

						{
							if (AllocatePlayfieldMem() != RETURN_OK)
								return RETURN_FAIL;
							my_VisualInfo = GetVisualInfo(GolMainWindow->WScreen, TAG_END);
     422:	42af 004c      	clr.l 76(sp)
     426:	2c79 0000 34fc 	movea.l 34fc <GadToolsBase>,a6
     42c:	2079 0000 3522 	movea.l 3522 <GolMainWindow>,a0
     432:	2068 002e      	movea.l 46(a0),a0
     436:	43ef 004c      	lea 76(sp),a1
     43a:	4eae ff82      	jsr -126(a6)
     43e:	2400           	move.l d0,d2
							MainMenuStrip = CreateMenus(GolMainMenu, TAG_END);
     440:	42af 004c      	clr.l 76(sp)
     444:	2c79 0000 34fc 	movea.l 34fc <GadToolsBase>,a6
     44a:	41f9 0000 3388 	lea 3388 <GolMainMenu>,a0
     450:	43ef 004c      	lea 76(sp),a1
     454:	4eae ffd0      	jsr -48(a6)
     458:	2040           	movea.l d0,a0
     45a:	23c0 0000 351e 	move.l d0,351e <MainMenuStrip>
							LayoutMenus(MainMenuStrip, my_VisualInfo, TAG_END);
     460:	42af 004c      	clr.l 76(sp)
     464:	2c79 0000 34fc 	movea.l 34fc <GadToolsBase>,a6
     46a:	2242           	movea.l d2,a1
     46c:	45ef 004c      	lea 76(sp),a2
     470:	4eae ffbe      	jsr -66(a6)
							SetMenuStrip(GolMainWindow, MainMenuStrip);
     474:	2c79 0000 3504 	movea.l 3504 <IntuitionBase>,a6
     47a:	2079 0000 3522 	movea.l 3522 <GolMainWindow>,a0
     480:	2279 0000 351e 	movea.l 351e <MainMenuStrip>,a1
     486:	4eae fef8      	jsr -264(a6)
	return RETURN_ERROR;
}

int MainLoop()
{
	DrawAllCells(GolMainWindow);
     48a:	2e39 0000 3522 	move.l 3522 <GolMainWindow>,d7
     490:	2f07           	move.l d7,-(sp)
     492:	4eb9 0000 0bfa 	jsr bfa <DrawAllCells>

	while (AppRunning)
     498:	588f           	addq.l #4,sp
     49a:	4a79 0000 34f0 	tst.w 34f0 <AppRunning>
     4a0:	6700 0112      	beq.w 5b4 <main+0x540>
	USHORT subNum;
	struct MenuItem *item;
	WORD coordX, coordY;
	int x, y;

	if (!GameRunning)
     4a4:	3f79 0000 351c 	move.w 351c <GameRunning>,48(sp)
     4aa:	0030 
     4ac:	4bf9 0000 0f74 	lea f74 <memset>,a5
		EventLoop(GolMainWindow, MainMenuStrip);
     4b2:	2c39 0000 351e 	move.l 351e <MainMenuStrip>,d6
	if (!GameRunning)
     4b8:	4a6f 0030      	tst.w 48(sp)
     4bc:	6600 065e      	bne.w b1c <main+0xaa8>
		UpdateCnt = 0;
     4c0:	4279 0000 351a 	clr.w 351a <UpdateCnt>
     4c6:	2647           	movea.l d7,a3
     4c8:	2e06           	move.l d6,d7
	/* There may be more than one message, so keep processing messages until there are no more. */
	while ((message = (struct IntuiMessage *)GetMsg(theWindow->UserPort)))
     4ca:	2c79 0000 3516 	movea.l 3516 <SysBase>,a6
     4d0:	206b 0056      	movea.l 86(a3),a0
     4d4:	4eae fe8c      	jsr -372(a6)
     4d8:	2440           	movea.l d0,a2
     4da:	4a80           	tst.l d0
     4dc:	6700 00b0      	beq.w 58e <main+0x51a>
	{
		/* Copy the necessary information from the message. */
		msg_class = message->Class;
     4e0:	242a 0014      	move.l 20(a2),d2
		msg_code = message->Code;
     4e4:	3a2a 0018      	move.w 24(a2),d5
		coordX = message->MouseX - theWindow->BorderLeft;
     4e8:	102b 0036      	move.b 54(a3),d0
     4ec:	4880           	ext.w d0
     4ee:	362a 0020      	move.w 32(a2),d3
     4f2:	9640           	sub.w d0,d3
		coordY = message->MouseY - theWindow->BorderTop;
     4f4:	102b 0037      	move.b 55(a3),d0
     4f8:	4880           	ext.w d0
     4fa:	382a 0022      	move.w 34(a2),d4
     4fe:	9840           	sub.w d0,d4

		/* Reply as soon as possible. */
		ReplyMsg((struct Message *)message);
     500:	2c79 0000 3516 	movea.l 3516 <SysBase>,a6
     506:	224a           	movea.l a2,a1
     508:	4eae fe86      	jsr -378(a6)

		/* Take the proper action in response to the message. */
		switch (msg_class)
     50c:	7010           	moveq #16,d0
     50e:	b082           	cmp.l d2,d0
     510:	6700 017e      	beq.w 690 <main+0x61c>
     514:	6500 015c      	bcs.w 672 <main+0x5fe>
     518:	7004           	moveq #4,d0
     51a:	b082           	cmp.l d2,d0
     51c:	6700 01dc      	beq.w 6fa <main+0x686>
     520:	5182           	subq.l #8,d2
     522:	66a6           	bne.s 4ca <main+0x456>
				DrawActive = FALSE;
				break;
			}
		case IDCMP_MOUSEMOVE: /* The position of the mouse has changed. */
			x = (coordX / GameMatrix.CellSizeH) + 1;
			y = (coordY / GameMatrix.CellSizeV) + 1;
     524:	3444           	movea.w d4,a2
			x = (coordX / GameMatrix.CellSizeH) + 1;
     526:	3c43           	movea.w d3,a6
     528:	7000           	moveq #0,d0
     52a:	3039 0000 3538 	move.w 3538 <GameMatrix+0x10>,d0
     530:	49f9 0000 1206 	lea 1206 <__divsi3>,a4
     536:	2f00           	move.l d0,-(sp)
     538:	2f0e           	move.l a6,-(sp)
     53a:	4e94           	jsr (a4)
     53c:	508f           	addq.l #8,sp
     53e:	2400           	move.l d0,d2
     540:	5282           	addq.l #1,d2
			y = (coordY / GameMatrix.CellSizeV) + 1;
     542:	7000           	moveq #0,d0
     544:	3039 0000 353a 	move.w 353a <GameMatrix+0x12>,d0
     54a:	2f00           	move.l d0,-(sp)
     54c:	2f0a           	move.l a2,-(sp)
     54e:	4e94           	jsr (a4)
     550:	508f           	addq.l #8,sp
     552:	2800           	move.l d0,d4
     554:	5284           	addq.l #1,d4
     556:	0c45 0068      	cmpi.w #104,d5
     55a:	6700 0324      	beq.w 880 <main+0x80c>
     55e:	0c45 00e8      	cmpi.w #232,d5
     562:	6600 015e      	bne.w 6c2 <main+0x64e>
				DrawActive = FALSE;
     566:	4279 0000 3514 	clr.w 3514 <DrawActive>
			if (DrawActive && (x != OldSelectX || y != OldSelectY))
			{
				ToggleCellStatus(coordX, coordY);
			}
			OldSelectX = x;
     56c:	23c2 0000 350c 	move.l d2,350c <OldSelectX>
			OldSelectY = y;
     572:	23c4 0000 3508 	move.l d4,3508 <OldSelectY>
	while ((message = (struct IntuiMessage *)GetMsg(theWindow->UserPort)))
     578:	2c79 0000 3516 	movea.l 3516 <SysBase>,a6
     57e:	206b 0056      	movea.l 86(a3),a0
     582:	4eae fe8c      	jsr -372(a6)
     586:	2440           	movea.l d0,a2
     588:	4a80           	tst.l d0
     58a:	6600 ff54      	bne.w 4e0 <main+0x46c>
		if (GameRunning)
     58e:	3f79 0000 351c 	move.w 351c <GameRunning>,48(sp)
     594:	0030 
     596:	6600 03c4      	bne.w 95c <main+0x8e8>
		DrawCells(GolMainWindow, FALSE);
     59a:	2e39 0000 3522 	move.l 3522 <GolMainWindow>,d7
     5a0:	2f07           	move.l d7,-(sp)
     5a2:	4eb9 0000 0d86 	jsr d86 <DrawCells.constprop.0>
	while (AppRunning)
     5a8:	588f           	addq.l #4,sp
     5aa:	4a79 0000 34f0 	tst.w 34f0 <AppRunning>
     5b0:	6600 ff00      	bne.w 4b2 <main+0x43e>
	}
}

void CleanUp()
{
	FreeMem((APTR)GameMatrix.Playfield, GameMatrix.Rows * GameMatrix.Columns * sizeof(GameOfLifeCell));
     5b4:	3039 0000 3530 	move.w 3530 <GameMatrix+0x8>,d0
     5ba:	c0f9 0000 3532 	mulu.w 3532 <GameMatrix+0xa>,d0
     5c0:	2c79 0000 3516 	movea.l 3516 <SysBase>,a6
     5c6:	49f9 0000 3528 	lea 3528 <GameMatrix>,a4
     5cc:	2254           	movea.l (a4),a1
     5ce:	e588           	lsl.l #2,d0
     5d0:	4eae ff2e      	jsr -210(a6)

	if (GolMainWindow)
     5d4:	2079 0000 3522 	movea.l 3522 <GolMainWindow>,a0
     5da:	b0fc 0000      	cmpa.w #0,a0
     5de:	670a           	beq.s 5ea <main+0x576>
		CloseWindow(GolMainWindow);
     5e0:	2c79 0000 3504 	movea.l 3504 <IntuitionBase>,a6
     5e6:	4eae ffb8      	jsr -72(a6)
	if (GadToolsBase)
     5ea:	2279 0000 34fc 	movea.l 34fc <GadToolsBase>,a1
     5f0:	b2fc 0000      	cmpa.w #0,a1
     5f4:	670a           	beq.s 600 <main+0x58c>
		CloseLibrary((struct Library *)GadToolsBase);
     5f6:	2c79 0000 3516 	movea.l 3516 <SysBase>,a6
     5fc:	4eae fe62      	jsr -414(a6)
	if (GolScreen)
     600:	2079 0000 34f8 	movea.l 34f8 <GolScreen>,a0
     606:	b0fc 0000      	cmpa.w #0,a0
     60a:	670a           	beq.s 616 <main+0x5a2>
		CloseScreen(GolScreen);
     60c:	2c79 0000 3504 	movea.l 3504 <IntuitionBase>,a6
     612:	4eae ffbe      	jsr -66(a6)
	if (GfxBase)
     616:	2279 0000 34f4 	movea.l 34f4 <GfxBase>,a1
     61c:	b2fc 0000      	cmpa.w #0,a1
     620:	670a           	beq.s 62c <main+0x5b8>
		CloseLibrary((struct Library *)GfxBase);
     622:	2c79 0000 3516 	movea.l 3516 <SysBase>,a6
     628:	4eae fe62      	jsr -414(a6)
	if (IntuitionBase)
     62c:	2279 0000 3504 	movea.l 3504 <IntuitionBase>,a1
     632:	b2fc 0000      	cmpa.w #0,a1
     636:	670a           	beq.s 642 <main+0x5ce>
		CloseLibrary((struct Library *)IntuitionBase);
     638:	2c79 0000 3516 	movea.l 3516 <SysBase>,a6
     63e:	4eae fe62      	jsr -414(a6)
	if (DOSBase)
     642:	2279 0000 3500 	movea.l 3500 <DOSBase>,a1
     648:	b2fc 0000      	cmpa.w #0,a1
     64c:	6700 04d6      	beq.w b24 <main+0xab0>
		CloseLibrary((struct Library *)DOSBase);
     650:	2c79 0000 3516 	movea.l 3516 <SysBase>,a6
     656:	4eae fe62      	jsr -414(a6)
     65a:	7000           	moveq #0,d0
}
     65c:	4cdf 7cfc      	movem.l (sp)+,d2-d7/a2-a6
     660:	4fef 00c4      	lea 196(sp),sp
     664:	4e75           	rts
		return RETURN_FAIL;
     666:	7014           	moveq #20,d0
}
     668:	4cdf 7cfc      	movem.l (sp)+,d2-d7/a2-a6
     66c:	4fef 00c4      	lea 196(sp),sp
     670:	4e75           	rts
		switch (msg_class)
     672:	0c82 0000 0100 	cmpi.l #256,d2
     678:	6700 008e      	beq.w 708 <main+0x694>
     67c:	0c82 0000 0200 	cmpi.l #512,d2
     682:	6600 fe46      	bne.w 4ca <main+0x456>
			AppRunning = FALSE;
     686:	4279 0000 34f0 	clr.w 34f0 <AppRunning>
			break;
     68c:	6000 fe3c      	bra.w 4ca <main+0x456>
			y = (coordY / GameMatrix.CellSizeV) + 1;
     690:	3444           	movea.w d4,a2
			x = (coordX / GameMatrix.CellSizeH) + 1;
     692:	3c43           	movea.w d3,a6
     694:	7000           	moveq #0,d0
     696:	3039 0000 3538 	move.w 3538 <GameMatrix+0x10>,d0
     69c:	49f9 0000 1206 	lea 1206 <__divsi3>,a4
     6a2:	2f00           	move.l d0,-(sp)
     6a4:	2f0e           	move.l a6,-(sp)
     6a6:	4e94           	jsr (a4)
     6a8:	508f           	addq.l #8,sp
     6aa:	2400           	move.l d0,d2
     6ac:	5282           	addq.l #1,d2
			y = (coordY / GameMatrix.CellSizeV) + 1;
     6ae:	7000           	moveq #0,d0
     6b0:	3039 0000 353a 	move.w 353a <GameMatrix+0x12>,d0
     6b6:	2f00           	move.l d0,-(sp)
     6b8:	2f0a           	move.l a2,-(sp)
     6ba:	4e94           	jsr (a4)
     6bc:	508f           	addq.l #8,sp
     6be:	2800           	move.l d0,d4
     6c0:	5284           	addq.l #1,d4
			if (DrawActive && (x != OldSelectX || y != OldSelectY))
     6c2:	4a79 0000 3514 	tst.w 3514 <DrawActive>
     6c8:	6700 fea2      	beq.w 56c <main+0x4f8>
     6cc:	b4b9 0000 350c 	cmp.l 350c <OldSelectX>,d2
     6d2:	660a           	bne.s 6de <main+0x66a>
     6d4:	b8b9 0000 3508 	cmp.l 3508 <OldSelectY>,d4
     6da:	6700 fe90      	beq.w 56c <main+0x4f8>
				ToggleCellStatus(coordX, coordY);
     6de:	2f0a           	move.l a2,-(sp)
     6e0:	2f0e           	move.l a6,-(sp)
     6e2:	4eb9 0000 0b38 	jsr b38 <ToggleCellStatus>
     6e8:	508f           	addq.l #8,sp
			OldSelectX = x;
     6ea:	23c2 0000 350c 	move.l d2,350c <OldSelectX>
			OldSelectY = y;
     6f0:	23c4 0000 3508 	move.l d4,3508 <OldSelectY>
			break;
     6f6:	6000 fe80      	bra.w 578 <main+0x504>
			DrawAllCells(theWindow);
     6fa:	2f0b           	move.l a3,-(sp)
     6fc:	4eb9 0000 0bfa 	jsr bfa <DrawAllCells>
     702:	588f           	addq.l #4,sp
     704:	6000 fdc4      	bra.w 4ca <main+0x456>
			menuNumber = message->Code;
     708:	342a 0018      	move.w 24(a2),d2
			while ((menuNumber != MENUNULL) && (AppRunning))
     70c:	0c42 ffff      	cmpi.w #-1,d2
     710:	6700 fdb8      	beq.w 4ca <main+0x456>
					SetWindowTitles(theWindow, (STRPTR) "Running", (STRPTR)-1);
     714:	2c3c 0000 130d 	move.l #4877,d6
			while ((menuNumber != MENUNULL) && (AppRunning))
     71a:	4a79 0000 34f0 	tst.w 34f0 <AppRunning>
     720:	6700 fda8      	beq.w 4ca <main+0x456>
				item = ItemAddress(theMenu, menuNumber);
     724:	2c79 0000 3504 	movea.l 3504 <IntuitionBase>,a6
     72a:	2047           	movea.l d7,a0
     72c:	3002           	move.w d2,d0
     72e:	4eae ff70      	jsr -144(a6)
     732:	2840           	movea.l d0,a4
				menuNum = MENUNUM(menuNumber);
     734:	3002           	move.w d2,d0
     736:	0240 001f      	andi.w #31,d0
				if ((menuNum == 0) && (itemNum == 5))
     73a:	6646           	bne.s 782 <main+0x70e>
				itemNum = ITEMNUM(menuNumber);
     73c:	3002           	move.w d2,d0
     73e:	ea48           	lsr.w #5,d0
     740:	0240 003f      	andi.w #63,d0
				if ((menuNum == 0) && (itemNum == 5))
     744:	0c40 0005      	cmpi.w #5,d0
     748:	6746           	beq.s 790 <main+0x71c>
				if ((menuNum == 0) && (itemNum == 1))
     74a:	0c40 0001      	cmpi.w #1,d0
     74e:	6768           	beq.s 7b8 <main+0x744>
				if ((menuNum == 0) && (itemNum == 3) && (subNum == 2))
     750:	0c40 0003      	cmpi.w #3,d0
     754:	662c           	bne.s 782 <main+0x70e>
				subNum = SUBNUM(menuNumber);
     756:	700b           	moveq #11,d0
     758:	e06a           	lsr.w d0,d2
				if ((menuNum == 0) && (itemNum == 3) && (subNum == 2))
     75a:	0c42 0002      	cmpi.w #2,d2
     75e:	6700 018c      	beq.w 8ec <main+0x878>
				if ((menuNum == 0) && (itemNum == 3) && (subNum == 0))
     762:	4a42           	tst.w d2
     764:	6600 00e6      	bne.w 84c <main+0x7d8>
					SetWindowTitles(theWindow, (STRPTR) "Running", (STRPTR)-1);
     768:	2c79 0000 3504 	movea.l 3504 <IntuitionBase>,a6
     76e:	204b           	movea.l a3,a0
     770:	2246           	movea.l d6,a1
     772:	347c ffff      	movea.w #-1,a2
     776:	4eae feec      	jsr -276(a6)
					GameRunning = TRUE;
     77a:	33fc 0001 0000 	move.w #1,351c <GameRunning>
     780:	351c 
				menuNumber = item->NextSelect;
     782:	342c 0020      	move.w 32(a4),d2
			while ((menuNumber != MENUNULL) && (AppRunning))
     786:	0c42 ffff      	cmpi.w #-1,d2
     78a:	668e           	bne.s 71a <main+0x6a6>
     78c:	6000 fd3c      	bra.w 4ca <main+0x456>
					AppRunning = FALSE;
     790:	4279 0000 34f0 	clr.w 34f0 <AppRunning>
					SetWindowTitles(theWindow, (STRPTR) "Running", (STRPTR)-1);
     796:	2c79 0000 3504 	movea.l 3504 <IntuitionBase>,a6
     79c:	204b           	movea.l a3,a0
     79e:	2246           	movea.l d6,a1
     7a0:	347c ffff      	movea.w #-1,a2
     7a4:	4eae feec      	jsr -276(a6)
				menuNumber = item->NextSelect;
     7a8:	342c 0020      	move.w 32(a4),d2
			while ((menuNumber != MENUNULL) && (AppRunning))
     7ac:	0c42 ffff      	cmpi.w #-1,d2
     7b0:	6600 ff68      	bne.w 71a <main+0x6a6>
     7b4:	6000 fd14      	bra.w 4ca <main+0x456>
					SavePlayfield((CONST_STRPTR) "test.gold", 1, 1, GameMatrix.Columns - 1, GameMatrix.Rows - 1);
     7b8:	7800           	moveq #0,d4
     7ba:	3839 0000 3530 	move.w 3530 <GameMatrix+0x8>,d4
     7c0:	7000           	moveq #0,d0
     7c2:	3039 0000 3532 	move.w 3532 <GameMatrix+0xa>,d0
     7c8:	2f40 002c      	move.l d0,44(sp)
	}
}

int SavePlayfield(CONST_STRPTR file, int startX, int startY, int width, int height)
{
	for (int x = startX; x < startX + width; x++)
     7cc:	7001           	moveq #1,d0
     7ce:	b0af 002c      	cmp.l 44(sp),d0
     7d2:	6cae           	bge.s 782 <main+0x70e>
     7d4:	b084           	cmp.l d4,d0
     7d6:	6caa           	bge.s 782 <main+0x70e>
     7d8:	347c 0004      	movea.w #4,a2
     7dc:	7001           	moveq #1,d0
     7de:	2f40 0030      	move.l d0,48(sp)
	for (int i = 0; i < GameMatrix.Columns; i++)
     7e2:	7a04           	moveq #4,d5
	{
		for (int y = startY; y < startY + height; y++)
     7e4:	7601           	moveq #1,d3
     7e6:	2f47 0034      	move.l d7,52(sp)
     7ea:	2e2f 0030      	move.l 48(sp),d7
		{
			Printf((CONST_STRPTR) "%d,%d,%d\n", x, y, GameMatrix.Playfield[x][y].Status);
     7ee:	2f47 004c      	move.l d7,76(sp)
     7f2:	2f43 0050      	move.l d3,80(sp)
     7f6:	43f9 0000 3528 	lea 3528 <GameMatrix>,a1
     7fc:	2051           	movea.l (a1),a0
     7fe:	2070 a800      	movea.l (0,a0,a2.l),a0
     802:	7000           	moveq #0,d0
     804:	1030 5800      	move.b (0,a0,d5.l),d0
     808:	2f40 0054      	move.l d0,84(sp)
     80c:	2c79 0000 3500 	movea.l 3500 <DOSBase>,a6
     812:	223c 0000 1315 	move.l #4885,d1
     818:	744c           	moveq #76,d2
     81a:	d48f           	add.l sp,d2
     81c:	4eae fc46      	jsr -954(a6)
		for (int y = startY; y < startY + height; y++)
     820:	5283           	addq.l #1,d3
     822:	5885           	addq.l #4,d5
     824:	b684           	cmp.l d4,d3
     826:	66c6           	bne.s 7ee <main+0x77a>
	for (int x = startX; x < startX + width; x++)
     828:	2e2f 0034      	move.l 52(sp),d7
     82c:	52af 0030      	addq.l #1,48(sp)
     830:	588a           	addq.l #4,a2
     832:	202f 002c      	move.l 44(sp),d0
     836:	b0af 0030      	cmp.l 48(sp),d0
     83a:	6700 ff46      	beq.w 782 <main+0x70e>
	for (int i = 0; i < GameMatrix.Columns; i++)
     83e:	7a04           	moveq #4,d5
		for (int y = startY; y < startY + height; y++)
     840:	7601           	moveq #1,d3
     842:	2f47 0034      	move.l d7,52(sp)
     846:	2e2f 0030      	move.l 48(sp),d7
     84a:	60a2           	bra.s 7ee <main+0x77a>
				if ((menuNum == 0) && (itemNum == 3) && (subNum == 1))
     84c:	0c42 0001      	cmpi.w #1,d2
     850:	6600 ff30      	bne.w 782 <main+0x70e>
					SetWindowTitles(theWindow, (STRPTR) "Stopped", (STRPTR)-1);
     854:	2c79 0000 3504 	movea.l 3504 <IntuitionBase>,a6
     85a:	204b           	movea.l a3,a0
     85c:	43f9 0000 12ec 	lea 12ec <PutChar+0x5c>,a1
     862:	347c ffff      	movea.w #-1,a2
     866:	4eae feec      	jsr -276(a6)
					GameRunning = FALSE;
     86a:	4279 0000 351c 	clr.w 351c <GameRunning>
				menuNumber = item->NextSelect;
     870:	342c 0020      	move.w 32(a4),d2
			while ((menuNumber != MENUNULL) && (AppRunning))
     874:	0c42 ffff      	cmpi.w #-1,d2
     878:	6600 fea0      	bne.w 71a <main+0x6a6>
     87c:	6000 fc4c      	bra.w 4ca <main+0x456>
				if (!GameRunning)
     880:	4a79 0000 351c 	tst.w 351c <GameRunning>
     886:	6600 fe3a      	bne.w 6c2 <main+0x64e>
					DrawActive = TRUE;
     88a:	33fc 0001 0000 	move.w #1,3514 <DrawActive>
     890:	3514 
					ToggleCellStatus(coordX, coordY);
     892:	2f0a           	move.l a2,-(sp)
     894:	2f0e           	move.l a6,-(sp)
     896:	4eb9 0000 0b38 	jsr b38 <ToggleCellStatus>
					UpdateList[UpdateCnt].X = x;
     89c:	3239 0000 351a 	move.w 351a <UpdateCnt>,d1
     8a2:	7000           	moveq #0,d0
     8a4:	3001           	move.w d1,d0
     8a6:	2240           	movea.l d0,a1
     8a8:	d3c0           	adda.l d0,a1
     8aa:	d3c0           	adda.l d0,a1
     8ac:	d3c9           	adda.l a1,a1
     8ae:	d3f9 0000 3510 	adda.l 3510 <UpdateList>,a1
     8b4:	3282           	move.w d2,(a1)
					UpdateList[UpdateCnt].Y = y;
     8b6:	3344 0002      	move.w d4,2(a1)
					UpdateList[UpdateCnt++].Status = GameMatrix.Playfield[x][y].Status;
     8ba:	49f9 0000 3528 	lea 3528 <GameMatrix>,a4
     8c0:	2054           	movea.l (a4),a0
     8c2:	2002           	move.l d2,d0
     8c4:	d082           	add.l d2,d0
     8c6:	d080           	add.l d0,d0
     8c8:	2070 0800      	movea.l (0,a0,d0.l),a0
     8cc:	2004           	move.l d4,d0
     8ce:	d084           	add.l d4,d0
     8d0:	d080           	add.l d0,d0
     8d2:	5241           	addq.w #1,d1
     8d4:	33c1 0000 351a 	move.w d1,351a <UpdateCnt>
     8da:	1030 0800      	move.b (0,a0,d0.l),d0
     8de:	0240 00ff      	andi.w #255,d0
     8e2:	3340 0004      	move.w d0,4(a1)
     8e6:	508f           	addq.l #8,sp
     8e8:	6000 fde2      	bra.w 6cc <main+0x658>
					ClearPlayfield(GameMatrix.Playfield);
     8ec:	41f9 0000 3528 	lea 3528 <GameMatrix>,a0
     8f2:	2450           	movea.l (a0),a2
	for (int x = 0; x < GameMatrix.Columns; x++)
     8f4:	3639 0000 3532 	move.w 3532 <GameMatrix+0xa>,d3
     8fa:	6746           	beq.s 942 <main+0x8ce>
		memset(pf[x], 0, GameMatrix.Rows * sizeof(GameOfLifeCell));
     8fc:	7400           	moveq #0,d2
     8fe:	3439 0000 3530 	move.w 3530 <GameMatrix+0x8>,d2
     904:	d482           	add.l d2,d2
     906:	d482           	add.l d2,d2
     908:	0283 0000 ffff 	andi.l #65535,d3
     90e:	d683           	add.l d3,d3
     910:	d683           	add.l d3,d3
     912:	280a           	move.l a2,d4
     914:	d883           	add.l d3,d4
     916:	201a           	move.l (a2)+,d0
     918:	2f02           	move.l d2,-(sp)
     91a:	42a7           	clr.l -(sp)
     91c:	2f00           	move.l d0,-(sp)
     91e:	4e95           	jsr (a5)
	for (int x = 0; x < GameMatrix.Columns; x++)
     920:	4fef 000c      	lea 12(sp),sp
     924:	b5c4           	cmpa.l d4,a2
     926:	66ee           	bne.s 916 <main+0x8a2>
     928:	2479 0000 352c 	movea.l 352c <GameMatrix+0x4>,a2
     92e:	d68a           	add.l a2,d3
		memset(pf[x], 0, GameMatrix.Rows * sizeof(GameOfLifeCell));
     930:	201a           	move.l (a2)+,d0
     932:	2f02           	move.l d2,-(sp)
     934:	42a7           	clr.l -(sp)
     936:	2f00           	move.l d0,-(sp)
     938:	4e95           	jsr (a5)
	for (int x = 0; x < GameMatrix.Columns; x++)
     93a:	4fef 000c      	lea 12(sp),sp
     93e:	b5c3           	cmpa.l d3,a2
     940:	66ee           	bne.s 930 <main+0x8bc>
					DrawCells(theWindow, TRUE);
     942:	2f0b           	move.l a3,-(sp)
     944:	4eb9 0000 0d86 	jsr d86 <DrawCells.constprop.0>
     94a:	588f           	addq.l #4,sp
				menuNumber = item->NextSelect;
     94c:	342c 0020      	move.w 32(a4),d2
			while ((menuNumber != MENUNULL) && (AppRunning))
     950:	0c42 ffff      	cmpi.w #-1,d2
     954:	6600 fdc4      	bne.w 71a <main+0x6a6>
     958:	6000 fb70      	bra.w 4ca <main+0x456>
			UpdateCnt = 0;
     95c:	4279 0000 351a 	clr.w 351a <UpdateCnt>
	GameOfLifeCell **pf = GameMatrix.Playfield;
     962:	43f9 0000 3528 	lea 3528 <GameMatrix>,a1
     968:	2f51 0040      	move.l (a1),64(sp)
	GameOfLifeCell **pf_n1 = GameMatrix.Playfield_n1;
     96c:	2f79 0000 352c 	move.l 352c <GameMatrix+0x4>,68(sp)
     972:	0044 
	for (int x = 1; x < GameMatrix.Columns - 1; x++)
     974:	7000           	moveq #0,d0
     976:	3039 0000 3532 	move.w 3532 <GameMatrix+0xa>,d0
     97c:	2f40 003c      	move.l d0,60(sp)
     980:	7002           	moveq #2,d0
     982:	b0af 003c      	cmp.l 60(sp),d0
     986:	6c00 00e8      	bge.w a70 <main+0x9fc>
		for (int y = 1; y < GameMatrix.Rows - 1; y++)
     98a:	3f79 0000 3530 	move.w 3530 <GameMatrix+0x8>,52(sp)
     990:	0034 
				UpdateList[UpdateCnt].X = x;
     992:	2c39 0000 3510 	move.l 3510 <UpdateList>,d6
     998:	286f 0044      	movea.l 68(sp),a4
     99c:	588c           	addq.l #4,a4
     99e:	2c6f 0040      	movea.l 64(sp),a6
     9a2:	202f 003c      	move.l 60(sp),d0
     9a6:	5380           	subq.l #1,d0
     9a8:	2f40 0038      	move.l d0,56(sp)
     9ac:	7a01           	moveq #1,d5
     9ae:	4243           	clr.w d3
     9b0:	382f 0034      	move.w 52(sp),d4
     9b4:	5344           	subq.w #1,d4
		for (int y = 1; y < GameMatrix.Rows - 1; y++)
     9b6:	0c6f 0002 0034 	cmpi.w #2,52(sp)
     9bc:	6300 009e      	bls.w a5c <main+0x9e8>
     9c0:	2456           	movea.l (a6),a2
     9c2:	226e 0004      	movea.l 4(a6),a1
					if (pf[x + xi][y + yj].Status)
     9c6:	206e 0008      	movea.l 8(a6),a0
     9ca:	7201           	moveq #1,d1
     9cc:	7004           	moveq #4,d0
     9ce:	9088           	sub.l a0,d0
     9d0:	2f40 002c      	move.l d0,44(sp)
     9d4:	4a12           	tst.b (a2)
     9d6:	56c0           	sne d0
     9d8:	4880           	ext.w d0
     9da:	4440           	neg.w d0
     9dc:	2e2f 002c      	move.l 44(sp),d7
     9e0:	de88           	add.l a0,d7
     9e2:	4a2a 0004      	tst.b 4(a2)
     9e6:	6702           	beq.s 9ea <main+0x976>
						neighbours++;
     9e8:	5240           	addq.w #1,d0
					if (pf[x + xi][y + yj].Status)
     9ea:	4a2a 0008      	tst.b 8(a2)
     9ee:	6702           	beq.s 9f2 <main+0x97e>
						neighbours++;
     9f0:	5240           	addq.w #1,d0
					if (pf[x + xi][y + yj].Status)
     9f2:	4a11           	tst.b (a1)
     9f4:	6702           	beq.s 9f8 <main+0x984>
						neighbours++;
     9f6:	5240           	addq.w #1,d0
					if (pf[x + xi][y + yj].Status)
     9f8:	1429 0004      	move.b 4(a1),d2
     9fc:	6702           	beq.s a00 <main+0x98c>
						neighbours++;
     9fe:	5240           	addq.w #1,d0
					if (pf[x + xi][y + yj].Status)
     a00:	4a29 0008      	tst.b 8(a1)
     a04:	6702           	beq.s a08 <main+0x994>
						neighbours++;
     a06:	5240           	addq.w #1,d0
					if (pf[x + xi][y + yj].Status)
     a08:	4a10           	tst.b (a0)
     a0a:	6702           	beq.s a0e <main+0x99a>
						neighbours++;
     a0c:	5240           	addq.w #1,d0
					if (pf[x + xi][y + yj].Status)
     a0e:	4a28 0004      	tst.b 4(a0)
     a12:	6702           	beq.s a16 <main+0x9a2>
						neighbours++;
     a14:	5240           	addq.w #1,d0
					if (pf[x + xi][y + yj].Status)
     a16:	4a28 0008      	tst.b 8(a0)
     a1a:	6702           	beq.s a1e <main+0x9aa>
						neighbours++;
     a1c:	5240           	addq.w #1,d0
			if (pf[x][y].Status)
     a1e:	4a02           	tst.b d2
     a20:	6700 00a8      	beq.w aca <main+0xa56>
					pf_n1[x][y].Status = 0;
     a24:	2654           	movea.l (a4),a3
     a26:	d7c7           	adda.l d7,a3
				if (neighbours < 2 || neighbours > 3)
     a28:	5740           	subq.w #3,d0
     a2a:	0c40 0001      	cmpi.w #1,d0
     a2e:	6300 00d8      	bls.w b08 <main+0xa94>
					pf_n1[x][y].Status = 0;
     a32:	4213           	clr.b (a3)
					UpdateList[UpdateCnt].X = x;
     a34:	7000           	moveq #0,d0
     a36:	3003           	move.w d3,d0
     a38:	2640           	movea.l d0,a3
     a3a:	d7c0           	adda.l d0,a3
     a3c:	d7c0           	adda.l d0,a3
     a3e:	d7cb           	adda.l a3,a3
     a40:	d7c6           	adda.l d6,a3
     a42:	3685           	move.w d5,(a3)
					UpdateList[UpdateCnt].Y = y;
     a44:	3741 0002      	move.w d1,2(a3)
					UpdateList[UpdateCnt].Status = pf_n1[x][y].Status;
     a48:	426b 0004      	clr.w 4(a3)
					UpdateCnt++;
     a4c:	5243           	addq.w #1,d3
		for (int y = 1; y < GameMatrix.Rows - 1; y++)
     a4e:	588a           	addq.l #4,a2
     a50:	5241           	addq.w #1,d1
     a52:	5888           	addq.l #4,a0
     a54:	5889           	addq.l #4,a1
     a56:	b244           	cmp.w d4,d1
     a58:	6600 ff7a      	bne.w 9d4 <main+0x960>
	for (int x = 1; x < GameMatrix.Columns - 1; x++)
     a5c:	5285           	addq.l #1,d5
     a5e:	588c           	addq.l #4,a4
     a60:	588e           	addq.l #4,a6
     a62:	baaf 0038      	cmp.l 56(sp),d5
     a66:	6600 ff4e      	bne.w 9b6 <main+0x942>
     a6a:	33c3 0000 351a 	move.w d3,351a <UpdateCnt>
	for (int col = 0; col < GameMatrix.Columns; col++)
     a70:	4aaf 003c      	tst.l 60(sp)
     a74:	6700 fb24      	beq.w 59a <main+0x526>
		memcpy(pf[col], pf_n1[col], GameMatrix.Rows * sizeof(GameOfLifeCell));
     a78:	7600           	moveq #0,d3
     a7a:	3639 0000 3530 	move.w 3530 <GameMatrix+0x8>,d3
     a80:	d683           	add.l d3,d3
     a82:	d683           	add.l d3,d3
     a84:	246f 0044      	movea.l 68(sp),a2
     a88:	266f 0040      	movea.l 64(sp),a3
     a8c:	242f 003c      	move.l 60(sp),d2
     a90:	d482           	add.l d2,d2
     a92:	d482           	add.l d2,d2
     a94:	d48a           	add.l a2,d2
     a96:	49f9 0000 1042 	lea 1042 <memcpy>,a4
     a9c:	221a           	move.l (a2)+,d1
     a9e:	201b           	move.l (a3)+,d0
     aa0:	2f03           	move.l d3,-(sp)
     aa2:	2f01           	move.l d1,-(sp)
     aa4:	2f00           	move.l d0,-(sp)
     aa6:	4e94           	jsr (a4)
	for (int col = 0; col < GameMatrix.Columns; col++)
     aa8:	4fef 000c      	lea 12(sp),sp
     aac:	b48a           	cmp.l a2,d2
     aae:	6700 faea      	beq.w 59a <main+0x526>
		memcpy(pf[col], pf_n1[col], GameMatrix.Rows * sizeof(GameOfLifeCell));
     ab2:	221a           	move.l (a2)+,d1
     ab4:	201b           	move.l (a3)+,d0
     ab6:	2f03           	move.l d3,-(sp)
     ab8:	2f01           	move.l d1,-(sp)
     aba:	2f00           	move.l d0,-(sp)
     abc:	4e94           	jsr (a4)
	for (int col = 0; col < GameMatrix.Columns; col++)
     abe:	4fef 000c      	lea 12(sp),sp
     ac2:	b48a           	cmp.l a2,d2
     ac4:	66d6           	bne.s a9c <main+0xa28>
     ac6:	6000 fad2      	bra.w 59a <main+0x526>
			else if (neighbours == 3)
     aca:	0c40 0003      	cmpi.w #3,d0
     ace:	6600 ff7e      	bne.w a4e <main+0x9da>
				pf_n1[x][y].Status = 1;
     ad2:	2654           	movea.l (a4),a3
     ad4:	17bc 0001 7800 	move.b #1,(0,a3,d7.l)
				UpdateList[UpdateCnt].X = x;
     ada:	7000           	moveq #0,d0
     adc:	3003           	move.w d3,d0
     ade:	2640           	movea.l d0,a3
     ae0:	d7c0           	adda.l d0,a3
     ae2:	d7c0           	adda.l d0,a3
     ae4:	d7cb           	adda.l a3,a3
     ae6:	d7c6           	adda.l d6,a3
     ae8:	3685           	move.w d5,(a3)
				UpdateList[UpdateCnt].Y = y;
     aea:	3741 0002      	move.w d1,2(a3)
				UpdateList[UpdateCnt].Status = pf_n1[x][y].Status;
     aee:	377c 0001 0004 	move.w #1,4(a3)
				UpdateCnt++;
     af4:	5243           	addq.w #1,d3
		for (int y = 1; y < GameMatrix.Rows - 1; y++)
     af6:	588a           	addq.l #4,a2
     af8:	5241           	addq.w #1,d1
     afa:	5888           	addq.l #4,a0
     afc:	5889           	addq.l #4,a1
     afe:	b244           	cmp.w d4,d1
     b00:	6600 fed2      	bne.w 9d4 <main+0x960>
     b04:	6000 ff56      	bra.w a5c <main+0x9e8>
					pf_n1[x][y].Status = pf[x][y].Status;
     b08:	1682           	move.b d2,(a3)
		for (int y = 1; y < GameMatrix.Rows - 1; y++)
     b0a:	588a           	addq.l #4,a2
     b0c:	5241           	addq.w #1,d1
     b0e:	5888           	addq.l #4,a0
     b10:	5889           	addq.l #4,a1
     b12:	b244           	cmp.w d4,d1
     b14:	6600 febe      	bne.w 9d4 <main+0x960>
     b18:	6000 ff42      	bra.w a5c <main+0x9e8>
     b1c:	2647           	movea.l d7,a3
     b1e:	2e06           	move.l d6,d7
     b20:	6000 f9a8      	bra.w 4ca <main+0x456>
     b24:	7000           	moveq #0,d0
}
     b26:	4cdf 7cfc      	movem.l (sp)+,d2-d7/a2-a6
     b2a:	4fef 00c4      	lea 196(sp),sp
     b2e:	4e75           	rts
	for (int i = 0; i < GameMatrix.Columns; i++)
     b30:	7000           	moveq #0,d0
     b32:	6000 f8c2      	bra.w 3f6 <main+0x382>
     b36:	4e71           	nop

00000b38 <ToggleCellStatus>:
{
     b38:	48e7 3020      	movem.l d2-d3/a2,-(sp)
     b3c:	262f 0014      	move.l 20(sp),d3
	int x = coordX / GameMatrix.CellSizeH + 1;
     b40:	7000           	moveq #0,d0
     b42:	3039 0000 3538 	move.w 3538 <GameMatrix+0x10>,d0
     b48:	45f9 0000 1206 	lea 1206 <__divsi3>,a2
     b4e:	2f00           	move.l d0,-(sp)
     b50:	306f 0016      	movea.w 22(sp),a0
     b54:	2f08           	move.l a0,-(sp)
     b56:	4e92           	jsr (a2)
     b58:	508f           	addq.l #8,sp
     b5a:	2400           	move.l d0,d2
     b5c:	5282           	addq.l #1,d2
	if (!(x < 0 || x > GameMatrix.Columns - 1 || y < 0 || y > GameMatrix.Rows))
     b5e:	6b78           	bmi.s bd8 <ToggleCellStatus+0xa0>
     b60:	7000           	moveq #0,d0
     b62:	3039 0000 3532 	move.w 3532 <GameMatrix+0xa>,d0
     b68:	b480           	cmp.l d0,d2
     b6a:	6c6c           	bge.s bd8 <ToggleCellStatus+0xa0>
	int y = coordY / GameMatrix.CellSizeV + 1;
     b6c:	7000           	moveq #0,d0
     b6e:	3039 0000 353a 	move.w 353a <GameMatrix+0x12>,d0
     b74:	2f00           	move.l d0,-(sp)
     b76:	3043           	movea.w d3,a0
     b78:	2f08           	move.l a0,-(sp)
     b7a:	4e92           	jsr (a2)
     b7c:	508f           	addq.l #8,sp
     b7e:	5280           	addq.l #1,d0
	if (!(x < 0 || x > GameMatrix.Columns - 1 || y < 0 || y > GameMatrix.Rows))
     b80:	6b56           	bmi.s bd8 <ToggleCellStatus+0xa0>
     b82:	7200           	moveq #0,d1
     b84:	3239 0000 3530 	move.w 3530 <GameMatrix+0x8>,d1
     b8a:	b081           	cmp.l d1,d0
     b8c:	6e4a           	bgt.s bd8 <ToggleCellStatus+0xa0>
		if (GameMatrix.Playfield[x][y].Status)
     b8e:	2279 0000 3528 	movea.l 3528 <GameMatrix>,a1
     b94:	2202           	move.l d2,d1
     b96:	d282           	add.l d2,d1
     b98:	2041           	movea.l d1,a0
     b9a:	d1c1           	adda.l d1,a0
     b9c:	2200           	move.l d0,d1
     b9e:	d280           	add.l d0,d1
     ba0:	d281           	add.l d1,d1
     ba2:	2270 9800      	movea.l (0,a0,a1.l),a1
     ba6:	d3c1           	adda.l d1,a1
			UpdateList[UpdateCnt].X = x;
     ba8:	3239 0000 351a 	move.w 351a <UpdateCnt>,d1
     bae:	7600           	moveq #0,d3
     bb0:	3601           	move.w d1,d3
     bb2:	2043           	movea.l d3,a0
     bb4:	d1c3           	adda.l d3,a0
     bb6:	d1c3           	adda.l d3,a0
     bb8:	d1c8           	adda.l a0,a0
     bba:	d1f9 0000 3510 	adda.l 3510 <UpdateList>,a0
			UpdateCnt++;
     bc0:	5241           	addq.w #1,d1
		if (GameMatrix.Playfield[x][y].Status)
     bc2:	4a11           	tst.b (a1)
     bc4:	6718           	beq.s bde <ToggleCellStatus+0xa6>
			GameMatrix.Playfield[x][y].Status = 0;
     bc6:	4211           	clr.b (a1)
			UpdateList[UpdateCnt].X = x;
     bc8:	3082           	move.w d2,(a0)
			UpdateList[UpdateCnt].Y = y;
     bca:	3140 0002      	move.w d0,2(a0)
			UpdateList[UpdateCnt].Status = 0;
     bce:	4268 0004      	clr.w 4(a0)
			UpdateCnt++;
     bd2:	33c1 0000 351a 	move.w d1,351a <UpdateCnt>
}
     bd8:	4cdf 040c      	movem.l (sp)+,d2-d3/a2
     bdc:	4e75           	rts
			GameMatrix.Playfield[x][y].Status = 1;
     bde:	12bc 0001      	move.b #1,(a1)
			UpdateList[UpdateCnt].X = x;
     be2:	3082           	move.w d2,(a0)
			UpdateList[UpdateCnt].Y = y;
     be4:	3140 0002      	move.w d0,2(a0)
			UpdateList[UpdateCnt].Status = 1;
     be8:	317c 0001 0004 	move.w #1,4(a0)
			UpdateCnt++;
     bee:	33c1 0000 351a 	move.w d1,351a <UpdateCnt>
}
     bf4:	4cdf 040c      	movem.l (sp)+,d2-d3/a2
     bf8:	4e75           	rts

00000bfa <DrawAllCells>:

	return RETURN_OK;
}

void DrawAllCells(struct Window *theWindow)
{
     bfa:	4fef fff0      	lea -16(sp),sp
     bfe:	48e7 3f3e      	movem.l d2-d7/a2-a6,-(sp)
     c02:	266f 0040      	movea.l 64(sp),a3
	//SetFillPattern(theWindow->RPort);
	for (int y = 1; y < GameMatrix.Rows - 1; y++)
     c06:	0c79 0002 0000 	cmpi.w #2,3530 <GameMatrix+0x8>
     c0c:	3530 
     c0e:	6300 00f0      	bls.w d00 <DrawAllCells+0x106>
	{
		for (int x = 1; x < GameMatrix.Columns - 1; x++)
     c12:	3239 0000 3532 	move.w 3532 <GameMatrix+0xa>,d1
     c18:	7004           	moveq #4,d0
     c1a:	2f40 0030      	move.l d0,48(sp)
	for (int y = 1; y < GameMatrix.Rows - 1; y++)
     c1e:	7001           	moveq #1,d0
     c20:	2f40 0038      	move.l d0,56(sp)
     c24:	4bf9 0000 3528 	lea 3528 <GameMatrix>,a5
     c2a:	49f9 0000 1188 	lea 1188 <__mulsi3>,a4
		for (int x = 1; x < GameMatrix.Columns - 1; x++)
     c30:	0c41 0002      	cmpi.w #2,d1
     c34:	6300 00ca      	bls.w d00 <DrawAllCells+0x106>
     c38:	202f 0038      	move.l 56(sp),d0
     c3c:	5380           	subq.l #1,d0
     c3e:	2f40 0034      	move.l d0,52(sp)
     c42:	7804           	moveq #4,d4
     c44:	347c 0001      	movea.w #1,a2
		{
			GameMatrix.Playfield[x][y].StatusChanged = FALSE;
     c48:	2055           	movea.l (a5),a0
     c4a:	2070 4800      	movea.l (0,a0,d4.l),a0
     c4e:	d1ef 0030      	adda.l 48(sp),a0
     c52:	4268 0002      	clr.w 2(a0)

			if (GameMatrix.Playfield[x][y].Status)
				SetAPen(theWindow->RPort, GameMatrix.ColorAlive);
     c56:	2c79 0000 34f4 	movea.l 34f4 <GfxBase>,a6
     c5c:	226b 0032      	movea.l 50(a3),a1
     c60:	7000           	moveq #0,d0
			if (GameMatrix.Playfield[x][y].Status)
     c62:	4a10           	tst.b (a0)
     c64:	6700 00a4      	beq.w d0a <DrawAllCells+0x110>
				SetAPen(theWindow->RPort, GameMatrix.ColorAlive);
     c68:	3039 0000 3534 	move.w 3534 <GameMatrix+0xc>,d0
     c6e:	4eae feaa      	jsr -342(a6)
			else
				SetAPen(theWindow->RPort, GameMatrix.ColorDead);

			RectFill(theWindow->RPort,
     c72:	226b 0032      	movea.l 50(a3),a1
     c76:	7a00           	moveq #0,d5
     c78:	3a39 0000 3538 	move.w 3538 <GameMatrix+0x10>,d5
     c7e:	2f05           	move.l d5,-(sp)
     c80:	486a ffff      	pea -1(a2)
     c84:	2f49 0034      	move.l a1,52(sp)
     c88:	4e94           	jsr (a4)
     c8a:	508f           	addq.l #8,sp
     c8c:	2400           	move.l d0,d2
     c8e:	2c00           	move.l d0,d6
     c90:	5286           	addq.l #1,d6
     c92:	7e00           	moveq #0,d7
     c94:	3e39 0000 353a 	move.w 353a <GameMatrix+0x12>,d7
     c9a:	2f2f 0034      	move.l 52(sp),-(sp)
     c9e:	2f07           	move.l d7,-(sp)
     ca0:	4e94           	jsr (a4)
     ca2:	508f           	addq.l #8,sp
     ca4:	2600           	move.l d0,d3
     ca6:	2c79 0000 34f4 	movea.l 34f4 <GfxBase>,a6
     cac:	226f 002c      	movea.l 44(sp),a1
     cb0:	2006           	move.l d6,d0
     cb2:	2203           	move.l d3,d1
     cb4:	5281           	addq.l #1,d1
     cb6:	2045           	movea.l d5,a0
     cb8:	41f0 28ff      	lea (-1,a0,d2.l),a0
     cbc:	2408           	move.l a0,d2
     cbe:	2047           	movea.l d7,a0
     cc0:	41f0 38ff      	lea (-1,a0,d3.l),a0
     cc4:	2608           	move.l a0,d3
     cc6:	4eae fece      	jsr -306(a6)
		for (int x = 1; x < GameMatrix.Columns - 1; x++)
     cca:	528a           	addq.l #1,a2
     ccc:	3239 0000 3532 	move.w 3532 <GameMatrix+0xa>,d1
     cd2:	5884           	addq.l #4,d4
     cd4:	7000           	moveq #0,d0
     cd6:	3001           	move.w d1,d0
     cd8:	5380           	subq.l #1,d0
     cda:	b5c0           	cmpa.l d0,a2
     cdc:	6d00 ff6a      	blt.w c48 <DrawAllCells+0x4e>
	for (int y = 1; y < GameMatrix.Rows - 1; y++)
     ce0:	52af 0038      	addq.l #1,56(sp)
     ce4:	7000           	moveq #0,d0
     ce6:	3039 0000 3530 	move.w 3530 <GameMatrix+0x8>,d0
     cec:	5380           	subq.l #1,d0
     cee:	b0af 0038      	cmp.l 56(sp),d0
     cf2:	6f0c           	ble.s d00 <DrawAllCells+0x106>
     cf4:	58af 0030      	addq.l #4,48(sp)
		for (int x = 1; x < GameMatrix.Columns - 1; x++)
     cf8:	0c41 0002      	cmpi.w #2,d1
     cfc:	6200 ff3a      	bhi.w c38 <DrawAllCells+0x3e>
					 (y - 1) * GameMatrix.CellSizeV + 1,
					 (x - 1) * GameMatrix.CellSizeH + GameMatrix.CellSizeH - 1,
					 (y - 1) * GameMatrix.CellSizeV + GameMatrix.CellSizeV - 1);
		}
	}
}
     d00:	4cdf 7cfc      	movem.l (sp)+,d2-d7/a2-a6
     d04:	4fef 0010      	lea 16(sp),sp
     d08:	4e75           	rts
				SetAPen(theWindow->RPort, GameMatrix.ColorDead);
     d0a:	3039 0000 3536 	move.w 3536 <GameMatrix+0xe>,d0
     d10:	4eae feaa      	jsr -342(a6)
			RectFill(theWindow->RPort,
     d14:	226b 0032      	movea.l 50(a3),a1
     d18:	7a00           	moveq #0,d5
     d1a:	3a39 0000 3538 	move.w 3538 <GameMatrix+0x10>,d5
     d20:	2f05           	move.l d5,-(sp)
     d22:	486a ffff      	pea -1(a2)
     d26:	2f49 0034      	move.l a1,52(sp)
     d2a:	4e94           	jsr (a4)
     d2c:	508f           	addq.l #8,sp
     d2e:	2400           	move.l d0,d2
     d30:	2c00           	move.l d0,d6
     d32:	5286           	addq.l #1,d6
     d34:	7e00           	moveq #0,d7
     d36:	3e39 0000 353a 	move.w 353a <GameMatrix+0x12>,d7
     d3c:	2f2f 0034      	move.l 52(sp),-(sp)
     d40:	2f07           	move.l d7,-(sp)
     d42:	4e94           	jsr (a4)
     d44:	508f           	addq.l #8,sp
     d46:	2600           	move.l d0,d3
     d48:	2c79 0000 34f4 	movea.l 34f4 <GfxBase>,a6
     d4e:	226f 002c      	movea.l 44(sp),a1
     d52:	2006           	move.l d6,d0
     d54:	2203           	move.l d3,d1
     d56:	5281           	addq.l #1,d1
     d58:	2045           	movea.l d5,a0
     d5a:	41f0 28ff      	lea (-1,a0,d2.l),a0
     d5e:	2408           	move.l a0,d2
     d60:	2047           	movea.l d7,a0
     d62:	41f0 38ff      	lea (-1,a0,d3.l),a0
     d66:	2608           	move.l a0,d3
     d68:	4eae fece      	jsr -306(a6)
		for (int x = 1; x < GameMatrix.Columns - 1; x++)
     d6c:	528a           	addq.l #1,a2
     d6e:	3239 0000 3532 	move.w 3532 <GameMatrix+0xa>,d1
     d74:	5884           	addq.l #4,d4
     d76:	7000           	moveq #0,d0
     d78:	3001           	move.w d1,d0
     d7a:	5380           	subq.l #1,d0
     d7c:	b5c0           	cmpa.l d0,a2
     d7e:	6d00 fec8      	blt.w c48 <DrawAllCells+0x4e>
     d82:	6000 ff5c      	bra.w ce0 <DrawAllCells+0xe6>

00000d86 <DrawCells.constprop.0>:
void DrawCells(struct Window *theWindow, BOOL forceFull)
     d86:	48e7 3f3e      	movem.l d2-d7/a2-a6,-(sp)
     d8a:	266f 0030      	movea.l 48(sp),a3
	for (int entry = 0; entry < UpdateCnt; entry++)
     d8e:	4a79 0000 351a 	tst.w 351a <UpdateCnt>
     d94:	6700 00a0      	beq.w e36 <DrawCells.constprop.0+0xb0>
     d98:	7a00           	moveq #0,d5
     d9a:	7800           	moveq #0,d4
     d9c:	49f9 0000 1188 	lea 1188 <__mulsi3>,a4
		int x = UpdateList[entry].X;
     da2:	2079 0000 3510 	movea.l 3510 <UpdateList>,a0
     da8:	d1c5           	adda.l d5,a0
     daa:	7c00           	moveq #0,d6
     dac:	3c10           	move.w (a0),d6
		int y = UpdateList[entry].Y;
     dae:	7600           	moveq #0,d3
     db0:	3628 0002      	move.w 2(a0),d3
			SetAPen(theWindow->RPort, GameMatrix.ColorAlive);
     db4:	226b 0032      	movea.l 50(a3),a1
     db8:	2c79 0000 34f4 	movea.l 34f4 <GfxBase>,a6
     dbe:	7000           	moveq #0,d0
		if (s)
     dc0:	4a68 0004      	tst.w 4(a0)
     dc4:	6776           	beq.s e3c <DrawCells.constprop.0+0xb6>
			SetAPen(theWindow->RPort, GameMatrix.ColorAlive);
     dc6:	3039 0000 3534 	move.w 3534 <GameMatrix+0xc>,d0
     dcc:	4eae feaa      	jsr -342(a6)
		RectFill(theWindow->RPort,
     dd0:	2a6b 0032      	movea.l 50(a3),a5
     dd4:	7400           	moveq #0,d2
     dd6:	3439 0000 3538 	move.w 3538 <GameMatrix+0x10>,d2
     ddc:	2f02           	move.l d2,-(sp)
     dde:	2046           	movea.l d6,a0
     de0:	4868 ffff      	pea -1(a0)
     de4:	4e94           	jsr (a4)
     de6:	508f           	addq.l #8,sp
     de8:	2440           	movea.l d0,a2
     dea:	2e00           	move.l d0,d7
     dec:	5287           	addq.l #1,d7
     dee:	7c00           	moveq #0,d6
     df0:	3c39 0000 353a 	move.w 353a <GameMatrix+0x12>,d6
     df6:	2f06           	move.l d6,-(sp)
     df8:	2043           	movea.l d3,a0
     dfa:	4868 ffff      	pea -1(a0)
     dfe:	4e94           	jsr (a4)
     e00:	508f           	addq.l #8,sp
     e02:	2600           	move.l d0,d3
     e04:	2c79 0000 34f4 	movea.l 34f4 <GfxBase>,a6
     e0a:	224d           	movea.l a5,a1
     e0c:	2007           	move.l d7,d0
     e0e:	2203           	move.l d3,d1
     e10:	5281           	addq.l #1,d1
     e12:	45f2 28ff      	lea (-1,a2,d2.l),a2
     e16:	240a           	move.l a2,d2
     e18:	2046           	movea.l d6,a0
     e1a:	41f0 38ff      	lea (-1,a0,d3.l),a0
     e1e:	2608           	move.l a0,d3
     e20:	4eae fece      	jsr -306(a6)
	for (int entry = 0; entry < UpdateCnt; entry++)
     e24:	5284           	addq.l #1,d4
     e26:	5c85           	addq.l #6,d5
     e28:	7000           	moveq #0,d0
     e2a:	3039 0000 351a 	move.w 351a <UpdateCnt>,d0
     e30:	b084           	cmp.l d4,d0
     e32:	6e00 ff6e      	bgt.w da2 <DrawCells.constprop.0+0x1c>
}
     e36:	4cdf 7cfc      	movem.l (sp)+,d2-d7/a2-a6
     e3a:	4e75           	rts
			SetAPen(theWindow->RPort, GameMatrix.ColorDead);
     e3c:	3039 0000 3536 	move.w 3536 <GameMatrix+0xe>,d0
     e42:	4eae feaa      	jsr -342(a6)
		RectFill(theWindow->RPort,
     e46:	2a6b 0032      	movea.l 50(a3),a5
     e4a:	7400           	moveq #0,d2
     e4c:	3439 0000 3538 	move.w 3538 <GameMatrix+0x10>,d2
     e52:	2f02           	move.l d2,-(sp)
     e54:	2046           	movea.l d6,a0
     e56:	4868 ffff      	pea -1(a0)
     e5a:	4e94           	jsr (a4)
     e5c:	508f           	addq.l #8,sp
     e5e:	2440           	movea.l d0,a2
     e60:	2e00           	move.l d0,d7
     e62:	5287           	addq.l #1,d7
     e64:	7c00           	moveq #0,d6
     e66:	3c39 0000 353a 	move.w 353a <GameMatrix+0x12>,d6
     e6c:	2f06           	move.l d6,-(sp)
     e6e:	2043           	movea.l d3,a0
     e70:	4868 ffff      	pea -1(a0)
     e74:	4e94           	jsr (a4)
     e76:	508f           	addq.l #8,sp
     e78:	2600           	move.l d0,d3
     e7a:	2c79 0000 34f4 	movea.l 34f4 <GfxBase>,a6
     e80:	224d           	movea.l a5,a1
     e82:	2007           	move.l d7,d0
     e84:	2203           	move.l d3,d1
     e86:	5281           	addq.l #1,d1
     e88:	45f2 28ff      	lea (-1,a2,d2.l),a2
     e8c:	240a           	move.l a2,d2
     e8e:	2046           	movea.l d6,a0
     e90:	41f0 38ff      	lea (-1,a0,d3.l),a0
     e94:	2608           	move.l a0,d3
     e96:	4eae fece      	jsr -306(a6)
	for (int entry = 0; entry < UpdateCnt; entry++)
     e9a:	5284           	addq.l #1,d4
     e9c:	5c85           	addq.l #6,d5
     e9e:	7000           	moveq #0,d0
     ea0:	3039 0000 351a 	move.w 351a <UpdateCnt>,d0
     ea6:	b084           	cmp.l d4,d0
     ea8:	6e00 fef8      	bgt.w da2 <DrawCells.constprop.0+0x1c>
     eac:	6088           	bra.s e36 <DrawCells.constprop.0+0xb0>

00000eae <memset.constprop.0>:
	void* memset(void *dest, int val, unsigned long len)
     eae:	2f0a           	move.l a2,-(sp)
     eb0:	2f02           	move.l d2,-(sp)
     eb2:	202f 000c      	move.l 12(sp),d0
     eb6:	206f 0014      	movea.l 20(sp),a0
	while(len-- > 0)
     eba:	43e8 ffff      	lea -1(a0),a1
     ebe:	b0fc 0000      	cmpa.w #0,a0
     ec2:	6700 0096      	beq.w f5a <memset.constprop.0+0xac>
     ec6:	2200           	move.l d0,d1
     ec8:	4481           	neg.l d1
     eca:	7403           	moveq #3,d2
     ecc:	c282           	and.l d2,d1
     ece:	7405           	moveq #5,d2
		*ptr++ = val;
     ed0:	2440           	movea.l d0,a2
     ed2:	b489           	cmp.l a1,d2
     ed4:	6450           	bcc.s f26 <memset.constprop.0+0x78>
     ed6:	4a81           	tst.l d1
     ed8:	672c           	beq.s f06 <memset.constprop.0+0x58>
     eda:	421a           	clr.b (a2)+
	while(len-- > 0)
     edc:	43e8 fffe      	lea -2(a0),a1
     ee0:	7401           	moveq #1,d2
     ee2:	b481           	cmp.l d1,d2
     ee4:	6720           	beq.s f06 <memset.constprop.0+0x58>
		*ptr++ = val;
     ee6:	2440           	movea.l d0,a2
     ee8:	548a           	addq.l #2,a2
     eea:	2240           	movea.l d0,a1
     eec:	4229 0001      	clr.b 1(a1)
	while(len-- > 0)
     ef0:	43e8 fffd      	lea -3(a0),a1
     ef4:	7403           	moveq #3,d2
     ef6:	b481           	cmp.l d1,d2
     ef8:	660c           	bne.s f06 <memset.constprop.0+0x58>
		*ptr++ = val;
     efa:	528a           	addq.l #1,a2
     efc:	2240           	movea.l d0,a1
     efe:	4229 0002      	clr.b 2(a1)
	while(len-- > 0)
     f02:	43e8 fffc      	lea -4(a0),a1
     f06:	2408           	move.l a0,d2
     f08:	9481           	sub.l d1,d2
     f0a:	2040           	movea.l d0,a0
     f0c:	d1c1           	adda.l d1,a0
     f0e:	72fc           	moveq #-4,d1
     f10:	c282           	and.l d2,d1
     f12:	d288           	add.l a0,d1
		*ptr++ = val;
     f14:	4298           	clr.l (a0)+
     f16:	b1c1           	cmpa.l d1,a0
     f18:	66fa           	bne.s f14 <memset.constprop.0+0x66>
     f1a:	72fc           	moveq #-4,d1
     f1c:	c282           	and.l d2,d1
     f1e:	d5c1           	adda.l d1,a2
     f20:	93c1           	suba.l d1,a1
     f22:	b282           	cmp.l d2,d1
     f24:	6734           	beq.s f5a <memset.constprop.0+0xac>
     f26:	4212           	clr.b (a2)
	while(len-- > 0)
     f28:	b2fc 0000      	cmpa.w #0,a1
     f2c:	672c           	beq.s f5a <memset.constprop.0+0xac>
		*ptr++ = val;
     f2e:	422a 0001      	clr.b 1(a2)
	while(len-- > 0)
     f32:	7201           	moveq #1,d1
     f34:	b289           	cmp.l a1,d1
     f36:	6722           	beq.s f5a <memset.constprop.0+0xac>
		*ptr++ = val;
     f38:	422a 0002      	clr.b 2(a2)
	while(len-- > 0)
     f3c:	7402           	moveq #2,d2
     f3e:	b489           	cmp.l a1,d2
     f40:	6718           	beq.s f5a <memset.constprop.0+0xac>
		*ptr++ = val;
     f42:	422a 0003      	clr.b 3(a2)
	while(len-- > 0)
     f46:	7203           	moveq #3,d1
     f48:	b289           	cmp.l a1,d1
     f4a:	670e           	beq.s f5a <memset.constprop.0+0xac>
		*ptr++ = val;
     f4c:	422a 0004      	clr.b 4(a2)
	while(len-- > 0)
     f50:	7404           	moveq #4,d2
     f52:	b489           	cmp.l a1,d2
     f54:	6704           	beq.s f5a <memset.constprop.0+0xac>
		*ptr++ = val;
     f56:	422a 0005      	clr.b 5(a2)
}
     f5a:	241f           	move.l (sp)+,d2
     f5c:	245f           	movea.l (sp)+,a2
     f5e:	4e75           	rts

00000f60 <strlen>:
{
     f60:	206f 0004      	movea.l 4(sp),a0
	unsigned long t=0;
     f64:	7000           	moveq #0,d0
	while(*s++)
     f66:	4a10           	tst.b (a0)
     f68:	6708           	beq.s f72 <strlen+0x12>
		t++;
     f6a:	5280           	addq.l #1,d0
	while(*s++)
     f6c:	4a30 0800      	tst.b (0,a0,d0.l)
     f70:	66f8           	bne.s f6a <strlen+0xa>
}
     f72:	4e75           	rts

00000f74 <memset>:
{
     f74:	48e7 3f30      	movem.l d2-d7/a2-a3,-(sp)
     f78:	202f 0024      	move.l 36(sp),d0
     f7c:	282f 0028      	move.l 40(sp),d4
     f80:	226f 002c      	movea.l 44(sp),a1
	while(len-- > 0)
     f84:	2a09           	move.l a1,d5
     f86:	5385           	subq.l #1,d5
     f88:	b2fc 0000      	cmpa.w #0,a1
     f8c:	6700 00ae      	beq.w 103c <memset+0xc8>
		*ptr++ = val;
     f90:	1e04           	move.b d4,d7
     f92:	2200           	move.l d0,d1
     f94:	4481           	neg.l d1
     f96:	7403           	moveq #3,d2
     f98:	c282           	and.l d2,d1
     f9a:	7c05           	moveq #5,d6
     f9c:	2440           	movea.l d0,a2
     f9e:	bc85           	cmp.l d5,d6
     fa0:	646a           	bcc.s 100c <memset+0x98>
     fa2:	4a81           	tst.l d1
     fa4:	6724           	beq.s fca <memset+0x56>
     fa6:	14c4           	move.b d4,(a2)+
	while(len-- > 0)
     fa8:	5385           	subq.l #1,d5
     faa:	7401           	moveq #1,d2
     fac:	b481           	cmp.l d1,d2
     fae:	671a           	beq.s fca <memset+0x56>
		*ptr++ = val;
     fb0:	2440           	movea.l d0,a2
     fb2:	548a           	addq.l #2,a2
     fb4:	2040           	movea.l d0,a0
     fb6:	1144 0001      	move.b d4,1(a0)
	while(len-- > 0)
     fba:	5385           	subq.l #1,d5
     fbc:	7403           	moveq #3,d2
     fbe:	b481           	cmp.l d1,d2
     fc0:	6608           	bne.s fca <memset+0x56>
		*ptr++ = val;
     fc2:	528a           	addq.l #1,a2
     fc4:	1144 0002      	move.b d4,2(a0)
	while(len-- > 0)
     fc8:	5385           	subq.l #1,d5
     fca:	2609           	move.l a1,d3
     fcc:	9681           	sub.l d1,d3
     fce:	7c00           	moveq #0,d6
     fd0:	1c04           	move.b d4,d6
     fd2:	2406           	move.l d6,d2
     fd4:	4842           	swap d2
     fd6:	4242           	clr.w d2
     fd8:	2042           	movea.l d2,a0
     fda:	2404           	move.l d4,d2
     fdc:	e14a           	lsl.w #8,d2
     fde:	4842           	swap d2
     fe0:	4242           	clr.w d2
     fe2:	e18e           	lsl.l #8,d6
     fe4:	2646           	movea.l d6,a3
     fe6:	2c08           	move.l a0,d6
     fe8:	8486           	or.l d6,d2
     fea:	2c0b           	move.l a3,d6
     fec:	8486           	or.l d6,d2
     fee:	1407           	move.b d7,d2
     ff0:	2040           	movea.l d0,a0
     ff2:	d1c1           	adda.l d1,a0
     ff4:	72fc           	moveq #-4,d1
     ff6:	c283           	and.l d3,d1
     ff8:	d288           	add.l a0,d1
		*ptr++ = val;
     ffa:	20c2           	move.l d2,(a0)+
	while(len-- > 0)
     ffc:	b1c1           	cmpa.l d1,a0
     ffe:	66fa           	bne.s ffa <memset+0x86>
    1000:	72fc           	moveq #-4,d1
    1002:	c283           	and.l d3,d1
    1004:	d5c1           	adda.l d1,a2
    1006:	9a81           	sub.l d1,d5
    1008:	b283           	cmp.l d3,d1
    100a:	6730           	beq.s 103c <memset+0xc8>
		*ptr++ = val;
    100c:	1484           	move.b d4,(a2)
	while(len-- > 0)
    100e:	4a85           	tst.l d5
    1010:	672a           	beq.s 103c <memset+0xc8>
		*ptr++ = val;
    1012:	1544 0001      	move.b d4,1(a2)
	while(len-- > 0)
    1016:	7201           	moveq #1,d1
    1018:	b285           	cmp.l d5,d1
    101a:	6720           	beq.s 103c <memset+0xc8>
		*ptr++ = val;
    101c:	1544 0002      	move.b d4,2(a2)
	while(len-- > 0)
    1020:	7402           	moveq #2,d2
    1022:	b485           	cmp.l d5,d2
    1024:	6716           	beq.s 103c <memset+0xc8>
		*ptr++ = val;
    1026:	1544 0003      	move.b d4,3(a2)
	while(len-- > 0)
    102a:	7c03           	moveq #3,d6
    102c:	bc85           	cmp.l d5,d6
    102e:	670c           	beq.s 103c <memset+0xc8>
		*ptr++ = val;
    1030:	1544 0004      	move.b d4,4(a2)
	while(len-- > 0)
    1034:	5985           	subq.l #4,d5
    1036:	6704           	beq.s 103c <memset+0xc8>
		*ptr++ = val;
    1038:	1544 0005      	move.b d4,5(a2)
}
    103c:	4cdf 0cfc      	movem.l (sp)+,d2-d7/a2-a3
    1040:	4e75           	rts

00001042 <memcpy>:
{
    1042:	48e7 3e00      	movem.l d2-d6,-(sp)
    1046:	202f 0018      	move.l 24(sp),d0
    104a:	222f 001c      	move.l 28(sp),d1
    104e:	262f 0020      	move.l 32(sp),d3
	while(len--)
    1052:	2803           	move.l d3,d4
    1054:	5384           	subq.l #1,d4
    1056:	4a83           	tst.l d3
    1058:	675e           	beq.s 10b8 <memcpy+0x76>
    105a:	2041           	movea.l d1,a0
    105c:	5288           	addq.l #1,a0
    105e:	2400           	move.l d0,d2
    1060:	9488           	sub.l a0,d2
    1062:	7a02           	moveq #2,d5
    1064:	ba82           	cmp.l d2,d5
    1066:	55c2           	sc.s d2
    1068:	4402           	neg.b d2
    106a:	7c08           	moveq #8,d6
    106c:	bc84           	cmp.l d4,d6
    106e:	55c5           	sc.s d5
    1070:	4405           	neg.b d5
    1072:	c405           	and.b d5,d2
    1074:	6748           	beq.s 10be <memcpy+0x7c>
    1076:	2400           	move.l d0,d2
    1078:	8481           	or.l d1,d2
    107a:	7a03           	moveq #3,d5
    107c:	c485           	and.l d5,d2
    107e:	663e           	bne.s 10be <memcpy+0x7c>
    1080:	2041           	movea.l d1,a0
    1082:	2240           	movea.l d0,a1
    1084:	74fc           	moveq #-4,d2
    1086:	c483           	and.l d3,d2
    1088:	d481           	add.l d1,d2
		*d++ = *s++;
    108a:	22d8           	move.l (a0)+,(a1)+
	while(len--)
    108c:	b488           	cmp.l a0,d2
    108e:	66fa           	bne.s 108a <memcpy+0x48>
    1090:	74fc           	moveq #-4,d2
    1092:	c483           	and.l d3,d2
    1094:	2040           	movea.l d0,a0
    1096:	d1c2           	adda.l d2,a0
    1098:	d282           	add.l d2,d1
    109a:	9882           	sub.l d2,d4
    109c:	b483           	cmp.l d3,d2
    109e:	6718           	beq.s 10b8 <memcpy+0x76>
		*d++ = *s++;
    10a0:	2241           	movea.l d1,a1
    10a2:	1091           	move.b (a1),(a0)
	while(len--)
    10a4:	4a84           	tst.l d4
    10a6:	6710           	beq.s 10b8 <memcpy+0x76>
		*d++ = *s++;
    10a8:	1169 0001 0001 	move.b 1(a1),1(a0)
	while(len--)
    10ae:	5384           	subq.l #1,d4
    10b0:	6706           	beq.s 10b8 <memcpy+0x76>
		*d++ = *s++;
    10b2:	1169 0002 0002 	move.b 2(a1),2(a0)
}
    10b8:	4cdf 007c      	movem.l (sp)+,d2-d6
    10bc:	4e75           	rts
    10be:	2240           	movea.l d0,a1
    10c0:	d283           	add.l d3,d1
		*d++ = *s++;
    10c2:	12e8 ffff      	move.b -1(a0),(a1)+
	while(len--)
    10c6:	b288           	cmp.l a0,d1
    10c8:	67ee           	beq.s 10b8 <memcpy+0x76>
    10ca:	5288           	addq.l #1,a0
    10cc:	60f4           	bra.s 10c2 <memcpy+0x80>

000010ce <memmove>:
{
    10ce:	48e7 3c20      	movem.l d2-d5/a2,-(sp)
    10d2:	202f 0018      	move.l 24(sp),d0
    10d6:	222f 001c      	move.l 28(sp),d1
    10da:	242f 0020      	move.l 32(sp),d2
		while (len--)
    10de:	2242           	movea.l d2,a1
    10e0:	5389           	subq.l #1,a1
	if (d < s) {
    10e2:	b280           	cmp.l d0,d1
    10e4:	636c           	bls.s 1152 <memmove+0x84>
		while (len--)
    10e6:	4a82           	tst.l d2
    10e8:	6762           	beq.s 114c <memmove+0x7e>
    10ea:	2441           	movea.l d1,a2
    10ec:	528a           	addq.l #1,a2
    10ee:	2600           	move.l d0,d3
    10f0:	968a           	sub.l a2,d3
    10f2:	7802           	moveq #2,d4
    10f4:	b883           	cmp.l d3,d4
    10f6:	55c3           	sc.s d3
    10f8:	4403           	neg.b d3
    10fa:	7a08           	moveq #8,d5
    10fc:	ba89           	cmp.l a1,d5
    10fe:	55c4           	sc.s d4
    1100:	4404           	neg.b d4
    1102:	c604           	and.b d4,d3
    1104:	6770           	beq.s 1176 <memmove+0xa8>
    1106:	2600           	move.l d0,d3
    1108:	8681           	or.l d1,d3
    110a:	7803           	moveq #3,d4
    110c:	c684           	and.l d4,d3
    110e:	6666           	bne.s 1176 <memmove+0xa8>
    1110:	2041           	movea.l d1,a0
    1112:	2440           	movea.l d0,a2
    1114:	76fc           	moveq #-4,d3
    1116:	c682           	and.l d2,d3
    1118:	d681           	add.l d1,d3
			*d++ = *s++;
    111a:	24d8           	move.l (a0)+,(a2)+
		while (len--)
    111c:	b688           	cmp.l a0,d3
    111e:	66fa           	bne.s 111a <memmove+0x4c>
    1120:	76fc           	moveq #-4,d3
    1122:	c682           	and.l d2,d3
    1124:	2440           	movea.l d0,a2
    1126:	d5c3           	adda.l d3,a2
    1128:	2041           	movea.l d1,a0
    112a:	d1c3           	adda.l d3,a0
    112c:	93c3           	suba.l d3,a1
    112e:	b682           	cmp.l d2,d3
    1130:	671a           	beq.s 114c <memmove+0x7e>
			*d++ = *s++;
    1132:	1490           	move.b (a0),(a2)
		while (len--)
    1134:	b2fc 0000      	cmpa.w #0,a1
    1138:	6712           	beq.s 114c <memmove+0x7e>
			*d++ = *s++;
    113a:	1568 0001 0001 	move.b 1(a0),1(a2)
		while (len--)
    1140:	7a01           	moveq #1,d5
    1142:	ba89           	cmp.l a1,d5
    1144:	6706           	beq.s 114c <memmove+0x7e>
			*d++ = *s++;
    1146:	1568 0002 0002 	move.b 2(a0),2(a2)
}
    114c:	4cdf 043c      	movem.l (sp)+,d2-d5/a2
    1150:	4e75           	rts
		const char *lasts = s + (len - 1);
    1152:	41f1 1800      	lea (0,a1,d1.l),a0
		char *lastd = d + (len - 1);
    1156:	d3c0           	adda.l d0,a1
		while (len--)
    1158:	4a82           	tst.l d2
    115a:	67f0           	beq.s 114c <memmove+0x7e>
    115c:	2208           	move.l a0,d1
    115e:	9282           	sub.l d2,d1
			*lastd-- = *lasts--;
    1160:	1290           	move.b (a0),(a1)
		while (len--)
    1162:	5388           	subq.l #1,a0
    1164:	5389           	subq.l #1,a1
    1166:	b288           	cmp.l a0,d1
    1168:	67e2           	beq.s 114c <memmove+0x7e>
			*lastd-- = *lasts--;
    116a:	1290           	move.b (a0),(a1)
		while (len--)
    116c:	5388           	subq.l #1,a0
    116e:	5389           	subq.l #1,a1
    1170:	b288           	cmp.l a0,d1
    1172:	66ec           	bne.s 1160 <memmove+0x92>
    1174:	60d6           	bra.s 114c <memmove+0x7e>
    1176:	2240           	movea.l d0,a1
    1178:	d282           	add.l d2,d1
			*d++ = *s++;
    117a:	12ea ffff      	move.b -1(a2),(a1)+
		while (len--)
    117e:	b28a           	cmp.l a2,d1
    1180:	67ca           	beq.s 114c <memmove+0x7e>
    1182:	528a           	addq.l #1,a2
    1184:	60f4           	bra.s 117a <memmove+0xac>
    1186:	4e71           	nop

00001188 <__mulsi3>:
	.text
	FUNC(__mulsi3)
	.globl	SYM (__mulsi3)
SYM (__mulsi3):
	.cfi_startproc
	movew	sp@(4), d0	/* x0 -> d0 */
    1188:	302f 0004      	move.w 4(sp),d0
	muluw	sp@(10), d0	/* x0*y1 */
    118c:	c0ef 000a      	mulu.w 10(sp),d0
	movew	sp@(6), d1	/* x1 -> d1 */
    1190:	322f 0006      	move.w 6(sp),d1
	muluw	sp@(8), d1	/* x1*y0 */
    1194:	c2ef 0008      	mulu.w 8(sp),d1
	addw	d1, d0
    1198:	d041           	add.w d1,d0
	swap	d0
    119a:	4840           	swap d0
	clrw	d0
    119c:	4240           	clr.w d0
	movew	sp@(6), d1	/* x1 -> d1 */
    119e:	322f 0006      	move.w 6(sp),d1
	muluw	sp@(10), d1	/* x1*y1 */
    11a2:	c2ef 000a      	mulu.w 10(sp),d1
	addl	d1, d0
    11a6:	d081           	add.l d1,d0
	rts
    11a8:	4e75           	rts

000011aa <__udivsi3>:
	.text
	FUNC(__udivsi3)
	.globl	SYM (__udivsi3)
SYM (__udivsi3):
	.cfi_startproc
	movel	d2, sp@-
    11aa:	2f02           	move.l d2,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	sp@(12), d1	/* d1 = divisor */
    11ac:	222f 000c      	move.l 12(sp),d1
	movel	sp@(8), d0	/* d0 = dividend */
    11b0:	202f 0008      	move.l 8(sp),d0

	cmpl	IMM (0x10000), d1 /* divisor >= 2 ^ 16 ?   */
    11b4:	0c81 0001 0000 	cmpi.l #65536,d1
	jcc	3f		/* then try next algorithm */
    11ba:	6416           	bcc.s 11d2 <__udivsi3+0x28>
	movel	d0, d2
    11bc:	2400           	move.l d0,d2
	clrw	d2
    11be:	4242           	clr.w d2
	swap	d2
    11c0:	4842           	swap d2
	divu	d1, d2          /* high quotient in lower word */
    11c2:	84c1           	divu.w d1,d2
	movew	d2, d0		/* save high quotient */
    11c4:	3002           	move.w d2,d0
	swap	d0
    11c6:	4840           	swap d0
	movew	sp@(10), d2	/* get low dividend + high rest */
    11c8:	342f 000a      	move.w 10(sp),d2
	divu	d1, d2		/* low quotient */
    11cc:	84c1           	divu.w d1,d2
	movew	d2, d0
    11ce:	3002           	move.w d2,d0
	jra	6f
    11d0:	6030           	bra.s 1202 <__udivsi3+0x58>

3:	movel	d1, d2		/* use d2 as divisor backup */
    11d2:	2401           	move.l d1,d2
4:	lsrl	IMM (1), d1	/* shift divisor */
    11d4:	e289           	lsr.l #1,d1
	lsrl	IMM (1), d0	/* shift dividend */
    11d6:	e288           	lsr.l #1,d0
	cmpl	IMM (0x10000), d1 /* still divisor >= 2 ^ 16 ?  */
    11d8:	0c81 0001 0000 	cmpi.l #65536,d1
	jcc	4b
    11de:	64f4           	bcc.s 11d4 <__udivsi3+0x2a>
	divu	d1, d0		/* now we have 16-bit divisor */
    11e0:	80c1           	divu.w d1,d0
	andl	IMM (0xffff), d0 /* mask out divisor, ignore remainder */
    11e2:	0280 0000 ffff 	andi.l #65535,d0

/* Multiply the 16-bit tentative quotient with the 32-bit divisor.  Because of
   the operand ranges, this might give a 33-bit product.  If this product is
   greater than the dividend, the tentative quotient was too large. */
	movel	d2, d1
    11e8:	2202           	move.l d2,d1
	mulu	d0, d1		/* low part, 32 bits */
    11ea:	c2c0           	mulu.w d0,d1
	swap	d2
    11ec:	4842           	swap d2
	mulu	d0, d2		/* high part, at most 17 bits */
    11ee:	c4c0           	mulu.w d0,d2
	swap	d2		/* align high part with low part */
    11f0:	4842           	swap d2
	tstw	d2		/* high part 17 bits? */
    11f2:	4a42           	tst.w d2
	jne	5f		/* if 17 bits, quotient was too large */
    11f4:	660a           	bne.s 1200 <__udivsi3+0x56>
	addl	d2, d1		/* add parts */
    11f6:	d282           	add.l d2,d1
	jcs	5f		/* if sum is 33 bits, quotient was too large */
    11f8:	6506           	bcs.s 1200 <__udivsi3+0x56>
	cmpl	sp@(8), d1	/* compare the sum with the dividend */
    11fa:	b2af 0008      	cmp.l 8(sp),d1
	jls	6f		/* if sum > dividend, quotient was too large */
    11fe:	6302           	bls.s 1202 <__udivsi3+0x58>
5:	subql	IMM (1), d0	/* adjust quotient */
    1200:	5380           	subq.l #1,d0

6:	movel	sp@+, d2
    1202:	241f           	move.l (sp)+,d2
	.cfi_adjust_cfa_offset -4
	rts
    1204:	4e75           	rts

00001206 <__divsi3>:
	.text
	FUNC(__divsi3)
	.globl	SYM (__divsi3)
SYM (__divsi3):
	.cfi_startproc
	movel	d2, sp@-
    1206:	2f02           	move.l d2,-(sp)
	.cfi_adjust_cfa_offset 4

	moveq	IMM (1), d2	/* sign of result stored in d2 (=1 or =-1) */
    1208:	7401           	moveq #1,d2
	movel	sp@(12), d1	/* d1 = divisor */
    120a:	222f 000c      	move.l 12(sp),d1
	jpl	1f
    120e:	6a04           	bpl.s 1214 <__divsi3+0xe>
	negl	d1
    1210:	4481           	neg.l d1
	negb	d2		/* change sign because divisor <0  */
    1212:	4402           	neg.b d2
1:	movel	sp@(8), d0	/* d0 = dividend */
    1214:	202f 0008      	move.l 8(sp),d0
	jpl	2f
    1218:	6a04           	bpl.s 121e <__divsi3+0x18>
	negl	d0
    121a:	4480           	neg.l d0
	negb	d2
    121c:	4402           	neg.b d2

2:	movel	d1, sp@-
    121e:	2f01           	move.l d1,-(sp)
	movel	d0, sp@-
    1220:	2f00           	move.l d0,-(sp)
	PICCALL	SYM (__udivsi3)	/* divide abs(dividend) by abs(divisor) */
    1222:	6186           	bsr.s 11aa <__udivsi3>
	addql	IMM (8), sp
    1224:	508f           	addq.l #8,sp

	tstb	d2
    1226:	4a02           	tst.b d2
	jpl	3f
    1228:	6a02           	bpl.s 122c <__divsi3+0x26>
	negl	d0
    122a:	4480           	neg.l d0

3:	movel	sp@+, d2
    122c:	241f           	move.l (sp)+,d2
	.cfi_adjust_cfa_offset -4
	rts
    122e:	4e75           	rts

00001230 <__modsi3>:
	.text
	FUNC(__modsi3)
	.globl	SYM (__modsi3)
SYM (__modsi3):
	.cfi_startproc
	movel	sp@(8), d1	/* d1 = divisor */
    1230:	222f 0008      	move.l 8(sp),d1
	movel	sp@(4), d0	/* d0 = dividend */
    1234:	202f 0004      	move.l 4(sp),d0
	movel	d1, sp@-
    1238:	2f01           	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    123a:	2f00           	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	PICCALL	SYM (__divsi3)
    123c:	61c8           	bsr.s 1206 <__divsi3>
	addql	IMM (8), sp
    123e:	508f           	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(8), d1	/* d1 = divisor */
    1240:	222f 0008      	move.l 8(sp),d1
	movel	d1, sp@-
    1244:	2f01           	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    1246:	2f00           	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	PICCALL	SYM (__mulsi3)	/* d0 = (a/b)*b */
    1248:	6100 ff3e      	bsr.w 1188 <__mulsi3>
	addql	IMM (8), sp
    124c:	508f           	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(4), d1	/* d1 = dividend */
    124e:	222f 0004      	move.l 4(sp),d1
	subl	d0, d1		/* d1 = a - (a/b)*b */
    1252:	9280           	sub.l d0,d1
	movel	d1, d0
    1254:	2001           	move.l d1,d0
	rts
    1256:	4e75           	rts

00001258 <__umodsi3>:
	.text
	FUNC(__umodsi3)
	.globl	SYM (__umodsi3)
SYM (__umodsi3):
	.cfi_startproc
	movel	sp@(8), d1	/* d1 = divisor */
    1258:	222f 0008      	move.l 8(sp),d1
	movel	sp@(4), d0	/* d0 = dividend */
    125c:	202f 0004      	move.l 4(sp),d0
	movel	d1, sp@-
    1260:	2f01           	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    1262:	2f00           	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	PICCALL	SYM (__udivsi3)
    1264:	6100 ff44      	bsr.w 11aa <__udivsi3>
	addql	IMM (8), sp
    1268:	508f           	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(8), d1	/* d1 = divisor */
    126a:	222f 0008      	move.l 8(sp),d1
	movel	d1, sp@-
    126e:	2f01           	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    1270:	2f00           	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	PICCALL	SYM (__mulsi3)	/* d0 = (a/b)*b */
    1272:	6100 ff14      	bsr.w 1188 <__mulsi3>
	addql	IMM (8), sp
    1276:	508f           	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(4), d1	/* d1 = dividend */
    1278:	222f 0004      	move.l 4(sp),d1
	subl	d0, d1		/* d1 = a - (a/b)*b */
    127c:	9280           	sub.l d0,d1
	movel	d1, d0
    127e:	2001           	move.l d1,d0
	rts
    1280:	4e75           	rts

00001282 <KPutCharX>:
	FUNC(KPutCharX)
	.globl	SYM (KPutCharX)

SYM(KPutCharX):
	.cfi_startproc
    move.l  a6, -(sp)
    1282:	2f0e           	move.l a6,-(sp)
	.cfi_adjust_cfa_offset 4
    move.l  4.w, a6
    1284:	2c78 0004      	movea.l 4 <_start+0x4>,a6
    jsr     -0x204(a6)
    1288:	4eae fdfc      	jsr -516(a6)
    movea.l (sp)+, a6
    128c:	2c5f           	movea.l (sp)+,a6
	.cfi_adjust_cfa_offset -4
    rts
    128e:	4e75           	rts

00001290 <PutChar>:
	FUNC(PutChar)
	.globl	SYM (PutChar)

SYM(PutChar):
	.cfi_startproc
	move.b d0, (a3)+
    1290:	16c0           	move.b d0,(a3)+
	rts
    1292:	4e75           	rts
