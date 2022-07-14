push si
        push ax

        mov si, line
        call printi

        mov ah, 0x0e
        mov al, 44
        int 0x10

        mov [r], cx
        mov si, r
        call printi

        mov [r], bx
        mov si, r
        call printi

        mov [r], bx
        mov si, r
        call printi

        mov ah, 0x0e
        mov al, 32
        int 0x10

        pop ax
        pop si
