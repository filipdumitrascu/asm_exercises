section .data
 
section .text
	global checkers
    extern printf
 
checkers:
    ;; DO NOT MODIFY
    push ebp
    mov ebp, esp                                      
    pusha                                              
                                                      
    mov eax, [ebp + 8]	; x                           
    mov ebx, [ebp + 12]	; y                           
    mov ecx, [ebp + 16] ; table 
 
    ;; DO NOT MODIFY
    ;; FREESTYLE STARTS HERE

    mov edx, 8  ; number of lines put in an auxiliary register
    mul edx     ; eax *= edx calculated for position determination
    
    ; in edx the dame position is calculated 
    mov edx, ecx
    add edx, eax
    add edx, ebx
    mov edi, 8   ; edi is used for moving the dame

    which_line:
        cmp eax, 8 * 7      ; if the dame is on the last line
        je down

        add edx, edi        ; otherwise the dame can move up
        jmp which_column

    down:      
        sub edx, edi        ; dame can move down
        jmp which_column

    centred_line:
        ; from the above line take it 2 lines down
        ; (one below the initial position)
        mov edi, 16
        jmp down

    which_column:
        cmp ebx, 0           ; if the dame is on the first column
        je to_the_right
        cmp ebx, 7           ; else if it is on the last column
        je to_the_left             
        jne centred_column

    to_the_right:
        mov byte [edx + 1], 1
        ; if it's on the last line no other elements should be put
        cmp eax, 8 * 7
        je out

        ; or if it's on the first line  
        cmp eax, 8 * 0 
        je out

        ; or if they are already put
        cmp edi, 16 
        je out

        ; otherwise put them (the ones under the dame)
        jne centred_line 

    to_the_left:
        mov byte [edx - 1], 1
        ; if it's on the last line no other elements should be put
        cmp eax, 8 * 7
        je out

        ; or if it's on the first line   
        cmp eax, 8 * 0 
        je out

        ; or if they are already put
        cmp edi, 16 
        je out

        ; otherwise put them (the ones under the dame)
        jne centred_line

    centred_column:
        mov byte [edx - 1], 1
        mov byte [edx + 1], 1  
        
        ; if it's on the last line no other elements should be put
        cmp eax, 8 * 7
        je out

        ; or if it's on the first line 
        cmp eax, 8 * 0 
        je out

        ; or if they are already put
        cmp edi, 16 
        je out

        ; otherwise put them (the ones under the dame)
        jne centred_line

out:
    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY