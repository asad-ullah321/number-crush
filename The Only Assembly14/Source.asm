; *********COAL Project Group Name: Snakes**********
INCLUDE Irvine32.inc




Highlighttile MACRO B_color
mov eax, yellow+(B_color*16)
call settextcolor
ENDM
 
Checks MACRO
mov mainCheck, 1
mov backswapCheck, 1
ENDM

Line_space MACRO
mov edx, offset spcline2
call writestring

ENDM

newline MACRO
mov edx, offset spc
call writestring
ENDM

newline2 MACRO
mov edx, offset spc2
call writestring

ENDM

newline3 MACRO
mov edx, offset spc3
call writestring

ENDM


ChngColor MACRO color
mov eax, color
call SetTextColor
ENDM




.data
filename BYTE "Score_Card.txt", 0
fileHandel HANDLE ?
 
BytesWritten DWORD ? 
noOfbytes DWORD ?
endl BYTE 0DH, 0AH








EVEN
Board	BYTE 10 DUP(?)
RowSize = ($-Board)
		BYTE 10 DUP(?)
		BYTE 10 DUP(?)
		BYTE 10 DUP(?)
		BYTE 10 DUP(?)
		BYTE 10 DUP(?)
		BYTE 10 DUP(?)
		BYTE 10 DUP(?)
		BYTE 10 DUP(?)
		BYTE 10 DUP(?)
EVEN
Board2	BYTE 9 DUP(?)
RowSize2 = ($-Board)
		BYTE 9 DUP(?)
		BYTE 9 DUP(?)
		BYTE 9 DUP(?)
		BYTE 9 DUP(?)
		BYTE 9 DUP(?)
		BYTE 9 DUP(?)
		BYTE 9 DUP(?)
		BYTE 9 DUP(?)


Istr1 BYTE " __    _  __   __  __   __  _______  _______  ______       _______  ______    __   __  _______  __   __ ",0
Istr2 BYTE "|  |  | ||  | |  ||  |_|  ||  _    ||       ||    _ |     |       ||    _ |  |  | |  ||       ||  | |  |",0
Istr3 BYTE "|   |_| ||  | |  ||       || |_|   ||    ___||   | ||     |       ||   | ||  |  | |  ||  _____||  |_|  |",0
Istr4 BYTE "|       ||  |_|  ||       ||       ||   |___ |   |_||_    |   ____||   |_||_ |  |_|  || |_____ |       |",0
Istr5 BYTE "|  _    ||       ||       ||  _   | |    ___||    __  |   |  |     |    __  ||       ||_____  ||       |",0
Istr6 BYTE "| | |   ||       || ||_|| || |_|   ||   |___ |   |  | |   |  |____ |   |  | ||       | _____| ||   _   |",0
Istr7 BYTE "|_|  |__||_______||_|   |_||_______||_______||___|  |_|   |_______||___|  |_||_______||_______||__| |__|",0																									   
Ispc BYTE  "         ", 0                                
Ispc2 BYTE "                                                          ",0
load BYTE "Loading", 0
dot BYTE '.'
																			  
INSTR1 BYTE "                                                  Press w to move corsor Up",0
INSTR2 BYTE "                                                  Press a to move corsor Left",0
INSTR3 BYTE "                                                  Press s to move corsor Down",0
INSTR4 BYTE "                                                  Press d to move corsor Right",0
INSTR5 BYTE "                                                  Press e to lock first tile",0





Nameply BYTE 100 DUP(0)
Namelen Dword ?

EVEN
spcline BYTE " | ", 0
number BYTE   "   1   2   3   4   5   6   7   8   9   10",0
EVEN
spcline2 BYTE "*-----------------------------------------* ", 0
spc  BYTE "                                    ", 0
spc2 BYTE "                                      ", 0
spc3  BYTE "                                  ", 0
colstr BYTE "00",0


Lev1 BYTE "                 Level 1", 0
Lev2 BYTE "                 Level 2", 0
Lev3 BYTE "                 Level 3", 0



Lev1f BYTE "Level 1: ", 0
Lev2f BYTE "Level 2: ", 0
Lev3f BYTE "Level 3: ", 0
Highf BYTE "Highest Score: ", 0



crush BYTE    "                                                    ->Crushing",0
explosion BYTE    "                                                    ->Explosion",0

Scorestr BYTE "                                                       Score: ",0
Movestr BYTE  "                                                  Moves Left: ",0
Namestr BYTE  "                                                     Enter Name: ",0
NameStr1 BYTE  "                                                        Name: ",0



tstr1 BYTE    "                                                       Tile1: ",0
tstr2 BYTE    "                                                       Tile2: ",0
inV BYTE    "                                                       Invalid: ",0


tile1 BYTE 0
tile2 BYTE 0
maincheck BYTE 0
backswapCheck BYTE 0
Score DWORD 9
SOAll DWORD 3 DUP(0)
Largest DWORD 0
stringNum BYTE 4 DUP(0)
Stringlen BYTE 0


blackstr BYTE 119 DUP (' '), 0



Moves BYTE 0

bombtile BYTE ?
reftile DwORD ?
.code

main proc
  



call start 

call Level1
mov eax, Score
mov SOAll[0], eax
call Level2
mov eax, Score
mov SOAll[4], eax
call Level3
mov eax, Score
mov SOAll[8], eax




mov largest, eax
mov ecx, 2
mov esi, offset SOALL
l1:
	cmp [esi], eax
	jbe noneed
		mov eax, [esi]
		mov largest, eax
noneed:
add esi, type dword
loop l1





INVOKE CreateFile, ADDR filename, GENERIC_Write + Generic_Read, DO_NOT_SHARE, NULL, OPEN_ALWAYS, FILE_ATTRIBUTE_NORMAL, 0
mov fileHandel, eax
 
INVOKE SetFilePointer, fileHandel, 0, 0, FILE_END
INVOKE WRITEFILE, filehandel, addr Nameply, Namelen, ADDR BytesWritten, NULL; name
INVOKE WRITEFILE, filehandel, addr endl, sizeof endl, ADDR BytesWritten, NULL; endline

INVOKE WRITEFILE, filehandel, addr lev1f, lengthof lev1f, ADDR BytesWritten, NULL; score1
call StrZero
mov eax, SOALL[0]
call numberToString 
INVOKE WRITEFILE, filehandel, addr stringnum, Stringlen, ADDR BytesWritten, NULL; score2
INVOKE WRITEFILE, filehandel, addr endl, sizeof endl, ADDR BytesWritten, NULL; endline



INVOKE WRITEFILE, filehandel, addr lev2f, lengthof lev2f, ADDR BytesWritten, NULL; score3
call StrZero

mov eax, SOALL[4]
call numberToString 
INVOKE WRITEFILE, filehandel, addr stringnum, Stringlen, ADDR BytesWritten, NULL; name
INVOKE WRITEFILE, filehandel, addr endl, sizeof endl, ADDR BytesWritten, NULL; endline


INVOKE WRITEFILE, filehandel, addr lev3f, lengthof lev3f, ADDR BytesWritten, NULL; name
call StrZero

mov eax, SOALL[8]
call numberToString 
INVOKE WRITEFILE, filehandel, addr stringnum, Stringlen, ADDR BytesWritten, NULL; name
INVOKE WRITEFILE, filehandel, addr endl, sizeof endl, ADDR BytesWritten, NULL; endline


INVOKE WRITEFILE, filehandel, addr highf, lengthof highf, ADDR BytesWritten, NULL; name

call StrZero

mov eax, Largest
call numberToString 
INVOKE WRITEFILE, filehandel, addr stringnum, Stringlen, ADDR BytesWritten, NULL; name
INVOKE WRITEFILE, filehandel, addr endl, sizeof endl, ADDR BytesWritten, NULL; endline 
 




call waitmsg
exit
main endp


clearscr proc

