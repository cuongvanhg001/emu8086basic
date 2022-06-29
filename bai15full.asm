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

 file_name db 'd:\namga.txt',0
 file_name2 db 'd:\namga2.txt',0
 
 handle dw ? 
 msg3 db 'Da thay doi ten$'

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
    rename:
        mov ah,56h ;rename file
        lea dx, file_name ; ten file cu
        lea di,file_name2 ;ten file moi
        int 21h
        mac msg3
        ret    
baib endp

end main
