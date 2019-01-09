TITLE program1     (program1.asm)

; Author: George Lenz
; CS 271 / Project3           Date:2/10/2018
; Description: Calculates average of user numbers between -100-1

INCLUDE Irvine32.inc

lower equ -100

.data

intro      BYTE   "Average of negatives", 0
author     BYTE   "by George Lenz", 0
userName   BYTE   50 DUP(0)
namePrompt BYTE   "What is your name? ",0
greet      BYTE   "Hello, ", 0
instruct   BYTE   "Input numbers from -100 - -1, and I will give you the average and sum (Enter a positive number to quit.)", 0
semiColon  BYTE   ": ", 0
closing    BYTE   "Goodbye, ", 0
directions BYTE   "Enter number ", 0
err        BYTE   "Invalid input, Enter number from -100 - -1.", 0
amount     BYTE   "Amount of numbers entered: ", 0
sum        BYTE  "The sum of your numbers is: ", 0
mean       BYTE  "The average of your numbers is: ", 0
extra      BYTE  "**EXTRA CREDIT: I HAVE NUMBERED USER INPUT LINES.**", 0 
catch      BYTE   "You entered 0 numbers, if you didn't want to play you should have never started the program...", 0
number     DWORD  0
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
	call   CrLF
	mov    edx, OFFSET extra
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

;How to play
Instructions:
    mov    edx, OFFSET instruct
	call   WriteString
	call   Crlf

;Initialize accumulator
	mov    ebx, 0

;display instructions and get numbers
UserInstructions:
Start:
    mov    edx, OFFSET directions
	call   WriteString
	mov    eax, count
	call   WriteDec
	mov    edx, OFFSET semiColon
	call   WriteString
	call   ReadInt
	mov    number, eax
	call   CrLf

;validate input
    cmp    number, lower
    jl     Error
	cmp    number, 0
	jnl    Calculations

;add to accumulator and re-prompt
Accumulate:
	inc    count
	add    ebx, number    
	jmp    UserInstructions

;display error message and restart
Error:
    mov    edx, OFFSET err
	call   WriteString
	call   CrLf
	jmp    Start

;Calculations and Outputs of Calculations
Calculations:
    sub    count, 1
	mov    eax, count
	cmp    eax, 0
	je     NA
	mov    edx, OFFSET amount
	call   WriteString
	call   WriteDec
	call   Crlf
	mov    edx, OFFSET sum
	call   WriteString
	mov    eax, ebx
	call   WriteInt
	call   Crlf
	mov    edx, OFFSET mean
	call   WriteString
	cdq
	idiv    count
	call   WriteInt
	jmp    farewell

;Catch for no numbers
NA:
    mov edx, OFFSET catch
	call WriteString


	    
; Closing Message
farewell: 
    call   CrLf
	call   CrLf
    mov    edx, OFFSET closing
	call   WriteString
	mov    edx, OFFSET userName
	call   WriteString
	call   CrLf
	call   CrLf

	exit	; exit to operating system
main ENDP

; (insert additional procedures here)

END main
