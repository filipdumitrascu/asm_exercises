%include "../include/io.mac"

section .text
    global simple
    extern printf

simple:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     ecx, [ebp + 8]  ; len
    mov     esi, [ebp + 12] ; plain
    mov     edi, [ebp + 16] ; enc_string
    mov     edx, [ebp + 20] ; step

    ;; DO NOT MODIFY
   
    ;; Your code starts here
    
    xor ebx, ebx                      ; first pos (0)

    start_iteration:
        cmp ebx, ecx                  ; if pos == len
        je end_iteration

        mov al, byte [esi + ebx]      ; gets current character
        add al, dl                    ; shifts character by step

        cmp al, 90                    ; check if it's past 'Z' after shiftting
        jg modulo_26
        mov byte [edi + ebx], al      ; write shifted character to output
        jmp next_iteration

        modulo_26:
            sub al, 26                ; back to 'A' - 'Z'
            mov byte [edi + ebx], al

        next_iteration:
            inc ebx                   ; next pos
            jmp start_iteration 

    end_iteration:
    
    ;; Your code ends here
    
    ;; DO NOT MODIFY

    popa
    leave
    ret
    
    ;; DO NOT MODIFY
