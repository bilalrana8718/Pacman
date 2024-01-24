INCLUDE Irvine32.inc
INCLUDE macros.inc
includelib winmm.lib
.386 
.MODEL flat, stdcall
.stack 4096

ExitProcess PROTO, dwExitCode:DWORD
PlaySound PROTO, pszSound:PTR BYTE, hmod:DWORD, fdwSound:DWORD

.data

ground_width = 82
BUFFER_SIZE = 1000

pacman_emo		BYTE "                                                                                        ",0
				BYTE "                                                                                        ",0
				BYTE "         ///////         //         //////  //      //      //      //       //         ",0
				BYTE "         //     //     //  //      //    // ////  ////    //  //    ////     //         ",0	
				BYTE "         //       // //      //   //        // //// //  //      //  // //    //         ",0
				BYTE "         //     //  //        // //         //  //  // //        // //  //   //         ",0
				BYTE "         ///////    //////////// //         //      // //////////// //   //  //         ",0
				BYTE "         //         //        //  //        //      // //        // //    // //         ",0
				BYTE "         //         //        //   //    // //      // //        // //     ////         ",0
				BYTE "         //         //        //    //////  //      // //        // //       //         ",0
				BYTE "                                                                                        ",0
				BYTE "                                                                                        ",0

inArray			BYTE "                                                                                 ",0
				BYTE "                                                                                 ",0
				BYTE "                                 INSTURCTIONS                                    ",0
				BYTE "                                                                                 ",0
				BYTE "        Use <i> for Up Move                        Use <K> for Down Move         ",0
				BYTE "                                                                                 ",0
				BYTE "        Use <j> for Left Move                      Use <l> for Right Move        ",0
				BYTE "                                                                                 ",0
				BYTE "        You have to move the Player <&> and eat all the food in the Maze         ",0
				BYTE "        You have to Protect yourself from the enemy in the red coats as          ",0
				BYTE "        they are after you. YOU WILL GET 3 LIVES                                 ",0
				BYTE "                                                                                 ",0
				BYTE "        START GAME <s>                               EXIT GAME <x>               ",0
				BYTE "                                                                                 ",0
				BYTE "                                                                                 ",0

ground1   		BYTE "|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||",0
				BYTE "|                                                                               |",0
				BYTE "|    |||||||||||||||||||||||||||||||||||||   |||||||||||||||||||||||||||||||    |",0
				BYTE "|    ||             ||                         ||              ||         ||    |",0
				BYTE "|    ||             ||             ||          ||              ||         ||    |",0
				BYTE "|    ||             ||             ||          ||              ||    |||||||    |",0
				BYTE "|    |||||||||      ||             ||          ||         |||||||    ||         |",0
				BYTE "|           ||      ||      |||||||||          |||||||    ||         ||         |",0
				BYTE "|           ||      ||      |||||||||          ||   ||    ||         |||||||    |",0
				BYTE "|           ||      ||      ||     ||          ||   ||    ||                    |",0
				BYTE "|                                         X                                     |",0
				BYTE "|    |||||||||||||||||||||||||||  ||||||||||||||||||||||   |||||||||||  |||||||||",0
				BYTE "|                                 ||                  ||   ||                   |",0
				BYTE "|    ||                       ||  ||                  ||   ||           ||      |",0
				BYTE "|    ||                       ||  ||                  ||   ||           ||      |",0
				BYTE "|    ||||||||||||||     ||||||||         |||||||||||||||   ||||||||||   ||||||  |",0
				BYTE "|         |||||||||     ||||||||         ||                                 ||  |",0
				BYTE "|         ||     ||           ||         |||||||||                ||||||||||||  |",0
				BYTE "||||||||||||     ||  X        ||      |||||                       ||            |",0
				BYTE "|                ||||||||     ||      ||        |||||||||  ||     ||            |",0
				BYTE "|                      ||     ||      ||        ||         ||     ||            |",0
				BYTE "|||||||                ||                       ||         ||     |||||||||     |",0
				BYTE "|    ||                ||                       ||         ||            ||     |",0
				BYTE "|    ||        ||||||||||          |||||||||||||||         ||                   |",0
				BYTE "|    ||                            ||                      |||||||||||||||||||  |",0
				BYTE "|    ||                            ||                      ||                   |",0
				BYTE "|    ||||||||||||||||||||          ||    ||||||||||||||||||||                   |",0
				BYTE "|                                  ||                                          X|",0
				BYTE "|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||",0

