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
 space db ' $'
 msg1 db 'Nhap chuoi: $'
 msg2 db 100 dup('$') 
 msg3 db 'So ki tu: $'

 
 
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
    mov cx,0
    input_str:
        mov ah,1
        int 21h
        cmp al,0dh
        jz b1
        inc cx
        jmp input_str
    b1:
        mac xd
        mac msg3 
        mov bx,10
        mov ax,cx
        mov cx,0
        jmp b2
    b2:
        mov dx,0
        div bx
        inc cx
        push dx
        cmp al,0
        je b3
        jmp b2
    b3:
        pop dx
        add dl,30h
        mov ah,2
        int 21h
        dec cx
        cmp cx,0
        jne b3
        ret
baib endp

end main
