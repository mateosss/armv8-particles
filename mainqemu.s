.data
// Qemu specific modifications
QEMU_BASE_ADDRESS: .dword 0x0000000040080000
UPDATE_DELTA: .dword 1
BACKGROUND_COLOR: .dword 0x0

PARTICLE_LIFETIME: .dword 60 // TODO this should be individual per particle
ORIGIN_X: .dword 256
ORIGIN_Y: .dword 256
PARTICLES_AMOUNT: .dword 3
PARTICLE_SIZE: .dword 8 // Amount of properties of a particle
PARTICLES:
  /* Notes:
    - dir are percentage of movement, 100 means 1 pixel per frame,
    - tempDir is always 0 at start, and updates until it reaches 100 or more and it depletes to move
    - lifetime is 0 for restart, and X for living X frames more

  */
  // particlex: .dword posX, posY, dirX, dirY, tempDirX, tempDirY, color, lifetime
  //									 0     8     16    24    32        40        48     56
  PARTICLE1: .dword 384, 0, -50, 100, 0, 0, 0x07FF, 1
  PARTICLE2: .dword 128, 0, 50, 100, 0, 0, 0xF81F, 1
  PARTICLE3: .dword 128, 128, 400, 1, 0, 0, 0xFFE0, 1

.text
.org 0x0000

mov x0, 0x4008
lsl x0, x0, 16
add x0, x0, 0x200

//--------------------------------------
b app