ground2			BYTE "|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||",0
				BYTE "|                               ||                    ||                        |",0
				BYTE "| | ||||||||||||||||||||||||||| ||  ||||||||||||||||| || ||||||||||||| |||||||| |",0
				BYTE "| |            X                ||                 ||X||                      | |",0
				BYTE "| |||||||||||||||||||||||           ||||||||||||||||| || |||||||||||||||||||||| |",0
				BYTE "|                                   ||||| |||    ||                             |",0
			    BYTE "|              |||||||||||||||||||||||||| |||    ||                             |",0
				BYTE "|||||||||||||| || ||                ||||| |||    || |||||||||||||||||||||||||||||",0
				BYTE "|||                        ||                    ||                            ||",0
				BYTE "||| |||||||||||||||||||||||||||  | ||||||||||||||||   || ||||||||||||||||||||| ||",0
				BYTE "|||                              |        L      ||   ||                       ||",0
				BYTE "||| |||||||||||||||||||||||||||  ||||||||||||||||||   || ||||||||||||||||||||||||",0
				BYTE "|                           ||                   ||                             |",0
				BYTE "| ||                     ||      ||                      ||                     |",0
				BYTE "| |||||||||||||||||||||||||||||| ||||||||||||||||||||||| |||||||||||||||||||||| |",0
				BYTE "| |                               ||                                          | |",0
				BYTE "| | ||||||||||||||||||||||||||||  ||||||||||||||||||| || |||||||||||||||||||  | |",0
				BYTE "| |                        ||                    ||||                         | |",0
				BYTE "| |||||||||||||||||||||||         |||||||||||||| |||| ||||||||||||||||||||||| | |",0
				BYTE "|               X                 ||                  ||                        |",0
				BYTE "| ||||||||||||||||||||||||||||||  ||                  ||                        |",0
				BYTE "| |||||||||||||||||||||||         ||||||||||||||||||| ||||||||||||||||||||||||| |",0
				BYTE "| |                               ||                  ||                        |",0
				BYTE "| |           ||||||||||||||||||| ||            ||    ||                     || |",0
				BYTE "||||||||||||||||||||||||||||||||| |||||||||||||||| |||||||||||||||||||||||||||| |",0
				BYTE "|                                 ||                  ||                        |",0
				BYTE "| ||||||||||||||||||||||||||||||| ||||||||||||||||||| || |||||||||||||||||||||| |",0
				BYTE "|                                           X         ||                        |",0
				BYTE "|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||",0

ground3			BYTE "|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||",0
				BYTE "|              X                  ||                                           ||",0
				BYTE "| | ||||||||||||||||||||||||||||  || |||||||||||||||| || |||||||||||||||||||   ||",0
				BYTE "| |                        ||                    ||||                          ||",0
				BYTE "| |||||||||||||||||||||||         |||||||||||||| |||| || ||||||||||||||||||||||||",0
				BYTE "                                  ||                  ||                        |",0
				BYTE "||||||||||||| ||||||||||||||||||  ||                  ||                        |",0
				BYTE "||||||||||||| |||||||||||         ||||||||||||||||||| ||||||||||||||||||||||||| |",0
				BYTE "|                                 ||                  ||                        |",0
				BYTE "| |           ||||||||||||||||||| ||            ||    ||                     || |",0
				BYTE "| ||||||||||||||||||||||||||||||| |||||||||||||||| |||||||||||||||||||||||||||| |",0
				BYTE "|                                 ||                  ||             X          |",0
				BYTE "| ||||||||||||||||||||||||||||||| ||||||||||||||||||| || |||||||||||||||||||||| |",0
				BYTE "|                                             X       ||                        |",0
				BYTE "| ||||||||||||||||||||||||||||| |||||||||||||||||||||||| |||||||||||||||||||||| |",0
				BYTE "|                               ||                    ||                        |",0
				BYTE "| | ||||||||||||||||||||||||||| || |||||||||||||||||| || ||||||||||||| |||||||| |",0
				BYTE "| |                             ||                 || ||                      | |",0
				BYTE "| |||||||||||||||||||||||           ||||||||||||||||| || |||||||||||||||||||||| |",0
				BYTE "|                                      ||L|||    ||                              ",0
			    BYTE "|              ||||||||||| || ||||||||||| |||    ||                              ",0
				BYTE "|||||||||||||| || ||                ||||| |||    || ||||||||||||||||||||||||||| |",0
				BYTE "|||                        ||                    ||                          || |",0
				BYTE "||| ||||||||||||||||||||||||||| || ||||||||||||||||   || |||||||||||||||||||||| |",0
				BYTE "|||              X              ||               ||   ||                     || |",0
				BYTE "||| ||||||||||||||||||||||||||| |||||||||||||||||||   || ||||| |||||||||||||||| |",0
				BYTE "|                           ||                   ||                             |",0
				BYTE "|   ||                      ||      ||                      ||                  |",0
				BYTE "|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||",0
         
				
ground			DD ?
level			BYTE 1
level_once		BYTE 0
coins			BYTE 0

