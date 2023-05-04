;Q3
;all assumptions are mentioned as comment
org 100h                                     
         
mov dx, offset buffer
mov ah, 0ah
int 21h    
                          
mov si, 0   
counter db 0
while_loop1:   
    mov bl, buffer[si]
    cmp bl, 13
    je break1          
    mov bh, 0
    push bx
    
    mov bh, counter           
    inc bh
    mov counter, bh           
jmp while_loop1
break1:    

mov cl, counter
mov ch, 0  
mov bl, 1
while_loop2:  
    jcxz break2
    
    pop ax
    mul bl
    add number, al                        
            
    mov al, bl
    mul factor
    mov bl, al            
loop while_loop2                  
break2:
   
                                         
       
nonDigitEntered:  
mov ah, 2
mov dl, 10
int 21h
mov dl, 13
int 21h  

mov dx, offset nonDigitErrorMsg
mov ah, 9
int 21h
                                         
                                         
ret                 
       
number db 0   
factor db 10    
      
; numbers above 99 can't be enterd. (width of the console is 80 by default)      
buffer db 3,?, 3 dup(' ')
        
        
nonDigitErrorMsg db "error: a non-digit character was entered!$"               