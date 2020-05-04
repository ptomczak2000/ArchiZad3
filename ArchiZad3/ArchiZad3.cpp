#include <iostream>
using namespace std;
extern "C" float tablica(int n, int tab[]);
extern "C" int zliczenia(char tab[], char znaczek);
int main()
{
    int wybor;
    char znak;
    cout << "----Archi---ZAD3----" << endl;
    cout << "1. Obliczanie sredniej z tablicy" << endl;
    cout << "2. Obliczanie wystapien danego znaku w tablicy znakowej" << endl;
    cout << "Wybierz opcje: ";
    cin >> wybor;
    do{
        switch (wybor) {
        case 1: {
            int ilosc;
            float srednia;
            cout << "Podaj podaj ilosc elementow: ";
            cin >> ilosc;
            int* tab = new int[ilosc];
            for (int i = 0; i < ilosc; i++) {
                cout << "Podaj element"<< i+1 << " tablicy: ";
                cin >> tab[i];
            }
            //srednia=tablica(ilosc, tab);
            //cout << "Srednia wynosi: " << srednia << endl;
            delete tab;
            break;
        }
        case 2: {
            char znaczek;
            char tab[256];
            int ilosc;
            cout << "Podaj tablice znakow: ";
            cin.get();
            cin.getline(tab, 256);
            cout << "Podaj szukany znak: ";
            cin >> znaczek;
            //ilosc=zliczenia(tab, znaczek);
            break;
        }
        default: {
            cout << "Wybrano zla opcje!" << endl;
        }
        }
        cout << "Czy chcesz kontynuowac? [y/n]";
        cin >> znak;
    }while(znak=='y' || znak=='Y');
    return 0;
}