strScore		BYTE "SCORE: ",0
;score			BYTE 32
str2			dd 'scop',0


xPos			BYTE 3
yPos			BYTE 8

xCoinPos		BYTE ?
yCoinPos		BYTE ?

inputChar		BYTE ?
moveKey			BYTE ?
index			DD	 ?

strlives		BYTE "LIVES: ",0
lives			BYTE 3

x_enemy1		BYTE 43
y_enemy1		BYTE 12
last_e1			BYTE " "
move_e1			BYTE 4

x_enemy2		BYTE 78
y_enemy2		BYTE 1
last_e2			BYTE " "
move_e2			BYTE 3

x_enemy3		BYTE 1
y_enemy3		BYTE 1
last_e3			BYTE " "
move_e3			BYTE 4

x_enemy4		BYTE 78
y_enemy4		BYTE 27
last_e4			BYTE " "
move_e4			BYTE 4

x_enemy5		BYTE 24
y_enemy5		BYTE 13
last_e5			BYTE " "
move_e5			BYTE 4

Xen				BYTE ?
Yen				BYTE ?
LastEn			BYTE ?		
MoveEN			BYTE ?

PlayerStr		BYTE "Player Name : ", 0

pl				BYTE '&'

game_speed		BYTE 70


;/////

buffer BYTE BUFFER_SIZE DUP(?), 0
filename    BYTE "writingfile.txt",0
fileHandle  HANDLE ?

buffer2 BYTE BUFFER_SIZE Dup(?), 0

PlayerName BYTE 20 dup (0), 0
plSize BYTE 0
score BYTE 0
score2 BYTE ?
remainder BYTE ?

scoreStr BYTE 4 dup(?), 0

counter DD ?
helc dd 0
boolScore BYTE 0
boolpl BYTE 0

deviceConnect BYTE "pacman_beginning.wav", 0
SND_ALIAS    DWORD 00010000h
SND_RESOURCE DWORD 00040005h
SND_FILENAME DWORD 00020000h
file BYTE "t.wav", 0



;/////

.code
; ////////////////////////////////////////////////////////////
;                   MAIN PROC
main PROC
	
STARTINGSCREEN: 
	mov eax, brown + (black * 16)
	call Clrscr
	call SetTextColor
	call Drawpacman
	
	mov dl,41
	mov dh,25
	call Gotoxy
	mov edx, OFFSET PlayerStr
	call writeString

	mov eax, lightred + (black * 16)
	call SetTextColor
	mov edx, OFFSET PlayerName
	mov ecx, 20
	call readString
;	INVOKE PlaySound, OFFSET deviceConnect, NULL, SND_ALIAS

MenuScreen:
	mov eax, brown + (black * 16)
	call Clrscr
	call SetTextColor
	mov dl,50
	mov dh,10
	call Gotoxy
	mWrite <"START <s>",0dh,0ah>
	mov dh,12
	call Gotoxy
	mWrite <"Change PLayer <c>",0dh,0ah>
	mov dh,14
	call Gotoxy
	mWrite <"INSTRUCTION <i>",0dh,0ah>
	mov dh,16
	call Gotoxy
	mWrite <"LEADERBOARD <l>",0dh,0ah>
	mov dh,18
	call Gotoxy
	mWrite <"EXIT <x>",0dh,0ah>

	mov eax, 0
	call readchar

	cmp al, 's'
	je MAINSCREEN
	cmp al, 'c'
	je Change_Player
	cmp al, 'i'
	je Instruct
	cmp al, 'l'
	je Lead
	cmp al, 'x'
	je exitGame

	jmp MAINSCREEN

Lead:
    call DisplayLead
	call crlf
	call waitmsg
	jmp MenuScreen
Instruct:
	call InstructionScreen
	cmp al, 'x'
	je exitGame

	jmp MAINSCREEN

Change_Player:
	mov eax, lightred + (black * 16)
	call Clrscr
	call SetTextColor
	mov dl,41
	mov dh,15
	call Gotoxy
	mWrite <"Enter the character: ">

	mov eax, lightred + (black * 16)
	call SetTextColor
	call readChar
 	call writeChar

	mov pl, al

	mov dl, 20
	mov dh,24
	call Gotoxy
	mWrite <"START GAME <s>",0dh,0ah>

	mov dl, 60
	mov dh,24
	call Gotoxy
	mWrite <"BACK <b>",0dh,0ah>

	call readChar
	
	cmp al, 's'
	je MAINSCREEN
	cmp al, 'b'
	je MenuScreen