mov dl, 0
mov dh, 0
call GOTOXY

Highlighttile black
mov ecx, 45
mov edx, offset blackstr
lo1:
	call writestring
	call crlf
loop lo1


mov dl, 0
mov dh, 0
call GOTOXY

chngcolor white

ret
clearscr endp


StrZero proc
mov ecx, 4
mov esi, offset Stringnum
mov al, 0
l1:
mov [esi], al
inc esi
loop l1
mov Stringlen, 0
ret
Strzero ENDP 
numberToString proc

mov stringlen, 0
mov bx,10
mov esi, offset stringNum
cmp eax, 9
ja D2
	mov ecx, 1
	jmp last

D2:
cmp eax, 99
ja DI3
mov ecx, 2
add esi, 1
jmp last
DI3:
cmp eax, 999
ja D4
	mov ecx, 3
	add esi, 2
	jmp last
D4:
	mov ecx, 4
	add esi, 3
last:



l1:
mov edx, 0
div bx
add dl,30h
mov [esi],dl
dec esi
inc Stringlen
loop l1





ret
numberToString endp
strprint proc

l1:
mov al, [esi]
call writechar
mov eax, 0
call delay
inc esi
loop l1
call crlf


ret
strprint endp
start proc

chngColor 03h

mov edx, offset Ispc
call writestring
mov esi, offset Istr1
mov ecx, lengthof Istr1
call strprint 


mov edx, offset Ispc
call writestring
mov esi, offset Istr2
mov ecx, lengthof Istr2
call strprint 


mov edx, offset Ispc
call writestring
mov esi, offset Istr3
mov ecx, lengthof Istr3
call strprint 


mov edx, offset Ispc
call writestring
mov esi, offset Istr4
mov ecx, lengthof Istr4
call strprint 



mov edx, offset Ispc
call writestring
mov esi, offset Istr5
mov ecx, lengthof Istr5
call strprint 


mov edx, offset Ispc
call writestring
mov esi, offset Istr6
mov ecx, lengthof Istr6
call strprint 


mov edx, offset Ispc
call writestring
mov esi, offset Istr7
mov ecx, lengthof Istr7
call strprint 

ChngColor 0Bh

	call crlf
	mov edx, offset Namestr
	call writestring
	mov edx, offset Nameply
	mov ecx, 100
	call ReadString
	mov Namelen, eax


			call crlf
			mov edx, offset Ispc2
			call writestring
			mov edx, offset load
			call writestring
			mov ecx, 3
			l1:
			mov eax, 500
			call delay
			mov al, dot
			call writechar
			loop l1
			call crlf


			mov edx, offset INSTR1
			call writestring
			call crlf
			mov edx, offset INSTR2
			call writestring
			call crlf
			mov edx, offset INSTR3
			call writestring
			call crlf
			mov edx, offset INSTR4
			call writestring
			call crlf
			mov edx, offset INSTR5
			call writestring
			call crlf
ChngColor white
		
		l4:
		call readchar
		cmp al, 'e'
		jne l4

ret
start endp



Level1 proc uses esi edi ecx

call NB_level1
again:
	mov mainCheck, 0

	call ROWcombo13
	call Colcombo13
	cmp mainCheck, 1
je again




;call PB_Level1
mov Score, 0
mov Moves, 3
mov tile1, 0
mov tile2, 0




l1:
    call clearscr
	;call PB_Level1 
	call Input1N

	mov eax, 3000
	call Delay
	call clearscr
	call SwapTiles
	call PH_tileD1
	mov eax, 3000
	call Delay
	call IsBomb13


	mov Backswapcheck, 0


	CMP bombtile, '0'
	je again1
		mov Backswapcheck, 1
		call clearscr
		call PH_Bomb1
	
		call Crush_bomb13 
		mov eax, 3000
		call Delay
		;call Clrscr
		call Drop13
	

					again1:

						mov mainCheck, 0
						call clearscr
						call PB_Level1

						call ROWcombo13
						cmp maincheck, 0
						je next
							mov eax, 3000
							call Delay


						next:
							mov mainCheck, 0
							call clearscr
							call PB_Level1

							call Colcombo13
							mov eax, 3000
							call Delay
							;call waitmsg

					cmp mainCheck, 1
					je again1

	


	CMP Backswapcheck, 1
	je noBackSwap
		;call waitmsg
		call clearscr 
		call PH_tileD1 
		call SwapTiles
		mov eax, 3000
		call Delay
		call clearscr
		call PH_tileD1 
		mov eax, 3000
		call Delay
		jmp l1


noBackSwap:
dec Moves
cmp Moves, 0
JA l1

ret
Level1 endp
level2 proc uses esi edi ecx


call NB_level2
again:
	mov mainCheck, 0

	call ROWcombo2
	call Colcombo2
	cmp mainCheck, 1
je again

;call PB_Level1
mov Score, 0
mov Moves, 3
mov tile1, 3
mov tile2, 3

l1:
	call clearscr
	;call PB_Level1 
	call Input2


	mov eax, 3000
	call Delay
	call clearscr
	;movzx eax, tile2
	;call writedec
	;call waitmsg
	call SwapTiles2
	call PH_tileD2
	mov eax, 3000
	call Delay
	call IsBomb2 


	mov Backswapcheck, 0


	CMP bombtile, '0'
	je again1
		mov Backswapcheck, 1
		call clearscr
		call PH_Bomb2
		call Crush_bomb2
		mov eax, 3000
		call Delay
		;call Clrscr
		call Drop2
		 


						again1:
								mov mainCheck, 0
								call clearscr
								call PB_Level2

								call ROWcombo2
								cmp maincheck, 0
								je next
								mov eax, 3000
								call Delay



								next:
								mov mainCheck, 0

								call clearscr
								call PB_Level2

								call Colcombo2
								mov eax, 3000
								call Delay
								;call waitmsg
								cmp mainCheck, 1
						je again1

	;call waitmsg

	CMP Backswapcheck, 1
	je noBackSwap
		;call waitmsg
		call clearscr
		call PH_tileD2
		call SwapTiles
		mov eax, 3000
		call Delay
		call clearscr
		call PH_tileD2
		mov eax, 3000
		call Delay
		jmp l1


noBackSwap:
dec Moves
cmp Moves, 0
JA l1


ret
level2 endp
Level3 proc uses esi edi ecx

call NB_level3

again:
	mov mainCheck, 0
	call ROWcombo13
	call Colcombo13
	cmp mainCheck, 1
je again



mov Score, 0
mov Moves, 3
mov tile1, 0
mov tile2, 0
;call waitmsg

l1:
	call clearscr
	;call PB_Level1 
	call Input3N


	mov eax, 3000
	call Delay
	call clearscr
	call SwapTiles
	call PH_tileD3 
	mov eax, 3000
	call Delay

	call IsBomb13 


	mov Backswapcheck, 0


	CMP bombtile, '0'
	je again1
		mov Backswapcheck, 1
		call clearscr
		call PH_Bomb3
		call Crush_bomb13 
		mov eax, 3000
		call Delay
		;call Clrscr
		call Drop13
	


							again1:
								mov mainCheck, 0
								call clearscr
								call PB_Level3

								call ROWcombo13
								cmp maincheck, 0
								je next
								mov eax, 3000
								call Delay



								next:
								mov mainCheck, 0

								call clearscr
								call PB_Level3

								call Colcombo13
								mov eax, 3000
								call Delay
								;call waitmsg
								cmp mainCheck, 1
							je again1

	;call waitmsg

	CMP Backswapcheck, 1
	je noBackSwap
		;call waitmsg
		call clearscr
		call PH_tileD3 
		
		call SwapTiles
		mov eax, 3000
		call Delay
		call clearscr
		call PH_tileD3  
		mov eax, 3000
		call Delay
		jmp l1


noBackSwap:
dec Moves
cmp Moves, 0
JA l1

ret
Level3 endp


