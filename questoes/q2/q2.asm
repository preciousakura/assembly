org 0x7c00
bits 16

mov ax, 0
mov ds, ax
cli


times 510 - ($ - $$) db 0
dw 0xaa55