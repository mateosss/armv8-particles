	.data
	// Qemu specific modifications
	QEMU_BASE_ADDRESS: .dword 0x0
	UPDATE_DELTA: .dword 65536
	BACKGROUND_COLOR: .dword 0x2105

	PARTICLE_LIFETIME: .dword 60 // TODO this should be individual per particle
	ORIGIN_X: .dword 128
	ORIGIN_Y: .dword 128

	PARTICLES_AMOUNT: .dword 30
	PARTICLE_SIZE: .dword 12 // Amount of properties of a particle
	PARTICLES:
	/* Notes:
		- dir are percentage of movement, 100 means 1 pixel per frame,
	 	- tempDir is always 0 at start, and updates until it reaches 100 or more and it depletes to move
		- lifetime is 0 for restart, and X for living X frames more
		- radius and initialRadius should be equal
	*/
  // particlex: .dword initialDirX, initialDirY, posX, posY, dirX, dirY, tempDirX, tempDirY, color, lifetime, radius, initialRadius
  //									 0     				8     			 16    24    32    40    48     	 56				 64			72				80			88

	PARTICLE1: .dword -64, 128, 128, 128, -64, 128, 0, 0, 0x07FF, 1, 3, 3
	PARTICLE2: .dword 64, 128, 128, 128, 64, 128, 0, 0, 0xF81F, 2, 3, 3
	PARTICLE3: .dword 384, 172, 128, 128, 384, 172, 0, 0, 0xFFE0, 3, 3, 3
	PARTICLE4: .dword -31, 142, 128, 128, -31, 142, 0, 0, 0x520E, 4, 3, 3
	PARTICLE5: .dword 194, 351, 128, 128, 194, 351, 0, 0, 0x25FD, 5, 7, 7
	PARTICLE6: .dword -259, -46, 128, 128, -259, -46, 0, 0, 0x20D9, 6, 6, 6
	PARTICLE7: .dword 103, -293, 128, 128, 103, -293, 0, 0, 0x30B0, 7, 5, 5
	PARTICLE8: .dword -381, -204, 128, 128, -381, -204, 0, 0, 0xC1D9, 8, 7, 7
	PARTICLE9: .dword -317, 11, 128, 128, -317, 11, 0, 0, 0x8751, 9, 6, 6
	PARTICLE10: .dword -212, -309, 128, 128, -212, -309, 0, 0, 0x1A80, 10, 7, 7
	PARTICLE11: .dword -262, 240, 128, 128, -262, 240, 0, 0, 0xE388, 11, 5, 5
	PARTICLE12: .dword 16, -11, 128, 128, 16, -11, 0, 0, 0x7278, 12, 4, 4
	PARTICLE13: .dword 160, 53, 128, 128, 160, 53, 0, 0, 0x6B6A, 13, 4, 4
	PARTICLE14: .dword 63, 44, 128, 128, 63, 44, 0, 0, 0xE126, 14, 3, 3
	PARTICLE15: .dword 177, -305, 128, 128, 177, -305, 0, 0, 0x1D1C, 15, 4, 4
	PARTICLE16: .dword -167, -350, 384, 384, -167, -350, 0, 0, 0x59FC, 16, 7, 7
	PARTICLE17: .dword 166, 242, 384, 384, 166, 242, 0, 0, 0xEA93, 17, 7, 7
	PARTICLE18: .dword 315, 74, 384, 384, 315, 74, 0, 0, 0xF608, 18, 7, 7
	PARTICLE19: .dword 297, 366, 384, 384, 297, 366, 0, 0, 0x749C, 19, 5, 5
	PARTICLE20: .dword -252, 343, 384, 384, -252, 343, 0, 0, 0x2597, 20, 4, 4
	PARTICLE21: .dword -214, 204, 384, 384, -214, 204, 0, 0, 0xC5FB, 21, 6, 6
	PARTICLE22: .dword 212, -175, 384, 384, 212, -175, 0, 0, 0x3428, 22, 5, 5
	PARTICLE23: .dword 349, -103, 384, 384, 349, -103, 0, 0, 0xA8C6, 23, 3, 3
	PARTICLE24: .dword -312, 16, 384, 384, -312, 16, 0, 0, 0xC77B, 24, 3, 3
	PARTICLE25: .dword -280, 38, 384, 384, -280, 38, 0, 0, 0x4E61, 25, 6, 6
	PARTICLE26: .dword 143, 135, 384, 384, 143, 135, 0, 0, 0xEB4C, 26, 4, 4
	PARTICLE27: .dword -262, -132, 384, 384, -262, -132, 0, 0, 0xC07B, 27, 6, 6
	PARTICLE28: .dword -1, 202, 384, 384, -1, 202, 0, 0, 0x31DE, 28, 4, 4
	PARTICLE29: .dword 321, -121, 384, 384, 321, -121, 0, 0, 0xC2D3, 29, 6, 6
	PARTICLE30: .dword -263, 227, 384, 384, -263, 227, 0, 0, 0xAFEC, 30, 3, 3
	/*PARTICLE1: .dword 66, 7, 215, 324, 66, 7, 0, 0, 0x484, 1, 4, 4
	PARTICLE2: .dword -252, 137, 228, 298, -252, 137, 0, 0, 0xB9AC, 2, 7, 7
	PARTICLE3: .dword -124, -234, 314, 170, -124, -234, 0, 0, 0xBB14, 3, 8, 8
	PARTICLE4: .dword 197, 293, 233, 342, 197, 293, 0, 0, 0x5D5F, 4, 6, 6
	PARTICLE5: .dword -344, -62, 284, 318, -344, -62, 0, 0, 0xFBF1, 5, 5, 5
	PARTICLE6: .dword -225, 111, 145, 187, -225, 111, 0, 0, 0xA2B3, 6, 5, 5
	PARTICLE7: .dword -211, 66, 371, 258, -211, 66, 0, 0, 0xB8AA, 7, 4, 4
	PARTICLE8: .dword -10, -296, 223, 316, -10, -296, 0, 0, 0xBA75, 8, 7, 7
	PARTICLE9: .dword -327, -226, 341, 294, -327, -226, 0, 0, 0x1102, 9, 7, 7
	PARTICLE10: .dword -222, 375, 253, 256, -222, 375, 0, 0, 0xED43, 10, 5, 5
	PARTICLE11: .dword -14, 171, 367, 196, -14, 171, 0, 0, 0x45B6, 11, 6, 6
	PARTICLE12: .dword 44, -213, 141, 286, 44, -213, 0, 0, 0xFF31, 12, 3, 3
	PARTICLE13: .dword 108, -174, 320, 284, 108, -174, 0, 0, 0x2E38, 13, 4, 4
	PARTICLE14: .dword -203, -240, 140, 283, -203, -240, 0, 0, 0xF953, 14, 6, 6
	PARTICLE15: .dword -193, 99, 208, 285, -193, 99, 0, 0, 0x28CD, 15, 5, 5
	PARTICLE16: .dword -67, -101, 355, 227, -67, -101, 0, 0, 0xCA47, 16, 8, 8
	PARTICLE17: .dword 2, -204, 204, 323, 2, -204, 0, 0, 0x5907, 17, 7, 7
	PARTICLE18: .dword -368, 174, 266, 144, -368, 174, 0, 0, 0x41A5, 18, 8, 8
	PARTICLE19: .dword 376, 188, 268, 321, 376, 188, 0, 0, 0xC51C, 19, 5, 5
	PARTICLE20: .dword 60, -87, 287, 383, 60, -87, 0, 0, 0xE357, 20, 3, 3
	PARTICLE21: .dword 35, 332, 315, 240, 35, 332, 0, 0, 0x24C9, 21, 5, 5
	PARTICLE22: .dword -211, 157, 187, 283, -211, 157, 0, 0, 0x8BB1, 22, 8, 8
	PARTICLE23: .dword -227, 374, 368, 206, -227, 374, 0, 0, 0x4920, 23, 8, 8
	PARTICLE24: .dword 364, -149, 165, 348, 364, -149, 0, 0, 0xDC16, 24, 8, 8
	PARTICLE25: .dword -381, 215, 251, 280, -381, 215, 0, 0, 0x984C, 25, 5, 5
	PARTICLE26: .dword -249, 46, 304, 149, -249, 46, 0, 0, 0xA515, 26, 8, 8
	PARTICLE27: .dword 100, 296, 192, 276, 100, 296, 0, 0, 0xF75D, 27, 5, 5
	PARTICLE28: .dword 89, 278, 383, 256, 89, 278, 0, 0, 0xB281, 28, 3, 3
	PARTICLE29: .dword 274, -192, 365, 218, 274, -192, 0, 0, 0xD110, 29, 5, 5
	PARTICLE30: .dword -218, 362, 148, 138, -218, 362, 0, 0, 0xBD49, 30, 3, 3
	PARTICLE31: .dword 81, -194, 161, 301, 81, -194, 0, 0, 0xD6D1, 31, 4, 4
	PARTICLE32: .dword -43, -268, 371, 254, -43, -268, 0, 0, 0x62CF, 32, 8, 8
	PARTICLE33: .dword -286, 64, 376, 278, -286, 64, 0, 0, 0x87D, 33, 8, 8
	PARTICLE34: .dword -110, 267, 149, 199, -110, 267, 0, 0, 0x4855, 34, 7, 7
	PARTICLE35: .dword -38, 315, 146, 349, -38, 315, 0, 0, 0x8532, 35, 7, 7
	PARTICLE36: .dword 85, -218, 334, 165, 85, -218, 0, 0, 0x9A8F, 36, 3, 3
	PARTICLE37: .dword 346, 214, 373, 292, 346, 214, 0, 0, 0x9355, 37, 3, 3
	PARTICLE38: .dword 327, 127, 211, 141, 327, 127, 0, 0, 0x1BD3, 38, 3, 3
	PARTICLE39: .dword -174, 392, 290, 282, -174, 392, 0, 0, 0xDE9E, 39, 3, 3
	PARTICLE40: .dword 185, -393, 178, 167, 185, -393, 0, 0, 0x6BC, 40, 4, 4
	PARTICLE41: .dword -294, -342, 132, 380, -294, -342, 0, 0, 0xC13C, 41, 4, 4
	PARTICLE42: .dword 54, 323, 257, 160, 54, 323, 0, 0, 0x6749, 42, 5, 5
	PARTICLE43: .dword -253, 151, 148, 131, -253, 151, 0, 0, 0xF72F, 43, 5, 5
	PARTICLE44: .dword -123, -294, 250, 197, -123, -294, 0, 0, 0x803, 44, 5, 5
	PARTICLE45: .dword 341, 247, 237, 371, 341, 247, 0, 0, 0x136E, 45, 7, 7
	PARTICLE46: .dword 261, -274, 249, 246, 261, -274, 0, 0, 0xB9D6, 46, 4, 4
	PARTICLE47: .dword -232, -255, 233, 215, -232, -255, 0, 0, 0x683E, 47, 8, 8
	PARTICLE48: .dword 398, 307, 245, 307, 398, 307, 0, 0, 0x29E2, 48, 7, 7
	PARTICLE49: .dword 55, 172, 309, 204, 55, 172, 0, 0, 0xDE9D, 49, 6, 6
	PARTICLE50: .dword -91, 386, 207, 184, -91, 386, 0, 0, 0x97A2, 50, 6, 6
	PARTICLE51: .dword 163, -25, 181, 193, 163, -25, 0, 0, 0x59C2, 51, 3, 3
	PARTICLE52: .dword 351, -125, 310, 129, 351, -125, 0, 0, 0x8DA5, 52, 6, 6
	PARTICLE53: .dword 335, -155, 283, 160, 335, -155, 0, 0, 0x1D99, 53, 8, 8
	PARTICLE54: .dword 158, -271, 200, 243, 158, -271, 0, 0, 0xE722, 54, 7, 7
	PARTICLE55: .dword 289, -105, 228, 329, 289, -105, 0, 0, 0x963B, 55, 6, 6
	PARTICLE56: .dword 231, 375, 196, 303, 231, 375, 0, 0, 0x3170, 56, 4, 4
	PARTICLE57: .dword 218, -230, 232, 200, 218, -230, 0, 0, 0xAF5A, 57, 4, 4
	PARTICLE58: .dword 171, -293, 135, 265, 171, -293, 0, 0, 0xCBB8, 58, 7, 7
	PARTICLE59: .dword -352, -347, 284, 364, -352, -347, 0, 0, 0x9EAD, 59, 4, 4
	PARTICLE60: .dword 328, -27, 169, 189, 328, -27, 0, 0, 0x91CB, 60, 5, 5
	PARTICLE61: .dword -194, -172, 342, 230, -194, -172, 0, 0, 0x975D, 61, 3, 3
	PARTICLE62: .dword 49, 252, 264, 151, 49, 252, 0, 0, 0x30D9, 62, 8, 8
	PARTICLE63: .dword 51, 351, 228, 201, 51, 351, 0, 0, 0x95CE, 63, 5, 5
	PARTICLE64: .dword 133, 261, 350, 350, 133, 261, 0, 0, 0xA0DF, 64, 4, 4
	PARTICLE65: .dword 122, 144, 356, 246, 122, 144, 0, 0, 0xDCA8, 65, 7, 7
	PARTICLE66: .dword -92, -356, 362, 272, -92, -356, 0, 0, 0xA634, 66, 6, 6
	PARTICLE67: .dword 376, 185, 375, 338, 376, 185, 0, 0, 0x9897, 67, 4, 4
	PARTICLE68: .dword -152, -92, 266, 302, -152, -92, 0, 0, 0x1EA6, 68, 4, 4
	PARTICLE69: .dword -294, -380, 356, 160, -294, -380, 0, 0, 0x558B, 69, 8, 8
	PARTICLE70: .dword 270, -368, 168, 163, 270, -368, 0, 0, 0x9B07, 70, 6, 6
	PARTICLE71: .dword 335, 161, 143, 228, 335, 161, 0, 0, 0x7F3B, 71, 5, 5
	PARTICLE72: .dword -12, -363, 188, 188, -12, -363, 0, 0, 0x6C1C, 72, 3, 3
	PARTICLE73: .dword 89, 181, 172, 236, 89, 181, 0, 0, 0x3DB4, 73, 6, 6
	PARTICLE74: .dword -14, 20, 346, 148, -14, 20, 0, 0, 0x350, 74, 7, 7
	PARTICLE75: .dword -280, 258, 243, 341, -280, 258, 0, 0, 0xE4B6, 75, 7, 7
	PARTICLE76: .dword -172, 297, 366, 199, -172, 297, 0, 0, 0xAA7B, 76, 6, 6
	PARTICLE77: .dword 118, -378, 229, 226, 118, -378, 0, 0, 0x5C63, 77, 5, 5
	PARTICLE78: .dword 340, 228, 219, 286, 340, 228, 0, 0, 0xE0A5, 78, 5, 5
	PARTICLE79: .dword 116, -360, 359, 166, 116, -360, 0, 0, 0x4DD, 79, 7, 7
	PARTICLE80: .dword 29, -280, 158, 177, 29, -280, 0, 0, 0xCBDC, 80, 5, 5
	PARTICLE81: .dword -266, -300, 130, 169, -266, -300, 0, 0, 0x1BEF, 81, 4, 4
	PARTICLE82: .dword -389, -210, 355, 344, -389, -210, 0, 0, 0x62AD, 82, 7, 7
	PARTICLE83: .dword -360, 21, 131, 360, -360, 21, 0, 0, 0xEDCD, 83, 6, 6
	PARTICLE84: .dword 165, 109, 384, 333, 165, 109, 0, 0, 0xD56D, 84, 7, 7
	PARTICLE85: .dword -5, 252, 356, 190, -5, 252, 0, 0, 0xD4FC, 85, 8, 8
	PARTICLE86: .dword 378, -84, 187, 130, 378, -84, 0, 0, 0xCBF8, 86, 7, 7
	PARTICLE87: .dword -280, -40, 267, 334, -280, -40, 0, 0, 0x1E3E, 87, 7, 7
	PARTICLE88: .dword 277, -313, 286, 361, 277, -313, 0, 0, 0xF304, 88, 3, 3
	PARTICLE89: .dword 376, -177, 288, 234, 376, -177, 0, 0, 0x74B7, 89, 8, 8
	PARTICLE90: .dword 386, 71, 306, 376, 386, 71, 0, 0, 0xC4EC, 90, 6, 6
	PARTICLE91: .dword -33, -20, 173, 285, -33, -20, 0, 0, 0x47DA, 91, 6, 6
	PARTICLE92: .dword -180, 372, 128, 376, -180, 372, 0, 0, 0xDEB1, 92, 6, 6
	PARTICLE93: .dword 311, 72, 163, 341, 311, 72, 0, 0, 0x3EFB, 93, 6, 6
	PARTICLE94: .dword -108, 219, 252, 340, -108, 219, 0, 0, 0xEC72, 94, 7, 7
	PARTICLE95: .dword -97, -327, 371, 293, -97, -327, 0, 0, 0xF555, 95, 4, 4
	PARTICLE96: .dword 112, -20, 249, 285, 112, -20, 0, 0, 0x8D2, 96, 6, 6
	PARTICLE97: .dword 12, -223, 236, 274, 12, -223, 0, 0, 0xC728, 97, 4, 4
	PARTICLE98: .dword -140, 293, 305, 315, -140, 293, 0, 0, 0xB32C, 98, 3, 3
	PARTICLE99: .dword 213, 98, 290, 232, 213, 98, 0, 0, 0x51E6, 99, 3, 3
	PARTICLE100: .dword -129, 35, 347, 321, -129, 35, 0, 0, 0xAC0E, 100, 6, 6*/
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