SwapTiles proc uses edi esi ecx


movzx eax, tile1
mov edi, offset board
add edi, eax
mov bl, [edi]

movzx eax, tile2
mov esi, offset board
add esi, eax
mov bh, [esi]

mov [edi], bh
mov [esi], bl

ret
SwapTiles endp
SwapTiles2 proc uses esi edi ecx


movzx eax, tile1
mov edi, offset board2
add edi, eax
mov bl, [edi]

movzx eax, tile2
mov esi, offset board2
add esi, eax
mov bh, [esi]

mov [edi], bh
mov [esi], bl


ret
SwapTiles2 endp


NB_level1 proc uses esi edi ecx

mov esi, offset Board
mov ecx, 10
call Randomize

l1:
push ecx
mov ecx, 10
	l2:
		mov eax, 6
		call RandomRange
		cmp eax, 5 
		je Bomb
			add eax, 49
			mov [esi], eax
			jmp last
		Bomb:
			mov al, 'B'
			mov [esi], al
		last:
			inc esi
	loop l2
pop ecx
loop l1

ret
NB_level1 endp
NB_Level2 PROC uses esi edi ecx
LOCAL row: BYTE, col:BYTE

mov esi, offset Board2
mov ecx, 9
call Randomize

l1: ; first simple intializing whole board of 9*9
push ecx
mov ecx, 9
	l2:
		mov eax, 5
		call RandomRange
		cmp eax, 4 
		je Bomb
			add eax, 49
			mov [esi], eax
			jmp last1
		Bomb:
			mov al, 'B'
			mov [esi], al
		last1:
			inc esi
	loop l2
pop ecx
loop l1

mov row, 0
mov esi, offset Board2
mov ecx, 9
mov al, 'X'
l3:
mov col, 0
push ecx
mov ecx, 9
mov col, 0
	l4:
		cmp row, 3
		jae secondrowcheck
			cmp col, 3
			jae secondcolcheck
					mov [esi], al
					jmp last
			secondcolcheck:
			cmp col, 5
			jbe last	
					mov [esi], al
					jmp last
		secondrowcheck:
		cmp row, 5
		jbe row4check
			cmp col, 3
			jae secondcolcheck2
					mov [esi], al
					jmp last
			secondcolcheck2:
			cmp col, 5
			jbe last
					mov [esi], al
					jmp last
		row4check:
		cmp row, 4
		jne last
			cmp col, 3
			jb last
				cmp col, 5
				ja last
					mov [esi], al

		last:
		inc esi
		inc col
	loop l4
inc row
pop ecx
loop l3


		
					
ret
NB_Level2 ENDP
NB_Level3 proc uses esi edx ecx
LOCAL row:BYTE
mov esi, offset Board
mov ecx, 10
call Randomize


l3:
	mov eax, 6
	call RandomRange
	cmp eax, 5
	je BOMB1
		add eax, 49d
		mov [esi], al
		jmp last1

	bomb1:
		mov al, 'B'
		mov [esi], al
	last1:
inc esi
loop l3



mov ecx, 9
mov row, 0
l1:
push ecx
mov ecx, 10
	l2:
		mov eax, 7
		call RandomRange
		cmp eax, 6
		jne notX
			mov eax, 'X'
			mov [esi], eax
			jmp last
		notX:
		cmp eax, 5
		je Bomb
			add eax, 49
			mov [esi], eax
			jmp last
		Bomb:
			mov al, 'B'
			mov [esi], al
		last:
		inc esi
	loop l2
inc row
pop ecx
loop l1


ret
NB_Level3 endp





Dis proc uses esi eax

mov al, [esi]
cmp al, 'B'
jne next0
			ChngColor 08h; dark grey
			mov al, [esi]
			call writechar

next0:
cmp  al, 'X'
jne next1
			ChngColor red
			mov al, 04h
			call writechar
next1:
cmp al, '1'
jne Next2
			ChngColor Magenta
			mov al, [esi]
			call writechar
Next2:
cmp al,  '2'
jne next3
			ChngColor Cyan
			mov al, [esi]
			call writechar
next3:
cmp al,  '3'
jne next4
			ChngColor 0Ah
			mov al, [esi]
			call writechar
next4:
cmp al,  '4'
jne next5
			ChngColor 07h
			mov al, [esi]
			call writechar
next5:
cmp al, '5'
jne endofch
			ChngColor 06h
			mov al, [esi]
			call writechar
endofch:
ret
Dis ENDP
PH_twotiles1 proc uses edi edx ecx

Newline 
mov edx, offset Lev1
call writestring
call crlf

mov ebx, offset board
mov edi, offset board
movzx eax, tile1
add ebx, eax
movzx eax, tile2
add edi, eax

mov esi, offset Board
mov ecx, 10
l1:
push ecx
mov ecx, 10
Newline
Line_Space
call crlf
Newline
mov edx, offset spcline
call writestring
	l2:
	cmp ebx, esi
	je Highlight
	cmp edi, esi
	je Highlight
		mov al, [esi]
		;cmp al, '0'
		;je space
			call Dis
			jmp simplecolor
		;space:
		;	mov al, ' '
		;	call WriteChar
		;	jmp simplecolor

	Highlight:
	Highlighttile red
	mov al, [esi]
	call Writechar
		simplecolor:
		ChngColor White
		mov edx, offset spcline
		call writestring
		inc esi
	loop l2
call crlf
pop ecx
loop l1
Newline
Line_space
call crlf

mov edx, offset Namestr1
call writestring
mov edx, offset Nameply
call writestring
call crlf


mov edx, offset scorestr
call writestring

mov eax, Score
call Writedec
call crlf



mov edx, offset Movestr
call writestring

movzx eax, Moves
call Writedec
call crlf

ret
PH_twoTiles1 endp
PH_twotiles3 proc uses edi edx ecx

Newline 
mov edx, offset Lev1
call writestring
call crlf

mov ebx, offset board
mov edi, offset board
movzx eax, tile1
add ebx, eax
movzx eax, tile2
add edi, eax

mov esi, offset Board
mov ecx, 10
l1:
push ecx
mov ecx, 10
Newline
Line_Space
call crlf
Newline
mov edx, offset spcline
call writestring
	l2:
	cmp ebx, esi
	je Highlight
	cmp edi, esi
	je Highlight
		mov al, [esi]
		;cmp al, '0'
		;je space
			call Dis
			jmp simplecolor
		;space:
		;	mov al, ' '
		;	call WriteChar
		;	jmp simplecolor

	Highlight:
	Highlighttile red
	mov al, [esi]
	call Writechar
		simplecolor:
		ChngColor White
		mov edx, offset spcline
		call writestring
		inc esi
	loop l2
call crlf
pop ecx
loop l1
Newline
Line_space
call crlf



mov edx, offset Namestr1
call writestring
mov edx, offset Nameply
call writestring
call crlf


mov edx, offset scorestr
call writestring

mov eax, Score
call Writedec
call crlf



mov edx, offset Movestr
call writestring

movzx eax, Moves
call Writedec
call crlf

ret
PH_twoTiles3 endp

PB_Level1 proc uses esi edx ecx



Newline 
mov edx, offset Lev1
call writestring
call crlf

mov esi, offset Board
mov ecx, 10
mov bx, 0
l1:
push ecx
mov ecx, 10
Newline
Line_Space
call crlf
Newline3

mov edx, offset spcline
call writestring
	l2:
		mov al, [esi]
		cmp al, '0'
		je space
			call Dis
			jmp abcd
		space:
			mov al, ' '
			call WriteChar

		abcd:
		ChngColor White
		mov edx, offset spcline
		call writestring
		inc esi
	loop l2
call crlf
pop ecx
loop l1
Newline
Line_space
call crlf



mov edx, offset Namestr1
call writestring
mov edx, offset Nameply
call writestring
call crlf

mov edx, offset scorestr
call writestring

