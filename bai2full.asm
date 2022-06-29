mac macro msgg
    mov ah,09
    lea dx, msgg
    int 21h
    mov ax,0
    mov dx,0
endm
.model small
.stack 100h
.data
ht db 'Ban Van Cuong$'
msvv db 'AT160210'
msv db 10 dup(?)
msg1 db 'Nhap msv: $'
msg2 db 'Ten la: $'
msg3 db 'nhap sai msv$'
xd db 13,10,'$' 
msg4 db 'Nhap n: $'
msg5 db 'sum = $'
x dw ?
.code

main proc
    mov ax,@data
    mov ds,ax
    mov es,ax
    mac msg1
    ;call input_sid 
    call baib
    mov ah,4ch
    int 21h       
main endp

input_sid proc
    lea si, msv
    input: 
        mov ah,1
        int 21h
        cmp al,0Dh
        je print
        mov [si], al
        inc si
        jmp input
    print:
        mov si,0
        cld
        mov cx,8
        lea si,msvv
        lea di, msv
        repe cmpsb
        je print_name
        mac xd
        mac msg3 
        ret
    print_name:
        mac xd
        mac msg2
        mac ht
        ret    
input_sid endp

baib proc
    mac xd
    mac msg4
    mov x,0
    mov bx,0
    mov cx,0
    input_num:
        mov ah,1
        int 21h
        cmp al,0dh
        je abx
        xor ah,ah
        sub al,30h
        add bx,ax
        jmp input_num
        
    abx:
        mov ax,bx
        mov bx,10
        jmp push_stack
    push_stack:
        mov dx,0
        div bx
        inc cx
        push dx
        cmp al,0
        je abc
        jmp push_stack
    abc:
        mac xd
        mac msg5
        jmp pop_stack
    pop_stack:
        pop dx
        add dl,30h
        mov ah,2
        int 21h
        dec cx
        cmp cx,0
        jne pop_stack
        ret    
baib endp

end main