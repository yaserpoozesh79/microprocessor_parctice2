;Q4
;all assumptions are mentioned as comment
org 100h  

; initializing loop counter
mov si, 40
while_loop1:      
    sub si, 2
    cmp si, 0
    jl break1    
    ; loading the target number to ax and passing to checkMersenne procedure
    mov ax, numbers[si]
    call checkMersenne
    ; printing the target number if it was mersenne
    cmp temp, 1  
    jne while_loop1
    mov param1, ax
    call printDecimal
    call printNewl
    ; counting the mersenne numbers 
    add counter, 1
jmp while_loop1   
break1:

; printing the msg
mov dx, offset msg
mov ah, 9
int 21h     

; printing the number of mersenne numbers  
mov dl, counter
mov dh, 0
mov param1, dx   
call printDecimal

ret
                        
numbers dw 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 127, 12, 13, 14, 15, 16, 31, 18, 19, 20                                   
counter db 0
msg db "total Mersenne numbers: $"               
               
; this variable is used by checkMersenne procedure               
temp dw 0                                                                                      
checkMersenne proc
    pusha   
    
    ; checking if number is less than or equal to 2. if so, it is not mersenne for sure
    mov temp, ax
    cmp ax, 2
    jle isntMersenne

    ; checking if the number is prime. if so, it is not mersenne for sure
    call checkPrime                  
    cmp temp2, 1                  
    jne isntMersenne 

    ; this loop caculates the base 2 log of the number+1 by counting devisions by 2 resulting in 0 quotient.
    mov cx, 0      
    inc ax    
    while_loop2:
        mov dx, 0
        mov bx, 2
        div bx   
        cmp ax, 0
        jle break_while2
        cmp dx, 0
        jne isntMersenne
        inc cx
    jmp while_loop2
    break_while2:
    ; checking if base 2 log of the number+1 is prime. if so, it is mersenne 
    mov ax, cx
    call checkPrime
    cmp temp2, 1
    jne isntMersenne
    
    mov temp, 1
    jmp returnCheckMersenne 
    
    isntMersenne:
    mov temp, 0
    jmp returnCheckMersenne 
     
    returnCheckMersenne: 
    popa              
    ret                  
checkMersenne endp     
                             
                             

; this variable is used by checkPrime procedure               
temp2 dw 0      
; this procedure checks the primity of number by counting the integer devisors of the number.                       
checkPrime proc
    pusha
    mov temp2, ax
    ; staring the counting from number/2 to 1
    mov dx, 0
    mov bx, 2
    div bx                
                  
    mov bx, 0
    mov cx, ax 
    for_loop1: 
        mov ax, temp2         
        cmp cx, 0
        jle break_for1
        
        mov dx, 0    
        div cx
        cmp dx, 0
        jne continue_for1
        inc bx 
        loop for_loop1
        continue_for1:         
    loop for_loop1
    break_for1:   
    cmp bx, 1
    jne notPrime 
    mov temp2, 1
    jmp returnPrime 
    notPrime:
    mov temp2, 0  
    returnPrime:
    popa
    ret    
checkPrime endp                                 
 
 
                
; this parameter is used by procedure printDecimal
param1 dw 0      
   
; procedure to print a number in decimal format    
printDecimal proc 
    pusha
              
    cmp param1, 0
    je printZero                    
    mov ax, param1  
    mov bx, 10  
    mov cl, 0 
    while_loop3:
        cmp ax, 0
        je  break3 
             
        mov dx, 0     
        div bx     
        push dx   
        
        mov dl, cl
        inc dl
        mov cl, dl
    jmp while_loop3
    break3:
    
    
    while_loop4:
        cmp cl, 0
        je  break4
         
        mov ah, 2
        pop dx
        add dl, 48
        int 21h  
        
        mov dl, cl
        dec dl
        mov cl, dl           
    jmp while_loop4          
    break4:          
     
    jmp returnPD      
    printZero:
    mov ah, 2
    mov dl, '0'
    int 21h  
    returnPD:    
    popa   
    ret            
printDecimal endp                

printNewl proc
    pusha
    
    mov ah, 2
    mov dl, 10
    int 21h
    mov dl, 13
    int 21h
    
    popa
    ret
printNewl endp 