mov eax, Score
call Writedec
call crlf



mov edx, offset Movestr
call writestring

movzx eax, Moves
call Writedec
call crlf

ret
PB_level1 endp
PB_Level2 PROC uses esi edi ecx
Newline2
mov edx, offset Lev2
call writestring
call crlf




mov esi, offset Board2
mov ecx, 9
l1:
push ecx
mov ecx, 9
Newline
Line_Space
call crlf
Newline2
mov edx, offset spcline
call writestring
	l2:
		mov al, [esi]
		cmp al, '0'
		jne notzero
		mov al, ' '
		call writechar
		notzero:
			call Dis
		ChngColor White
		mov edx, offset spcline
		call writestring
		inc esi
	loop l2
call crlf
pop ecx
loop l1
Newline
Line_space
call crlf




mov edx, offset Namestr1
call writestring
mov edx, offset Nameply
call writestring
call crlf


mov edx, offset scorestr
call writestring

mov eax, Score
call Writedec
call crlf



mov edx, offset Movestr
call writestring

movzx eax, Moves
call Writedec
call crlf

ret
PB_level2 endp
PB_level3 proc uses esi edi ecx
Newline 
mov edx, offset Lev3
call writestring
call crlf


mov esi, offset Board
mov ecx, 10
l1:
push ecx
mov ecx, 10
Newline
Line_Space
call crlf
Newline
mov edx, offset spcline
call writestring
	l2:
		mov al, [esi]
		cmp al, '0'
		je space
			call Dis
			jmp abcd
		space:
			mov al, ' '
			call WriteChar

		abcd:
		ChngColor White
		mov edx, offset spcline
		call writestring
		inc esi
	loop l2

call crlf
pop ecx
loop l1
Newline
Line_space
call crlf



mov edx, offset Namestr1
call writestring
mov edx, offset Nameply
call writestring
call crlf


mov edx, offset scorestr
call writestring

mov eax, Score
call Writedec
call crlf


mov edx, offset Movestr
call writestring

movzx eax, Moves
call Writedec
call crlf


ret
PB_level3 endp




ROWcombo13 proc
LOCAL row: BYTE, col:DWORD, count:DWORD , next:BYTE, sco:DWORD, check:BYTE



combointialized:

;call clrscr
;call PB_level1
;call waitmsg
mov row, 0
mov col, 0
mov sco, 0
mov check, 0
mov ecx, 10
mov esi, offset Board
l1:
push ecx
;movzx eax, row
;call writedec
mov ecx, 10
mov col, 0
	l2:
	mov next, 2
	mov count, 1
	mov al, [esi]
	cmp al, 88
	je nocombointialized
	CMP AL, 'B'
	je nocombointialized
	movzx ebx, next
	add ebx, col
	cmp ebx, 9
	ja nocombointialized
		cmp al, [esi+1]
		jne nocombointialized
		inc count
		again:
		movzx ebx, next
			mov ah, [esi+ebx]
			inc next
			cmp al, ah
			jne endofrow
			 inc count
			 movzx ebx, next
			 add ebx, col
			 cmp ebx, 9
			 jbe again

		endofrow:
		cmp count, 3
		jb nocombointialized
			mov check, 1
			mov backswapCheck, 1
			mov mainCheck, 1
			mov ecx, count
			mov al, '0'
			l3:
				mov [esi], al
				inc col
				inc esi
			loop l3
			mov ebx, count
			add Score, ebx
			;call PB_Level1
			;call waitmsg 
			;call waitmsg
			mov edx, offset crush
			call writestring
			call crlf
			

;call PB_level1
;call waitmsg
			call Drop13
			jmp combointialized
		nocombointialized:
		inc esi
		inc col
	dec ecx
	cmp ecx, 0
JA l2

pop ecx
inc row
dec ecx
cmp ecx, 0
JA l1
;call crlf
;mov eax, sco
;call writedec
;call crlf

;movzx eax, check
;call writedec
;call crlf

;call PB_level1
;call waitmsg
;call Drop13
;call waitmsg
ret
ROWcombo13 endp
Colcombo13 proc uses esi edi ecx
LOCAL row: Dword, col:Dword, count:DWORD , next:BYTE, sco:DWORD, check:BYTE

mov mainCheck, 0
combointialized:
;call PB_Level1 
;call waitmsg
mov col, 0
mov sco, 0
mov check, 0
mov ecx, 10

l1:
push ecx
mov esi, offset Board
add esi, col
;movzx eax, row
;call writedec
mov ecx, 10
mov row, 0
	l2:
	mov next, 20
	mov count, 1
	mov al, [esi]
	cmp al, 88
	je nocombointialized
	CMP AL, 'B'
	je nocombointialized
	movzx ebx, next
	add ebx, row
	cmp ebx, 90
	ja nocombointialized
		cmp al, [esi+10]
		jne nocombointialized
		inc count
		again:
		movzx ebx, next
			mov ah, [esi+ebx]
			add next, 10
			cmp al, ah
			jne endofrow
			 inc count
			 movzx ebx, next
			 add ebx, row
			 cmp ebx, 90
			 jbe again

		endofrow:
		cmp count, 3
		jb nocombointialized
			mov check, 1
			Checks
			mov ecx, count
			l3:
				mov al, '0'
				mov [esi], al
				add esi, 10		
			loop l3
			mov ebx, count
			add Score, ebx
			;call PB_Level1
			mov edx, offset crush
			call writestring
			call crlf
;call PB_Level1 
;call waitmsg
			call Drop13
			jmp combointialized
		nocombointialized:
		add esi, 10
		add row, 10
		
	dec ecx
	cmp ecx, 0
	JA l2

pop ecx
inc col
dec ecx
cmp ecx, 0
JA l1
;mov al, 'D'
;call writechar
;call crlf
;call waitmsg

;mov ebx, sco
;add Score, ebx

;call PB_level1
;call waitmsg
;call Drop13
;call waitmsg
ret

Colcombo13 endp
Drop13 proc uses esi edi ecx 
local col:BYTE, row:BYTE, checkDrop: BYTE, Xcount:Byte


call Randomize


againmain:


	
;
;call crlf
mov edi, offset Board
mov ecx, 10
l3:
	mov al, [edi]
	cmp al, '0'
	jne notneedednew
	mov eax, 5
		call RandomRange
		add eax, 49
		mov [edi], al
		;mov al, [edi]
		;call Writechar
	notneedednew:
	inc edi
loop l3
;call crlf

mov Xcount, 1
mov col, 9
mov row, 9

mov CheckDrop, 0
mov esi, offset board
movzx eax, col
add esi, 99d
mov ecx, 9;rows
l1:
push ecx
;movzx eax, row
;call writedec
mov col, 9
mov ecx, 10;columns
	l2:
	mov Xcount, 1
	mov al, [esi]
	cmp al, '0'
	jne noDrop
	mov checkdrop, 1
		mov ah, [esi - 10]
		cmp ah, 'X'
		je uppertileX
			mov al, ah
			mov [esi], al
			mov ah, '0'
			mov [esi - 10], ah
			jmp Nodrop
		uppertileX:
		mov ebx, 20
		againX:
		 
			inc Xcount
			mov edi, esi
			sub edi, ebx
			mov ah, [edi]
			add ebx, 10
			cmp ah, 'X'
			je againX
				mov ax, 10
				mul Xcount
				movzx ebx, ax
				mov edi, esi
				sub edi, ebx
				mov ah, [edi]
				mov al, '0'
				mov [edi], al
				mov [esi], ah



	NoDrop:
	dec esi
	loop l2

pop ecx
dec row
;call PB_Level1
;call waitmsg
loop l1



cmp Checkdrop, 0
jne againmain

ret
Drop13 endp



RowCombo2 proc uses esi edi ecx



LOCAL row: BYTE, col:DWORD, count:DWORD , next:BYTE, sco:DWORD, check:BYTE



