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
 msg1 db 'Nhap chuoi: $'
 msg2 db 100 dup('$')

 
 
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
    lea si, msg2
    input_str:
        mov ah,1
        int 21h
        cmp al,0dh
        jz b2
        cmp al,'a'
        jb b1
        mov [si],al
        inc si
        jmp input_str
    b1:
        cmp al,20h
        jz b3
        add al,20h
        mov [si],al
        inc si
        jmp input_str
    b3:
        mov [si],al
        inc si
        jmp input_str
    b2:
        mac xd
        mac msg2
        ret
        
    
    
baib endp

end main