MAINSCREEN:
	mov eax, brown +(black * 16)
	call Clrscr
	call SetTextColor

	call SelectLevel
	call DrawSideWall
	call DrawPlayer

	mov eax, yellow +(black * 16)
	call SetTextColor
	call Randomize
	call DrawCoin

	cmp level, 2
	jl gameloop
	mov eax, lightgreen +(lightgreen * 16)
	call SetTextColor
	call DrawFruit

	;; START OF THE GAME LOOP
	gameLoop:                      

		mov eax, brown +(black * 16)
		call SetTextColor
		
	; draw score:
		mov dl,90
		mov dh,2
		call Gotoxy
		mov edx,OFFSET strScore
		call WriteString
		mov al,score
		call WriteInt

		mov dl, 90
		mov dh, 6
		call Gotoxy
		mWrite <"LEVEL: ">
		mov al, level
		call WriteInt

		mov dl, 90
		mov dh, 4
		call Gotoxy
		mov edx,OFFSET strlives
		call WriteString
		mov al, lives
		call WriteInt

		

	onGround:
	cmp coins, 1
	je MAINSCREEN
	cmp level,4 
	je exitGame


	;; game speed
	movzx eax, game_speed
	call delay

	call livescheck
	cmp lives, 0
	je exitGame
		
	
	; Enemy Movement
	cmp moveKey, 5
	je characterInput
	call AllEnemies
	
	

	;;player color
		mov eax,  lightgreen + (black * 16)
		call SetTextColor

		mov bl, moveKey
		call movements
		call teleport
	
	characterInput:
	; get user key input:
		call Readkey
		jz gameLoop 
		mov inputChar,al

		cmp inputChar,"x"
		je exitGame

		cmp inputChar,"i"
		je moveUp

		cmp inputChar,"k"
		je moveDown

		cmp inputChar,"j"
		je moveLeft

		cmp inputChar,"l"
		je moveRight

		cmp inputChar,"p"
		je pauses

		
	moveUp:
		mov moveKey, 0
		;call upMove
		jmp gameLoop
	moveDown:
		mov moveKey, 1
		;call downMove
		jmp gameLoop
	moveLeft:
		mov moveKey, 2
		;call leftMove
		jmp gameLoop
	moveRight:
		mov moveKey, 3
		;call rightMove
		jmp gameLoop
	pauses:
		mov moveKey, 5
		jmp gameLoop
	

	jmp gameLoop

	exitGame:
	

	call clearScreen
	call EndScreen
	;INVOKE PlaySound, OFFSET deviceConnect, NULL, SND_ALIAS

	call FilesWork


	exit
main ENDP

; ////////////////////////////////////////////////////////////////
;               PLAYER PROCS

movements PROC
	cmp bl, 0
	jne over1
	call upMove
	over1:
	cmp bl, 1
	jne over2
	call downMove
	over2:
	cmp bl, 2
	jne over3
	call leftMove
	over3:
	cmp bl, 3
	jne over4
	call rightMove
	over4:

	RET
movements ENDP

teleport PROC
	cmp xPos, 0
	jne over1
	call UpdatePlayer
	mov xPos, 80
	mov yPos, 20
	call DrawPlayer
	RET
	over1:
	cmp xPos, 80
	jne over2
	call UpdatePlayer
	mov xPos, 1
	mov yPos, 5
	call DrawPlayer
	over2:
	RET
teleport ENDP

upMove PROC
		call UpdatePlayer
		dec yPos
		call checkPoint
		call checkob
		call power_up
		call checkPosition
		jz Up_con 
		jmp up_bound
	Up_con:
		inc yPos
	up_bound:
		call DrawPlayer
	ret
upMove ENDP

downMove PROC
	call UpdatePlayer
		inc yPos
		call checkPoint
		call checkob
		call power_up
		call checkPosition
		jz Down_con
		jmp out_bound  
	Down_con:
		dec yPos
	out_bound:
		call DrawPlayer
RET
downMove ENDP

leftMove PROC
		call UpdatePlayer
		dec xPos
		call checkPoint
		call checkob
		call power_up
		call checkPosition
		jz Left_con
		jmp Left_Bound
	Left_con:
		inc xPos
	Left_Bound:
		call DrawPlayer
RET
leftMove ENDP

rightMove PROC
		call UpdatePlayer
		inc xPos
		call checkPoint
		call checkob
		call power_up
		call checkPosition
		jz Right_con		
		jmp RIGHT_Bound
	Right_con:
		dec xPos
	RIGHT_Bound:
		call DrawPlayer
RET
rightMove ENDP

clearScreen PROC
	mov eax,  brown +(black * 16)
	call Clrscr
	call SetTextColor
clearScreen ENDP

DrawPlayer PROC
	mov edi, ground
	movzx edx, yPos
    imul edx, ground_width
	movzx eax, xPos
    add edx, eax
	add edi, edx
	mov al,pl
    mov [edi], al

	
	mov dl,xPos
	mov dh,yPos
	call Gotoxy  
	call WriteChar
	ret