combointialized:

;call PB_level2
;call waitmsg
mov row, 0
mov col, 0
mov sco, 0
mov check, 0
mov ecx, 9
mov esi, offset Board2
l1:
push ecx
;movzx eax, row
;call writedec
mov ecx, 9
mov col, 0
	l2:
	mov next, 2
	mov count, 1
	mov al, [esi]
	cmp al, 'X'
	je nocombointialized
	CMP AL, 'B'
	je nocombointialized
	movzx ebx, next
	add ebx, col
	cmp ebx, 8
	ja nocombointialized
		cmp al, [esi+1]
		jne nocombointialized
		inc count
		again:
		movzx ebx, next
			mov ah, [esi+ebx]
			inc next
			cmp al, ah
			jne endofrow
			 inc count
			 movzx ebx, next
			 add ebx, col
			 cmp ebx, 8
			 jbe again

		endofrow:
		cmp count, 3
		jb nocombointialized
			mov check, 1
			mov backswapCheck, 1
			mov mainCheck, 1
			push ecx
			mov ecx, count
			l3:
				mov al, '0'
				mov [esi], al
				inc col
				inc esi
			loop l3
			mov ebx, count
			add Score, ebx
			pop ecx
			dec count
			sub ecx, count
			;call PB_Level2
			;call waitmsg 
			;call waitmsg
			mov edx, offset crush
			call writestring
			call crlf
			call Drop2
			;call waitmsg
			jmp combointialized
		nocombointialized:
		inc esi
		inc col

	dec ecx
	cmp ecx, 0
JA l2

pop ecx
inc row
dec ecx
cmp ecx, 0
JA l1
;call crlf
;mov eax, sco
;call writedec
;call crlf

;movzx eax, check
;call writedec
;call crlf

;call PB_level1
;call waitmsg
;call Drop13
;call waitmsg

ret
RowCombo2 endp
Colcombo2 proc uses esi edi ecx
LOCAL row: Dword, col:Dword, count:DWORD , next:BYTE, sco:DWORD, check:BYTE

mov mainCheck, 0
combointialized:
;call PB_Level2
;call waitmsg
mov col, 0
mov sco, 0
mov check, 0
mov ecx, 9
;mov esi, offset Board
l1:
push ecx
mov esi, offset Board2
add esi, col
;movzx eax, row
;call writedec
mov ecx, 9
mov row, 0
	l2:
	mov next, 18
	mov count, 1
	mov al, [esi]
	cmp al, 'X'
	je nocombointialized
	CMP AL, 'B'
	je nocombointialized
	movzx ebx, next
	add ebx, row
	cmp ebx, 72d
	ja nocombointialized
		cmp al, [esi+9]
		jne nocombointialized
		inc count
		again:
		movzx ebx, next
			mov ah, [esi+ebx]
			add next, 9
			cmp al, ah
			jne endofrow
			 inc count
			 movzx ebx, next
			 add ebx, row
			 cmp ebx, 72d
			 jbe again

		endofrow:
		cmp count, 3
		jb nocombointialized
			mov check, 1
			Checks
			push ecx
			mov ecx, count
			l3:
				mov al, '0'
				mov [esi], al
				add row, 9
				add esi, 9		
			loop l3
			mov ebx, count
			add Score, ebx
			dec count
			pop ecx
			sub ecx, count
			;call PB_Level1
			mov edx, offset crush
			call writestring
			call crlf
			call Drop2
			;call waitmsg
			jmp combointialized
		nocombointialized:
		add esi, 9
		add row, 9
	
	dec ecx
	cmp ecx, 0
	JA l2

pop ecx
inc col
dec ecx
cmp ecx, 0
JA l1

;mov ebx, sco
;add Score, ebx

;call PB_level1
;call waitmsg
;call Drop13
;call waitmsg
ret

Colcombo2 endp
Drop2 proc uses esi edi ecx

local col:BYTE, row:BYTE, checkDrop: BYTE, Xcount:Byte



call Randomize

againmain:

;call PB_Level2 
;call waitmsg
	

;call crlf
mov edi, offset Board2
add edi, 3
mov ecx, 3
l3:
	mov al, [edi]
	cmp al, '0'
	jne notneedednew
	mov eax, 5
		call RandomRange
		add eax, 49
		mov [edi], al
		;mov al, [edi]
		;call Writechar
	notneedednew:
	inc edi
loop l3
;call crlf

mov Xcount, 1
mov col, 5
mov row, 9

mov CheckDrop, 0
mov esi, offset board2
add esi, 77d;poiting last element
;mov al, [esi]
;call writechar
mov ecx, 8
l1:
push ecx
;movzx eax, row
;call writedec
mov col, 5
mov ecx, 3
	l2:
	mov Xcount, 1
	mov al, [esi]
	;call writechar
	cmp al, '0'
	jne noDrop
	mov checkdrop, 1
		mov ah, [esi - 9]
		cmp ah, 'X'
		je uppertileX
			mov al, ah
			mov [esi], al
			mov ah, '0'
			mov [esi - 9], ah
			jmp Nodrop
		uppertileX:
		mov ebx, 18
		againX:
		 
			inc Xcount
			mov edi, esi
			sub edi, ebx
			mov ah, [edi]
			add ebx, 9
			cmp ah, 'X'
			je againX
				mov ax, 9
				mul Xcount
				movzx ebx, ax
				mov edi, esi
				sub edi, ebx
				mov ah, [edi]
				mov al, '0'
				mov [edi], al
				mov [esi], ah



	NoDrop:
	dec esi
	loop l2
;call crlf
pop ecx
dec row
sub esi, 6
;call PB_Level1
;call waitmsg
loop l1

;call Randomize
;call crlf
mov edi, offset Board2
add edi, 3
mov ecx, 3
l4:
	mov al, [edi]
	cmp al, '0'
	jne notneedednew1
	mov eax, 5
		call RandomRange
		add eax, 49
		mov [edi], al
		;mov al, [edi]
		;call Writechar
	notneedednew1:
	inc edi
loop l4
;call crlf



cmp Checkdrop, 0
jne againmain






againmain1:

;call PB_Level2 
;call waitmsg
	
;call Randomize
;call crlf
mov edi, offset Board2
add edi, 27
mov ecx, 9
l5:
	mov al, [edi]
	cmp al, '0'
	jne notneedednew2
	mov eax, 5
		call RandomRange
		add eax, 49
		mov [edi], al
		;mov al, [edi]
		;call Writechar
	notneedednew2:
	inc edi
loop l5
;call crlf

mov Xcount, 1
mov col, 5
mov row, 9

mov CheckDrop, 0
mov esi, offset board2
add esi, 53d;poiting last element
;mov al, [esi]
;call writechar
mov ecx, 2
l6:
push ecx
;movzx eax, row
;call writedec
mov col, 5
mov ecx, 9
	l7:
	mov Xcount, 1
	mov al, [esi]
	;call writechar
	cmp al, '0'
	jne noDrop1
	mov checkdrop, 1
		mov ah, [esi - 9]
		cmp ah, 'X'
		je uppertileX1
			mov al, ah
			mov [esi], al
			mov ah, '0'
			mov [esi - 9], ah
			jmp Nodrop1
		uppertileX1:
		mov ebx, 18
		againX1:
		 
			inc Xcount
			mov edi, esi
			sub edi, ebx
			mov ah, [edi]
			add ebx, 9
			cmp ah, 'X'
			je againX1
				mov ax, 9
				mul Xcount
				movzx ebx, ax
				mov edi, esi
				sub edi, ebx
				mov ah, [edi]
				mov al, '0'
				mov [edi], al
				mov [esi], ah



	NoDrop1:
	dec esi
	loop l7
;call crlf
pop ecx
dec row
;call PB_Level1
;call waitmsg
loop l6

