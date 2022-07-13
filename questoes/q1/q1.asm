org 0x7c00
bits 16

mov ax, 0
mov ds, ax
cli

int 0x13

mov ah, 0x02
mov al, 3
mov cl, 2
mov ch, 0
mov dh, 0
mov bx, str

int 0x13

mov ah, 0x00 
mov al, 0x13
int 0x10

mov ax, 0xA000
mov es, ax

mov di, numero
mov si, str
call toint

jmp fim

toint: push si
       push ax
       push cx
       push bx

       mov ah, 0
       mov cx, 0

  num: mov al, [si]
       cmp al, 44
       je mnum
       cmp al, 32
       je endp

       sub ax, 48
       mov bx, ax
       mov ax, [di]
       mov dx, 0

       push bx
       mov bx, 10
       mul bx
       pop bx
       
       add ax, bx
       mov [di], ax

  rst: inc si
       jmp num
       
 mnum: call color
       inc cx
       mov [di], byte (0)
       jmp rst

 endp: call color
       pop bx
       pop cx
       pop ax
       pop si
       ret 

color: push si
       push di
       push ax
       push dx

       push cx

       mov dx, 0
       mov ax, cx
       mov cx, 320
       mul cx 

       pop cx

       add ax, [di]
       mov di, ax
       mov [es:di], byte(15)

       pop dx
       pop ax
       pop di
       pop si
       ret

fim: hlt

numero: dw 0
str: 

times 510 - ($ - $$) db 0
dw 0xaa55