.globl app
app:
	// X0 contiene la direccion base del framebuffer
	
	//---------------- CODE HERE ------------------------------------
	
	mov w10, 0x07E0    // 0x07E8 = GREEN
	mov x2,512         // Y Size 
loop1:
	mov x1,512         // X Size
loop0:
	sturh w10,[x0]	   // Set color of pixel N
	add x0,x0,2	   // Next pixel
	sub x1,x1,1	   // decrement X counter
	cbnz x1,loop0	   // If not end row jump
	
	sub x2,x2,1	   // Decrement Y counter
	cmp x2, 256
	B.NE cont
	mov w10, 0x001F	   // BLUE
cont:	
	cbnz x2,loop1	   // if not last row, jump

	//---------------------------------------------------------------
	
        // Infinite Loop 
InfLoop: 
	b InfLoop
	
