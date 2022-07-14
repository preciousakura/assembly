org 0x7c00
bits 16

mov ax, 0
mov ds, ax
cli

mov ax, 0xA000
mov es, ax

mov ah, 0x00 
mov al, 0x13 
int 0x10  

mov si, line
mov di, currentcolor
call chgplt

call clrln

jmp fim

chgplt: push di
        push si
        push ax
        push dx
        push cx

        mov cx, 0

chloop: mov ah, 0
        mov dx, 0x03c8
        mov al, [si]
        out dx, al
        mov dx, 0x03c9

clrcmp: cmp [di], byte 'g'
        je grnclr

        cmp [di], byte 'b'
        je blclr

        cmp [di], byte 'y'
        je yclr

 rdclr: mov al, cl
        out dx, al
        
        mov al, 0
        out dx, al
        
        mov al, 0
        out dx, al

        jmp rgbend

grnclr: mov al, 0
        out dx, al
        
        mov al, cl
        out dx, al
        
        mov al, 0
        out dx, al

        jmp rgbend

 blclr: mov al, 0
        out dx, al
        
        mov al, 0
        out dx, al
        
        mov al, cl
        out dx, al

        jmp rgbend

  yclr: mov al, cl
        out dx, al
        
        mov al, cl
        out dx, al
        
        mov al, 0
        out dx, al

rgbend: mov ax, [si]
        cmp ax, 255
        je chgend
        cmp cx, 63
        je chcolor
  test: inc cx
        inc ax
        mov [si], ax
        jmp chloop

chcolor:cmp [di], byte 'r'
        je cred

        cmp [di], byte 'g'
        je cgrn

        cmp [di], byte 'b'
        je cble

        cmp [di], byte 'y'
        je cble

cred: mov [di], byte 'g'
      mov cx, 0
      jmp test
      
cgrn: mov [di], byte 'b'
      mov cx, 0
      jmp test

cble: mov [di], byte 'y'
      mov cx, 0
      jmp test

chgend: pop cx
        pop dx
        pop ax
        pop si
        pop di
        ret

clrln:push ax
      push di
      push bx
      push si
      push cx
      push dx

      mov cx, 0
clinc:cmp cx, 256
      je clrfm
      mov ax, cx
      mov bx, 320
      mul bx
      mov bx, ax

      sub ax, 320
      mov di, ax

loop: mov [es:di], cl
      inc di
      cmp di, bx
      je lpend
      jmp loop
lpend:inc cx
      jmp clinc
clrfm:pop dx
      pop cx
      pop si
      pop bx
      pop di
      pop ax
      ret

fim: hlt

line: dw 0
currentcolor: db 'r'

times 510 - ($ - $$) db 0
dw 0xaa55