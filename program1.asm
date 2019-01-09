TITLE program1     (program1.asm)

; Author: George Lenz
; CS 271 / Project1           Date:1/21/2018
; Description: Simple match calculations on user inputted numbers

INCLUDE Irvine32.inc

; (insert constant definitions here)

.data

intro      BYTE   "Simple Math Program     by George Lenz", 0
closing    BYTE   "Thanks for Playing, Goodbye", 0
first      BYTE   "First Number: ", 0
second     BYTE   "Second Number: ", 0
userNum1   DWORD  0
userNum2   DWORD  0
sum        DWORD  ?
product    DWORD  ?
difference DWORD  ?
quotient   DWORD  ?
remainder     DWORD  ?
plus       BYTE  " + ", 0
minus      BYTE  " - ", 0
times      BYTE  " x ", 0
divide     BYTE  " / ", 0
equals     BYTE  " = ", 0
extra      BYTE  " remainder ", 0

.code
main PROC

;Introduction
    mov    edx, OFFSET intro
	call   WriteString
	call   CrLf
	call   CrLf

;get first number from user
    mov    edx, OFFSET first
	call   WriteString
	call   ReadInt
	mov    userNum1, eax
	call CrLf
;get second numner from user
    mov    edx, OFFSET second
	call   WriteString
	call   ReadInt
	mov    userNum2, eax
	call   CrLf
	call   CrLf

;calculate sum
    mov    eax, userNum1
	mov    ebx, userNum2
	add    eax, ebx
	mov    sum, eax

;calculate differenct
    mov    eax, userNum1
	mov    ebx, userNum2
	sub    eax, ebx
	mov    difference, eax

;calculate product
    mov    eax, userNum1
	mov    ebx, userNum2
	mul    ebx
	mov    product, eax

;calculate difference

    mov    eax, userNum1
	mov    edx, 0
	mov    ebx, userNum2
	div    ebx
	mov    quotient, eax
	mov    remainder, edx


;report addition result
    mov    eax, userNum1
	call   WriteDec
	mov    edx, OFFSET plus
	call   WriteString
	mov    eax, userNum2
	call   WriteDec
	mov    edx, OFFSET equals
	call   WriteString
	mov    eax, sum
	call   WriteDec
	call   CrLf

;report subtraction result

    mov    eax, userNum1
	call   WriteDec
	mov    edx, OFFSET minus
	call   WriteString
	mov    eax, userNum2
	call   WriteDec
	mov    edx, OFFSET equals
	call   WriteString
	mov    eax, difference
	call   WriteDec
	call   CrLf

;report multiplication result

    mov    eax, userNum1
	call   WriteDec
	mov    edx, OFFSET times
	call   WriteString
	mov    eax, userNum2
	call   WriteDec
	mov    edx, OFFSET equals
	call   WriteString
	mov    eax, product
	call   WriteDec
	call   CrLf

;report division result
    mov    eax, userNum1
	call   WriteDec
	mov    edx, OFFSET divide
	call   WriteString
	mov    eax, userNum2
	call   WriteDec
	mov    edx, OFFSET equals
	call   WriteString
	mov    eax, quotient
	call   WriteDec
	mov    edx, OFFSET extra
	call   WriteString
	mov    eax, remainder
	call   WriteDec
	call   CrLf
	call   CrLf

; Closing Message
    mov    edx, OFFSET closing
	call   WriteString
	call   CrLf

	exit	; exit to operating system
main ENDP

; (insert additional procedures here)

END main
