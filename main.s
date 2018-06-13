	.data
	// Qemu specific modifications
	QEMU_BASE_ADDRESS: .dword 0x0
	UPDATE_DELTA: .dword 65536
	BACKGROUND_COLOR: .dword 0x2105

	PARTICLE_LIFETIME: .dword 60 // TODO this should be individual per particle
	ORIGIN_X: .dword 256
	ORIGIN_Y: .dword 256

	PARTICLES_AMOUNT: .dword 30
	PARTICLE_SIZE: .dword 10 // Amount of properties of a particle
	PARTICLES:
		/* Notes:
			- dir are percentage of movement, 100 means 1 pixel per frame,
		 	- tempDir is always 0 at start, and updates until it reaches 100 or more and it depletes to move
			- lifetime is 0 for restart, and X for living X frames more
			- radius and initialRadius should be equal
		*/
	  // particlex: .dword posX, posY, dirX, dirY, tempDirX, tempDirY, color, lifetime, radius, initialRadius
	  //									 0     8     16    24    32        40        48     56				64			72
	  PARTICLE1: .dword 384, 0, -50, 100, 0, 0, 0x07FF, 1, 2, 2
	  PARTICLE2: .dword 128, 0, 50, 100, 0, 0, 0xF81F, 2, 2, 2
	  PARTICLE3: .dword 128, 128, 400, 1, 0, 0, 0xFFE0, 3, 2, 2
		PARTICLE4: .dword 384, 0, -31, 142, 0, 0, 0x520E, 4, 2, 2
		PARTICLE5: .dword 128, 0, 194, 351, 0, 0, 0x25FD, 5, 7, 7
		PARTICLE6: .dword 128, 128, -259, -46, 0, 0, 0x20D9, 6, 6, 6
		PARTICLE7: .dword 384, 0, 103, -293, 0, 0, 0x30B0, 7, 5, 5
		PARTICLE8: .dword 128, 0, -381, -204, 0, 0, 0xC1D9, 8, 7, 7
		PARTICLE9: .dword 128, 128, -317, 11, 0, 0, 0x8751, 9, 6, 6
		PARTICLE10: .dword 384, 0, -212, -309, 0, 0, 0x1A80, 10, 7, 7
		PARTICLE11: .dword 128, 0, -262, 240, 0, 0, 0xE388, 11, 5, 5
		PARTICLE12: .dword 128, 128, 16, -11, 0, 0, 0x7278, 12, 2, 2
		PARTICLE13: .dword 384, 0, 160, 53, 0, 0, 0x6B6A, 13, 4, 4
		PARTICLE14: .dword 128, 0, 63, 44, 0, 0, 0xE126, 14, 3, 3
		PARTICLE15: .dword 128, 128, 177, -305, 0, 0, 0x1D1C, 15, 4, 4
		PARTICLE16: .dword 384, 0, -167, -350, 0, 0, 0x59FC, 16, 7, 7
		PARTICLE17: .dword 128, 0, 166, 242, 0, 0, 0xEA93, 17, 7, 7
		PARTICLE18: .dword 128, 128, 315, 74, 0, 0, 0xF608, 18, 7, 7
		PARTICLE19: .dword 384, 0, 297, 366, 0, 0, 0x749C, 19, 5, 5
		PARTICLE20: .dword 128, 0, -252, 343, 0, 0, 0x2597, 20, 4, 4
		PARTICLE21: .dword 128, 128, -214, 204, 0, 0, 0xC5FB, 21, 6, 6
		PARTICLE22: .dword 384, 0, 212, -175, 0, 0, 0x3428, 22, 5, 5
		PARTICLE23: .dword 128, 0, 349, -103, 0, 0, 0xA8C6, 23, 3, 3
		PARTICLE24: .dword 128, 128, -312, 16, 0, 0, 0xC77B, 24, 3, 3
		PARTICLE25: .dword 384, 0, -280, 38, 0, 0, 0x4E61, 25, 6, 6
		PARTICLE26: .dword 128, 0, 143, 135, 0, 0, 0xEB4C, 26, 4, 4
		PARTICLE27: .dword 128, 128, -262, -132, 0, 0, 0xC07B, 27, 6, 6
		PARTICLE28: .dword 384, 0, -1, 202, 0, 0, 0x31DE, 28, 2, 2
		PARTICLE29: .dword 128, 0, 321, -121, 0, 0, 0xC2D3, 29, 6, 6
		PARTICLE30: .dword 128, 128, -263, 227, 0, 0, 0xAFEC, 30, 2, 2

	.text
	.org 0x0000

	// Setup Frame Buffer
	.equ SCREEN_X, 512
	.equ SCREEN_Y, 512
	.equ BITS_PER_PIXEL, 16
	.equ MAIL_BASE,  0xB880 // Mailbox Base Address
	.equ MAIL_WRITE, 0x20 // Mailbox Write Register
	.equ MAIL_TAGS,  0x8    // Mailbox Channel 8: Tags (ARM to VC)
	.equ PERIPHERAL_BASE, 0x3F000000 // Peripheral Base Address

	.equ Allocate_Buffer,      0x00040001 // Frame Buffer: Allocate Buffer (Response: Frame Buffer Base Address In Bytes, Frame Buffer Size In Bytes)

	.equ Set_Physical_Display, 0x00048003 // Frame Buffer: Set Physical (Display) Width/Height (Response: Width In Pixels, Height In Pixels)
	.equ Set_Virtual_Buffer,   0x00048004 // Frame Buffer: Set Virtual (Buffer) Width/Height (Response: Width In Pixels, Height In Pixels)
	.equ Set_Depth,            0x00048005 // Frame Buffer: Set Depth (Response: Bits Per Pixel)
	.equ Set_Virtual_Offset,   0x00048009 // Frame Buffer: Set Virtual Offset (Response: X In Pixels, Y In Pixels)
	.equ Set_Palette,          0x0004800B // Frame Buffer: Set Palette (Response: RGBA Palette Values (Index 0 To 255))



