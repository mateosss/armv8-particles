.data
colors: .dword 0x1F, 0, 0 // Initial r, g, b
dirBase: .dword 0x0000000040080000

updateDT: .dword 65536
particlesAmount: .dword 2
particles:
  // particlex: .dword posX, posY, dirX, dirY, color, lifetime // 100% dirX is one pixel per frame
  particle1: .dword 256, 256, -1, 1, 0xF81F, 100
  particle2: .dword 128, 384, 1, 1, 0x0AAA, 100

.text
.org 0x0000

mov x0, 0x4008
lsl x0, x0, 16
add x0, x0, 0x200

//--------------------------------------
b app
