BasicUpstart2(begin)      // <- This creates a basic sys line that can start your program

// Raster debug ?
.const DEBUG = 0
.const INTLINE = 150

// Start of the main program
* = $2000 "Main Program"    // <- The name 'Main program' will appear in the memory map when assembling   jsr clear
begin:
	//.byte $b,$08,$ef,$0,$9e,$32,$30,$36,$31,$0,$0,$0

	lda	#11
	sta	$d011
	lda	#0
	sta	$d020
	lda	#6
	sta	$d021

	ldx	#0
	ldy	#250
!loop:
	lda	defeest_pet,x
	sta	$400,x
	lda	defeest_pet+250,x
	sta	$400+250,x
	lda	defeest_pet+500,x
	sta	$400+500,x
	lda	defeest_pet+750,x
	sta	$400+750,x

	lda	defeest_pet+1000,x
	sta	$d800,x
	lda	defeest_pet+1250,x
	sta	$d800+250,x
	lda	defeest_pet+1500,x
	sta	$d800+500,x
	lda	defeest_pet+1750,x
	sta	$d800+750,x

	inx
	dey
	bne	!loop-

	lda	#27
	sta	$d011

	jsr initraster

	jmp *

////
// Init Raster interrupt
initraster:
	lda #%01111111				// 'Switch off' inturrupt signals CIA-1
	sta $DC0D							
	and $D011							// Clear msb in SID raster register
	sta $D011
	lda #INTLINE					// Set Raster interrupt line to 210
	sta $D012
	lda #<Irq1
	sta $0314
	lda #>Irq1
	sta $0315
	lda #%00000001				// Enable raster interrupt
	sta $D01A
	rts

////
// Raster interrupt 2
Irq1:
.if (DEBUG==1) {
	lda #7
	sta $D020
}

	ldx #90									// Some debug code
!loop:
	dex
	bne !loop-

	dec rastercountdown			// When the countdown reaches 0, go to the next frame
	bne !over+

	lda #1									// Borders to white
	sta $D020
	sta $D021
	ldx	#0									// Copy petscii data into screen
	ldy	#250
!loop:
	lda	eat_pet,x					  // Character memory
	sta	$400,x
	lda	eat_pet+250,x
	sta	$400+250,x
	lda	eat_pet+500,x
	sta	$400+500,x
	lda	eat_pet+750,x
	sta	$400+750,x
	lda	eat_pet+1000,x			// Color memory
	sta	$d800,x
	lda	eat_pet+1250,x
	sta	$d800+250,x
	lda	eat_pet+1500,x
	sta	$d800+500,x
	lda	eat_pet+1750,x
	sta	$d800+750,x
	inx											// Loop counters
	dey
	bne	!loop-

	lda #50
	sta rastercountdown
	lda #<Irq2
	sta $0314
	lda #>Irq2
	sta $0315
!over:

	lda #0
.if (DEBUG==1) {
	sta $D020
}
	asl $D019
	jmp $EA31								// Jump into Kernal Interrupt routine

////
// Raster interrupt 2
Irq2:
.if (DEBUG==1) {
	lda #8
	sta $D020
}

	ldx #90									// Some debug code
!loop:
	dex
	bne !loop-

	dec rastercountdown			// When the countdown reaches 0, go to the next frame
	bne !over+

	lda #1									// Borders to white
	sta $D020
	sta $D021
	ldx	#0									// Copy petscii data into screen
	ldy	#250
!loop:
	lda	sleep_pet,x					  // Character memory
	sta	$400,x
	lda	sleep_pet+250,x
	sta	$400+250,x
	lda	sleep_pet+500,x
	sta	$400+500,x
	lda	sleep_pet+750,x
	sta	$400+750,x
	lda	sleep_pet+1000,x			// Color memory
	sta	$d800,x
	lda	sleep_pet+1250,x
	sta	$d800+250,x
	lda	sleep_pet+1500,x
	sta	$d800+500,x
	lda	sleep_pet+1750,x
	sta	$d800+750,x
	inx											// Loop counters
	dey
	bne	!loop-

	lda #50
	sta rastercountdown
	lda #<Irq3
	sta $0314
	lda #>Irq3
	sta $0315
	