;call Randomize
;call crlf
mov edi, offset Board2
add edi, 3
mov ecx, 3
l8:
	mov al, [edi]
	cmp al, '0'
	jne notneedednew3
	mov eax, 5
		call RandomRange
		add eax, 49
		mov [edi], al
		;mov al, [edi]
		;call Writechar
	notneedednew3:
	inc edi
loop l8
;call crlf



cmp Checkdrop, 0
jne againmain1

ret
Drop2 endp 







Input13 proc uses esi edi ecx
local temp:byte 

again:
mov edx, offset tstr1
call writestring
call Readdec
	cmp eax, 1
	jb again
	cmp eax, 100
	ja again
mov tile1, al
mov esi, offset board
add esi, eax
dec esi
mov al, [esi]
	cmp al, 'X'
	je again
mov edx, offset tstr2
call writestring
call Readdec
call crlf
	cmp eax, 1
	jb again
	cmp eax, 100
	ja again
mov tile2, al
mov temp, al
mov esi, offset board
add esi, eax
dec esi
mov al, [esi]
	cmp al, 'X'
	je again
mov dx, 0
movzx ax, tile1
mov bx, 10
DIV bx
cmp dl, 0
je tens
mov dx,0
movzx ax, tile2
mov bx, 10
DIV bx
cmp dl, 0
je tens


mov al, tile2
inc al
cmp tile1, al
je valid

	mov al, tile2
	dec al	
	cmp tile1, al
	je valid

		mov al, tile2
		add al, 10	
		cmp tile1, al
		je valid

			mov al, tile2
			sub al, 10	
			cmp tile1, al
			je valid
				JMP again

tens:
call swapfortens
mov al, tile2
	dec al	
	cmp tile1, al
	je valid

		mov al, tile2
		add al, 10	
		cmp tile1, al
		je valid

			mov al, tile2
			sub al, 10	
			cmp tile1, al
			je valid
				JMP again



valid:

dec tile1
dec tile2

ret
Input13 endp
Input1N proc uses esi edi ecx
local input:BYTE

;mov tile1, 0
;mov tile2, 0




while1:
movzx eax, tile1
push eax
call clearscr
call PH_tileS1 
;call waitmsg
;call PB_Level2
call crlf
mov edx, offset tstr1
call writeString 
call readchar
MOV input, al
cmp al, 'd'
jne next1
inc tile1
jmp last
	next1:
	cmp al, 's'
	jne next2
	add tile1, 10
	jmp last

	next2:
		cmp al, 'w'
		jne next3
		sub tile1, 10
		jmp last

		next3:
			cmp al, 'a'
			jne orE
			dec tile1
last:
movzx eax, tile1
call writedec
cmp tile1, 0
jb needed
cmp tile1, 99
ja needed
mov edi, offset board
movzx eax, tile1
add edi, eax
mov al, [edi]
cmp al, 'X'
jne noneed
needed:
pop eax
mov tile1, al


noneed:
orE:
;call clrscr
;call PH_tileS13



cmp input, 'e'
jne while1



again2:

call crlf
mov al, tile1
mov tile2, al 
mov edx, offset tstr2
call writeString 
call readchar
call crlf
MOV input, al
cmp al, 'd'
jne next11
inc tile2
jmp last1
	next11:
	cmp al, 's'
	jne next12
	add tile2, 10
	jmp last1

	next12:
		cmp al, 'w'
		jne next13
		sub tile2, 10
		jmp last1

		next13:
			cmp al, 'a'
			jne again2
			dec tile2

last1:
cmp tile2, 0
JB again2
cmp tile2, 99
JA again2
mov edi, offset board
movzx eax, tile2
add edi, eax
mov al, [edi]
cmp al, 'X'
je again2





call clearscr
call PH_tileD1

call IsValide13 
cmp ebx, 0
je while1

;call waitmsg

ret
Input1N endp
Input3N proc uses esi edi ecx
local input:BYTE

;mov tile1, 0
;mov tile2, 0




while1:
movzx eax, tile1
push eax
call clearscr
call PH_tileS3 
;call waitmsg
;call PB_Level2
call crlf
mov edx, offset tstr1
call writeString 
call readchar
MOV input, al
cmp al, 'd'
jne next1
inc tile1
jmp last
	next1:
	cmp al, 's'
	jne next2
	add tile1, 10
	jmp last

	next2:
		cmp al, 'w'
		jne next3
		sub tile1, 10
		jmp last

		next3:
			cmp al, 'a'
			jne orE
			dec tile1
last:
cmp tile1, 0
jb needed
cmp tile1, 99
ja needed
mov edi, offset board
movzx eax, tile1
add edi, eax
mov al, [edi]
cmp al, 'X'
jne noneed
needed:
pop eax
mov tile1, al


noneed:
orE:
;call clrscr
;call PH_tileS13



cmp input, 'e'
jne while1

again2:
call crlf
mov edx, offset tstr1
call writeString
movzx eax, tile1
call writedec
call crlf
mov al, tile1
mov tile2, al 
mov edx, offset tstr2
call writeString 
call readchar
call crlf
MOV input, al
cmp al, 'd'
jne next11
inc tile2
jmp last1
	next11:
	cmp al, 's'
	jne next12
	add tile2, 10
	jmp last1

	next12:
		cmp al, 'w'
		jne next13
		sub tile2, 10
		jmp last1

		next13:
			cmp al, 'a'
			jne again2
			dec tile2

last1:
cmp tile2, 0
JB again2
cmp tile2, 99
JA again2
mov edi, offset board
movzx eax, tile2
add edi, eax
mov al, [edi]
cmp al, 'X'
je again2





call clearscr
call PH_tileD3

call IsValide13 
cmp ebx, 0
je while1

;call waitmsg

ret
Input3N endp

IsValide13 proc uses esi edi ecx
local temp:byte 

inc tile1
inc tile2


mov dx, 0
movzx ax, tile1
mov bx, 10
DIV bx
cmp dl, 0
je tens
mov dx,0
movzx ax, tile2
mov bx, 10
DIV bx
cmp dl, 0
jne nottens


tens:
call swapfortens 
mov al, tile2
	dec al	
	cmp tile1, al
	je valid

		mov al, tile2
		add al, 10	
		cmp tile1, al
		je valid

			mov al, tile2
			sub al, 10	
			cmp tile1, al
			je valid
				JMP again


again:
mov edx, offset inV
call writestring
call crlf 
;call waitmsg
dec tile1
dec tile2
mov ebx, 0
mov eax, 6000
call delay
ret

valid:
nottens:

dec tile1
dec tile2
mov ebx, 1

ret
IsValide13 endp
swapfortens proc uses esi edi ecx


movzx ax, tile2
mov bx, 10
DIV bx
cmp dl, 0
je not_needed
mov al, tile2
mov ah, tile1
mov tile2, ah
mov tile1, al

not_needed:


ret
swapfortens endp
PH_tileS1 PROC uses esi edi ecx



Newline
mov edx, offset Lev1
call writestring
call crlf

mov edi, offset board
movzx eax, tile1
add edi, eax


mov esi, offset Board
mov ecx, 10
l1:
push ecx
mov ecx, 10
Newline
Line_Space
call crlf
Newline
mov edx, offset spcline
call writestring
	l2:
	cmp edi, esi
	je Highe
		mov al, [esi]
		;cmp al, '0'
		;jne notzero1
		;mov al, ' '
		;call writechar
		;notzero1:
			call Dis
		jmp simplecolor1
	Highe:
	Highlighttile red
	mov al, [esi]
	call Writechar
		simplecolor1:
		ChngColor White
		mov edx, offset spcline
		call writestring
		inc esi
	loop l2
call crlf
pop ecx
loop l1
Newline
Line_space
call crlf

mov edx, offset Namestr1
call writestring
mov edx, offset Nameply
call writestring
call crlf


mov edx, offset scorestr
call writestring

