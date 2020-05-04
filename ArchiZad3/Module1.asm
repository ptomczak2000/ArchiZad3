;=============================================================================;
;                                                                             ;
; Plik           : Module1.asm                                                ;
; Format         : EXE                                                        ;
; Cwiczenie      : Program Hybrydowy										  ;
; Autorzy        : Piotr Tomczak, Kacper Wiœniewski, 2, poniedzia³ek, 12:15   ;
; Data zaliczenia: 23.03.2020r.                                               ;
; Uwagi          : Plik zawieraj¹cy modu³y do obliczania sredniej tablicy	  ;			
;                  oraz zliczaj¹cy ilosc znaku w tablicy                      ;
;=============================================================================;
				.MODEL		SMALL, C

				PUBLIC		tablica
				PUBLIC		zliczenia

				.CODE
tablica:		PROC
				mov  ax, 0
				
				ENDP
zliczenia:		PROC

				ENDP
				END

				.STACK
				DB 100h DUP	(?)
				END