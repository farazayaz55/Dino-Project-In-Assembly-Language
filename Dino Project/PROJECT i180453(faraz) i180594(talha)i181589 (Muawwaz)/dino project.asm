  .model small

.data
    s1 db "PLease enter your name :$"
    s2 db 25 dup('$') 
    names db "NAME:$"    
    score db 0
    scores db "Score:$"
    live db 5
    lives db "Lives:$"
    space db "          $"
    s3 db "Started at:$" 
    s4 db "High Score:$"
    s5 db "START$"
    s6 db "INSTRUCTIONS$"
    s7 db "EXIT$"
    s8 db "BACK$"

    ;prin db "Time is $"
    ;prin2 db "Hour Min Sec $"
    ;prin3 db "  $"
    hourh db ?
    hourl db ?
    minh db ?
    minl db ?
    sech db ?
    secl db ?
    file db "Inst.txt",0    
    buffer db  280 dup("$")
    handler dw ?
    file1 db "Exit.txt",0    
    buffer1 db  13 dup("$")
    handler1 dw ?

.code 
    mov ax,@data
    mov ds,ax        
    
	;---------------------------------------Menu Page----------------------------------
    menu:   
    mov al,3
    mov ah,0
    int 10h           
    mov dx,0      
    mov ah,06h
    int 21h
    mov al,0 
    mov cl,0
    mov ch,0   
    mov dl,80
    mov dh,30
    mov bh,010h   
    int 10h
    
    mov dx,0      
    mov ah,06h
    int 21h
    mov al,0 
    mov cl,30
    mov ch,3   
    mov dl,50
    mov dh,7
    mov bh,020h   
    int 10h
    mov ah,2
    mov bh,0
    mov dl,38
    mov dh,5
    int 10h
    lea dx,s5
    mov ah,9
    int 21h

    mov dx,0      
    mov ah,06h
    int 21h
    mov al,0 
    mov cl,30
    mov ch,10  
    mov dl,50
    mov dh,14
    mov bh,020h   
    int 10h
    mov ah,2
    mov bh,0
    mov dl,34
    mov dh,12
    int 10h
    lea dx,s6
    mov ah,9
    int 21h

    mov dx,0      
    mov ah,06h
    int 21h
    mov al,0 
    mov cl,30
    mov ch,17   
    mov dl,50
    mov dh,21
    mov bh,020h   
    int 10h
    mov ah,2
    mov bh,0
    mov dl,38
    mov dh,19
    int 10h
    lea dx,s7
    mov ah,9
    int 21h

    jmp mouse

	;-----------------------------------------Mouse------------------------------------------  
    mouse: 
    int 33h
    mov ax,01;displaying the cursor
    int 33h
    mov ax,03;getting cursor position
    int 33h
    cmp bx,1h;no button is pressed
    je check
    jmp mouse 
    
    check: 
    cmp ch,0
    je checkl1 
    cmp ch,1
    je checkl2
    jmp mouse
    
    checkl1:
    cmp cl,0F0h
    jge check1 
    jmp mouse
    
    checkl2:
    cmp cl,097h
    jbe check1
    jmp mouse
 
    check1:
    cmp dl,018h
    jae check2
    jmp mouse
    
    check2:
    cmp dl,03Fh
    jbe start 
    cmp dl,050h
    jae check3
    jmp mouse

    check3:
    cmp dl,077h
    jbe x1
    cmp dl,088h
    jge check4
    jmp mouse
    
    check4:
;    cmp dl,0AFh
    jmp x2
    jmp mouse
     
     
    x1:
    jmp inst
    x2:
    jmp exit 
    ;-----------------------------------------Start Page-------------------------------
    start:   
	mov al,3
	mov ah,0
	int 10h 
        mov si,0;
        mov cx,5
        l1:
            call newl
            loop l1  
        LEA dx,s1
        mov ah,09
        int 21h
         
         
       l2:
       mov ah,01
       int 21h 
       cmp al,13
       je l3
       mov s2[si],al 
       inc si
       jmp l2  
        
        
        
        l3:
        
        ;clrscr
        mov al,03
        mov ah,0
        int 10h
        ;-----------------
        
        ;mov cursor
        mov ah,02h
        mov dh,0
        mov  dl,0
        int 10h
        ;-----------------
        ;display 1st line 
        Lea dx,scores
        mov ah,09
        int 21h 
        mov dh,0
        mov dl,score
        add dl,48
        mov ah,02
        int 21h
        Lea dx,space
        mov ah,09
        int 21h
                   
                   
                   
        Lea dx,lives
        mov ah,09
        int 21h
        mov dh,0
       
        mov cl,live
        looplabel:
        mov dl,3
        mov ah,02
        int 21h
        loop looplabel 
               
        Lea dx,space
        mov ah,09
        int 21h 
         
         
    ;    Nameloop:   
        Lea dx,names
        mov ah,09
        int 21h 
        mov si,0
        mov dh,0 
        Nameloop:
        mov dl,s2[si]
        cmp dl,'$'
        je time
        mov ah,02
        int 21h     
        inc si
        jmp Nameloop
        
         
    ;   started at-----------------------------      
        time:
        LEA dx,space
        mov ah,09
        int 21h  
        Lea dx,s3
        mov ah,09
        int 21h
        mov ah,2ch
        int 21h
                
                
                
                
     asci PROC
 ;       LEA dx,prin
 ;      mov ah,09
 ;       int 21h   
       
 ;       mov dl,10
 ;       mov ah,02
 ;       int 21h
        
 ;       mov dl,13
 ;       mov ah,02
 ;       int 21h
 ;             
 ;       mov dl,10
 ;       mov ah,02
 ;       int 21h
        
 ;       mov dl,13
 ;       mov ah,02
