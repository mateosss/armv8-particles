.data
colors: .dword 0x1F, 0, 0 // Initial r, g, b
dirBase: .dword 0x0000000040080000

.text
.org 0x0000

mov x0, 0x4008
lsl x0, x0, 16
add x0, x0, 0x100

//--------------------------------------
b app
