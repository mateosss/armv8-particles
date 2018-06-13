/*
Debería emitir cuadrados en vez de cruces borrandose mal, (con cruces)

*/

/* TODO's
  - [x] rename constants to uppercase
  - [x] set particle speed by percentage
  - [x] set BACKGROUND_COLOR constant
  - [x] movement temp should be part of particle memory
  - [x] load particle -> draw -> recalc loop for every particle
  - [x] clear last position of particle before painting new (erase between load and draw)
  - [x] if lifetime 0 respawn from origin
  - [x] make that work with many particles
  - [~] shape of particles
      - [x] cross
      - [~] square
      - [ ] diamond
      - [ ] circle
  - [ ] size of particles
  - [ ] modify size of particles during lifetime
  - [~] make lifetime work
      - it's not individual
  - [ ] offset of particle spawn time
  - [ ] deberia? hacer modulo 512 a los argumentos del draw pixel
  - [ ] diminish particle speed linearly
  - [ ] diminish particle speed with hermite cubic spline
  - [ ] make origin move
  - [ ] make origin move in a bezier curve
  - [ ] modify color of particle through its lifetime
  - [ ] header with explanation of what this file does with pseudocode
  - [ ] review TODOs
  - [ ] a way to share  .data in main.s and mainqemu.s
  - [ ]
*/

.globl app
app:
mov x29, x0 // TODO: Backup of framebuffer base address

mov sp, #0x8000
ldr x9, QEMU_BASE_ADDRESS // Sets QEMU_BASE_ADDRESS thing
add x9, sp, x9
mov sp, x9
//---------------- CODE HERE ------------------------------------


// Paint background

ldr x10, BACKGROUND_COLOR
cbz x10, start
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

  - x3: loadedParticle base address
  - x6: current drawn particle index
  - x7: PARTICLES_AMOUNT
  - x8: PARTICLE_SIZE

  - x19: loadedParticle.posX
  - x20: loadedParticle.posY
  - x21: loadedParticle.dirX
  - x22: loadedParticle.dirY
  - x23: loadedParticle.tempDirX
  - x24: loadedParticle.tempDirY
  - x25: loadedParticle.color
  - x26: loadedParticle.lifetime
  - x27: loadedParticle.radius

  - x29: Backup of memory address of pixel (0,0)
*/

start:

// Reset registers
mov x0, x29
mov x1, 0
mov x2, 0
mov x3, 0
mov x4, 0
mov x6, 0
ldr x7, PARTICLES_AMOUNT
ldr x8, PARTICLE_SIZE
mov x19, 0
mov x20, 0
mov x25, 0
mov x23, 0
mov x24, 0


update:

  //for every particle: load -> draw > recalc data -> store
  mov x6, x7 // x6 = PARTICLES_AMOUNT
  update_for:
    cbz x6, update_for_done
    sub x6, x6, 1

    bl load_particle

    bl clear_square

    bl recalc_x
    bl recalc_y
    bl recalc_lifetime

    bl draw_square

    bl store_particle

    b update_for
  update_for_done:

  bl delay
  b update


b InfLoop