;        int 21h
;                      
              
       
  ;      LEA dx,prin2
  ;      mov ah,09 
  ;      int 21h
 ;         mov dl,10
 ;       mov ah,02
 ;       int 21h
 ;       
 ;       mov dl,13
 ;       mov ah,02
 ;       int 21h     
        
        mov hourh,ch
        mov minh,cl
        mov sech,dh
        mov ah,0
        mov al,hourh
        mov dl,10
        div dl
        mov hourh,ah
        mov hourl,al
        mov ah,0
        mov al,minh
        mov dl,10
        div dl  
        mov minh,ah
        mov minl,al
        mov ah,0 
        mov al,sech 
        div dl
        mov sech,ah
        mov secl,al
        add sech,48
        add secl,48
        add hourh,48
        add hourl,48
        add minh,48
        add minl,48

        mov dl,hourl
        mov ah,02
        int 21h
            

            
        mov dl,hourh
        mov ah,02
        int 21h 
         
        mov dl,'/'
        mov ah,02
        int 21h 
               
  ;      LEA dx,prin3
  ;      mov ah,09
  ;      int 21h
                           
               
        mov dl,minl
        mov ah,02
        int 21h
          
        mov dl,minh
        mov ah,02
        int 21h
        
         
        mov dl,'/'
        mov ah,02
        int 21h 
 ;       LEA dx,prin3
  ;      mov ah,09
  ;      int 21h
            

        mov dl,secl
        mov ah,02
        int 21h

        mov dl,sech
        mov ah,02
        int 21h     
        asci ENDP
    
    
    
    ;------------------------------------------     
        box:    
        mov dx,0
        mov al,0 ;
        mov ah,06h
         int 21h
        mov ah,06
        mov al,0
        mov ch,3
        mov cl,0
        mov dh,21
        mov dl,79
        mov bh,15h
        int 10h  
        jmp hurdles
        
        
        
        
        hurdles:   
        ;--------------leg
        mov ah,06
        mov al,0
        mov ch,12
        mov dh,20
        mov cl,3
        mov dl,4
        mov bh,25h
        int 10h
        
       
        mov ah,06
        mov al,0
        mov ch,12
        mov dh,20
        mov cl,7
        mov dl,8
        mov bh,25h
        int 10h       
       

        mov ah,06
        mov al,0
        mov ch,12
        mov dh,20
        mov cl,11
        mov dl,12
        mov bh,25h
        int 10h
 
        mov ah,06
        mov al,0
        mov ch,12
        mov dh,20
        mov cl,15
        mov dl,16
        mov bh,25h
        int 10h        
        
        
;-----------------body
        mov ah,06
        mov al,0
        mov ch,15
        mov dh,16
        mov cl,3
        mov dl,18
        mov bh,25h
        int 10h        
        
        
;---------------------------up of body        
        mov ah,06
        mov al,0
        mov ch,13
        mov dh,14
        mov cl,5
        mov dl,6
        mov bh,05h
        int 10h        
                
        mov ah,06
        mov al,0
        mov ch,13
        mov dh,14
        mov cl,9
        mov dl,10
        mov bh,05h
        int 10h        
        
        mov ah,06
        mov al,0
        mov ch,13
        mov dh,14
        mov cl,13
        mov dl,14
        mov bh,05h
        int 10h        
        
        mov ah,06
        mov al,0
        mov ch,13
        mov dh,14
        mov cl,17
        mov dl,18
        mov bh,05h
        int 10h
               
               
               
