.globl app
app:
mov sp, #0x8000
ldr x9, dirBase // Sets dirbase thing
add x9, sp, x9
mov sp, x9
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

ldr x1, =colors // x1 will be de location of the colors array, sets dirBase offset for qemu
ldr x9, dirBase
add x1, x1, x9


initialize_row:
  mov x2, 0 // Column counter, reset row on x2 == 512

  // Sets full red as starting color
  mov x9, 0x1F
  stur x9, [x1, 0]
  stur XZR, [x1, 8]
  stur XZR, [x1, 16]

  // Point x9 to the `moving` color address, green at first
  add x9, x1, 8

  // Sets direction (x10) and chunk_counter (x11)
  mov x10, 1
  mov x11, 0

  /* cbz x30, while1_start // First execution of initialize_row
  ret */

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
		sub x9, x9, 8 // x9--
    cmp x9, x1 // x9 < &colors
		b.GE while1_start
		add x9, x1, 16 // x9 = blue
    b while1_start

while1_end: // TODO: Ver cuando terminar

paint:
	// Compose color value
	ldur w12, [x1, 0]
	ldur w13, [x1, 8]
	ldur w14, [x1, 16]
	add w14, w14, w13, LSL 6
	add w14, w14, w12, LSL 11

	// Draw pixel
	strh w14, [x0]
	add x0, x0, 2

	add x2, x2, 1 // TODO: Related to x2 at start of file remove when done

  cmp x2, 2048
  b.EQ InfLoop
  /* cmp x2, 512 // Last column? then initialize_row
  b.LT paint_return
  b initialize_row*/
  /*str x30, [sp, #-8]! // Save return address in stack
  bl initialize_row
  ldr x30, [sp],8*/

	paint_return: ret

//---------------------------------------------------------------

// Infinite Loop
InfLoop:
	b InfLoop
