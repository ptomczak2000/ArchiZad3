;=============================================================================;
;                                                                             ;
; Plik           : Module1.asm                                                ;
; Format         : EXE                                                        ;
; Cwiczenie      : Program Hybrydowy										  ;
; Autorzy        : Piotr Tomczak, Kacper Wiœniewski, 2, poniedzia³ek, 12:15   ;
; Data zaliczenia: 23.03.2020r.                                               ;
; Uwagi          : Plik zawieraj¹cy modu³y do obliczania sredniej tablicy	  ;			
;                   oraz zliczaj¹cy ilosc znaku w tablicy                     ;
;=============================================================================;
				.MODEL		SMALL, C
				.CODE 
				PUBLIC		tablica
				;PUBLIC		zliczenia
tablica		PROC
Start:
				push bp	
				mov bp, sp
				mov si, [bp+4] ; tablica
				fldz
				fld dword ptr [si]
				add si,4	
			    mov ax, 1 ; inkrementacja
Petla1:
				cmp ax,[bp+6]
				je Zakonczenie
				fadd dword ptr [si]
				add si,4
				inc ax
				jmp Petla1

Zakonczenie:
				fidiv word ptr [bp+6]
				mov sp,bp
				pop bp
				ret

				
				ENDP
				END