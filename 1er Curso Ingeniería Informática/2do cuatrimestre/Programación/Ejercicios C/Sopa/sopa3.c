#include <stdio.h>
#include <string.h>
#include <stdbool.h>
#include <time.h>
#include <stdlib.h>

#define DIM 15
#define TCHAR 11
#define N_TEMAS 5
#define N_PAL 5
#define ZERO 48
#define MIN 0
#define MAX 4
#define ESC 27

void    rellenaTemas(char[N_TEMAS][N_PAL][TCHAR]);
void    compruebaTemas(char[N_TEMAS][N_PAL][TCHAR]);
void    crearSopa(int[DIM][DIM]);
void    imprimirSopa(int[DIM][DIM]);
int     solicitaOpcionMenu();
void    colocaPalabras(int[DIM][DIM], char[N_TEMAS][N_PAL][TCHAR], int);
bool    esPosibleColocarPalabra(int[DIM][DIM], char[TCHAR], int, int, int);
int     buscaAleatorio(int, int);
void    colocaPalabra(int[DIM][DIM], char[TCHAR], int);
void    rellenaMatriz(int[DIM][DIM]);
int     clean_stdin();
void    introduceNum(int *);
bool    coincidePal(int[DIM][DIM], char[N_TEMAS][N_PAL][TCHAR], int,
		    int[N_PAL]);
void imprimeOpciones(int);
void juego(char [N_TEMAS][N_PAL][TCHAR],int [DIM][DIM],int [N_PAL],int);

/*@AUTOR: Jorge Navarro González y Mario Ubierna San Mamés
 *@NOMBRE: Sopa de Letras
 *@DESCRIPCIÓN: Es una sopa de letras con distintos temas a resolver
 *@VERSIÓN: v1.0
 *@RETURN: 0
 *@FECHA: 30-03-2016
 */
int main() {
  //variables locales
  char    temas[N_TEMAS][N_PAL][TCHAR];
  int     sopa[DIM][DIM];
  int     palEncontrada[N_PAL];
  int     tema;
  tema=0;
  juego(temas, sopa, palEncontrada, tema);
  return 0;
}

/*@AUTOR: Carlos Pardo (mirar)
 *@NOMBRE: clean_stdin
 *@DESCRIPCIÓN: Limpia el buffer
 *@RETURN: 1
 */
int clean_stdin() {
  while(getchar() != '\n') ;
  return 1;
}

/*@AUTOR: Jorge Navarro y Mario Ubierna
 *@NOMBRE: solicitaOpcionMenu
 *@DESCRIPCIÓN: Solicita la opción del menú
 *@RETURN: opcion-1
 *@VERSIÓN: v1.0
 *@FECHA: 30-03-2016
 */

int solicitaOpcionMenu() {
  int     opcion;
  char    enter;
  int     leidos;
  do {
    printf("\n\t********************\n"
	   "\t1.- Coches\n"
	   "\t2.- Colores\n"
	   "\t3.- Formas\n"
	   "\t4.- Ciudades\n"
	   "\t5.- Países\n"
	   "\t0.- Salir\n" "\t********************\n" "\tOpcion: ");
    leidos = scanf("%d%c", &opcion, &enter);
    if(leidos != 2 || enter != '\n') {
      printf("\nError en el menú\n");
      clean_stdin();
    } else if(opcion < 0 || 5 < opcion) {
      printf("\nValor fuera de rango\n");
    } else if(opcion == 0) {
      exit(0);
    }
  } while(opcion < 0 || 5 < opcion || leidos != 2 || enter != '\n');
  printf("\n\nOpción elegida: %d\n", opcion);
  if(opcion == 1)
    printf("Palabras a buscar: MERCEDES, FORD, RENAULT, AUDI, OPEL.\n\n");
  else if(opcion == 2)
    printf("Palabras a buscar: ROJO, AMARILLO, AZUL, NARANJA, VERDE.\n\n");
  else if(opcion == 3)
    printf
	("Palabras a buscar: CIRCULO, TRIANGULO, CUADRADO, ROMBO, ELIPSE.\n\n");
  else if(opcion == 4)
    printf
	("Palabras a buscar: MADRID, BARCELONA, BILBAO, ZARAGOZA, BURGOS.\n\n");
  else if(opcion == 5)
    printf
	("Palabras a buscar: INGLATERRA, ARGELIA, ITALIA, FRANCIA, MARRUECOS.\n\n");
  return opcion - 1;
}

/*@AUTOR: Jorge Navarro González y Mario Ubierna San Mamés
 *@NOMBRE: imprimirSopa
 *@DESCRIPCIÓN: Nos imprime la sopa de letras con las palabras
 *@VERSIÓN: v1.0
 *@PARAMETRO DE ENTRADA: sopa[DIM][DIM]
 *@FECHA: 30-03-2016
 */
void imprimirSopa(int sopa[DIM][DIM]) {
  int     i, j;
  printf("        0  1  2  3  4  5  6  7  8  9 10 11 12 13 14\n");
  printf("     -------------------------------------------------\n");
  for(i = 0; i < DIM; i++) {
    if(i < 10) {
      printf("   %d |", i);
    } else
      printf("   %d|", i);
    for(j = 1; j <= DIM; j++) {
      printf("%3c", sopa[i][j - 1]);
    }
    printf("  |%d\n", i);
  }
  printf("     -------------------------------------------------\n");
  printf("        0  1  2  3  4  5  6  7  8  9 10 11 12 13 14\n");
}

/*@AUTOR: Jorge Navarro González y Mario Ubierna San Mamés
 *@NOMBRE: rellenaTemas
 *@DESCRIPCIÓN: rellena la matriz de los temas
 *@VERSIÓN: v1.0
 *@PARAMETRO DE ENTRADA: temas[N_TEMAS][N_PAL][TCHAR]
 *@FECHA: 06-04-2016
 */
void rellenaTemas(char temas[N_TEMAS][N_PAL][TCHAR]) {
  strcpy(temas[0][0], "audi");
  strcpy(temas[0][1], "mercedes");
  strcpy(temas[0][2], "ford");
  strcpy(temas[0][3], "opel");
  strcpy(temas[0][4], "renault");
  strcpy(temas[1][0], "rojo");
  strcpy(temas[1][1], "verde");
  strcpy(temas[1][2], "azul");
  strcpy(temas[1][3], "amarillo");
  strcpy(temas[1][4], "naranja");
  strcpy(temas[2][0], "circulo");
  strcpy(temas[2][1], "triangulo");
  strcpy(temas[2][2], "cuadrado");
  strcpy(temas[2][3], "rombo");
  strcpy(temas[2][4], "elipse");
  strcpy(temas[3][0], "madrid");
  strcpy(temas[3][1], "barcelona");
  strcpy(temas[3][2], "bilbao");
  strcpy(temas[3][3], "zaragoza");
  strcpy(temas[3][4], "burgos");
  strcpy(temas[4][0], "inglaterra");
  strcpy(temas[4][1], "argelia");
  strcpy(temas[4][2], "italia");
  strcpy(temas[4][3], "francia");
  strcpy(temas[4][4], "marruecos");
  /*
  int i=0;
  int j=0;
  char caracter;
  do{
    printf("Introduce palabra de la sopa: ");
    for(j=0;j<TCHAR;++j){
        scanf("%c",&caracter);
        temas[0][i][j]=caracter;
        if(temas[0][i][j]=='\n'){
            temas[0][i][j]='\0';
            j=TCHAR;
        }
        }
  ++i;
    }while(i<N_PAL);
    */
  }

/*@AUTOR: Jorge Navarro González y Mario Ubierna San Mamés
 *@NOMBRE: compruebaTemas
 *@DESCRIPCIÓN: Comprueba todos los temas que hay en la matriz
 *@VERSIÓN: v1.0
 *@PARAMETRO DE ENTRADA: temas[N_TEMAS][N_PAL][TCHAR]
 *@FECHA: 06-04-2016
 */
void compruebaTemas(char temas[N_TEMAS][N_PAL][TCHAR]) {
  int     f;
  int     c;
  for(f = 0; f <= 4; f++) {
    for(c = 0; c <= 4; c++) {
      printf("%s", temas[f][c]);
    }
  }
  printf("\n");
}

/*@AUTOR: Jorge Navarro González y Mario Ubierna San Mamés
 *@NOMBRE: crearSopa
 *@DESCRIPCIÓN: nos rellena la matriz sopa con 0
 *@VERSIÓN: v1.0
 *@PARAMETRO DE ENTRADA: sopa[DIM][DIM]
 *@FECHA: 06-04-2016
 */