!over:

	lda #0
.if (DEBUG==1) {
	sta $D020
}
	asl $D019
	jmp $EA31								// Jump into Kernal Interrupt routine

////
// Raster interrupt 3
Irq3:
.if (DEBUG==1) {
	lda #8
	sta $D020
}

	ldx #90									// Some debug code
!loop:
	dex
	bne !loop-

	dec rastercountdown			// When the countdown reaches 0, go to the next frame
	bne !over+

	lda #1									// Borders to white
	sta $D020
	sta $D021
	ldx	#0									// Copy petscii data into screen
	ldy	#250
!loop:
	lda	copy_pet,x					  // Character memory
	sta	$400,x
	lda	copy_pet+250,x
	sta	$400+250,x
	lda	copy_pet+500,x
	sta	$400+500,x
	lda	copy_pet+750,x
	sta	$400+750,x
	lda	copy_pet+1000,x			// Color memory
	sta	$d800,x
	lda	copy_pet+1250,x
	sta	$d800+250,x
	lda	copy_pet+1500,x
	sta	$d800+500,x
	lda	copy_pet+1750,x
	sta	$d800+750,x
	inx											// Loop counters
	dey
	bne	!loop-

	lda #50
	sta rastercountdown
	lda #<Irq4
	sta $0314
	lda #>Irq4
	sta $0315
	
!over:

	lda #0
.if (DEBUG==1) {
	sta $D020
}
	asl $D019
	jmp $EA31								// Jump into Kernal Interrupt routine

////
// Raster interrupt 4
Irq4:
.if (DEBUG==1) {
	lda #8
	sta $D020
}

	ldx #90									// Some debug code
!loop:
	dex
	bne !loop-

	dec rastercountdown			// When the countdown reaches 0, go to the next frame
	bne !over+

	lda #1									// Borders to white
	sta $D020
	sta $D021
	ldx	#0									// Copy petscii data into screen
	ldy	#250
!loop:
	lda	paste_pet,x					  // Character memory
	sta	$400,x
	lda	paste_pet+250,x
	sta	$400+250,x
	lda	paste_pet+500,x
	sta	$400+500,x
	lda	paste_pet+750,x
	sta	$400+750,x
	lda	paste_pet+1000,x			// Color memory
	sta	$d800,x
	lda	paste_pet+1250,x
	sta	$d800+250,x
	lda	paste_pet+1500,x
	sta	$d800+500,x
	lda	paste_pet+1750,x
	sta	$d800+750,x
	inx											// Loop counters
	dey
	bne	!loop-

	lda #50
	sta rastercountdown
	lda #<Irq1
	sta $0314
	lda #>Irq1
	sta $0315
	
!over:

	lda #0
.if (DEBUG==1) {
	sta $D020
}
	asl $D019
	jmp $EA31								// Jump into Kernal Interrupt routine

