.globl app
app:
//---------------- CODE HERE ------------------------------------

/*

Pseudocode of this file

colors = [red, green, blue] // Saved in stack
direction = 1 // 1 up, -1 down
chunk_counter = 0 // Oscilates between 0 and 31
moving = *green // Pointer to the moving color in stack

while (screen not entirely painted) {
  if (direction == 1 && chunk_counter < 31 || direction == -1 y chunk_counter > 0)
    *moving += direction
  } else {
    moving = (moving - 1) mod 3 // change moving colors in the pattern g -> r -> b -> g -> ...
    direction *= -1
  }
}

*/

mov x1, 0 // TODO: Dummy counter for testing, delete when done

// Reserve memory for saving color values before rendering
sub SP, SP, 24 // Reserves 3 slots from stack pointer

initialize_row:

  // Sets full red as starting color
  mov x9, 0x1F
  str x9, [SP, 16]
  str XZR, [SP, 8]
  str XZR, [SP, 0]

  // Point x9 to the `moving` color address, green at first
  add x9, SP, 8

  // Sets direction (x10) and chunk_counter (x11)
  mov x10, 1
  mov x11, 0

// (x10 == 1 && x11 < 31) || (x10 == -1 && x11 > 0)
while1_start:
	cmp x10, xzr
	b.LE or
	cmp x11, 31
	b.LT while1_true
	or:
	cmp x10, xzr
	b.GT while1_false
	cmp x11, xzr
	b.GT while1_true
	b while1_false

	while1_true:
		// *moving += direction
		ldr x12, [x9]
		add x12, x12, x10
		str x12, [x9]

		// paint
		bl paint

		// chunk_counter += direction
		add x11, x11, x10

		b while1_start

	while1_false:
		// direction *= -1
		sub x10, xzr, x10

		// x9 = (x9 - 1) mod 3 // Ir al color anterior g -> r -> b -> g -> ...
		add x9, x9, 8
		cmp x9, x29 // x9 > FP
		b.LT while1_start
		mov x9, SP // x9 = blue
    b while1_start

while1_end: // TODO: Ver cuando terminar


paint:
	mov x12, 1 // TODO: This block is related to the x1 counter, should be gone when done
	lsl x12, x12, 18
	cmp x1, x12
	b.EQ InfLoop

	// Compose color value
	ldr w12, [x9, 16]
	ldr w13, [x9, 8]
	ldr w14, [x9, 0]
	add w14, w14, w13, LSL 6
	add w14, w14, w12, LSL 11

	// Draw pixel
	strh w14, [x0]
	add x0, x0, 2

	add x1, x1, 1 // TODO: Related to x1 at start of file remove when done

	ret

//---------------------------------------------------------------

// Infinite Loop
InfLoop:
	b InfLoop
