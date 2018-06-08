# Odc2018 - Lab Rpi3

- Configuracion de pantalla: 512x512 pixeles, formato RGB 16 bits.
- El registro X0 contiene la direccion base del FrameBuffer (Pixel 1)
- El codigo de cada consigna debe ser escrito en el archivo app.s
- El archivo main.s contiene la inicializacion del FrameBuffer y la llamada a app.s (NO EDITAR)
- El codigo de ejemplo pinta toda la pantalla de color ROJO puro.
- dashboard memory watch 0x40080100 256

# Use the stack
```arm
str x30, [sp, #-8]! // Save return address in stack
bl initialize_row
ldr x30, [sp],8
```
