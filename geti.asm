org 0x7c00
bits 16

mov ax, 0
mov ds, ax

mov di, resp
call geti

mov si, resp
call printi

jmp fim

geti: push di
      push cx
      push dx
      push ax
      push bx

      mov cx, 1
      
      mov ax, 10
      push ax

loop: mov ah, 0
      int 0x16   ;interrupção de teclado
      cmp al, 8
      je bksp
      cmp al, 13
      je nline
      mov ah, 0
      push ax
      mov ah, 0x0e
      int 0x10 
      jmp loop

bksp: mov ah, 0x0e
      int 0x10
      mov al, 32
      int 0x10
      mov al, 8
      int 0x10
      pop ax 
      jmp loop 

nline:mov ah, 0x0e
      mov al, 10
      int 0x10
      mov al, 13
      int 0x10
      mov [di], byte(0) 

pil:  pop ax
      cmp ax, 10
      je endp
      sub ax, 48
      mul cx
      add [di], ax

      mov ax, cx
      mov cx, 10
      mul cx
      mov cx, ax

      jmp pil

endp: pop bx
      pop ax
      pop dx
      pop cx
      pop di
      ret


printi:
      push si
      push ax
      push bx
      push dx
      
      mov ax, 10
      push ax
      mov ax, [si]
dvd:  mov dx, 0      
      mov bx, 10
      div bx
      push dx
      cmp ax, 0
      je  imp
      jmp dvd

imp:  pop ax
      cmp ax, 10
      je trm
      mov ah, 0x0e
      add al, 48
      int 0x10
      jmp imp
      
trm:  pop dx
      pop bx
      pop ax
      pop si
      ret

fim: hlt

resp: 

times 510 - ($ - $$) db 0
dw 0xaa55