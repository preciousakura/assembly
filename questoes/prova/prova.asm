org 0x7c00
bits 16

mov ax, 0
mov ds, ax
cli

mov si, str
call prints

       mov bx, 0
loopg: mov ah, 0      
       int 0x16    
       cmp al, 32
       je movime   
       cmp al, 13
       je nline

movime:cmp bx, 10
       je cont
       inc bx
       jmp loopg
cont:  mov bx, 0
       jmp loopg
nline: mov ah, 0x0e
       mov al, 10
       int 0x10
       mov al, 13
       int 0x10

       mov si, str
       mov di, str2
       call printfrag

       mov si, str2
       call prints  
       jmp loopg

jmp fim

printfrag: push si
           push cx
           push di
           push ax
           push bx
           push dx
           
           mov dx, bx
           mov cx, 0
           mov bx, 0

prtfrag:   cmp [si], byte 0
           je prtbc
           cmp cx, 7
           jge prtend

           cmp bx, dx
           jl igctr

           mov ax, [si]
           mov [di], ax

           inc cx
           inc di

igctr:     inc si
           inc bx
           jmp prtfrag
           
prtbc:     mov ax, "*"
           mov [di], ax

           inc cx
           inc di

           mov si, str
           mov bx, 0
           mov dx, 0
           
           jmp prtfrag

prtend:    pop dx
           pop bx
           pop ax
           pop di
           pop cx
           pop si
           ret

prints:
      push si
      push ax
      mov ah, 0x0e
loop: lodsb
      or al, al
      jz endp
      int 0x10       
      jmp loop
endp: pop ax
      pop si
      ret

fim: hlt

str2: times 10 db 0
str:   db "Ol", 160, ",mundo!", 0

times 510 - ($ - $$) db 0
dw 0xaa55