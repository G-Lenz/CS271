TITLE program4     (program4.asm)

; Author: George Lenz
; Email: lenzg@oregonstate.edu
; CS 271-400 / Project3           Due Date:2/18/2018
; Description: Displays a user specified number of composite numbers.

INCLUDE Irvine32.inc

upper equ 400
lower equ 1

.data

intro      BYTE   "Composite Number Calculator", 0
author     BYTE   "by George Lenz", 0
userName   BYTE   50 DUP(0)
namePrompt BYTE   "What is your name? ",0
greet      BYTE   "Hello, ", 0
instruct   BYTE   "Enter the amount of composite numbers you would like to see (1-400)", 0
closing    BYTE   "Goodbye, ", 0
err        BYTE   "Invalid input; Enter number from 1-400.", 0
space     BYTE   "          ", 0
temp       DWORD  ?
number     DWORD  0
count      DWORD  4
check      DWORD  2
lineCount  DWORD  0

.code
main PROC

    call Introduction
	call getUserData
	call showComposites
	call Farewell




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
	mov    number, eax
	call   CrLf
	call   validate
	leave
	ret
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
;showComposite PROC
;
;Shows a user specified number of composite numbers
;--------------------------------------------------------------------------------------------
showComposites PROC
    
    enter  0,0
    mov    ECX, number  

;show composite numbers
showComp:
	call   isComposite
	cmp    lineCount, 10
	je     newLine
	jmp    continue

;if 10 items on line, ceate a new line
newLine:
    call   Crlf
	mov    lineCount, 0

;skip newline if not 10 items
continue:
	inc    count
	mov    check, 2
	loop   showComp
	leave
	ret    
showComposites ENDP

;---------------------------------------------------------------------------------------	
;isComposite Proc
;
;Determines if a number is composite and prints it to the screen.
;---------------------------------------------------------------------------------------
isComposite PROC
  
    enter  0,0
    mov    temp, ECX
	mov    EAX, count
	sub    EAX, 3
	mov    ECX, EAX

;check to see if number is composite
checkComp:
	mov    EAX, 0
    mov    EAX, count
	mov    EDX, 0
	div    check
	cmp    EDX, 0
	je     endComp
	inc    check
	loop   checkComp
	inc    temp
	mov    ECX, temp
	leave
	ret    

;if number is composite print and return
endComp:

    mov    EAX, count
	call   WriteDec
	mov    EDX, OFFSET space
	call   WriteString
	inc    lineCount
	mov    ECX, temp
	leave
	ret    


 
isComposite ENDP

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