;----------------------------HEAD OF DINO's bod               
        mov ah,06
        mov al,0
        mov ch,10
        mov dh,16
        mov cl,19
        mov dl,21
        mov bh,25h
        int 10h        
                       
;--------------------------MAIN HEAD
          mov ah,06
        mov al,0
        mov ch,10
        mov dh,11
        mov cl,22
        mov dl,23
        mov bh,00h
        int 10h             
               
;--------------------------------------------now hurdles
        ;leg
         mov ah,06
        mov al,0
        mov ch,16
        mov dh,20
        mov cl,28
        mov dl,29
        mov bh,25h
        int 10h
        ;mid
        mov ah,06
        mov al,0
        mov ch,14
        mov dh,15
        mov cl,25
        mov dl,32
        mov bh,25h
        int 10h 
        ;head legno1
        mov ah,06
        mov al,0
        mov ch,12
        mov dh,13
        mov cl,25
        mov dl,26
        mov bh,25h
        int 10h
        ;head legno2
        mov ah,06
        mov al,0
        mov ch,12
        mov dh,13
        mov cl,28
        mov dl,29
        mov bh,25h
        int 10h        
        ;head legno3
        mov ah,06
        mov al,0
        mov ch,12
        mov dh,13
        mov cl,31
        mov dl,32
        mov bh,25h
        int 10h        


;---------------------------------------------------2nd hurdle
         mov ah,06
        mov al,0
        mov ch,18
        mov dh,20 
        mov cl,37
        mov dl,38
        mov bh,25h
        int 10h
        ;mid
        mov ah,06
        mov al,0
        mov ch,16
        mov dh,17
        mov cl,34
        mov dl,41
        mov bh,25h
        int 10h 
        ;head legno1
        mov ah,06
        mov al,0
        mov ch,13
        mov dh,15
        mov cl,34
        mov dl,35
        mov bh,25h
        int 10h
        ;head legno2
        mov ah,06
        mov al,0
        mov ch,13
        mov dh,15
        mov cl,37
        mov dl,38
        mov bh,25h
        int 10h        
        ;head legno3
        mov ah,06
        mov al,0
        mov ch,13
        mov dh,15
        mov cl,40
        mov dl,41
        mov bh,25h
        int 10h     

;-------------------3rd hurdle 
         mov ah,06
        mov al,0
        mov ch,18
        mov dh,20 
        mov cl,46
        mov dl,47
        mov bh,25h
        int 10h
        ;mid
        mov ah,06
        mov al,0
        mov ch,16
        mov dh,17
        mov cl,43
        mov dl,50
        mov bh,25h
        int 10h 
        ;head legno1
        mov ah,06
        mov al,0
        mov ch,14
        mov dh,15
        mov cl,43
        mov dl,44
        mov bh,25h
        int 10h
        ;head legno2
        mov ah,06
        mov al,0
        mov ch,13
        mov dh,15
        mov cl,46
        mov dl,47
        mov bh,25h
        int 10h        
        ;head legno3
        mov ah,06
        mov al,0
        mov ch,12
        mov dh,16
        mov cl,49
        mov dl,50
        mov bh,25h
        int 10h     

;-----------------------------------4 hurdle----------------------------------------------
        mov ah,06
        mov al,0
        mov ch,18
        mov dh,20 
        mov cl,58
        mov dl,59
        mov bh,25h
        int 10h
        ;mid
        mov ah,06
        mov al,0
        mov ch,16
        mov dh,17
        mov cl,55
        mov dl,62
        mov bh,25h
        int 10h 
        ;head legno1
        mov ah,06
        mov al,0
        mov ch,12
        mov dh,16
        mov cl,55
        mov dl,56
        mov bh,25h
        int 10h
        ;head legno2
        mov ah,06
        mov al,0
        mov ch,13
        mov dh,15
        mov cl,58
        mov dl,59
        mov bh,25h
        int 10h        
        ;head legno3
        mov ah,06
        mov al,0
        mov ch,14
        mov dh,15
        mov cl,61
        mov dl,62
        mov bh,25h
        int 10h 

;------------------------------------------hurdle5
         mov ah,06
        mov al,0
        mov ch,18
        mov dh,20 
        mov cl,67
        mov dl,68
        mov bh,25h
        int 10h
        ;mid
        mov ah,06
        mov al,0
        mov ch,16
        mov dh,17
        mov cl,64
        mov dl,71
        mov bh,25h
        int 10h 
        ;head legno1
        mov ah,06
        mov al,0
        mov ch,12
        mov dh,16
        mov cl,64
        mov dl,65
        mov bh,25h
        int 10h
        ;head legno2
        mov ah,06
        mov al,0
        mov ch,12
        mov dh,16
        mov cl,67
        mov dl,68
        mov bh,25h
        int 10h        
        ;head legno3
        mov ah,06
        mov al,0
        mov ch,12
        mov dh,16
        mov cl,70
        mov dl,71
        mov bh,25h
        int 10h 
               
;----------------------------------------- rectangular hurdle
        ;box
        mov ah,06
        mov al,0
        mov ch,6
        mov dh,9
        mov cl,60
        mov dl,63
        mov bh,25h
        int 10h 
        ;edges  (lef)
        mov ah,06
        mov al,0
        mov ch,7
        mov dh,8
        mov cl,57
        mov dl,59
        mov bh,05h
        int 10h         
        
       
        ;righ
        mov ah,06
        mov al,0
        mov ch,7
        mov dh,8
        mov cl,64
        mov dl,66
        mov bh,05h
        int 10h       
       
       
        ;up
         mov ah,06
        mov al,0
        mov ch,4
        mov dh,5
        mov cl,61
        mov dl,62
        mov bh,05h
        int 10h        
            
        ;down
         mov ah,06
        mov al,0
        mov ch,10
        mov dh,11
        mov cl,61
        mov dl,62
        mov bh,05h
        int 10h
 
          
;---------------------------------------------------------
;----------------------moving cursor----------------------
;---------------------------------------------------------
;---------------------------------------------------------
       lastline:
       mov ah,02h
       mov bh,0
       mov dh,28h
       mov dl,0
       int 10h    
        lea dx,s4
        mov ah,09
        int 21h      
       
       mov dx,0      
    mov ah,06h
    int 21h
    mov al,0 
    mov cl,68
    mov ch,23   
    mov dl,75
    mov dh,23
    mov bh,030h   
    int 10h
    mov ah,2
    mov bh,0
    mov dl,70
    mov dh,23
    int 10h
    lea dx,s8
    mov ah,9
    int 21h
    
    mouse1: 
    int 33h
    mov ax,01;displaying the cursor
    int 33h
    mov ax,03;getting cursor position
    int 33h
    cmp bx,1h;no button is pressed
    je checking
    jmp mouse1 
    
    checking:  
    cmp ch,2
    je checking2
    jmp mouse1

    checking2:
    cmp cl,020h
    jge checking3
    jmp mouse1

    checking3:
    cmp cl,05Fh
    jbe checking4
    jmp mouse1

    checking4:
    cmp dl,0B8h
    jge checking5
    jmp mouse1

    checking5:
    cmp dl,0BFh
    jbe x3
    jmp mouse1

    x3:
    jmp menu

        newl Proc
            mov dl,10
            mov ah,02
            int 21h
            ret 
        newl ENDP     
            
     
    ;-----------------------------------------Instructions Page-------------------------------
    inst:  
    mov al,03
    mov ah,0
    int 10h
    mov dx,0      
    mov ah,06h
    int 21h
    mov al,0 
    mov cl,0
    mov ch,0   
    mov dl,80
    mov dh,30
    mov bh,002h   
    int 10h

    mov ah,3dh 
    lea dx,file
    mov al,0
    int 21h 
    
    mov handler,ax

    mov al,0
    mov dx,offset buffer
    mov ah,3fh
    mov bx,handler
    mov cx,278
    int 21h

    mov bh,0
    mov dl,0
    mov dh,5
    mov ah,02h
    int 10h
    lea dx,buffer
    mov ah,9
    int 21h

    mov dx,0      
    mov ah,06h
    int 21h
    mov al,0 
    mov cl,68
    mov ch,23   
    mov dl,75
    mov dh,23
    mov bh,030h   
    int 10h
    mov ah,2
    mov bh,0
    mov dl,70
    mov dh,23
    int 10h
    lea dx,s8
    mov ah,9
    int 21h

    jmp mouse1

    ;-----------------------------------------Exit---------------------------------------
    exit:
    mov al,03
    mov ah,0
    int 10h
    mov dx,0      
    mov ah,06h
    int 21h
    mov al,0 
    mov cl,0
    mov ch,0   
    mov dl,80
    mov dh,30
    mov bh,002h   
    int 10h

    mov ah,3dh 
    lea dx,file1
    mov al,0
   int 21h 
    
    mov handler1,ax

    mov al,0
    mov dx,offset buffer1
    mov ah,3fh
    mov bx,handler1
    mov cx,11
    int 21h

    mov bh,0
    mov dl,38
    mov dh,5
    mov ah,02h
    int 10h
    lea dx,buffer1
    mov ah,9
    int 21h
    mov ah,4ch
    int 21h
    mov ah,4ch
    int 21h
end        