// Border, bg, chars, colors
defeest_pet:
// Character data
	.byte 160,160,160,160,160,228,248,227,227,160,160,160,160,160,160,160,227,248,120,228,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160
	.byte 160,160,160,236,254,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,248,226,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160
	.byte 160,160,254,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,247,249,160,160,160,160,160,160,160,160,160,160,160,160,160,160
	.byte 160,254,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,227,226,160,160,160,160,160,160,160,160,160,160,160,160
	.byte 97,160,160,160,160,160,160,160,160,160,160,160,228,226,119,119,99,32,32,32,99,99,99,120,226,228,160,160,160,95,160,160,160,160,160,160,160,160,160,160
	.byte 229,160,160,160,160,160,160,160,160,160,105,119,100,32,32,32,32,32,32,32,32,32,32,32,32,32,99,120,239,160,227,228,160,160,160,160,160,160,160,160
	.byte 160,160,160,160,160,160,160,160,160,126,32,32,160,32,100,100,96,32,32,32,32,32,32,32,32,32,32,32,32,119,95,160,223,160,160,160,160,160,160,160
	.byte 160,160,160,160,160,160,160,160,32,32,233,224,160,32,233,227,223,32,32,32,32,32,32,32,32,32,32,32,32,32,32,99,251,252,160,160,160,160,160,160
	.byte 160,160,160,160,160,160,160,126,32,32,160,71,160,103,160,71,224,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,124,160,251,160,160,160,160
	.byte 229,160,160,160,160,160,231,32,32,32,160,71,160,103,160,224,105,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,124,160,251,160,160,160
	.byte 245,160,160,160,160,160,117,32,32,32,160,71,160,103,160,31,125,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,124,160,160,160,160
	.byte 231,160,160,160,160,160,101,32,32,32,160,207,160,103,160,98,32,100,100,100,32,100,100,100,100,100,100,32,100,100,32,100,100,100,32,32,95,252,160,160
	.byte 160,95,160,160,160,160,101,32,32,32,95,160,160,32,95,160,101,233,160,224,89,160,224,246,233,160,224,108,233,160,223,224,160,224,29,32,32,160,223,160
	.byte 160,160,251,160,160,160,97,32,32,32,32,119,119,32,32,119,32,160,71,119,89,160,119,119,160,71,119,89,160,84,96,80,160,79,32,32,32,229,160,160
	.byte 160,160,252,160,160,160,160,32,32,32,32,32,32,32,32,32,32,160,71,121,89,160,121,32,160,71,96,89,160,12,32,32,160,101,32,32,32,225,160,97
	.byte 160,160,160,252,160,160,160,223,32,32,32,32,32,32,32,32,32,160,160,29,89,160,160,101,160,160,29,32,95,224,223,32,160,101,32,32,32,245,160,160
	.byte 160,160,160,160,252,160,160,160,223,32,32,32,32,32,32,32,32,160,71,119,89,160,99,32,160,71,99,32,100,96,224,32,160,101,32,32,32,160,160,160
	.byte 160,160,160,160,160,252,228,160,160,223,32,32,32,32,32,32,32,160,71,32,89,160,111,111,160,71,111,89,82,82,224,32,160,101,32,32,233,160,160,160
	.byte 160,160,160,160,160,160,160,95,160,160,252,123,32,32,32,32,32,160,71,32,89,160,160,66,160,160,160,124,160,160,105,32,160,101,32,233,160,160,160,160
	.byte 160,160,160,160,160,160,160,160,252,160,160,160,227,121,32,32,32,119,32,32,32,119,119,119,119,119,119,32,119,119,32,32,119,32,248,160,160,160,160,160
	.byte 160,160,160,160,160,160,160,160,160,160,95,160,160,160,160,247,98,111,100,32,32,32,32,32,32,32,32,32,32,32,100,111,247,160,160,160,160,160,160,105
	.byte 160,160,160,160,160,160,160,160,160,160,160,160,226,160,160,160,160,160,160,227,247,248,98,98,98,98,98,248,247,227,160,160,160,160,160,160,160,160,160,160
	.byte 160,160,160,160,160,160,160,160,160,160,160,160,160,160,226,228,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,228,254,160
	.byte 160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,227,226,228,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,226,160,160,160
	.byte 160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,247,98,239,160,160,160,160,160,160,160,160,160,160,160,239,98,160,160,160,160,160
