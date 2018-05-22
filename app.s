.globl app
app:
	// X0 contiene la direccion base del framebuffer
    // X1 x. col
    // X2 y. rows
    // w10 color
    // x3 amount of pixels to paint for the paint function



	//---------------- CODE HERE ------------------------------------
  mov x3, 2
	mov x2,512         // Y Size
  mov x4, 1 // Sections of the loop


ymov:
    mov w10, 0xF800    // 0xF800 = red
    sub x2,x2,1
    mov x1,0         // X Size
    mov x4, 1

    cbz x2, InfLoop
    b f0_t63

f0_t63:
    bl paint
    /*if x4==1{
      cmp x1, 64
    } elif x4==0 {
    }
      cmp x1, 448 //384 + 64
    b.EQ f64_t127*/

    cmp x4, 1
    b.NE else
    cmp x1, 64
    b done
    else:
      cmp x1, 448
    done:
    b.EQ f64_t127

    add w10, w10, 0x40 //sube verde
    b f0_t63

f64_t127:
    bl paint
    /* if  x4 == 1 {
      cmp x1, 128
      b.EQ f128_191
    } else {
      cmp x1, 512
      b.EQ ymov
    } */
    cmp x4, 1
    b.NE else1
      cmp x1, 128
      b.EQ f128_191
      b done1
    else1:
      cmp x1, 512
      b.EQ ymov
    done1:
    sub w10, w10, 0x800 //baja rojo
    b f64_t127

f128_191:
    bl paint
    cmp x1, 192
    b.EQ f192_t255
    add w10, w10, 1 //sube azul
    b f128_191

f192_t255:
    bl paint
    cmp x1, 256
    b.EQ f256_t319
    sub w10, w10, 0x40 //baja verde
    b f192_t255

f256_t319:
    bl paint
    cmp x1, 320
    b.EQ f320_t383
    add w10, w10, 0x800 //sube rojo
    b f256_t319

f320_t383:
    bl paint
    cmp x1, 384

    /*b.EQ f384_512
    if x1==384 {
      x4--q
      b f0_t63
    }*/
    cmp x1, 384
    b.NE else2
      sub x4, x4, 1
      b f0_t63
    else2:
      sub w10, w10, 1 //baja azul
      b f320_t383

f384_512:
    mov w10, 0x0
    bl paint
    cmp x1, 512
    b.EQ ymov
    b f384_512

paint:
  	sturh w10,[x0]	   // Set color of pixel N
  	add x0,x0,2	   	   // Next pixel
  	add x1,x1,1	       // decrement X counter
    sub x3, x3, 1 // Decrement x3 paint counter
    cbnz x3, paint
    mov x3, 2
    ret







//---------------------------------------------------------------

// Infinite Loop
InfLoop:
	b InfLoop