load_particle:
  // Point x3 to PARTICLE1, and save all properties of the property to x19-x27
  // Expects particle number at x6 and PARTICLE_SIZE at x8
  ldr x3, =PARTICLES
  mul x9, x6, x8 // x9 = particle_index * PARTICLE_SIZE
  add x3, x3, x9, LSL 3 // point x3 to current particle
  ldr x9, QEMU_BASE_ADDRESS
  add x3, x3, x9

  ldr x19, [x3, #0] // posX
  ldr x20, [x3, #8] // posY
  ldr x21, [x3, #16] // dirX
  ldr x22, [x3, #24] // dirY
  ldr x23, [x3, #32] // tempDirX
  ldr x24, [x3, #40] // tempDirY
  ldr x25, [x3, #48] // color
  ldr x26, [x3, #56] // lifetime
  ldr x27, [x3, #64] // radius

  ret

store_particle:
  // save x19-x27 to the particle in memory
  // Expects particle number at x6 and PARTICLE_SIZE at x8

  str x19, [x3, #0] // posX
  str x20, [x3, #8] // posY
  str x21, [x3, #16] // dirX
  str x22, [x3, #24] // dirY
  str x23, [x3, #32] // tempDirX
  str x24, [x3, #40] // tempDirY
  str x25, [x3, #48] // color
  str x26, [x3, #56] // lifetime
  str x27, [x3, #64] // radius

  ret

clear_pixel:
  // Invokes draw_pixel with BACKGROUND_COLOR color
  stp x30, x25, [sp, #-16]!
  ldr x25, BACKGROUND_COLOR
  bl draw_pixel
  ldp x30, x25, [sp],16
  ret

draw_pixel:
  // Draws the x19, x20 pixel of x25 color
  mov x0, x29 // Reset x0
  add x0, x0, x19, LSL 1 // base + x * 2
  add x0, x0, x20, LSL 10 // (base + x * 2) + y * 512
  strh w25, [x0]
  ret

clear_cross:
  // Invokes draw_cross with BACKGROUND_COLOR color
  stp x30, x25, [sp, #-16]!
  ldr x25, BACKGROUND_COLOR
  bl draw_cross
  ldp x30, x25, [sp],16
  ret

draw_cross:
  // Draws a cross with center in the (x19, x20) pixel of x25 color
  stp x30, xzr, [sp, #-16]! // stores ret address in stack

  bl draw_pixel // center
  sub x19, x19, 1
  bl draw_pixel // left
  add x19, x19, 2
  bl draw_pixel // right
  sub x19, x19, 1
  sub x20, x20, 1
  bl draw_pixel // top
  add x20, x20, 2
  bl draw_pixel // bottom
  sub x20, x20, 1 // back to center

  ldp x30, xzr, [sp],16 // restore ret address
  ret

clear_square:
  // Invokes draw_cross with BACKGROUND_COLOR color
  stp x30, x25, [sp, #-16]!
  ldr x25, BACKGROUND_COLOR
  bl draw_square
  ldp x30, x25, [sp],16
  ret

draw_square:
  // Draws a square with center in the (x19, x20) pixel of x25 color, of x27 radius (2*x27+1 side)

  // backup variables
  stp x30, xzr, [sp, #-16]! // stores ret address in stack
  mov x9, x19 // Save original x19, x20
  mov x10, x20

  // Set draw_pixel arguments to top left corner of square
  sub x19, x19, x27
  sub x20, x20, x27

  // Set x11, x12; height and width, to 1 + 2*radius
  mov x13, 1
  add x13, x13, x27, LSL 1 // SIDE of the square

  mov x11, x13 // x11 = height of square
  mov x12, x13 // x12 = width of square

  // Draw square
  draw_square_for_height:
    cbz x11, draw_square_for_height_done // for x11 in height
    draw_square_for_width:
      cbz x12, draw_square_for_width_done // for x12 in width
        bl draw_pixel
        add x19, x19, 1
        sub x12, x12, 1
        b draw_square_for_width
      draw_square_for_width_done:
      add x20, x20, 1
      sub x11, x11, 1
      mov x12, x13 // reset x12
      sub x19, x9, x27
      b draw_square_for_height
  draw_square_for_height_done:

  // restoration
  mov x19, x9
  mov x20, x10
  ldp x30, xzr, [sp],16 // restore ret address
  ret

delay:
  ldr x12, UPDATE_DELTA
  delay_loop:
    sub x12, x12, 1
    cbnz x12, delay_loop
  ret

recalc_x:
  /*
    while (|dirTempX| < 100) {
      dirTemp -= sign(dirTempX) * 100
      draw_pixel_at_x += sign(dirTempX)
    }
    dirTemp += dir
  */
  // Position update
  x_recalc_while:
    mov x9, x23

    stp x30, xzr, [sp, #-16]!
    bl abs // x9 = |x23|
    ldp x30, xzr, [sp],16

    cmp x9, 100
    b.LT x_recalc_while_done
      cmp x23, xzr // x23 >= 0?
      b.LT x_recalc_if_false
        sub x23, x23, 100
        add x19, x19, 1
        b x_recalc_if_done
      x_recalc_if_false:
        add x23, x23, 100
        sub x19, x19, 1
      x_recalc_if_done:
      b x_recalc_while
    x_recalc_while_done:

    // dirTemp update
    add x23, x23, x21 // Add dirX to dirTempX
    ret

recalc_y:
  /* See recalc_x is the same but for Y */

  // Position update
  y_recalc_while:
    mov x9, x24

    stp x30, xzr, [sp, #-16]!
    bl abs // x9 = |x24|
    ldp x30, xzr, [sp],16

    cmp x9, 100
    b.LT y_recalc_while_done
      cmp x24, xzr // x24 >= 0?
      b.LT y_recalc_if_false
        sub x24, x24, 100
        add x20, x20, 1
        b y_recalc_if_done
      y_recalc_if_false:
        add x24, x24, 100
        sub x20, x20, 1
      y_recalc_if_done:
      b y_recalc_while
  y_recalc_while_done:

  // dirTemp update
  add x24, x24, x22 // Add dirY to dirTempY
  ret

recalc_lifetime:
  /* Substract 1 from lifetime, and if 0 reset, and reset position */
  // Lifetime update
  cmp x26, 0
  b.GT recalc_lifetime_else
    ldr x19, ORIGIN_X
    ldr x20, ORIGIN_Y
    ldr x26, PARTICLE_LIFETIME
  recalc_lifetime_else:
    sub x26, x26, 1
  recalc_lifetime_return: ret

abs:
  // x9 = |x9|
  cmp x9, xzr
  b.GE abs_ret
  sub x9, xzr, x9
  abs_ret: ret

//---------------------------------------------------------------

// Infinite Loop
InfLoop:
	b InfLoop