// Color data
	.byte 0,0,0,0,0,0,7,7,7,7,7,7,7,7,7,7,7,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 0,0,0,0,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 0,0,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 0,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 0,7,7,7,7,7,7,7,7,7,7,7,7,7,7,12,12,3,3,3,12,12,7,7,7,7,7,7,7,0,0,0,0,0,0,0,0,0,0,0
	.byte 7,7,7,7,7,7,7,7,7,7,7,12,10,7,3,3,3,3,3,3,3,3,3,3,3,3,12,7,7,7,7,0,0,0,0,0,0,0,0,0
	.byte 7,7,7,7,7,7,7,7,7,7,3,12,14,7,10,10,10,3,3,3,3,3,3,3,3,3,3,3,3,12,7,7,7,0,0,0,0,0,0,0
	.byte 7,7,7,7,7,7,7,7,7,3,14,14,14,7,14,14,14,3,3,3,3,3,3,3,3,3,3,3,3,3,3,7,7,7,0,0,0,0,0,0
	.byte 7,7,7,7,7,7,7,7,3,3,14,7,14,7,14,7,14,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,7,7,0,0,0,0,0
	.byte 7,7,7,7,7,7,7,3,3,3,14,7,14,7,14,14,14,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,7,7,0,0,0,0
	.byte 7,7,7,7,7,7,7,3,3,3,14,7,14,7,14,7,7,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,7,7,0,0,0
	.byte 0,7,7,7,7,7,7,3,3,3,14,7,14,7,14,7,7,10,10,10,10,10,10,10,10,10,10,12,10,10,12,10,10,10,3,3,7,7,0,0
	.byte 0,7,7,7,7,7,7,3,3,3,14,14,14,7,14,14,7,14,14,14,7,14,14,7,14,14,14,7,14,14,14,14,14,14,7,3,12,7,7,0
	.byte 0,0,7,7,7,7,7,3,3,3,3,7,7,3,3,7,3,14,7,7,7,14,7,7,14,7,7,7,14,7,7,7,14,7,12,3,3,7,7,0
	.byte 0,0,0,7,7,7,7,10,3,3,3,3,3,3,3,3,3,14,7,12,7,14,7,7,14,7,14,7,14,7,3,7,14,7,3,3,3,7,7,7
	.byte 0,0,0,0,7,7,7,7,3,3,3,3,3,3,3,3,3,14,14,7,7,14,14,7,14,14,7,3,14,14,14,7,14,7,3,3,3,7,7,7
	.byte 0,0,0,0,0,7,7,7,7,3,3,3,3,3,3,3,3,14,7,12,7,14,12,12,14,7,12,12,12,7,14,7,14,7,3,3,10,7,7,7
	.byte 0,0,0,0,0,0,7,7,7,7,12,3,3,3,3,3,3,14,7,3,7,14,12,10,14,7,10,7,7,7,14,7,14,7,3,3,7,7,7,7
	.byte 0,0,0,0,0,0,0,7,7,7,7,7,12,3,3,3,3,14,7,3,7,14,14,7,14,14,14,7,14,14,14,7,14,7,3,7,7,7,7,7
	.byte 0,0,0,0,0,0,0,0,0,7,7,7,7,7,12,3,3,7,10,3,10,7,7,7,7,7,7,4,7,7,10,10,7,7,7,7,7,7,7,7
	.byte 0,0,0,0,0,0,0,0,0,0,7,7,7,7,7,7,7,7,12,3,3,3,3,3,3,3,3,3,3,3,12,7,7,7,7,7,7,7,7,7
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7,7,7,7,7,7,7,7,7,7,7,7,7,0,0,0,0,0,0
// EAT
eat_pet:
//	.byte 1,1
// Character data
	.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
	.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
	.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
	.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
	.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
	.byte 32,32,32,32,98,98,98,98,98,98,98,123,32,32,32,32,32,32,108,98,123,32,32,32,32,32,98,98,98,98,98,98,98,98,98,98,123,32,32,32
	.byte 32,32,32,103,160,228,228,228,228,228,228,97,32,32,32,32,32,32,160,160,231,32,32,32,32,32,204,228,228,228,160,160,228,228,228,228,97,32,32,32
	.byte 32,32,32,103,160,117,32,32,32,32,32,32,32,32,32,32,32,103,160,194,160,101,32,32,32,32,32,32,32,32,225,160,101,32,32,32,32,32,32,32
	.byte 32,32,32,103,160,117,32,32,32,32,32,32,32,32,32,32,32,229,160,32,160,97,32,32,32,32,32,32,32,32,225,160,101,32,32,32,32,32,32,32
	.byte 32,32,32,103,160,117,32,32,32,32,32,32,32,32,32,32,32,160,97,32,245,160,32,32,32,32,32,32,32,32,225,160,101,32,32,32,32,32,32,32
	.byte 32,32,32,103,160,252,98,98,98,98,98,32,32,32,32,32,118,160,101,32,103,160,101,32,32,32,32,32,32,32,225,160,101,32,32,32,32,32,32,32
	.byte 32,32,32,103,160,228,228,228,228,228,228,101,32,32,32,32,229,231,32,32,32,160,231,32,32,32,32,32,32,32,225,160,101,32,32,32,32,32,32,32
	.byte 32,32,32,103,160,117,32,32,32,32,32,32,32,32,32,103,160,97,32,32,32,225,160,32,32,32,32,32,32,32,225,160,101,32,32,32,32,32,32,32
	.byte 32,32,32,103,160,117,32,32,32,32,32,32,32,32,32,225,160,227,227,227,227,227,160,97,32,32,32,32,32,32,225,160,101,32,32,32,32,32,32,32
	.byte 32,32,32,103,160,117,32,32,32,32,32,32,32,32,32,160,236,226,226,226,226,226,251,231,32,32,32,32,32,32,225,160,101,32,32,32,32,32,32,32
	.byte 32,32,32,103,160,117,32,32,32,32,32,32,32,32,118,160,101,32,32,32,32,32,118,160,101,32,32,32,32,32,225,160,101,32,32,32,32,32,32,32
	.byte 32,32,32,103,160,247,247,247,247,247,247,208,32,32,229,160,32,32,32,32,32,32,32,160,246,32,32,32,32,32,225,160,101,32,32,32,32,32,32,32
	.byte 32,32,32,103,249,249,249,249,249,249,249,125,32,32,249,250,32,32,32,32,32,32,32,204,249,32,32,32,32,32,124,249,101,32,32,32,32,32,32,32
	.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
	.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
	.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
	.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
	.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
	.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
	.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
