.globl app
app:
//---------------- CODE HERE ------------------------------------

/* colores= [rojo, verde, azul]
direccion = 1
moviendo = *verde

*moviendo += direccion
if dir es 1 y contadorDeMovimiento == 32 || dir es  -1 y contadorDeMovimiento es 0
	moviendo = (moviendo - 1) mod colores.length
	dir *= -1
}
else repetir */

mov x1, 0

// Reserve memory for saving color values before rendering
sub SP, SP, 24 // Reserves 3 slots from stack pointer
str XZR, [SP, 0]
str XZR, [SP, 8]
str XZR, [SP, 16]

// Sets full red
mov x9, 0
str x9, [SP, 0]

// Point x9 to the `increasing` color address, green at first
add x9, SP, 8

// Sets direction (x10) and chunk_counter (x11)
mov x10, 1
mov x11, 0

bl paint

// (dir == 1 && chunk_counter < 32) || (x10 == -1 && x11 >= 0)
while1_start:
	cmp x10, xzr
	b.LE or
	cmp x11, 32
	b.LT while1_true
	or:
	cmp x10, xzr
	b.GT while1_false
	cmp x11, xzr
	b.GE while1_true
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

		b while1_end

	while1_false:
		// direction *= -1
		sub x10, xzr, x10

		// x9 = (x9 - 1) mod 3
		sub x9, x9, 8
		cmp x9, FP
		b.GE while1_end
		add x12, FP, 16
		mov x9, x12

while1_end:


paint:
	mov x12, 1
	lsl x12, x12, 18
	cmp x1, x12
	b.EQ InfLoop


	// Compose color value
	ldr w12, [x9, 0]
	ldr w13, [x9, 8]
	ldr w14, [x9, 16]
	add w14, w14, w13, LSL 5
	add w14, w14, w12, LSL 11

	// Draw pixel
	strh w14, [x0]
	add x0, x0, 2

	add x1, x1, 1

	ret

//---------------------------------------------------------------

// Infinite Loop
InfLoop:
	b InfLoop
