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
				.MODEL		SMALL, C ; dodatkowy argument w dyrektywie .MODEL zapewni kombatybilnosc z jezykami wysokiego programowania C i C++
				.CODE 
				PUBLIC		tablica ; dyrektywa PUBLIC sprawia, ¿e moduly assemblerowe s¹ dostêpne z innych modu³ów(w naszym przypadku funkcja main w pliku cpp)
				PUBLIC		zliczenia
tablica		PROC
Start:
				push bp	;zachowanie starej wartosci BP (adres wyjscia z funkcji z powrotem do glownego modu³u cpp)
				mov bp, sp ; ustawienie nowej wartosci BP na wierzcho³ek stosu
				mov si, [bp+4] ; wprowadzenie offsetu pierwszego elementu tablicy do rejestru si
				fldz ; pushowanie(zerowanie) na stos koprocesora liczby 0 co zapobiegnie blednym wynikom przy powtornych uruchomieniach programu
				fld dword ptr [si] ; pushowanie na stos koprocesora wskaznika na pierwszy element tablicy, wartosc z tego miejsca na stosie
									;bedzie zwracana, poniewaz funkcja w programie zwraca wartosc typu float
				add si,4	;przejscie o 4 bajty w stosie, czyli przejscie do nastepnego elementu w tablicy
			    mov ax, 1 ; w rejestrze ax bedziemy przechowywac zmienna(iterator), wedlug ktorego bedziemy przechodzic tablice
Petla1:
				cmp ax,[bp+6] ; porownujemy czy indeks przegladanego elementu tablicy jest rowny wielkosci tablicy(warunek wyjscia z petli)
				je Zakonczenie; jesli ----||---- to znaczy ze przeszlismy cala tablice, wiec wychodzimy z pêtli do etykiety Zakonczenie
				fadd dword ptr [si]; dodanie do naszej sumy (znajdujacej sie na stosie w miejscu ST(0)) wartosci znajdujacej sie w tablicy pod adresem
									; znajdujacym sie w rejestrze si
				add si,4
				inc ax ; inkrementacja iteratora, wedlug ktorego przechodzimy tablice
				jmp Petla1 ; powtorzenie petli, analiza kolejnego elementu

Zakonczenie:
				fidiv word ptr [bp+6] ; podzielenie naszej otrzymanej sumy przez ilosc liczb jakie dodawalismy(wielkosc tablicy), by otrzymac srednia
										;arytmetyczna co zostanie zwrocona
				pop bp ;przywrocenie ze stosu starej wartoœci BP co pozwoli nam na wyjœcie z funkcji do g³ównego modu³u cpp
				ret ; powrot z procedury

				
				ENDP
zliczenia		PROC
Start2:
				push bp	; zachowanie starej wartosci BP (adres wyjscia z funkcji z powrotem do glownego modu³u cpp)
				mov bp, sp ; ustawienie nowej wartosci BP na wierzcho³ek stosu
				mov si, [bp+4] ; wprowadzenie offsetu pierwszego elementu tablicy do rejestru si
				mov bl, [bp+6] ; wprowadzenie szukanego znaku do rejestru bl
				mov ax,0 ; zerowanie licznika wystapien znaku (funkcja zwraca typ int, wiec przy takim typie zawartosc rejestru ax zostanie zwrocona)
Petla2:
				mov cl,[si] ; kopiowanie wartosc rejestru si do cl w celu porownania
				cmp cl,0Ah ; sprawdzanie czy skopiowana wartosc jest koncem tablicy czyli znakiem ASCII konca linii (10 w kodzie szesnastkowym)
				je Zakonczenie2 ; jesli jest to koniec linii, czyli koniec tablicy, to wychodzimy z pêtli i idziemy do etykiety zakoñczenia
				cmp cl, bl ; porównujemy skopiowan¹ wartoœæ z tablicy do znaku którego iloœæ sprawdzamy
				jne Inkrementacja ; jeœli nie, idziemy do etykiety Inkrementacja która przejdzie do nastêpnego elementu tablicy
				inc ax ; jeœli tak, to inkrementujemy licznik wyst¹pieñ poszukiwanego znaku
Inkrementacja:
				inc si ; inkrementujemy si, by przejœæ do nastêpnego elementu tablicy
				jmp Petla2 ; wracamy do pêtli sprawdzaj¹cej
Zakonczenie2:
				pop bp ; przywrocenie ze stosu starej wartoœci BP co pozwoli nam na wyjœcie z funkcji do g³ównego modu³u cpp
				ret ; powrót z procedury
				ENDP
				END