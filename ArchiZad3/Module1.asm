;=============================================================================;
;                                                                             ;
; Plik           : Module1.asm                                                ;
; Format         : EXE                                                        ;
; Cwiczenie      : Program Hybrydowy										  ;
; Autorzy        : Piotr Tomczak, Kacper Wi�niewski, 2, poniedzia�ek, 12:15   ;
; Data zaliczenia: 23.03.2020r.                                               ;
; Uwagi          : Plik zawieraj�cy modu�y do obliczania sredniej tablicy	  ;			
;                   oraz zliczaj�cy ilosc znaku w tablicy                     ;
;=============================================================================;
				.MODEL		SMALL, C ; dodatkowy argument w dyrektywie .MODEL zapewni kombatybilnosc z jezykami wysokiego programowania C i C++
				.CODE 
				PUBLIC		tablica ; dyrektywa PUBLIC sprawia, �e moduly assemblerowe s� dost�pne z innych modu��w(w naszym przypadku funkcja main w pliku cpp)
				PUBLIC		zliczenia
tablica		PROC
Start:
				push bp	;zachowanie starej wartosci BP (adres wyjscia z funkcji z powrotem do glownego modu�u cpp)
				mov bp, sp ; ustawienie nowej wartosci BP na wierzcho�ek stosu
				mov si, [bp+4] ; wprowadzenie offsetu pierwszego elementu tablicy do rejestru si
				fldz ; pushowanie(zerowanie) na stos koprocesora liczby 0 co zapobiegnie blednym wynikom przy powtornych uruchomieniach programu
				fld dword ptr [si] ; pushowanie na stos koprocesora wskaznika na pierwszy element tablicy, wartosc z tego miejsca na stosie
									;bedzie zwracana, poniewaz funkcja w programie zwraca wartosc typu float
				add si,4	;przejscie o 4 bajty w stosie, czyli przejscie do nastepnego elementu w tablicy
			    mov ax, 1 ; w rejestrze ax bedziemy przechowywac zmienna(iterator), wedlug ktorego bedziemy przechodzic tablice
Petla1:
				cmp ax,[bp+6] ; porownujemy czy indeks przegladanego elementu tablicy jest rowny wielkosci tablicy(warunek wyjscia z petli)
				je Zakonczenie; jesli ----||---- to znaczy ze przeszlismy cala tablice, wiec wychodzimy z p�tli do etykiety Zakonczenie
				fadd dword ptr [si]; dodanie do naszej sumy (znajdujacej sie na stosie w miejscu ST(0)) wartosci znajdujacej sie w tablicy pod adresem
									; znajdujacym sie w rejestrze si
				add si,4
				inc ax ; inkrementacja iteratora, wedlug ktorego przechodzimy tablice
				jmp Petla1 ; powtorzenie petli, analiza kolejnego elementu

Zakonczenie:
				fidiv word ptr [bp+6] ; podzielenie naszej otrzymanej sumy przez ilosc liczb jakie dodawalismy(wielkosc tablicy), by otrzymac srednia
										;arytmetyczna co zostanie zwrocona
				pop bp ;przywrocenie ze stosu starej warto�ci BP co pozwoli nam na wyj�cie z funkcji do g��wnego modu�u cpp
				ret ; powrot z procedury

				
				ENDP
zliczenia		PROC
Start2:
				push bp	; zachowanie starej wartosci BP (adres wyjscia z funkcji z powrotem do glownego modu�u cpp)
				mov bp, sp ; ustawienie nowej wartosci BP na wierzcho�ek stosu
				mov si, [bp+4] ; wprowadzenie offsetu pierwszego elementu tablicy do rejestru si
				mov bl, [bp+6] ; wprowadzenie szukanego znaku do rejestru bl
				mov ax,0 ; zerowanie licznika wystapien znaku (funkcja zwraca typ int, wiec przy takim typie zawartosc rejestru ax zostanie zwrocona)
Petla2:
				mov cl,[si] ; kopiowanie wartosc rejestru si do cl w celu porownania
				cmp cl,0Ah ; sprawdzanie czy skopiowana wartosc jest koncem tablicy czyli znakiem ASCII konca linii (10 w kodzie szesnastkowym)
				je Zakonczenie2 ; jesli jest to koniec linii, czyli koniec tablicy, to wychodzimy z p�tli i idziemy do etykiety zako�czenia
				cmp cl, bl ; por�wnujemy skopiowan� warto�� z tablicy do znaku kt�rego ilo�� sprawdzamy
				jne Inkrementacja ; je�li nie, idziemy do etykiety Inkrementacja kt�ra przejdzie do nast�pnego elementu tablicy
				inc ax ; je�li tak, to inkrementujemy licznik wyst�pie� poszukiwanego znaku
Inkrementacja:
				inc si ; inkrementujemy si, by przej�� do nast�pnego elementu tablicy
				jmp Petla2 ; wracamy do p�tli sprawdzaj�cej
Zakonczenie2:
				pop bp ; przywrocenie ze stosu starej warto�ci BP co pozwoli nam na wyj�cie z funkcji do g��wnego modu�u cpp
				ret ; powr�t z procedury
				ENDP
				END