DrawPlayer ENDP

UpdatePlayer PROC 
mov edi, ground
	movzx edx, yPos
    imul edx, ground_width
    movzx eax, xPos
    add edx, eax
	add edi, edx
	mov al," "
    mov [edi], al
	
	mov dl,xPos
	mov dh,yPos
	call Gotoxy 
	mov al," "
	call WriteChar
	ret
UpdatePlayer ENDP

DrawCoin PROC
	mov ecx, 10
l1:
CoinCreation:
	call CreateRandomCoin
	mov edi, ground
    movzx edx, yCoinPos
    imul edx, ground_width
    movzx eax, xCoinPos
    add edx, eax
	add edi, edx
	mov al, [edi]
	cmp al, '|'
	je CoinCreation
	inc coins
    mov al, 'O'
    mov [edi], al

    mov dl, xCoinPos
    mov dh, yCoinPos
    call Gotoxy
    call WriteChar
loop l1
	ret
DrawCoin ENDP

CreateRandomCoin PROC
	mov eax,78
	inc eax
	call RandomRange
	mov xCoinPos,al
	inc xCoinPos
	mov eax,26
	inc eax
	call RandomRange
	mov yCoinPos,al
	inc yCoinPos
	ret
CreateRandomCoin ENDP

DrawSideWall PROC
mov ecx, 29
	mov edi, 0
	mov edx, ground
l1:
	call WriteString
	call crlf
	add edx, ground_width
	mov eax, 50
	call delay
loop l1
ret
DrawSideWall ENDP

Drawpacman PROC
	mov ecx, 12
	mov ebx, 8
	mov edx, OFFSET pacman_emo
	mov edi, OFFSET pacman_emo
	
l1:
	mov dl,16
	mov dh, bl
	call Gotoxy
	;mov ecx, 89
	mov edx, edi
	call WriteString
	add edx, 89
	mov edi, edx
	inc ebx
	mov eax, 100
	call delay
loop l1
ret
Drawpacman ENDP


checkPosition PROC
    mov edi, ground
	movzx edx, yPos
    imul edx, ground_width
	movzx eax, xPos
    add edx, eax
	add edi, edx
    mov al, [edi]

   
    cmp al, '|'
    jne validMove
ret
validMove:
	or al, 0
ret

checkPosition ENDP

checkPoint PROC
   mov edi, ground
	mov edx, 0
    mov dl, yPos
    imul edx, ground_width
	movzx eax, xPos
    add edx, eax
	add edi, edx
    mov al, [edi]

    cmp al, 'O'
    jne validMove
	;INVOKE PlaySound, OFFSET deviceConnect, NULL, SND_ALIAS
	inc score
	dec coins
    ret
validMove:
	cmp al, 'F'
	jne validMove2
	add score, 5

validMove2:
    stc
ret
checkPoint ENDP

checkob PROC
   mov edi, ground
	mov edx, 0
    mov dl, yPos
    imul edx, ground_width
	movzx eax, xPos
    add edx, eax
	add edi, edx
    mov al, [edi]

    cmp al, 'X'
    jne validMove
	dec lives
	dec score
    ret
validMove:
ret
checkob ENDP

power_up PROC
   mov edi, ground
	mov edx, 0
    mov dl, yPos
    imul edx, ground_width
	movzx eax, xPos
    add edx, eax
	add edi, edx
    mov al, [edi]

    cmp al, 'L'
    jne validMove
	inc lives
	sub score,5
    ret
validMove:
ret
power_up ENDP

livescheck PROC
	mov bl, xPos
	cmp bl, x_enemy1
	jne over1
	mov bl, yPos
	cmp bl, y_enemy1
	jne over1
	dec lives
	call UpdatePlayer
	mov last_e1, ' '
	mov xPos, 1
	mov yPos, 1
	call DrawPlayer
	over1:

	mov bl, xPos
	cmp bl, x_enemy2
	jne over2
	mov bl, yPos
	cmp bl, y_enemy2
	jne over2
	dec lives
	call UpdatePlayer
	mov last_e2, ' '
	mov xPos, 1
	mov yPos, 1
	call DrawPlayer
	over2:

	mov bl, xPos
	cmp bl, x_enemy3
	jne over3
	mov bl, yPos
	cmp bl, y_enemy3
	jne over3
	dec lives
	call UpdatePlayer
	mov last_e3, ' '
	mov xPos, 1
	mov yPos, 1
	call DrawPlayer
	over3:

	cmp level, 3
	jne over_end

	mov bl, xPos
	cmp bl, x_enemy4
	jne over4
	mov bl, yPos
	cmp bl, y_enemy4
	jne over4
	dec lives
	call UpdatePlayer
	mov last_e4, ' '
	mov xPos, 1
	mov yPos, 1
	call DrawPlayer
	over4:

	mov bl, xPos
	cmp bl, x_enemy5
	jne over5
	mov bl, yPos
	cmp bl, y_enemy5
	jne over5
	dec lives
	call UpdatePlayer
	mov last_e5, ' '
	mov xPos, 1
	mov yPos, 1
	call DrawPlayer
	over5:
	over_end:
ret
livescheck ENDP


;///////////////////////////////////////////////////////////
;             ENEMY PROCS
;///////////////////////////////////////////////////////////

checkPosition_e PROC uses edi edx eax
mov edi, ground
	movzx edx, Yen
    imul edx, ground_width
	movzx eax, Xen
    add edx, eax
	add edi, edx
    mov al, [edi]

   
    cmp al, '|'
    jne validMove
ret
validMove:
	or al, 0
ret

checkPosition_e ENDP

DrawEnemy PROC uses edi edx eax
mov edi, ground
	movzx edx, Yen
    imul edx, ground_width
	movzx eax, Xen
    add edx, eax
	add edi, edx
	mov al, [edi]

	cmp al, 'E'
	je over1
	mov LastEn, al
	jmp over2
	over1:
	mov LastEn, " "
	over2:
	mov al,"E"
    mov [edi], al

	mov dl,Xen
	mov dh,Yen
	call Gotoxy  
	call WriteChar
	ret
DrawEnemy ENDP

UpdateEnemy PROC uses edi edx eax
mov edi, ground
	movzx edx, Yen
    imul edx, ground_width
	movzx eax, Xen
    add edx, eax
	add edi, edx
	mov al, LastEn
	cmp al,pl
	jne cover1
	mov al,' '
	cover1:
    mov [edi], al
	
	mov dl,Xen
	mov dh,Yen
	call Gotoxy 
	mov al,LastEn
	cmp al,pl
	jne cover2
	mov al,' '
	cover2:
	call WriteChar
	ret
UpdateEnemy ENDP

upMove_e PROC
		mov eax,  yellow +(black * 16)
		call SetTextColor

		call UpdateEnemy
		dec Yen
		call checkPosition_e
		jz Up_con 
		cmp Yen, 0
		jg up_bound
	Up_con:
		inc Yen
		mov eax, 4
		call RandomRange
		inc al
		mov MoveEN, al
	up_bound:
		mov eax,  red +(red * 16)
		call SetTextColor

		call DrawEnemy
	ret
upMove_e ENDP

downMove_e PROC
		mov eax,  yellow +(black * 16)
		call SetTextColor

		call UpdateEnemy
		inc Yen
		call checkPosition_e
		jz Up_con 
		cmp Yen, 0
		jg up_bound
	Up_con:
		dec Yen
		mov eax, 4
		call RandomRange
		inc al
		mov MoveEn, al
	up_bound:
		mov eax,  red +(red * 16)
		call SetTextColor
		call DrawEnemy
	ret
downMove_e ENDP

leftMove_e PROC
	mov eax,  yellow +(black * 16)
		call SetTextColor
		call UpdateEnemy

		dec Xen
		call checkPosition_e
		jz Up_con 
		cmp Xen, 0
		jg up_bound
	Up_con:
		inc Xen
		mov eax, 4
		call RandomRange
		inc al
		mov MoveEn, al
	up_bound:
	mov eax,  red +(red * 16)
		call SetTextColor

		call DrawEnemy
	ret
leftMove_e ENDP

rightMove_e PROC
		mov eax,  yellow +(black * 16)
		call SetTextColor

		call UpdateEnemy
		inc Xen
		call checkPosition_e
		jz Up_con 
		cmp Xen, 0
		jg up_bound
	Up_con:
		dec Xen
		mov eax, 4
		call RandomRange
		inc al
		mov MoveEn, al
	up_bound:
		mov eax,  red +(red * 16)
		call SetTextColor
		call DrawEnemy
	ret
rightMove_e ENDP

movements_e PROC uses eax ebx
mov eax, 10
call delay

	cmp bl, 1
	jne over1
	call upMove_e
	over1:
	cmp bl, 2
	jne over2
	call downMove_e
	over2:
	cmp bl, 3
	jne over3
	call leftMove_e
	over3:
	cmp bl, 4
	jne over4
	call rightMove_e
	over4:

	RET
movements_e ENDP