mov eax, Score
call Writedec
call crlf



mov edx, offset Movestr
call writestring

movzx eax, Moves
call Writedec
call crlf

ret
PH_tileS1 endp
PH_tileS3 PROC uses esi edi ecx



Newline
mov edx, offset Lev3
call writestring
call crlf

mov edi, offset board
movzx eax, tile1
add edi, eax


mov esi, offset Board
mov ecx, 10
l1:
push ecx
mov ecx, 10
Newline
Line_Space
call crlf
Newline
mov edx, offset spcline
call writestring
	l2:
	cmp edi, esi
	je Highe
		mov al, [esi]
		;cmp al, '0'
		;jne notzero1
		;mov al, ' '
		;call writechar
		;notzero1:
			call Dis
		jmp simplecolor1
	Highe:
	Highlighttile red
	mov al, [esi]
	call Writechar
		simplecolor1:
		ChngColor White
		mov edx, offset spcline
		call writestring
		inc esi
	loop l2
call crlf
pop ecx
loop l1
Newline
Line_space
call crlf

mov edx, offset Namestr1
call writestring
mov edx, offset Nameply
call writestring
call crlf


mov edx, offset scorestr
call writestring

mov eax, Score
call Writedec
call crlf



mov edx, offset Movestr
call writestring

movzx eax, Moves
call Writedec
call crlf

ret
PH_tileS3 endp

PH_tileD1 PROC uses esi edi ecx



Newline
mov edx, offset Lev1
call writestring
call crlf

mov edi, offset board
movzx eax, tile1
add edi, eax
mov ebx, offset board
movzx eax, tile2
add ebx, eax

mov esi, offset Board
mov ecx, 10
l1:
push ecx
mov ecx, 10
Newline
Line_Space
call crlf
Newline
mov edx, offset spcline
call writestring
	l2:
	cmp edi, esi
	je Highe
	cmp ebx, esi
	je highe
		mov al, [esi]
		;cmp al, '0'
		;jne notzero1
		;mov al, ' '
		;call writechar
		;notzero1:
			call Dis
		jmp simplecolor1
	Highe:
	Highlighttile red
	mov al, [esi]
	call Writechar
		simplecolor1:
		ChngColor White
		mov edx, offset spcline
		call writestring
		inc esi
	loop l2
call crlf
pop ecx
loop l1
Newline
Line_space
call crlf

mov edx, offset Namestr1
call writestring
mov edx, offset Nameply
call writestring
call crlf


mov edx, offset scorestr
call writestring

mov eax, Score
call Writedec
call crlf


mov edx, offset Movestr
call writestring

movzx eax, Moves
call Writedec
call crlf

ret
PH_tileD1 endp
PH_tileD3 PROC uses esi edi ecx



Newline
mov edx, offset Lev3
call writestring
call crlf

mov edi, offset board
movzx eax, tile1
add edi, eax
mov ebx, offset board
movzx eax, tile2
add ebx, eax

mov esi, offset Board
mov ecx, 10
l1:
push ecx
mov ecx, 10
Newline
Line_Space
call crlf
Newline
mov edx, offset spcline
call writestring
	l2:
	cmp edi, esi
	je Highe
	cmp ebx, esi
	je highe
		mov al, [esi]
		;cmp al, '0'
		;jne notzero1
		;mov al, ' '
		;call writechar
		;notzero1:
			call Dis
		jmp simplecolor1
	Highe:
	Highlighttile red
	mov al, [esi]
	call Writechar
		simplecolor1:
		ChngColor White
		mov edx, offset spcline
		call writestring
		inc esi
	loop l2
call crlf
pop ecx
loop l1
Newline
Line_space
call crlf


mov edx, offset Namestr1
call writestring
mov edx, offset Nameply
call writestring
call crlf


mov edx, offset scorestr
call writestring

mov eax, Score
call Writedec
call crlf


mov edx, offset Movestr
call writestring

movzx eax, Moves
call Writedec
call crlf

ret
PH_tileD3 endp




Input2 proc uses esi edi ecx
local input:BYTE

;mov tile1, 3
;mov tile2, 3




while1:
call clearscr
movzx eax, tile1
push eax
call PH_tileS2
;call PB_Level2
call crlf
mov edx, offset tstr1
call writeString 
call readchar
MOV input, al
cmp al, 'd'
jne next1
inc tile1
jmp last
	next1:
	cmp al, 's'
	jne next2
	add tile1, 9
	jmp last

	next2:
		cmp al, 'w'
		jne next3
		sub tile1, 9
		jmp last

		next3:
			cmp al, 'a'
			jne orE
			dec tile1
last:
cmp tile1, 0
jb needed
cmp tile1, 80
ja needed
mov edi, offset board2
movzx eax, tile1
add edi, eax
mov al, [edi]
cmp al, 'X'
jne noneed
needed:
pop eax
mov tile1, al


noneed:
orE:
call clearscr 
call PH_tileS2



cmp input, 'e'
jne while1

again2:

call crlf
mov edx, offset tstr1
call writeString
movzx eax, tile1
call writedec
call crlf
mov al, tile1
mov tile2, al 
mov edx, offset tstr2
call writeString 
call readchar
call crlf
MOV input, al
cmp al, 'd'
jne next11
inc tile2
jmp last1
	next11:
	cmp al, 's'
	jne next12
	add tile2, 9
	jmp last1

	next12:
		cmp al, 'w'
		jne next13
		sub tile2, 9
		jmp last1

		next13:
			cmp al, 'a'
			jne again2
			dec tile2

last1:
cmp tile2, 0
JB again2
cmp tile2, 80
JA again2
mov edi, offset board2
movzx eax, tile2
add edi, eax
mov al, [edi]
cmp al, 'X'
je again2





call clearscr 
call PH_tileD2

call IsValide2 
cmp ebx, 0
je while1



ret
Input2 endp
IsValide2 proc uses esi edi ecx
local temp:byte 

inc tile1
inc tile2


mov dx, 0
movzx ax, tile1
mov bx, 9
DIV bx
cmp dl, 0
je tens
mov dx,0
movzx ax, tile2
mov bx, 9
DIV bx
cmp dl, 0
jne nottens


tens:
call swapfornines
mov al, tile2
	dec al	
	cmp tile1, al
	je valid

		mov al, tile2
		add al, 9	
		cmp tile1, al
		je valid

			mov al, tile2
			sub al, 9	
			cmp tile1, al
			je valid
				JMP again


again:
mov edx, offset inV
call writestring
call crlf 

dec tile1
dec tile2
mov ebx, 0
mov ebx, 0
mov eax, 6000
call delay

ret

valid:
nottens:

dec tile1
dec tile2

ret
IsValide2 endp
swapfornines proc uses esi edi ecx


movzx ax, tile2
mov bx, 9
DIV bx
cmp dl, 0
je not_needed
mov al, tile2
mov ah, tile1
mov tile2, ah
mov tile1, al

not_needed:


ret
swapfornines endp
PH_tileS2 PROC uses esi edi ecx



Newline2
mov edx, offset Lev2
call writestring
call crlf

mov edi, offset board2
movzx eax, tile1
add edi, eax


mov esi, offset Board2
mov ecx, 9
l1:
push ecx
mov ecx, 9
Newline
Line_Space
call crlf
Newline2
mov edx, offset spcline
call writestring
	l2:
	cmp edi, esi
	je Highe
		mov al, [esi]
		;cmp al, '0'
		;jne notzero1
		;mov al, ' '
		;call writechar
		;notzero1:
			call Dis
		jmp simplecolor1
	Highe:
	Highlighttile red
	mov al, [esi]
	call Writechar
		simplecolor1:
		ChngColor White
		mov edx, offset spcline
		call writestring
		inc esi
	loop l2
call crlf
pop ecx
loop l1
Newline
Line_space
call crlf

mov edx, offset Namestr1
call writestring
mov edx, offset Nameply
call writestring
call crlf


