;Q1
;all assumptions are mentioned as comment
org 100h    

; initializing loop counter:
mov cl,13
; initializing array index: it is gonna increase by each iteration 
mov si,4

for_loop:
    ;calculating sum of the smaller numbers          
    mov ax, my_array[si-2]       
    add ax, my_array[si-4]
    
    ;comparing the sum with the larger number
    cmp ax,my_array[si]
    jbe fail                                              
    
    ;increasing array index by two: (for word array)
    add si, 2    
loop for_loop    


mov ah, 1    
jmp exit

                 
fail:
    mov ah, 0    
    jmp exit
                   
 
exit:          
ret

;we assume that the array is sorted in ascending order 
;the first array below is generated according to this rule: my_array[x] = my_array[x-1] + my_array[x-2] -1  
    
    my_array dw  2, 3, 4, 6, 9, 14, 22, 35, 56, 90, 145, 234, 378, 611, 988     ;should generate successful result