AllEnemies PROC

		mov ecx, 0
		mov bh, last_e1
		mov bl, move_e1
		mov ch, x_enemy1
		mov cl, y_enemy1
		mov MoveEn, bl
		mov Xen, ch
		mov Yen, cl
		mov LastEn, bh 
		call movements_e
		mov bl, MoveEn
		mov bh, LastEn
		mov cl, Yen
		mov ch, Xen
		mov y_enemy1, cl
		mov x_enemy1, ch
		mov move_e1, bl
		mov last_e1, bh

		mov ecx, 0
		mov bh, last_e2
		mov bl, move_e2
		mov ch, x_enemy2
		mov cl, y_enemy2
		mov MoveEn, bl
		mov Xen, ch
		mov Yen, cl
		mov LastEn, bh 
		call movements_e
		mov bl, MoveEn
		mov bh, LastEn
		mov cl, Yen
		mov ch, Xen
		mov y_enemy2, cl
		mov x_enemy2, ch
		mov move_e2, bl
		mov last_e2, bh

		mov ecx, 0
		mov bh, last_e3
		mov bl, move_e3
		mov ch, x_enemy3
		mov cl, y_enemy3
		mov MoveEn, bl
		mov Xen, ch
		mov Yen, cl
		mov LastEn, bh 
		call movements_e
		mov bl, MoveEn
		mov bh, LastEn
		mov cl, Yen
		mov ch, Xen
		mov y_enemy3, cl
		mov x_enemy3, ch
		mov move_e3, bl
		mov last_e3, bh

		cmp level, 3
		jne over1

		mov ecx, 0
		mov bh, last_e4
		mov bl, move_e4
		mov ch, x_enemy4
		mov cl, y_enemy4
		mov MoveEn, bl
		mov Xen, ch
		mov Yen, cl
		mov LastEn, bh 
		call movements_e
		mov bl, MoveEn
		mov bh, LastEn
		mov cl, Yen
		mov ch, Xen
		mov y_enemy4, cl
		mov x_enemy4, ch
		mov move_e4, bl
		mov last_e4, bh

		mov ecx, 0
		mov bh, last_e5
		mov bl, move_e5
		mov ch, x_enemy5
		mov cl, y_enemy5
		mov MoveEn, bl
		mov Xen, ch
		mov Yen, cl
		mov LastEn, bh 
		call movements_e
		mov bl, MoveEn
		mov bh, LastEn
		mov cl, Yen
		mov ch, Xen
		mov y_enemy5, cl
		mov x_enemy5, ch
		mov move_e5, bl
		mov last_e5, bh

		over1:
RET
AllEnemies ENDP

;////////////////////////////////////////////////////////////

EndScreen PROC
	mov eax, Brown + (black * 16)
	call Clrscr
	call SetTextColor
	mov dl,50
	mov dh,8
	call Gotoxy
	mWrite <"GAME OVER",0dh,0ah>
	
	mov dl,45
	mov dh,10
	call Gotoxy
	mWrite <"Player Name: ">
	mov edx, OFFSET PlayerName
	call writeString

	mov dl,50
	mov dh,12
	call Gotoxy
	mov edx, OFFSET strscore
	call writeString
	mov eax, 0
	mov al, score
	call writeint
	
	mov dl,41
	mov dh,25
	call Gotoxy
	call waitmsg
	
ret
EndScreen ENDP

InstructionScreen PROC
	mov eax, Brown + (black * 16)
	call Clrscr
	call SetTextColor
	mov ecx, 15
	mov ebx, 8
	mov edx, OFFSET inArray
	mov edi, OFFSET inArray
l1:
	mov dl,16
	mov dh, bl
	call Gotoxy
	mov edx, edi
	call WriteString
	add edx, 82
	mov edi, edx
	inc ebx
	mov eax, 100
	call delay
loop l1
	
	call readchar

Ret
InstructionScreen ENDP

SelectLevel PROC
		
	cmp level_once, 0
	je over_inc
	inc level
	mov coins, 0
	over_inc:
	inc level_once
	cmp level, 1
	jne over_l1
	mov edx, OFFSET ground1
	mov ground, edx
	jmp over_l3
	over_l1:
	cmp level, 2
	jne over_l2
	mov edx, OFFSET ground2
	mov ground, edx
	mov game_speed, 50
	jmp over_l3
	over_l2:
	cmp level, 3
	jne over_l3
	mov edx, OFFSET ground3
	mov ground, edx
	mov game_speed , 30
	over_l3:
ret
SelectLevel ENDP

DrawFruit PROC
	mov ecx, 5
l1:
fruitCreation:
	call CreateRandomFruit
	mov edi, ground
    movzx edx, yCoinPos
    imul edx, ground_width
    movzx eax, xCoinPos
    add edx, eax
	add edi, edx
	mov al, [edi]
	cmp al, '|'
	je fruitCreation
	cmp al, 'O'
	je fruitCreation
    mov al, 'F'
    mov [edi], al

    mov dl, xCoinPos
    mov dh, yCoinPos
    call Gotoxy
    call WriteChar
loop l1
	ret
