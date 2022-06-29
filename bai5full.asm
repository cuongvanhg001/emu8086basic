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
 msg1 db 'Nhap day so co dau: $'
 msg2 db 'Tong so duong: $'
 msg3 db ' Tong so am: $'
 
 
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
    mov bx,0
    mov cx,0
    input_num:
        mov ah,1
        int 21h
        cmp al,0dh
        jz b1
        cmp al, '+'
        je so_duong
        cmp al,'-'
        je so_am
        jmp input_num
    so_duong:
        mov ah,1
        int 21h
        add bx,1
        jmp input_num
    so_am:
        mov ah,1
        int 21h
        add cx,1
        jmp input_num
    b1:
        mac xd
        mac msg2
        mov dx,bx
        add dl,30h
        mov ah,2
        int 21h
        mac xd
        mac msg3
        mov dx,cx
        add dl,30h
        mov ah,2
        int 21h
        ret    
    
baib endp

end main