void crearSopa(int sopa[DIM][DIM]) {
  int     i, j;
  for(i = 0; i <= DIM; i++) {
    for(j = 0; j < DIM; j++) {
      sopa[i][j] = ZERO;
    }
  }
}

/*@AUTOR: Jorge Navarro González y Mario Ubierna San Mamés
 *@NOMBRE: colocaPalabras
 *@DESCRIPCIÓN: nos coloca las palabras de matriz temas en la sopa
 *@VERSIÓN: v1.0
 *@PARAMETRO DE ENTRADA: sopa[DIM][DIM], palabra[N_TEMAS][N_PAL][TCHAR], temas
 *@FECHA: 13-04-2016
 */
void colocaPalabras(int sopa[DIM][DIM],
		    char temas[N_TEMAS][N_PAL][TCHAR], int tema) {
  int     j;
  for(j = 0; j < N_PAL; j++) {
    colocaPalabra(sopa, temas[tema][j], buscaAleatorio(1, 4));
  }
}

/*@AUTOR: Jorge Navarro González y Mario Ubierna San Mamés
 *@NOMBRE: buscaAleatorio
 *@DESCRIPCIÓN: Nos genera los valores aleatorios entre dos valores
 *@VERSIÓN: v1.0
 *@PARAMETROS DE ENTRADA: min, max
 *@RETURN: aleatorio
 *@FECHA: 13-04-2016
 */
int buscaAleatorio(int min, int max) {
  int     aleatorio;
  aleatorio = (rand() / (1.0 + RAND_MAX) * (1 + max - min) + min);
  return aleatorio;
}

/*@AUTOR: Jorge Navarro González y Mario Ubierna San Mamés
 *@NOMBRE: colocaPalabra
 *@DESCRIPCIÓN: nos coloca las palabras en la sopa en cuatro direcciones diferentes
 *@VERSIÓN: v1.0
 *@PARAMETRO DE ENTRADA: sopa[DIM][DIM], palabra[TCHAR], direccion
 *@FECHA: 20-04-2016
 */
void colocaPalabra(int sopa[DIM][DIM], char palabra[TCHAR], int direccion) {
  int     fila, columna, i;
  int     j = 0;
  bool    s;
  do {
    fila = buscaAleatorio(0, DIM - 1);
    columna = buscaAleatorio(0, DIM - 1);
    s = esPosibleColocarPalabra(sopa, palabra, direccion, columna, fila);
  } while(!s);
  if(direccion == 1) {
    for(i = columna; i < (columna + (int)strlen(palabra)); ++i) {
      sopa[fila][i] = (int)palabra[j];
      ++j;
    }
  } else if(direccion == 2) {
    for(i = columna; i > (columna - (int)strlen(palabra)); --i) {
      sopa[fila][i] = (int)palabra[j];
      ++j;
    }
  } else if(direccion == 3) {
    for(i = fila; i < (fila + (int)strlen(palabra)); ++i) {
      sopa[i][columna] = (int)palabra[j];
      ++j;
    }
  } else if(direccion == 4) {
    for(i = fila; i > (fila - (int)strlen(palabra)); --i) {
      sopa[i][columna] = (int)palabra[j];
      ++j;
    }
  }
}

/*@AUTOR: Jorge Navarro González y Mario Ubierna San Mamés
 *@NOMBRE: esPosibleColocarPalabra
 *@DESCRIPCIÓN: funcion que te devuelve true si es posible colocar palabra y false si no es posible
 *@VERSIÓN: v1.0
 *@PARAMETROS DE ENTRADA: sopa[DIM][DIM], palabra[TCHAR], direccion, columna, fila
 *@RETURN: er
 *@FECHA: 27-04-2016
 */