mov edx, offset scorestr
call writestring

mov eax, Score
call Writedec
call crlf


mov edx, offset Movestr
call writestring

movzx eax, Moves
call Writedec
call crlf

ret
PH_tileS2 endp
PH_tileD2 PROC uses esi edi ecx



Newline2
mov edx, offset Lev2
call writestring
call crlf

mov edi, offset board2
movzx eax, tile1
add edi, eax
mov ebx, offset board2
movzx eax, tile2
add ebx, eax

mov esi, offset Board2
mov ecx, 9
l1:
push ecx
mov ecx, 9
Newline
Line_Space
call crlf
Newline2
mov edx, offset spcline
call writestring
	l2:
	cmp edi, esi
	je Highe
	cmp ebx, esi
	je highe
		mov al, [esi]
		;cmp al, '0'
		;jne notzero1
		;mov al, ' '
		;call writechar
		;notzero1:
			call Dis
		jmp simplecolor1
	Highe:
	Highlighttile red
	mov al, [esi]
	call Writechar
		simplecolor1:
		ChngColor White
		mov edx, offset spcline
		call writestring
		inc esi
	loop l2
call crlf
pop ecx
loop l1
Newline
Line_space
call crlf


mov edx, offset Namestr1
call writestring
mov edx, offset Nameply
call writestring
call crlf


mov edx, offset scorestr
call writestring

mov eax, Score
call Writedec
call crlf




mov edx, offset Movestr
call writestring

movzx eax, Moves
call Writedec
call crlf


ret
PH_tileD2 endp

   





IsBomb13 proc uses esi edi ecx

mov esi, offset Board
movzx eax, tile1
add esi, eax
mov al, [esi]
cmp al, 'B'
jne Secondtilecheck
mov ebx, 1
mov reftile, esi
mov esi, offset Board
movzx eax, tile2
add esi, eax
mov al, [esi]
mov bombtile, al
ret

Secondtilecheck:
mov esi, offset Board
movzx eax, tile2
add esi, eax
mov al, [esi]
cmp al, 'B'
jne noBomb
mov ebx, 1
mov reftile, esi
mov esi, offset Board
movzx eax, tile1
add esi, eax
mov al, [esi]
mov bombtile, al
ret



noBomb:
mov bombtile, '0'
mov ebx, 0
ret
IsBomb13 endp
IsBomb2 proc uses esi edi ecx

mov esi, offset Board2
movzx eax, tile1
add esi, eax
mov al, [esi]
cmp al, 'B'
jne Secondtilecheck
mov ebx, 1
mov reftile, esi
mov esi, offset Board2
movzx eax, tile2
add esi, eax
mov al, [esi]
mov bombtile, al
ret



Secondtilecheck:
mov esi, offset Board2
movzx eax, tile2
add esi, eax
mov al, [esi]
cmp al, 'B'
jne noBomb
mov ebx, 1
mov reftile, esi
mov esi, offset Board2
movzx eax, tile1
add esi, eax
mov al, [esi]
mov bombtile, al
ret



noBomb:
mov bombtile, '0'
mov ebx, 0
ret
IsBomb2 endp



PH_Bomb1 PROC uses esi edi ecx
mov bl, bombtile

Newline
mov edx, offset Lev1
call writestring
call crlf



mov esi, offset Board
mov ecx, 10
l1:
push ecx
mov ecx, 10
Newline
Line_Space
call crlf
Newline
mov edx, offset spcline
call writestring
	l2:
	mov al, [esi]
	cmp al, bl
	je Highe
		mov al, [esi]
		cmp al, '0'
		jne notzero1
		mov al, ' '
		call writechar
		notzero1:
			call Dis
		jmp simplecolor1
	Highe:
	Highlighttile red
	mov al, [esi]
	call Writechar
		simplecolor1:
		ChngColor White
		mov edx, offset spcline
		call writestring
		inc esi
	loop l2
call crlf
pop ecx
loop l1
Newline
Line_space
call crlf

mov edx, offset Namestr1
call writestring
mov edx, offset Nameply
call writestring
call crlf


mov edx, offset scorestr
call writestring

mov eax, Score
call Writedec
call crlf


mov edx, offset Movestr
call writestring

movzx eax, Moves
call Writedec
call crlf



ret
PH_Bomb1 endp
PH_Bomb3 PROC uses esi edi ecx
mov bl, bombtile

Newline
mov edx, offset Lev3
call writestring
call crlf



mov esi, offset Board
mov ecx, 10
l1:
push ecx
mov ecx, 10
Newline
Line_Space
call crlf
Newline
mov edx, offset spcline
call writestring
	l2:
	mov al, [esi]
	cmp al, bl
	je Highe
		mov al, [esi]
		cmp al, '0'
		jne notzero1
		mov al, ' '
		call writechar
		notzero1:
			call Dis
		jmp simplecolor1
	Highe:
	Highlighttile red
	mov al, [esi]
	call Writechar
		simplecolor1:
		ChngColor White
		mov edx, offset spcline
		call writestring
		inc esi
	loop l2
call crlf
pop ecx
loop l1
Newline
Line_space
call crlf


mov edx, offset Namestr1
call writestring
mov edx, offset Nameply
call writestring
call crlf



mov edx, offset scorestr
call writestring

mov eax, Score
call Writedec
call crlf

mov edx, offset Movestr
call writestring

movzx eax, Moves
call Writedec
call crlf


ret
PH_Bomb3 endp

Crush_bomb13 proc uses esi edi ecx

mov esi,offset board
mov ecx, 10
mov bl, bombtile
;mov ebx, 1


mov edx, offset explosion
call writestring
call crlf


l1:
push ecx
mov ecx, 10
	l2:
		mov al, [esi]
		cmp al, bl
		jne noneed
			mov al, '0'
			mov [esi], al
			add Score, 1
		noneed:
		inc esi
	loop l2
pop ecx
loop l1

;call PB_level3

mov esi, reftile
mov eax, 5
call RandomRange	
add eax, 49
mov [esi], al

;call PB_level3
;call waitmsg

ret
Crush_bomb13 endp

Crush_bomb2 proc uses esi edi ecx

mov esi,offset board2
mov ecx, 9
mov bl, bombtile
;mov ebx, 1

mov edx, offset explosion
call writestring
call crlf


l1:
push ecx
mov ecx, 9
	l2:
		mov al, [esi]
		cmp al, bl
		jne noneed
			mov al, '0'
			mov [esi], al
			add Score, 1
		noneed:
		inc esi
	loop l2
pop ecx
loop l1


mov esi, reftile
mov eax, 4
call RandomRange	
add eax, 49
mov [esi], al
			

ret
Crush_bomb2 endp
PH_Bomb2 PROC uses esi edi ecx
mov bl, bombtile

Newline2
mov edx, offset Lev2
call writestring
call crlf



mov esi, offset Board2
mov ecx, 9
l1:
push ecx
mov ecx, 9
Newline
Line_Space
call crlf
Newline2
mov edx, offset spcline
call writestring
	l2:
	mov al, [esi]
		cmp al, bl
		je Highe
			mov al, [esi]
			cmp al, '0'
			jne notzero1
			mov al, ' '
			call writechar
			notzero1:
				call Dis
			jmp simplecolor1
		Highe:
			Highlighttile red
			mov al, [esi]
			call Writechar
		simplecolor1:
			ChngColor White
			mov edx, offset spcline
			call writestring
	inc esi
	loop l2
call crlf
pop ecx
loop l1
Newline
Line_space
call crlf


mov edx, offset Namestr1
call writestring
mov edx, offset Nameply
call writestring
call crlf


mov edx, offset scorestr
call writestring

mov eax, Score
call Writedec
call crlf


mov edx, offset Movestr
call writestring

movzx eax, Moves
call Writedec
call crlf


ret
PH_Bomb2 endp







END main