// Color data
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,12,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,12,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
// SLEEP
// Border, bg, chars, colors
sleep_pet:
//	.byte 1,1
// Character data
	.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
	.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
	.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
	.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
	.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
	.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
	.byte 32,32,32,111,98,98,121,32,32,32,121,123,32,32,32,32,32,121,121,121,121,121,123,32,32,121,121,121,121,121,123,32,32,121,121,121,111,32,32,32
	.byte 32,32,233,160,226,226,249,97,32,32,160,117,32,32,32,32,32,160,236,249,249,249,125,32,32,160,249,249,249,249,125,32,32,160,249,249,239,160,32,32
	.byte 32,32,160,101,32,32,32,32,32,32,160,117,32,32,32,32,32,160,117,32,32,32,32,32,32,160,101,32,32,32,32,32,32,160,101,32,32,229,97,32
	.byte 32,32,160,223,32,32,32,32,32,32,160,117,32,32,32,32,32,160,117,32,32,32,32,32,32,160,101,32,32,32,32,32,32,160,101,32,32,245,246,32
	.byte 32,32,95,160,227,248,111,32,32,32,160,117,32,32,32,32,32,160,247,247,247,247,97,32,32,160,247,247,247,247,117,32,32,160,101,100,100,160,97,32
	.byte 32,32,32,99,120,249,160,223,32,32,160,117,32,32,32,32,32,160,79,119,119,119,32,32,32,160,79,119,119,119,32,32,32,160,228,228,228,105,32,32
	.byte 32,32,32,32,32,32,103,160,32,32,160,117,32,32,32,32,32,160,117,32,32,32,32,32,32,160,101,32,32,32,32,32,32,160,101,32,32,32,32,32
	.byte 32,32,32,32,32,32,103,160,32,32,160,117,32,32,32,32,32,160,117,32,32,32,32,32,32,160,101,32,32,32,32,32,32,160,101,32,32,32,32,32
	.byte 32,32,160,98,121,98,160,105,32,32,160,252,248,248,248,110,32,160,252,248,248,248,208,32,32,160,248,248,248,248,208,32,32,160,101,32,32,32,32,32
	.byte 32,32,99,226,226,226,119,32,32,32,120,120,120,120,120,126,32,120,120,120,120,120,120,32,32,120,120,120,120,120,120,32,32,120,32,32,32,32,32,32
	.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
	.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
	.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
	.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
	.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
	.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
	.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
	.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
	.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
