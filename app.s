.globl app
app:
mov x29, x0 // TODO: Backup of framebuffer base address

mov sp, #0x8000
ldr x9, dirBase // Sets dirbase thing
add x9, sp, x9
mov sp, x9
//---------------- CODE HERE ------------------------------------


// Paint background
/*
mov w10, 0x2105    // GRIS
mov x2,512         // Y Size
loop1:
  mov x1,512         // X Size
loop0:
  sturh w10,[x0]	   // Set color of pixel N
  add x0,x0,2	   // Next pixel
  sub x1,x1,1	   // decrement X counter
  cbnz x1,loop0	   // If not end row jump
  sub x2,x2,1	   // Decrement Y counter
  cbnz x2,loop1	   // if not last row, jump
*/

/*

TODO: Pseudocode here

origin = [x, y]
particle = [x, y, r, g, b speedx, speedy, life]

paint x,y,r,g,b

*/

/* List of used registers
  - x0: Last painted pixel memory address
  - x1: Last painted pixel column
  - x2: Last painted pixel row
  - x8: Base address of selected particle
  - x9: Argument X of draw_pixel
  - x10: Argument Y of draw_pixel
  - x11: Argument COLOR of draw_pixel
  - x29: Backup of memory address of pixel (0,0)
*/

mov x0, x29 // Reset x0

mov x1, 0 // Current screen column x
mov x2, 0 // Current screen row y


bl load_particle
update:
  bl draw_pixel
  add x9, x9, 1
  add x10, x10, 1

  bl delay
  b update


b InfLoop

load_particle:
  // Point x8 to particle1
  ldr x8, =particle1
  ldr x7, dirBase // Sets dirbase thing
  add x8, x8, x7

  ldr x9, [x8, #0] // x
  ldr x10, [x8, #8] // y
  ldr x11, [x8, #32] // color
  ret

draw_pixel:
  // Draws the x9, x10 pixel of x11 color
  mov x0, x29 // Reset x0
  sub x12, x9, x1 // offset_x
  sub x13, x10, x2 // offset_y

  add x0, x0, x12, LSL 1 // x + offset_x * 2
  add x0, x0, x13, LSL 10 // y + offset_y * 512
  strh w11, [x0]
  ret

delay:
  ldr x12, updateDT
  delay_loop:
    sub x12, x12, 1
    cbnz x12, delay_loop
    ret

//---------------------------------------------------------------

// Infinite Loop
InfLoop:
	b InfLoop
