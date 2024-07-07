%include "../include/io.mac"

struc proc
    .pid: resw 1
    .prio: resb 1
    .time: resw 1
endstruc

section .text
    global sort_procs

sort_procs:
    ;; DO NOT MODIFY
    enter 0,0
    pusha

    mov edx, [ebp + 8]      ; processes
    mov eax, [ebp + 12]     ; length
    ;; DO NOT MODIFY

    ;; Your code starts here

    ; iterating from the last one to the first one
    dec eax
    mov ebx, eax            ; i = len - 1

    i_iteration:
        mov ecx, ebx      
        dec ecx             ; j = i - 1

        mov esi, edx        ; temp offset for the element in i_iteration
        mov eax, proc_size
        mul ebx             ; eax = i * proc_size 
        mov edx, esi        ; edx = offset
        mov esi, eax        ; esi "=" i 

    j_iteration:
        mov edi, edx        ; temp offset for the element in j_iteration
        mov eax, proc_size
        mul ecx             ; eax, edx = j * proc_size 
        mov edx, edi        ; edx = offset
        mov edi, eax        ; edi "=" j

        ; after the positions and the offset are set  
        ; sorts by priority in descendig order starting with the last
        ; process being equivalent to sorting ascending starting with
        ; the first process
        mov al, byte [edx + esi + proc.prio]
        cmp al, byte [edx + edi + proc.prio]
        jl swap
        jg next_iteration

        ; sorts by time if prriorities are equal
        mov ax, word [edx + esi + proc.time]
        cmp ax, word [edx + edi + proc.time]
        jl swap
        jg next_iteration

        ; sorts by id if the time is equal
        mov ax, word [edx + esi + proc.pid]
        cmp ax, word [edx + edi + proc.pid]
        jge next_iteration

    ; bubble sort where al and ax registers are the aux variables
    ; al and ax are selected based on prio and pid/time sizes
    swap:
        mov al, byte [edx + esi + proc.prio]
        push eax
        mov al, byte [edx + edi + proc.prio]
        push eax
        pop eax 
        mov [edx + esi + proc.prio], al
        pop eax
        mov [edx + edi + proc.prio], al

        mov ax, word [edx + esi + proc.pid]
        push eax
        mov ax, word [edx + edi + proc.pid]
        push eax
        pop eax
        mov [edx + esi + proc.pid], ax
        pop eax
        mov [edx + edi + proc.pid], ax

        mov ax, word [edx + esi + proc.time]
        push eax
        mov ax, word [edx + edi + proc.time]
        push eax
        pop eax
        mov [edx + esi + proc.time], ax
        pop eax
        mov [edx + edi + proc.time], ax

    ; if there is no swap needed go to the next element 
    ; in the same i_iteration or for the next one
    next_iteration:
        dec ecx
        cmp ecx, 0
        jge j_iteration
        
        dec ebx
        cmp ebx, 1
        jge i_iteration

    ;; Your code ends here
    
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY