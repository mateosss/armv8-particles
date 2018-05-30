.data
  _stack_ptr: .dword _stack_end   // Get the stack pointer value from memmap definition
.text
.org 0x0000

ldr x1, _stack_ptr  // Load stack pointer to X1
mov SP, x1          // Move stack pointer to the sp register
mov x29, SP

mov x0, 0x4008
lsl x0, x0, 16
add x0, x0, 0x100

//--------------------------------------
b app