bool esPosibleColocarPalabra(int sopa[DIM][DIM], char palabra[TCHAR],int direccion, int columna, int fila) {
  bool    er = true;
  int     i, j;
  if(direccion == 1) {
    if(columna + (int)strlen(palabra) > DIM) {
      er = false;
    } else {
      for(i = columna, j = 0; i <= columna + (int)strlen(palabra);
	  ++i, ++j) {
	if(sopa[fila][i] != ZERO) {
	  if(palabra[j] != sopa[fila][i]) {
	    er = false;
	  }
	}
      }
    }
  } else if(direccion == 2) {
    if(columna - (int)strlen(palabra) < 0) {
      er = false;
    } else {
      for(i = columna, j = 0; i >= columna - (int)strlen(palabra);
	  i--, j++) {
	if(sopa[fila][i] != ZERO) {
	  if(palabra[j] != sopa[fila][i]) {
	    er = false;
	  }
	}
      }
    }
  } else if(direccion == 3) {
    if(fila + (int)strlen(palabra) > DIM) {
      er = false;
    } else {
      for(i = fila, j = 0; i <= fila + (int)strlen(palabra); i++, j++) {
	if(sopa[i][columna] != ZERO) {
	  if(palabra[j] != sopa[i][columna]) {
	    er = false;
	  }
	}
      }
    }
  } else if(direccion == 4) {
    if(fila - (int)strlen(palabra) < 0) {
      er = false;
    } else {
      for(i = fila, j = 0; i >= fila - (int)strlen(palabra); i--, j++) {
	if(sopa[i][columna] != ZERO) {
	  if(palabra[j] != sopa[i][columna]) {
	    er = false;
	  }
	}
      }
    }
  }
  return er;
}

/*@AUTOR: Jorge Navarro González y Mario Ubierna San Mamés
 *@NOMBRE: rellenaMatriz
 *@DESCRIPCIÓN: nos rellena la matriz con letras aleatorias
 *@VERSIÓN: v1.0
 *@PARAMETRO DE ENTRADA: sopa[DIM][DIM]
 *@FECHA: 06-04-2016
 */
void rellenaMatriz(int sopa[DIM][DIM]) {
  int     i, j;
  for(i = 0; i < DIM; i++) {
    for(j = 0; j < DIM; j++) {
      if(sopa[i][j] == ZERO) {
	sopa[i][j] = buscaAleatorio(65, 90);
      }
    }
  }
}

/*@AUTOR: Jorge Navarro González y Mario Ubierna San Mamés
 *@NOMBRE: introduceNum
 *@DESCRIPCIÓN: introducimos un numero y podemos volver al menu pulsando ESC
 *@VERSIÓN: v1.0
 *@PARAMETRO DE ENTRADA: *num
 *@FECHA: 30-04-2016
 */
void introduceNum(int *num) {
  char a;
  int leidos;
  int fin;
  int b=0;
  do{
  leidos = scanf("%d%c", num, &a);
  if(leidos != 2 || a != '\n'){
    if(getchar()==ESC)
      exit(main());
    printf("Incorrecto. Introduce otro valor: ");
    clean_stdin();
    ++b;
  }else if(*num<0 || *num>DIM){
    printf("Incorrecto. Introduce otro valor: ");
    ++b;
  }else{
    fin=1;
  }
  if(b==5)
    exit(main());
  }while(fin!=1);
}

/*@AUTOR: Jorge Navarro González y Mario Ubierna San Mamés
 *@NOMBRE: coincidePal
 *@DESCRIPCIÓN: busca si las coordenadas que introducimos coinciden con la palabra de la matriz de temas
 *@VERSIÓN: v1.0
 *@PARAMETROS DE ENTRADA: sopa[DIM][DIM], temas[N_TEMAS][N_PAL][TCHAR], tema, palEncontrada[N_PAL]
 *@RETURN: true
 *@FECHA: 02-05-2016
 */
