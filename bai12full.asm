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

 msg1 db 'Nhap ten file: $'
 msg2 db 'Nhap noi dung: $'
 file_name db 100 dup(?) 
 content db 100 dup(?)
 content_size=$ - offset content
 handle dw ?


 
 
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
    lea si,file_name
    input_str:
        mov ah,1
        int 21h
        cmp al,0dh; nhan enter de ket thuc nhap ten file
        jz b1
        cmp al,1bh ;nhan esc de ket thuc nhap noi dung
        jz b2
        mov [si],al
        inc si
        jmp input_str
    b1:
        ;create file name
        mov ah,3ch ; create new file
        lea dx,file_name  
        mov cx,0 ;thuoc tinh tap tin
        int 21h
        mov handle, ax  ;cat the file
        jmp write
    write:
        mac xd
        mac msg2
        lea si, content
        jmp input_str
    b2:
        mov ah,40h ;write content
        mov bx,handle
        lea dx,content
        mov cx,content_size
        int 21h
        jmp close
    close:
        mov ah,3eh ;close file
        mov bx,handle
        int 21h
        ret  
baib endp

end main
