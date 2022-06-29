mac macro msgg
    mov ah,9
    lea dx, msgg
    int 21h
    mov ax,0
    mov dx,0
endm
.model small
.stack 100h
.data 
 
 msv2 db 'AT160210'
 msv db 10 dup(?)
 hoten db 'Ban Van Cuong$' 
 sai db 'M nhap sai roi$'
 xd db 13,10,'$'
 msg1 db 'Nhap so thap phan: $'
 msg2 db 'Bin: $'
 msg3 db ' Hex: $'
 x dw 0
 y dw 0
 z dw 0
 
 
.code
main proc
    mov ax,@data
    mov ds,ax
    mov es,ax
    ;call baia
    call baib
    ;exit
    mov ah,4ch
    int 21h    
    
main endp


baia proc
    lea si, msv
    input_sid:
        mov ah,1
        int 21h
        cmp al,0dh
        je a1
        mov [si], al
        inc si
        jmp input_sid
    a1:
        cld
        mov cx,8
        lea si,msv2
        lea di,msv
        repe cmpsb
        je a2
        mac xd
        mac sai
        ret
    a2:
        mac xd
        mac hoten
        ret     
baia endp


baib proc
    mac xd
    mac msg1
    mov bx,10
    input_num:
        mov ah,1
        int 21h
        cmp al,0dh
        jz b1
        sub al,30h ;chuyen ve so
        xor ah,ah
        mov y,ax
        mov ax,x
        mul bx
        add ax,y
        mov x,ax
        jmp input_num
    b1: 
        mac xd
        mac msg3
        call hex
        mac xd
        mac msg2
        call bin
        ret

baib endp

hex proc
    mov bx,16
    mov ax,x
    mov cx,0
    div_hex:
        mov dx,0
        div bx
        inc cx
        push dx
        cmp al,0
        je print_hex
        jmp div_hex
    print_hex:
        pop dx
        cmp dl,9
        ja convert
        add dl,30h
        mov ah,2
        int 21h
        jmp continue
    convert:
        cmp dl,10
        jne B
        mov dl,'A'
        mov ah,2
        int 21h
        jmp continue
        B:
            cmp dl,11
            jne C
            mov dl,'B'
            mov ah,2
            int 21h
            jmp continue
        C:
            cmp dl,12
            jne D
            mov dl,'C'
            mov ah,2
            int 21h
            jmp continue
        D:
            cmp dl,13
            jne E
            mov dl,'C'
            mov ah,2
            int 21h
            jmp continue
        E:
            cmp dl,14
            jne F
            mov dl,'E'
            mov ah,2
            int 21h
            jmp continue
        F:
            mov dl,'F'
            mov ah,2
            int 21h
            jmp continue
     continue:
        dec cx
        cmp cx,0
        jne print_hex
        ret
hex endp
bin proc
    mov cx,0
    mov bx,2
    mov ax,x
    div_bin:
        mov dx,0
        div bx
        push dx
        inc cx
        cmp al,0
        je push_full
        jmp div_bin
    push_full:
        mov dx,0
        push dx
        inc cx
        cmp cx,16
        je print_bin
        jmp push_full
    print_bin:
        pop dx
        add dl,30h
        mov ah,2
        int 21h
        loop print_bin
        dec cx
        ret
bin endp

end main
