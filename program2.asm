TITLE program1     (program1.asm)

; Author: George Lenz
; CS 271 / Project1           Date:1/21/2018
; Description: Simple match calculations on user inputted numbers

INCLUDE Irvine32.inc

; (insert constant definitions here)

.data

intro      BYTE   "The Amazing Fibonacci", 0
author     BYTE   "by George Lenz", 0
userName   BYTE   50 DUP(0)
namePrompt BYTE   "Who wishes to invoke the Fibonacci sequence? ",0
closing    BYTE   "You're fibonacci wishes have been granted: Farewell, ", 0
directions BYTE   "Enter your desired Fibonacci numbers: ", 0
err        BYTE   "Invalid input", 0
previous   DWORD  0
current    DWORD  1
spacing    BYTE   "     ", 0
iterations DWORD  0
count      DWORD  1

.code
main PROC

;Title and Author
Introduction:
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

;get number of Fibonacci terms
UserInstructions:
Start:
    mov    edx, OFFSET directions
	call   WriteString
	call   ReadInt
	mov    iterations, eax
	call   CrLf

;validate input
    cmp    iterations, 1
    jl     Error
	cmp    iterations, 47
	jnl    Error
	jmp    Counter

;display error message and restart
Error:
    mov    edx, OFFSET err
	call   WriteString
	call   CrLf
	jmp    Start

;set counter
Counter:
    mov    ecx, iterations

    

;display current fibonacci number and calculate the next
Calculations:
  
	mov     eax, current
	call    WriteDec
	mov     edx, OFFSET spacing
	call    WriteString
	add     eax, previous
	mov     ebx, current
	mov     previous, ebx
	mov     current, eax
	mov     eax, count

;format output and loop back to calculations
displayFibs:
	cmp     eax, 5
	je      NewLine
	add     eax, 1
	mov     count, eax
    loop    Calculations
	jmp     farewell

;create new line
NewLine:
    mov     eax, 1
	mov     count, eax
    call    CrLf
	loop    Calculations
	    
; Closing Message
farewell: 
    call   CrLf
	call   CrLf
    mov    edx, OFFSET closing
	call   WriteString
	mov    edx, OFFSET userName
	call   WriteString
	call   CrLf

	exit	; exit to operating system
main ENDP

; (insert additional procedures here)

END main