bool coincidePal(int sopa[DIM][DIM], char temas[N_TEMAS][N_PAL][TCHAR],
		 int tema, int palEncontrada[N_PAL]) {
  int     i;
  int     j;
  int     iF, iC, fF, fC;
  int     x;
  char    palabra[TCHAR];
  /*int b=0;
  */
  do {
    printf("\n\nIntroduce la coordenada de inicio de fila: ");
    introduceNum(&iF);
    printf("Introduce la coordenada de inicio de columna: ");
    introduceNum(&iC);
    printf("Introduce la coordenada de final de fila: ");
    introduceNum(&fF);
    printf("Introduce la coordenada de final de columna: ");
    introduceNum(&fC);
    if(iF == fF && iC < fC) {
      for(i = iC, j = 0; i <= fC; ++i, ++j) {
	palabra[j] = (char)sopa[iF][i];
      }
      palabra[j] = '\0';
    } else if(iF == fF && iC > fC) {
      for(i = iC, j = 0; i >= fC; --i, ++j) {
	palabra[j] = (char)sopa[iF][i];
      }
      palabra[j] = '\0';
    } else if(iC == fC && iF < fF) {
      for(i = iF, j = 0; i <= fF; ++i, ++j) {
	palabra[j] = (char)sopa[i][iC];
      }
      palabra[j] = '\0';
    } else if(iC == fC && iF > fF) {
      for(i = iF, j = 0; i >= fF; --i, ++j) {
	palabra[j] = (char)sopa[i][iC];
      }
      palabra[j] = '\0';
    }
    for(i = 0; i < N_PAL; i++) {
      if(strlen(temas[tema][i])==strlen(palabra)){
      if(strncmp(temas[tema][i],palabra, strlen(palabra)) == 0){
        palEncontrada[i] = 1;
        system("clear");
        imprimirSopa(sopa);
        imprimeOpciones(tema);
        for(i=0;i<N_PAL;++i){
          if(palEncontrada[i]==1){
          printf("%s ENCONTRADA\t",temas[tema][i]);
          }
        }
        x = 0;
        }
      }
      }
    for(i = 0; i < N_PAL; i++) {
      if(palEncontrada[i] == 1) {
	x++;
      }
    }
    /*if(strlen(temas[tema][i])!=strlen(palabra) || strncmp(temas[tema][i],palabra, strlen(palabra))!=0){
      ++b;
        if(b==5){
        exit(main());
    }
    }
    */
  }
  while(x != N_PAL);
  return true;
}

/*@AUTOR: Jorge Navarro González y Mario Ubierna San Mamés
 *@NOMBRE: imprimeOpciones
 *@DESCRIPCIÓN: nos imprime las palabras a buscar por cada tema
 *@VERSIÓN: v1.0
 *@PARAMETRO DE ENTRADA: tema
 *@FECHA: 02-05-2016
 */
void imprimeOpciones(int tema){
  if(tema == 0)
    printf("\nPalabras a buscar: MERCEDES, FORD, RENAULT, AUDI, OPEL.\n");
  else if(tema == 1)
    printf("\nPalabras a buscar: ROJO, AMARILLO, AZUL, NARANJA, VERDE.\n");
  else if(tema == 2)
    printf("\nPalabras a buscar: CIRCULO, TRIANGULO, CUADRADO, ROMBO, ELIPSE.\n");
  else if(tema == 3)
    printf("\nPalabras a buscar: MADRID, BARCELONA, BILBAO, ZARAGOZA, BURGOS.\n");
  else if(tema == 4)
    printf("\nPalabras a buscar: INGLATERRA, ARGELIA, ITALIA, FRANCIA, MARRUECOS.\n");
}

/*@AUTOR: Jorge Navarro González y Mario Ubierna San Mamés
 *@NOMBRE: juego
 *@DESCRIPCIÓN: nos pone todas las funciones para asi poder realizar el juego
 *@VERSIÓN: v1.0
 *@PARAMETROS DE ENTRADA: temas[N_TEMAS][N_PAL][TCHAR], sopa[DIM][DIM], palEncontrada[N_PAL], tema
 *@FECHA: 05-05-2016
 */
void juego(char temas[N_TEMAS][N_PAL][TCHAR],int sopa[DIM][DIM],int palEncontrada[N_PAL],int tema){
  int i;
  srand(time(NULL));
  do {
    for(i = 0; i < N_PAL; ++i)
    palEncontrada[i] = 0;
    tema = solicitaOpcionMenu();
    crearSopa(sopa);
    rellenaTemas(temas);
    //compruebaTemas(temas); La hemos usado para comprobar que se imprimian los temas de la matriz de temas pero para hacer el juego la hemos quitado
    colocaPalabras(sopa, temas, tema);
    rellenaMatriz(sopa);
    imprimirSopa(sopa);
    coincidePal(sopa, temas, tema, palEncontrada);
    printf("\n\n\t\t\t****GAME OVER****\n\t\t Pulsa enter para volver al menú\n");
  } while(getchar() != 0);
}



