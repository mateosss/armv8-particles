.data
// Qemu specific modifications
QEMU_BASE_ADDRESS: .dword 0x0000000040080000
UPDATE_DELTA: .dword 1

PARTICLES_AMOUNT: .dword 3
PARTICLE_SIZE: .dword 8 // Amount of properties of a particle
PARTICLES:
  // particlex: .dword posX, posY, dirX, dirY, tempDirX, tempDirY, color, lifetime // 100% dir{X/Y} is one pixel per frame, tempDir{X/Y} is always 0 at start
  //									 0     8     16    24    32        40        48     56
  PARTICLE1: .dword 384, 0, -50, 100, 0, 0, 0x07FF, 40
  PARTICLE2: .dword 128, 0, 50, 100, 0, 0, 0xF81F, 40
  PARTICLE3: .dword 128, 128, 400, 1, 0, 0, 0xFFE0, 40

.text
.org 0x0000

mov x0, 0x4008
lsl x0, x0, 16
add x0, x0, 0x200

//--------------------------------------
b app
