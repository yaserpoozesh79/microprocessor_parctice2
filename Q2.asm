;Q2
;all assumptions are mentioned as comment
org 100h                                     
                                
               
; initialzing loop iterator, which is also array index:     
mov  si, 0
while_loop1: 
; checking if si reached the last element's index
cmp B[si], 0
je break1
    ; moving the first number to cx for later
    mov cx, B[si]
    
    ; nested loop: it's gonna find the second number
    push si
    while_loop2:
    ; starting from the next element after the first number
    add si, 2
    ; checking if si reached the last element's index
    cmp B[si], 0
    je break2    
        ; calculating sum of the first and second numbers using bx register
        mov bx, cx
        add bx, B[si]
        ; comparing the sum with the raget value
        cmp bx, target
        jne while_loop2

        ; printing the result: 
        mov ah, 2
        mov dl, '('
        int 21h
        mov param1, cx
        call printDecimal
        mov dl, ','
        int 21h 
        mov dl, ' '
        int 21h   
        mov bx, B[si]
        mov param1, bx
        call printDecimal 
        mov dl, ')'
        int 21h 
        mov dl, 10
        int 21h
        mov dl, 13
        int 21h      
    jmp while_loop2
    break2:
    pop si
    add si, 2
jmp while_loop1    
break1:     
                 
ret
      
; these are the starting values for the program: array B and target value            
B dw 1, 2, 3, 4, 5, 6, 7, 8, 9, 0
target dw 10             
                         
; this parameter is used by procedure printDecimal as input
param1 dw 0      
; this variable is used by printDecimal to count the number of digits   
counter db 0 
; procedure to print a number in decimal format    
printDecimal proc 
    pusha
    mov ax, param1 
    ; bx is used to devide the number for each digit   
    mov bx, 10
    mov counter, 0
    while_loop3:
        cmp ax, 0
        je  break3 
        ; deviding the number by 10 to retreive digit and push it to stack     
        mov dx, 0     
        div bx     
        push dx   
        ; incrementing the counter
        add counter, 1
    jmp while_loop3
    break3:
    mov cl, counter
    mov ch, 0
    for_loop:
        ; printing each digit  
        mov ah, 2
        pop dx
        add dl, 48
        int 21h            
    loop for_loop                      
    popa   
    ret            
printDecimal endp