// Color data
	.byte 14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14
	.byte 14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14
	.byte 14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14
	.byte 14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14
	.byte 14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14
	.byte 14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14
	.byte 14,14,14,0,0,0,0,0,14,14,0,0,14,14,14,14,14,0,0,0,0,0,0,14,14,0,0,0,0,0,0,14,14,0,0,0,0,0,14,14
	.byte 14,14,0,0,0,0,0,0,14,14,0,0,14,14,14,14,14,0,0,0,0,0,0,14,14,0,0,0,0,0,0,14,14,0,0,0,0,0,0,14
	.byte 14,0,0,0,14,14,14,14,14,14,0,0,14,14,14,14,14,0,0,14,14,14,14,14,14,0,0,14,14,14,14,14,14,0,0,14,14,0,0,14
	.byte 14,0,0,0,14,14,14,14,14,14,0,0,14,14,14,14,14,0,0,14,14,14,14,14,14,0,0,14,14,14,14,14,14,0,0,14,14,0,0,14
	.byte 14,14,0,0,0,0,0,14,14,14,0,0,14,14,14,14,14,0,0,0,0,0,0,14,14,0,0,0,0,0,0,14,14,0,0,15,0,0,0,14
	.byte 14,14,14,0,0,0,0,0,14,14,0,0,14,14,14,14,14,0,0,0,0,0,0,14,14,0,0,0,0,0,0,14,14,0,0,0,0,0,14,14
	.byte 14,14,14,14,14,14,0,0,14,14,0,0,14,14,14,14,14,0,0,14,14,14,14,14,14,0,0,14,14,14,14,14,14,0,0,14,14,14,14,14
	.byte 14,14,0,14,14,14,0,0,14,14,0,0,14,14,14,14,14,0,0,14,14,14,14,14,14,0,0,14,14,14,14,14,14,0,0,14,14,14,14,14
	.byte 14,14,0,0,0,0,0,0,14,14,0,0,0,0,0,0,14,0,0,0,0,0,0,14,14,0,0,0,0,0,0,14,14,0,0,14,14,14,14,14
	.byte 14,14,0,0,0,0,0,14,14,14,0,0,0,0,0,0,14,0,0,0,0,0,0,14,14,0,0,0,0,0,0,14,14,0,0,14,14,14,14,14
	.byte 14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14
	.byte 14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14
	.byte 14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14
	.byte 14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14
	.byte 14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14
	.byte 14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14
	.byte 14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14
	.byte 14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14
	.byte 14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14
// COPY
copy_pet:
// Border, bg, chars, colors
//	.byte 1,1
// Character data
	.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
	.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
	.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
	.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
	.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
	.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
	.byte 32,32,32,32,32,98,247,227,247,121,32,32,32,32,108,247,227,247,98,32,32,32,32,108,248,248,248,98,32,32,108,248,32,32,32,32,108,248,32,32
	.byte 32,32,32,32,160,236,119,99,120,251,101,32,32,233,160,120,99,120,160,252,32,32,32,245,236,120,120,251,252,32,32,251,223,32,32,32,160,126,32,32
	.byte 32,32,32,229,236,32,32,32,32,32,32,32,103,160,126,32,32,32,124,160,101,32,32,245,246,32,32,32,160,101,32,124,160,123,32,254,105,32,32,32
	.byte 32,32,32,160,101,32,32,32,32,32,32,32,225,231,32,32,32,32,32,229,246,32,32,245,246,32,32,32,160,101,32,32,95,252,233,160,32,32,32,32
	.byte 32,32,32,160,101,32,32,32,32,32,32,32,229,246,32,32,32,32,32,225,231,32,32,245,246,100,111,254,160,32,32,32,32,251,160,126,32,32,32,32
	.byte 32,32,32,160,101,32,32,32,32,32,32,32,229,246,32,32,32,32,32,225,231,32,32,245,160,228,239,249,126,32,32,32,32,118,160,32,32,32,32,32
	.byte 32,32,32,160,117,32,32,32,32,32,32,32,225,231,32,32,32,32,32,229,246,32,32,245,246,32,32,32,32,32,32,32,32,118,160,32,32,32,32,32
	.byte 32,32,32,95,252,32,32,32,32,32,32,32,103,160,123,32,32,32,108,160,101,32,32,245,246,32,32,32,32,32,32,32,32,118,160,32,32,32,32,32
	.byte 32,32,32,32,251,252,98,121,98,160,101,32,32,95,160,98,121,98,160,105,32,32,32,245,246,32,32,32,32,32,32,32,32,118,160,32,32,32,32,32
	.byte 32,32,32,32,32,120,249,249,226,99,32,32,32,32,124,226,249,226,126,32,32,32,32,124,126,32,32,32,32,32,32,32,32,124,226,32,32,32,32,32
	.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
	.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
	.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
	.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
	.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
	.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
	.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
	.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
	.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
