;Q3
;all assumptions are mentioned as comment
org 100h                                     

; initializing parameters to get user input         
mov dx, offset buffer
mov ah, 10
int 21h    

; initializing the loop counter(cx) with the number if characters entered: 
; number of characters entered is stored in buffer[1]                                
mov cl, buffer[1]
mov ch, 0 

; this loop calculates the number enterd:
; bl stores the power of 10 which indicates the positional notation
mov bl, 1
for_loop1:  
    ; calculating the index of the first digit based on cx
    mov si, cx
    add si, 1  

    mov al, buffer[si]  
    sub al, 48 

    ; checking the character to output error if it wasn't a digit  
    cmp al, 0
    jb nonDigitEntered
    cmp al, 9
    ja nonDigitEntered
    
    ; caculating the actual value by multiplying the digit by bl
    mul bl  
    add number, al                        

    ; multiplying bl by 10 for the next digit to be calculated        
    mov al, bl
    mul factor
    mov bl, al                      
loop for_loop1

call printSquare
               
jmp exit      
; a piece of code that outputs error                                   
nonDigitEntered:  
mov ah, 2
mov dl, 10
int 21h
mov dl, 13
int 21h  
mov dx, offset nonDigitErrorMsg
mov ah, 9
int 21h
                                  
exit:                                         
ret                 
       
number db 0   
factor db 10    
counter db 0         
         
; numbers above 99 can't be enterd. (width of the console is 80 by default)      
buffer db 3,?, 3 dup(' ')
        
        
nonDigitErrorMsg db "error: a non-digit character was entered!$"               

                  
  
printSquare proc 
    pusha
    
    ; initializing loop counter by the number entered by user
    mov cl, number
    mov ch, 0  
    call printNewl
    for_topLine:     
        mov ah, 2
        mov dl, '*'
        int 21h 
    loop for_topLine: 
    call printNewl
     
    ; printing number-2 lines for middel lines 
    mov cl, number
    mov ch, 0 
    sub cx, 2 
    for_middleLines:
        cmp cx, 0
        jle break_middleLines    
        mov ah, 2
        mov dl, '*'
        int 21h
        
        push cx 
        mov cl, number
        mov ch, 0 
        sub cx, 2
        for_middleLine:
            cmp cx, 0
            jl  break_middleLine
            mov ah, 2
            mov dl, ' '
            int 21h
        loop for_middleLine
        break_middleLine: 
        pop cx
        
        mov ah, 2
        mov dl, '*'
        int 21h
        call printNewl
    loop for_middleLines:
    break_middleLines:

    cmp number,      
    mov cl, number
    mov ch, 0  
    for_bottomLine:     
        mov ah, 2
        mov dl, '*'
        int 21h 
    loop for_bottomLine:     
         
    popa
    ret
printSquare endp                      

 
 
 
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