/**
 * 
 */
package juego.modelo;

import juego.util.Direccion;

/**
 * Clase Tablero.
 * 
 * @author Mario Ubierna San Mamés
 * @author Jorge Navarro González
 *
 */
public class Tablero {

	/**
	 * Matriz de tipo Celda.
	 * 
	 */
	private Celda[][] matriz;

	/**
	 * Construtor Tablero y crea las celdas asociadas al tablero
	 * 
	 * @param filas
	 * @param columnas
	 */
	public Tablero(int filas, int columnas) {
		matriz = new Celda[filas][columnas];
		for (int i = 0; i < filas; ++i) {
			for (int j = 0; j < columnas; ++j) {
				this.matriz[i][j] = new Celda(i, j);
			}
		}
	}

	/**
	 * Asociamos la celda a la pieza y viceversa.
	 * 
	 * @param pieza
	 * @param celda
	 */
	public void colocar(Pieza pieza, Celda celda) {
		pieza.establecerCelda(celda);
		celda.establecerPieza(pieza);
	}

	/**
	 * Comprobamos si la fila y la columna pertenecer a la matriz.
	 * 
	 * @param fila
	 * @param columna
	 * @return boolean
	 */
	public boolean estaEnTablero(int fila, int columna) {
		if ((fila < matriz.length && fila >= 0) && (columna < matriz[0].length && columna >= 0)) {
			return true;
		} else {
			return false;
		}
	}

	/**
	 * Nos returna la celda asociada a la fila y a la columna.
	 * 
	 * @param fila
	 * @param columna
	 * @return
	 */
	public Celda obtenerCelda(int fila, int columna) {
		if (estaEnTablero(fila, columna) == true) {
			return matriz[fila][columna];
		} else {
			return null;
		}
	}

	/**
	 * Nos devuelve el numero de filas.
	 * 
	 * @return filas
	 */
	public int obtenerNumeroFilas() {
		return matriz.length;
	}

	/**
	 * Nos devuelve el numero de columnas.
	 * 
	 * @return columnas
	 */
	public int obtenerNumeroColumnas() {
		return matriz[0].length;
	}

	/**
	 * Comprobamos si esta completo el tablero.
	 * 
	 * @return boolean
	 */
	public boolean estaCompleto() {
		for (int i = 0; i < matriz.length; ++i) {
			for (int j = 0; j < matriz[0].length; ++j) {
				if (matriz[i][j].estaVacia() == false) {
					return true;
				}
			}
		}
		return false;
	}

	/**
	 * Nos devuelve el número de piezas.
	 * 
	 * @param celda
	 * @param direccion
	 * @return resultado
	 */
	public int contarPiezas(Celda celda, Direccion direccion) {
		int resultado = 0;
		switch (direccion) {
		case HORIZONTAL:
			for (int i = 0; i < obtenerNumeroFilas(); ++i) {
				for (int j = 0; j < obtenerNumeroColumnas(); ++j) {
					if (celda.estaVacia() == false) {
						resultado = resultado + 1;
					}
				}
			}
			break;
		case VERTICAL:
			for (int j = 0; j < obtenerNumeroColumnas(); ++j) {
				for (int i = 0; i < obtenerNumeroFilas(); ++i) {
					if (celda.estaVacia() == false) {
						resultado = resultado + 1;
					}
				}
			}
			break;
		case DIAGONAL_SO_NE:
			for (int i = obtenerNumeroFilas(), j = 0; (i > 0) && (j < obtenerNumeroColumnas()); --i, ++j) {
				if (celda.estaVacia() == false) {
					resultado = resultado + 1;
				}
			}
			break;
		case DIAGONAL_NO_SE:
			for (int i = 0, j = 0; (i < obtenerNumeroFilas()) && (j < obtenerNumeroColumnas()); ++i, ++j) {
				if (celda.estaVacia() == false) {
					resultado = resultado + 1;
				}
			}
			break;
		}
		return resultado;
	}

	/**
	 * Nos devuelve el numero de piezas del mismo color.
	 * 
	 * @param color
	 * @return resultado
	 */
	public int obtenerNumeroPiezas(Color color) {
		int resultado = 0;
		for (int i = 0; i < matriz.length; ++i) {
			for (int j = 0; j < matriz[i].length; ++j) {
				if (matriz[i][j].estaVacia() == false) {
					if ((matriz[i][j].obtenerPieza().obtenerColor() == color)) {
						resultado = resultado + 1;
					}
				}
			}
		}
		return resultado;
	}

	/**
	 * Nos devuelve el tablero.
	 * 
	 */
	public String toString() {
		String palabra = "";
		for (int i = 0; i < obtenerNumeroFilas(); ++i) {
			for (int j = 0; j < obtenerNumeroColumnas(); ++j) {
				if (obtenerCelda(i, j) == null) {
					palabra = "-\t";
				} else {
					palabra = obtenerCelda(i, j).obtenerPieza().obtenerColor().toChar() + "\t";
				}
			}
			palabra = "\n";
		}
		return palabra;
	}
}