// Color data
	.byte 14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14
	.byte 14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14
	.byte 14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14
	.byte 14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14
	.byte 14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14
	.byte 14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14
	.byte 14,14,14,14,0,0,0,0,0,0,14,14,14,14,0,0,0,0,0,14,14,14,14,0,0,0,0,0,0,14,0,0,11,14,14,14,0,0,15,14
	.byte 14,14,14,0,0,0,0,0,0,0,0,14,14,0,0,0,0,0,0,0,14,14,14,0,0,0,0,0,0,0,0,0,0,14,14,0,0,0,14,14
	.byte 14,14,14,0,0,15,14,14,14,0,0,14,0,0,0,14,14,14,0,0,0,14,14,0,0,14,14,0,0,0,14,0,0,0,14,0,0,14,14,14
	.byte 14,14,9,0,0,14,14,14,14,14,14,14,0,0,14,14,14,14,14,0,0,14,14,0,0,14,14,0,0,0,14,14,0,0,0,0,0,14,14,14
	.byte 14,14,0,0,0,14,14,14,14,14,14,14,0,0,14,14,14,14,14,0,0,14,14,0,0,0,0,0,0,0,14,14,0,0,0,0,14,14,14,14
	.byte 14,14,0,0,0,14,14,14,14,14,14,14,0,0,14,14,14,14,14,0,0,14,14,0,0,0,0,0,0,14,14,14,14,0,0,14,14,14,14,14
	.byte 14,14,12,0,0,14,14,14,14,14,14,14,0,0,14,14,14,14,14,0,0,14,14,0,0,14,14,14,14,14,14,14,14,0,0,14,14,14,14,14
	.byte 14,14,14,0,0,0,14,14,14,0,0,14,0,0,0,14,14,14,0,0,0,14,14,0,0,14,14,14,14,14,14,14,14,0,0,14,14,14,14,14
	.byte 14,14,14,0,0,0,0,0,0,0,0,14,14,0,0,0,0,0,0,0,14,14,14,0,0,14,14,14,14,14,14,14,14,0,0,14,14,14,14,14
	.byte 14,14,14,14,0,0,0,0,0,0,14,14,14,14,0,0,0,0,0,14,14,14,14,0,0,14,14,14,14,14,14,14,14,0,0,14,14,14,14,14
	.byte 14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14
	.byte 14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14
	.byte 14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14
	.byte 14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14
	.byte 14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14
	.byte 14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14
	.byte 14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14
	.byte 14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14
	.byte 14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14