// Return CPU ID (0..3) Of The CPU Executed On
	mrs x0,MPIDR_EL1 // X0 = Multiprocessor Affinity Register (MPIDR)
	ands x0,x0,3 // X0 = CPU ID (Bits 0..1)
	b.ne CoreLoop // IF (CPU ID != 0) Branch To Infinite Loop (Core ID 1..3)

// Core 0 Init the framebuffer
FB_Init:
	ldr x0, =(FB_STRUCT + MAIL_TAGS)
	ldr x1, =MAIL_BASE
	ldr x2, =FB_POINTER
	orr x1,x1,PERIPHERAL_BASE
	str w0,[x1,MAIL_WRITE + MAIL_TAGS] // Mail Box Write
	ldr w0,[x2] // W0 = Frame Buffer Pointer
	cbz w0,FB_Init // IF (Frame Buffer Pointer == Zero) Re-Initialize Frame Buffer
	and w0,w0,0x3FFFFFFF // Convert Mail Box Frame Buffer Pointer From BUS Address To Physical Address ($CXXXXXXX -> $3XXXXXXX)
	str w0,[x2] // Store Frame Buffer Pointer Physical Address

	// Core 0 branch to app
	b app

	// Infinite Loop For Core 1, 2 and 3
CoreLoop:
	b CoreLoop

.align 16
FB_STRUCT: // Mailbox Property Interface Buffer Structure
	.word FB_STRUCT_END - FB_STRUCT // Buffer Size In Bytes (Including The Header Values, The End Tag And Padding)
	.word 0x00000000 // Buffer Request/Response Code
	// Request Codes: $00000000 Process Request Response Codes: $80000000 Request Successful, $80000001 Partial Response
	// Sequence Of Concatenated Tags
	.word Set_Physical_Display // Tag Identifier
	.word 0x00000008 // Value Buffer Size In Bytes
	.word 0x00000008 // 1 bit (MSB) Request/Response Indicator (0=Request, 1=Response), 31 bits (LSB) Value Length In Bytes
	.word SCREEN_X // Value Buffer
	.word SCREEN_Y // Value Buffer

	.word Set_Virtual_Buffer // Tag Identifier
	.word 0x00000008 // Value Buffer Size In Bytes
	.word 0x00000008 // 1 bit (MSB) Request/Response Indicator (0=Request, 1=Response), 31 bits (LSB) Value Length In Bytes
	.word SCREEN_X // Value Buffer
	.word SCREEN_Y // Value Buffer

	.word Set_Depth // Tag Identifier
	.word 0x00000004 // Value Buffer Size In Bytes
	.word 0x00000004 // 1 bit (MSB) Request/Response Indicator (0=Request, 1=Response), 31 bits (LSB) Value Length In Bytes
	.word BITS_PER_PIXEL // Value Buffer

	.word Set_Virtual_Offset // Tag Identifier
	.word 0x00000008 // Value Buffer Size In Bytes
	.word 0x00000008 // 1 bit (MSB) Request/Response Indicator (0=Request, 1=Response), 31 bits (LSB) Value Length In Bytes
FB_OFFSET_X:
	.word 0 // Value Buffer
FB_OFFSET_Y:
	.word 0 // Value Buffer

	.word Set_Palette // Tag Identifier
	.word 0x00000010 // Value Buffer Size In Bytes
	.word 0x00000010 // 1 bit (MSB) Request/Response Indicator (0=Request, 1=Response), 31 bits (LSB) Value Length In Bytes
	.word 0 // Value Buffer (Offset: First Palette Index To Set (0-255))
	.word 2 // Value Buffer (Length: Number Of Palette Entries To Set (1-256))
FB_PAL:
	.word 0x00000000,0xFFFFFFFF // RGBA Palette Values (Offset To Offset+Length-1)

	.word Allocate_Buffer // Tag Identifier
	.word 0x00000008 // Value Buffer Size In Bytes
	.word 0x00000008 // 1 bit (MSB) Request/Response Indicator (0=Request, 1=Response), 31 bits (LSB) Value Length In Bytes
FB_POINTER:
	.word 0 // Value Buffer
	.word 0 // Value Buffer

	.word 0x00000000 // $0 (End Tag)
FB_STRUCT_END:
