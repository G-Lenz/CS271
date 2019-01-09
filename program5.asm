TITLE program4     (program4.asm)

; Author: George Lenz
; Email: lenzg@oregonstate.edu
; CS 271-400 / Project3           Due Date:2/18/2018
; Description: Creates a random array, sorts the numbers and finds the median.

INCLUDE Irvine32.inc

upper equ 200
lower equ 10
max   equ 999
min   equ 100

.data

intro      BYTE   "Random Array", 0
author     BYTE   "by George Lenz", 0
userName   BYTE   50 DUP(0)
namePrompt BYTE   "What is your name? ",0
greet      BYTE   "Hello, ", 0
instruct   BYTE   "Enter the amount of numbers you'd like in your array and I will show you that many random number, sort them, and find the median", 0
closing    BYTE   "Goodbye, ", 0
err        BYTE   "Invalid input; Enter number from 1-400.", 0
space      BYTE   "     ", 0
list       BYTE   "Your list of number is:", 0
sortedList BYTE   "Your sorted list of numbers is:", 0
median     BYTE   "The median is: ", 0


.code
main PROC

.data

    number    DWORD  0
	array     DWORD upper DUP (?)
	tempArray DWORD upper DUP (?)

.code

    call    Introduction

	push    OFFSET number
	call    getUserData
	
	call    Randomize
	
	push    OFFSET array
	push    number
	call    fillArray
	
	push    OFFSET list
	push    OFFSET array
	push    number
	call    showList

	push    OFFSET array
	push    number
	call    bubbleSort
	
	push    OFFSET median
	push    OFFSET array
	push    number
	call    findMedian

	push    OFFSET sortedList
	push    OFFSET array
	push    number
	call    showList

	;mov     EAX, OFFSET array
	;call    WriteDec
	call    Farewell




    exit	; exit to operating system
main ENDP

;-------------------------------------------------------------------------------
;Introduction PROC
;Displays Introductory information
;-------------------------------------------------------------------------------

Introduction PROC
    enter 0,0
    mov    edx, OFFSET intro
	call   WriteString
	call   CrLf
	mov    edx, OFFSET author
	call   WriteString
	call   CrLf
	call   CrLf

;get users name
getUserData:
    mov    edx, OFFSET namePrompt
	call   WriteString
    mov    edx, OFFSET userName
	mov    ecx, 49
	call   ReadString

;greet user
Greeting:
    mov    edx, OFFSET greet
	call   WriteString
	mov    edx, OFFSET userName
	call   WriteString
	call   Crlf
	call   crlf
	leave
	ret 
Introduction ENDP

;-----------------------------------------------------------------------------------------
;getUserData PROC
;
;gets an input from the user
;-----------------------------------------------------------------------------------------

getUserData PROC
    
	enter 0,0
	;Instructions
    mov    edx, OFFSET instruct
	call   WriteString
	call   Crlf
    call   ReadInt
	mov    [number], eax
	call   CrLf
	call   validate
	leave
	ret 4
getUserData ENDP

;---------------------------------------------------------------------------------------------
;Validate PROC
;
;validates the users input
;---------------------------------------------------------------------------------------------
validate PROC
    enter 0,0
    cmp    number, lower
    jl     Error
	cmp    number, upper
	jg     Error
	jmp    endVal
	
;display error message and restart
Error:
    mov    edx, OFFSET err
	call   WriteString
	call   CrLf
	sub    esp, 4
	call   getUserData

;ends the validation procedure
endVal:
	leave
	ret 
validate ENDP

;--------------------------------------------------------------------------------------------
;fillArray PROC
;
;fills the array with user indicated amount of random numbers
;--------------------------------------------------------------------------------------------
fillArray PROC
    
    enter  0,0
	
	mov    ECX, [ebp + 8]
	mov    ESI, [ebp + 12]
	;cmp    ECX, 0
	;je     doneFill

Fill:
    mov    EAX, max
	inc    EAX
	sub    EAX, min
	call   RandomRange
	add    EAX, min
	mov    [ESI], eax
	add    ESI, 4
	loop   Fill

doneFill:
    
    leave
	ret    8
fillArray ENDP

;------------------------------------------------------------------------------
;showList PROC
;
;Displays the list
;------------------------------------------------------------------------------
 showList PROC
	
	enter  2,0
	mov    WORD PTR [EBP - 2], 10
	mov    ECX, [EBP + 8]
	mov    ESI, [EBP + 12]
	mov    EDX, [ebp+16]
	call   WriteString
	call   crlf

Display:
    
    mov    EAX, [ESI]
	call   WriteDec
	mov    EDX, OFFSET space
	call   WriteString
	cmp    ECX, 0 
	je     doneShow
	dec    WORD PTR [ebp - 2]
	cmp    WORD PTR [ebp - 2], 0
	je     newline
	add    ESI, 4
	loop   Display

doneShow:
    call crlf
	call crlf
	leave
	ret 12

newline:
    call   crlf
	add    WORD PTR [EBP - 2], 10
	add    ESI, 4
	loop   Display
	jmp    doneShow

showList ENDP

;------------------------------------------------------------------------------
;bubbleSort PROC
;
;
;sorts array using bubble sort algorithm
;-------------------------------------------------------------------------------
bubbleSort PROC
   
    enter  0,0
	
	mov    ECX, [ebp+8]
	dec    ECX

outer:	
	push   ECX
	mov    ESI, [ebp+12]
 
 inner:
	mov    EAX, [ESI]
	cmp    EAX, [ESI+4]
	jl     next
	jmp    swap

swap:
    xchg   EAX, [ESI+4]
	mov    [ESI], EAX

next:
    add    ESI, 4
	loop   inner

    pop    ECX
	loop   outer

	leave
	ret 12

bubbleSort ENDP

;------------------------------------------------------------------------------
;findMedian PROC
;
;finds the Meidan of the array
;------------------------------------------------------------------------------
 findMedian PROC
     enter  0,0
	 mov    ESI, [EBP + 12]
	 mov    EAX, [EBP + 8]
	 mov    EDX, [EBP + 16]
	 call   WriteString
	 mov    EDX, 0
	 mov    EBX, 2
	 div    EBX
	 cmp    EDX, 0
	 je     evens
	 jmp    odd

odd: 
    mov    EBX, 4
    mul    EBX
	mov    EBX, EAX
	mov    EAX, [ESI + EBX]
	call   WriteDec

evens:
    mov   ECX, 4
	mul   ECX
    mov   EBX, [ESI+EAX]
	sub   EAX, 4
	mov   ECX, [ESI+EAX]
	mov   EAX, ECX
	add   EAX, EBX
	mov   EDX, 0
	mov   ECX, 2
	div   ECX
	call  WriteDec

	 call crlf
	 call crlf
	 leave
	 ret 12
findMedian ENDP

;------------------------------------------------------------------------------
;Farewell PROC
;
;Says goodbye to the user
;------------------------------------------------------------------------------

farewell PROC 
    enter  0,0
    call   CrLf
	call   CrLf
    mov    edx, OFFSET closing
	call   WriteString
	mov    edx, OFFSET userName
	call   WriteString
	call   CrLf
	call   CrLf
	leave
	ret
farewell ENDP
    
END main
