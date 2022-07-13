org 0x7c00
bits 16

mov ax, 0
mov ds, ax
cli

mov di, str1
call gets

mov di, str2
call gets 

mov si, str1
call substr

fim: hlt

substr: push bx
        push ax
        push si
        push di
subloop:cmp si, 11
        je posyes
        mov bl, [di] 
        cmp bl, 0
        je posyes
        mov al, [si]
        cmp al, bl
        je keepon
        jmp posnot
keepon: inc si
        inc di
        jmp subloop
posyes: mov si, stryes  
        jmp subend
posnot: mov si, strnot 
subend: call prints 
        pop di
        pop si
        pop ax
        pop bx
        ret

gets:  push ax
       push di    
loopg: mov ah, 0      
       int 0x16    
       cmp al, 8
       je bksp   
       cmp al, 13
       je nline
       mov [ds:di], al
       inc di        
wri:   mov ah, 0x0e
       int 0x10   
       jmp loopg
bksp:  dec di
       mov ah, 0x0e
       int 0x10
       mov al, 32
       int 0x10
       mov al, 8
       jmp wri   
nline: mov ah, 0x0e
       mov al, 10
       int 0x10
       mov al, 13
       int 0x10
       mov [ds:di], byte(0)
       pop di
       pop ax
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

str1: times 10 db 0
stryes: dw "eh substring", 0
strnot: dw "nao eh substring", 0
str2:

times 510 - ($ - $$) db 0
dw 0xaa55