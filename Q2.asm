;Q2
;all assumptions are mentioned as comment
org 100h                                     
                                
               
     
mov  si, 0
while_loop1: 
cmp B[si], 0
je break1
    
    mov cx, B[si]
    
    push si
    while_loop2:
    add si, 2
    cmp B[si], 0
    je break2    
        
        mov bx, cx
        add bx, B[si]
        cmp bx, target
        jne while_loop2
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
             
             
             
  
  
             

; this parameter is used by procedure printDecimal
param1 dw 0      
   
; procedure to print a number in decimal format    
printDecimal proc 
    pusha
    
    mov ax, param1    
    mov bx, 10
    counter db 0
    while_loop3:
        cmp ax, 0
        je  break3 
             
        mov dx, 0     
        div bx     
        push dx   
        
        mov dl, counter
        inc dl
        mov counter, dl
    jmp while_loop3
    break3:
    
    
    while_loop4:
        cmp counter, 0
        je  break4
         
        mov ah, 2
        pop dx
        add dl, 48
        int 21h  
        
        mov dl, counter
        dec dl
        mov counter, dl           
    jmp while_loop4          
    break4:          
          
    popa   
    ret            
printDecimal endp

