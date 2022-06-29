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
msvv db 'AT160210'
msv db 10 dup(?)
msg1 db 'Nhap msv: $'
msg2 db 'Ten la: Ban Van Cuong$'
msg3 db 'nhap sai msv$'
xd db 13,10,'$' 
msg4 db 'Nhap n: $'
msg5 db 'count = $'
x dw ?
num db 50 dup(?)
.code

main proc
    mov ax,@data
    mov ds,ax
    mov es,ax
    mac msg1
    ;call baia 
    call baib
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
        lea si, msv
        lea di,msvv
        repe cmpsb
        je a2
        mac xd
        mac msg3
        ret
    a2:
        mac xd
        mac msg2
        ret 
baia endp 

baib proc
    input_num:
        mov ah,1
        int 21h
        cmp al,0Dh
        je b1
        mov num[si], al 
        inc si
        jmp input_num
    b1:
        mov cx,si
        mov si,0
        mov bx,0
        mac xd
        mac msg5
        
    b2:
        cmp num[si],'2'
        je inc_bx
        cmp num[si],'3'
        je inc_bx
        cmp num[si],'5'
        je inc_bx
        cmp num[si],'7'
        je inc_bx
        inc si 
        cmp si,cx
        jne b2
        jmp print
    inc_bx:
        add bx,1
        inc si
        jmp b2
    print:
        mov ah,2
        lea dx,bx
        add dx,30h
        int 21h
        ret
baib endp