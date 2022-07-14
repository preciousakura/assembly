org 0x7c00  
bits 16

mov ax, 0
mov ds, ax

mov di, resp
call geti

;---------------------------programa principal-----------------------------
;inicializando registradores para ajudar no calc dos numeros de fibonacci

init:  mov bx, 0
       mov cx, 1
       
fibo:  cmp [resp], byte 0  ;caso di esteja em 0, ja percorremos os n numeros 
       jle fimfibcx         ;iremos para fim caso 0
       add cx, bx          ;cx = 2, segunda iteracao cx = 2+3 = 5 (somas recursivas de fibonacci)

       mov ax, [resp]
       dec ax
       mov [resp], ax      ;decremento em di
       
       cmp [resp], byte 0  ;comparar com 0, caso verdade vamos para o finall printar
       jle fimfibcx  
       add bx, cx          ;bx = 3 (note q inicializamos ambox cx e bx com 1 linhas 109 e 110)

       mov ax, [resp]
       dec ax
       mov [resp], ax      ;decremento em di

       cmp [resp], byte 0  ;comparar com 0, caso verdade vamos para o finall printar 
       jle fimfibbx 

       jmp fibo            ;voltamos para linha 112, continuar nosso programa


fimfibcx:mov ah, 0
         mov [resp], cx
         mov si, resp   ;mover cx para si, para printarmos
         call printi
         jmp fim

fimfibbx:mov ah, 0
         mov [resp], bx
         mov si, resp   ;mover bx para si, para printarmos
         call printi
         jmp fim

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

resp: db 0

times 510 - ($ - $$) db 0
dw 0xaa55

        