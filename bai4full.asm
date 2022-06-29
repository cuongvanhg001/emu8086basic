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
msv db 10 dup(?)
msv2 db 'AT160210'
msg1 db 'Nhap msv: $'
msg2 db 'Ho ten: Ban Van Cuong$'
msg3 db 'msv sai'
xd db 13,10,'$'

chuoi db 20 dup(?)
msg4 db 'Chuoi: $'
msg5 db 'count = $'
.code
main proc

    mov ax, @data
    mov ds,ax
    mov es,ax
    ;call baia 
    call baib
    mov ah,4ch
    int 21h    
    
main endp

baia proc
    mac msg1
    lea si, msv
    input_sid:
        mov ah,1
        int 21h
        cmp al,0dh
        je a2
        mov [si],al
        inc si
        jmp input_sid
    a2: 
        cld
        mov cx,8
        lea si,msv2
        lea di,msv
        repe cmpsb
        je a3
        mac xd
        mac msg3
        ret
    a3:
        mac xd
        mac msg2
        ret     
baia endp

baib proc
    mac xd
    mac msg4
    mov cx,0
    mov ax,0
    input_num:
        mov ah,1
        int 21h
        cmp al,0dh
        je b1
        cmp al,'5'
        je inc_count
        jmp input_num
    b1:
        mac xd
        mac msg5
        mov dl,cl
        add dl,30h
        mov ah,2
        int 21h
        ret
    inc_count:
        add cx,1
        jmp input_num
baib endp
end main