DrawFruit ENDP

CreateRandomFruit PROC
	mov eax,78
	inc eax
	call RandomRange
	mov xCoinPos,al
	inc xCoinPos
	mov eax,26
	inc eax
	call RandomRange
	mov yCoinPos,al
	inc yCoinPos
	ret
CreateRandomFruit ENDP

;file handling

DisplayLead PROC

call clrscr

mwrite <"LeaderBoard", 0dh, 0ah, 0ah>

mov edx,OFFSET filename
call OpenInputFile
mov fileHandle,eax


mov edx,OFFSET buffer
mov ecx, 1000
call ReadFromFile

mov edx,OFFSET buffer
call WriteString
call Crlf

closing_file:
mov eax,fileHandle
call CloseFile

quiting:

ret
DisplayLead ENDP

ReadF PROC
	
mov edx,OFFSET filename
call OpenInputFile
mov fileHandle,eax
cmp eax,INVALID_HANDLE_VALUE 
jne file_valid

mWrite <"Cannot open file",0dh,0ah>
jmp quiting

file_valid:

mov edx,OFFSET buffer
mov ecx, 1000
call ReadFromFile

jnc buffer_size_check
mWrite "Error reading file. "

call WriteWindowsMsg
jmp closing_file
buffer_size_Check:
cmp eax,1000

jbe buf_size_valid

mWrite <"Error: Buffer size not vslid",0dh,0ah>
jmp quiting

buf_size_valid:

call namesize
call ConvertScore

mov eax, 0
cmp buffer[eax], 32
jne not_empty
inc eax
cmp buffer[eax], 32
jne not_empty

mov esi, 0
mov edi, 0
call enterCurrent
jmp emp
not_empty:
call AddingCurrent
emp:

mov edx,OFFSET buffer2
call WriteString
call Crlf


closing_file:
mov eax,fileHandle
call CloseFile

quiting:
ret
ReadF ENDP

FilesWork PROC
	
	call ReadF

; \\\\\\\\\\\\\\\\\\\\\\\\\
; writing to file

	mov edx,OFFSET filename
    call CreateOutputFile
    mov fileHandle,eax

    cmp eax, INVALID_HANDLE_VALUE 
    jne file_ok


    jmp quiting
    file_ok:

    mov eax,fileHandle
    mov edx,OFFSET buffer2
    mov ecx, sizeof buffer2
    call WriteToFile

    call CloseFile
quiting:

ret
FilesWork ENDP

AddingCurrent PROC
	
	mov edx, OFFSET buffer
	mov esi, 0
	mov ecx, 1000
	mov helc, 0

	l1:
	mov counter, ecx
		mov al, buffer[esi]
		cmp al, '9'
		jg over1
		cmp al, '0'
		jl over1

		call comparingScore
		cmp boolscore, 0
		je over1
		cmp boolpl, 0
		jne over1
		call enterCurrent

		over1:
		mov edi, helc
		mov buffer2[edi], al
		inc esi
		inc helc
	mov ecx, counter
	loop l1


ret
AddingCurrent ENDP


ConvertScore PROC uses ebx eax ecx
	mov al , score
	mov score2, al

	mov ebx, 10
	mov ecx,4
	l1:
	movzx eax, score2
	div bl
	mov score2, al
	add ah, 30h
	mov scorestr[ecx - 1], ah
	loop l1
ret
ConvertScore ENDP


ComparingScore PROC
	mov edi, 0
	mov ecx, 4
	l1:
	mov dl, scoreStr[edi]
	cmp buffer[esi + edi], dl
	jg over1
	inc edi
	loop l1
	mov boolscore, 1
	ret
	over1:
	mov boolscore, 0
ret
ComparingScore ENDP

enterCurrent PROC uses edi ecx
	mov edi, 0
	mov ecx, 4
	l1:
	mov dl, scoreStr[edi]
	mov buffer2[esi + edi], dl 
	inc edi
	loop l1

	mov buffer2[esi + edi], ' '
	inc edi

	movzx ecx, plSize
	mov ebx, 0
	l2:
	mov dl, PlayerName[ebx]
	mov buffer2[esi + edi], dl
	inc edi
	inc ebx
	loop l2

	add level, 30h
	mov buffer2[esi + edi], ' '
	inc edi
	mov dl, level 
	mov buffer2[esi + edi], dl
	inc edi

	mov buffer2[esi + edi], 0dh
	inc edi
	mov buffer2[esi + edi], 0ah
	inc edi

	mov helc, esi
	add helc, edi

	inc boolpl
ret
enterCurrent ENDP


namesize proc
	mov ecx, 0
	l1:
	inc plSize
	inc ecx
	cmp playername[ecx], 0
	jne l1
ret
namesize endp

END main
check This code