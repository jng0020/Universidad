/**
 * 
 */
package juego.modelo;

import java.util.ArrayList;
import java.util.List;

import juego.util.Sentido;

/**
 * Clase que nos crea el tablero.
 * 
 * @author Mario Ubierna San Mames
 * @author Jorge Navarro Gonzalez
 *
 */
public class Tablero {
	/**
	 * Matriz de tipo Celda.
	 * 
	 */
	protected List<List<Celda>> matriz;

	/**
	 * Constructor de tablero.
	 * 
	 * @param filas
	 *            Son las filas del tablero
	 * @param columnas
	 *            Son las columnas del tablero
	 * 
	 */
	public Tablero(int filas, int columnas) {
		matriz = new ArrayList<List<Celda>>();
		for (int i = 0; i < filas; i++) {
			List<Celda> fila = new ArrayList<Celda>();
			for (int j = 0; j < columnas; j++) {
				fila.add(j, new Celda(i, j));
			}
			matriz.add(i, fila);
		}
	}

	/**
	 * Asociamos la celda al atomo y viceversa.
	 * 
	 * @param atomo
	 *            establecemos el atomo a la celda
	 * @param celda
	 *            establecemos la celda al atomo
	 */
	public void colocar(Atomo atomo, Celda celda) {
		atomo.establecerCelda(celda);
		celda.establecerAtomo(atomo);
	}

	/**
	 * Comprobamos si la fila y la columna pertenece a la matriz.
	 * 
	 * @param fila
	 *            numero de fila
	 * @param columna
	 *            numero de columna
	 * @return boolean devuelve true si la fila y la columna esta dentro del
	 *         tablero
	 */
	public boolean estaEnTablero(int fila, int columna) {
		if ((fila < matriz.size() && fila >= 0) && (columna < matriz.get(0).size() && columna >= 0)) {
			return true;
		} else {
			return false;
		}
	}

	/**
	 * Nos returna la celda asociada a la fila y a la columna o null.
	 * 
	 * @param fila
	 *            numero de fila
	 * @param columna
	 *            numero de columna
	 * @return matriz o null
	 */
	public Celda obtenerCelda(int fila, int columna) {
		if (estaEnTablero(fila, columna) == true) {
			return matriz.get(fila).get(columna);
		} else {
			return null;
		}
	}

	/**
	 * Almacenamos en un arraylist las celdas contiguas a una dada.
	 * 
	 * @param celda
	 *            le pasamos la celda
	 * @return lista nos deuelve las celdas contiguas
	 */
	public List<Celda> obtenerCeldasContiguas(Celda celda) {
		List<Celda> lista = new ArrayList<Celda>();
		Sentido[] sentido = Sentido.values();
		int filacelda = 0, columnacelda = 0;
		filacelda = celda.obtenerFila();
		columnacelda = celda.obtenerColumna();

		for (int i = 0; i < sentido.length; ++i) {
			if (this.estaEnTablero(filacelda + sentido[i].obtenerDesplazamientoFila(),
					columnacelda + sentido[i].obtenerDesplazamientoColumna())) {
				lista.add(obtenerCelda(filacelda + sentido[i].obtenerDesplazamientoFila(),
						columnacelda + sentido[i].obtenerDesplazamientoColumna()));
			}
		}
		return lista;
	}

	/**
	 * Nos devuelve el numero de filas.
	 * 
	 * @return filas
	 */
	public int obtenerNumeroFilas() {
		return matriz.size();
	}

	/**
	 * Nos devuelve el numero de columnas.
	 * 
	 * @return columnas
	 */
	public int obtenerNumeroColumnas() {
		return matriz.get(0).size();
	}

	/**
	 * Nos devuelve el numero de atomos del mismo color.
	 * 
	 * @param color
	 *            le pasamos el color de la ficha
	 * @return resultado
	 */
	public int contarAtomosDeColor(Color color) {
		int resultado = 0;
		for (int i = 0; i < matriz.size(); ++i) {
			for (int j = 0; j < matriz.get(i).size(); ++j) {
				if (matriz.get(i).get(j).estaVacia() == false) {
					if ((matriz.get(i).get(j).obtenerAtomo().obtenerColor() == color)) {
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
					palabra = "--\t";
				} else {
					palabra = obtenerCelda(i, j).obtenerAtomo().obtenerColor().toChar() + "\t";
				}
			}
			palabra = "\n";
		}
		return palabra;
	}
}
