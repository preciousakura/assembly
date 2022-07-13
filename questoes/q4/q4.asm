org 0x7c00
bits 16

mov ax, 0
mov ds, ax
cli

call cgcolor

cgcolor: push ax
         push bx 
         push cx 
         push dx ; color

         mov cx, 0

 loopcg: cmp cx, 256
         je cgend

         cmp dl, 64
         jmp chcolor

coloring:push dx
         mov dx, 0x03c8
         mov al, cl
         out dx, al
         mov dx, 0x03c9

         mov bl, 'g'
         cmp bl, flagcolor
         je grcolor

         mov bl, 'b'
         cmp bl, flagcolor
         je blcolor

redcolor: mov al, dl ; color
          out dx, al
        
          mov al, 0
          out dx, al
        
          mov al, 0
          out dx, al

          jmp keepon

 grcolor: mov al, 0
          out dx, al
        
          mov al, dl ; color
          out dx, al
        
          mov al, 0
          out dx, al

          jmp keepon

blcolor : mov al, 0
          out dx, al
        
          mov al, 0
          out dx, al
        
          mov al, dl ; color
          out dx, al
        
 keepon: inc dl
         inc cx
         pop dx
         jmp loopcg

chcolor: mov bx, flagcolor
         cmp [bx], byte 'r'
         je chred
         cmp [bx], byte 'g'
         je chblue
         cmp [bx], byte 'b'
         je chgreen
  chred: mov [bx], byte 'b'
         jmp chend
 chblue: mov [bx], byte 'g'
         jmp chend
chgreen: mov [bx], byte 'r' 
  chend: mov dx, 0
         jmp coloring

  cgend: pop dx
         pop cx
         pop bx
         pop ax
         ret

pintar: push ax
        push bx
        push dx

        mov ah, 0x00 
        mov al, 0x13
        int 0x10

       push cx
       push ax

       mov dx, 0
       mov ax, cx
       mov cx, 320
       mul cx 
       
       pop ax
       pop cx
    lp: cmp bx, cx
        je endps
        mov [es:di], byte(15)
 endps: pop dx
        pop bx
        pop ax

flagcolor: db 'r'

times 510 - ($ - $$) db 0
dw 0xaa55