// PASTE
//; Border, bg, chars, colors
paste_pet:
//	.byte 1,1
// Character data
	.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
	.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
	.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
	.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
	.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
	.byte 32,32,32,32,32,32,32,32,32,32,32,32,85,73,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
	.byte 32,32,32,32,32,32,32,32,32,32,32,32,74,75,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
	.byte 32,32,32,108,98,98,98,32,32,32,32,32,108,123,32,32,32,32,32,98,248,248,98,32,108,98,98,98,98,98,98,32,108,98,98,98,98,123,32,32
	.byte 32,32,32,245,105,120,226,160,32,32,32,32,160,160,32,32,32,32,160,105,99,119,226,32,124,120,120,229,79,120,120,32,225,236,120,120,120,126,32,32
	.byte 32,32,32,245,117,32,32,229,117,32,32,118,97,245,117,32,32,32,160,32,32,32,32,32,32,32,32,229,101,32,32,32,225,246,32,32,32,32,32,32
	.byte 32,32,32,245,117,32,32,160,101,32,32,229,101,103,231,32,32,32,160,252,121,100,32,32,32,32,32,229,101,32,32,32,225,252,121,121,121,32,32,32
	.byte 32,32,32,245,227,227,160,105,32,32,103,231,32,32,160,32,32,32,32,226,249,160,252,32,32,32,32,229,101,32,32,32,225,236,226,226,226,32,32,32
	.byte 32,32,32,245,117,32,32,32,32,32,225,252,248,248,254,97,32,32,32,32,32,32,160,101,32,32,32,229,101,32,32,32,225,246,32,32,32,32,32,32
	.byte 32,32,32,245,117,32,32,32,32,32,160,99,99,99,99,160,32,32,32,32,32,32,160,101,32,32,32,229,101,32,32,32,225,246,32,32,32,32,32,32
	.byte 32,32,32,245,117,32,32,32,32,103,231,32,32,32,32,229,101,32,160,248,98,254,236,32,32,32,32,229,101,32,32,32,225,252,248,248,248,123,32,32
	.byte 32,32,32,99,32,32,32,32,32,96,99,32,32,32,32,99,32,32,32,119,119,99,32,32,32,32,32,99,32,32,32,32,32,99,99,99,99,32,32,32
	.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
	.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
	.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
	.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
	.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
	.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
	.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
	.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
	.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
// Color data
	.byte 14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14
	.byte 14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14
	.byte 14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14
	.byte 14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14
	.byte 14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14
	.byte 14,14,14,14,14,14,14,14,14,14,14,14,0,0,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14
	.byte 14,14,14,14,14,14,14,14,14,14,14,14,0,0,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14
	.byte 14,14,14,0,0,0,0,0,14,14,14,14,0,0,14,14,14,14,0,0,0,0,0,14,0,0,0,0,0,0,0,14,0,0,0,0,0,0,14,14
	.byte 14,14,14,0,0,0,0,0,0,14,14,0,0,0,0,14,14,9,0,0,0,0,0,14,0,0,0,0,0,0,0,14,0,0,0,0,0,0,14,14
	.byte 14,14,14,0,0,14,14,0,0,14,14,0,0,0,0,14,14,0,0,12,14,14,14,14,14,14,14,0,0,14,14,14,0,0,14,14,14,14,14,14
	.byte 14,14,14,0,0,14,0,0,0,14,14,0,0,0,0,14,14,9,0,0,0,0,14,14,14,14,14,0,0,14,14,14,0,0,0,0,0,0,14,14
	.byte 14,14,14,0,0,0,0,0,14,14,0,0,14,15,0,0,14,14,0,0,0,0,0,14,14,14,14,0,0,14,14,14,0,0,0,0,0,0,14,14
	.byte 14,14,14,0,0,14,14,14,14,14,0,0,0,0,0,0,14,14,14,14,14,0,0,0,14,14,14,0,0,14,14,14,0,0,14,14,14,14,14,14
	.byte 14,14,14,0,0,14,14,14,14,0,0,0,0,0,0,0,15,0,0,14,14,0,0,0,14,14,14,0,0,14,14,14,0,0,14,14,14,14,14,14
	.byte 14,14,14,0,0,14,14,14,14,0,0,14,14,14,14,0,0,0,0,0,0,0,0,15,14,14,14,0,0,14,14,14,0,0,0,0,0,0,14,14
	.byte 14,14,14,0,0,14,14,14,14,14,0,14,14,14,14,0,0,14,0,0,0,0,14,14,14,14,14,0,0,14,14,14,0,0,0,0,0,0,14,14
	.byte 14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14
	.byte 14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14
	.byte 14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14
	.byte 14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14
	.byte 14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14
	.byte 14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14
	.byte 14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14
	.byte 14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14
	.byte 14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14

// Counter
rastercountdown: .byte 150
