.data
// Qemu specific modifications
QEMU_BASE_ADDRESS: .dword 0x0000000040080000
UPDATE_DELTA: .dword 1
BACKGROUND_COLOR: .dword 0x0

PARTICLE_LIFETIME: .dword 60 // TODO this should be individual per particle
ORIGIN_X: .dword 256
ORIGIN_Y: .dword 256

PARTICLES_AMOUNT: .dword 30
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
  PARTICLE2: .dword 128, 0, 50, 100, 0, 0, 0xF81F, 2
  PARTICLE3: .dword 128, 128, 400, 1, 0, 0, 0xFFE0, 3

  PARTICLE4: .dword 384, 0, -31, 142, 0, 0, 0x520E, 4
  PARTICLE5: .dword 128, 0, 194, 351, 0, 0, 0x25FD, 5
  PARTICLE6: .dword 128, 128, -259, -46, 0, 0, 0x20D9, 6
  PARTICLE7: .dword 384, 0, 103, -293, 0, 0, 0x30B0, 7
  PARTICLE8: .dword 128, 0, -381, -204, 0, 0, 0xC1D9, 8
  PARTICLE9: .dword 128, 128, -317, 11, 0, 0, 0x8751, 9
  PARTICLE10: .dword 384, 0, -212, -309, 0, 0, 0x1A80, 10
  PARTICLE11: .dword 128, 0, -262, 240, 0, 0, 0xE388, 11
  PARTICLE12: .dword 128, 128, 16, -11, 0, 0, 0x7278, 12
  PARTICLE13: .dword 384, 0, 160, 53, 0, 0, 0x6B6A, 13
  PARTICLE14: .dword 128, 0, 63, 44, 0, 0, 0xE126, 14
  PARTICLE15: .dword 128, 128, 177, -305, 0, 0, 0x1D1C, 15
  PARTICLE16: .dword 384, 0, -167, -350, 0, 0, 0x59FC, 16
  PARTICLE17: .dword 128, 0, 166, 242, 0, 0, 0xEA93, 17
  PARTICLE18: .dword 128, 128, 315, 74, 0, 0, 0xF608, 18
  PARTICLE19: .dword 384, 0, 297, 366, 0, 0, 0x749C, 19
  PARTICLE20: .dword 128, 0, -252, 343, 0, 0, 0x2597, 20
  PARTICLE21: .dword 128, 128, -214, 204, 0, 0, 0xC5FB, 21
  PARTICLE22: .dword 384, 0, 212, -175, 0, 0, 0x3428, 22
  PARTICLE23: .dword 128, 0, 349, -103, 0, 0, 0xA8C6, 23
  PARTICLE24: .dword 128, 128, -312, 16, 0, 0, 0xC77B, 24
  PARTICLE25: .dword 384, 0, -280, 38, 0, 0, 0x4E61, 25
  PARTICLE26: .dword 128, 0, 143, 135, 0, 0, 0xEB4C, 26
  PARTICLE27: .dword 128, 128, -262, -132, 0, 0, 0xC07B, 27
  PARTICLE28: .dword 384, 0, -1, 202, 0, 0, 0x31DE, 28
  PARTICLE29: .dword 128, 0, 321, -121, 0, 0, 0xC2D3, 29
  PARTICLE30: .dword 128, 128, -263, 227, 0, 0, 0xAFEC, 30

.text
.org 0x0000

mov x0, 0x4008
lsl x0, x0, 16
add x0, x0, 0x200

//--------------------------------------
b app
