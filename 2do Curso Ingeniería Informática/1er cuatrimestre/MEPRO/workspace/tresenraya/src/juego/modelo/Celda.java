/**
 * 
 */
package juego.modelo;

/**
 * Clase que crea las casillas del tablero.
 * 
 * @author Mario Ubierna San Mamés
 * @author Jorge Navarro González
 */
public class Celda {
	/**
	 * Coordenadas de la fila.
	 */
	private int fila;
	/**
	 * Coordenadas de la columna.
	 */
	private int columna;
	/**
	 * Pieza que asociamos a cada celda.
	 */
	private Pieza pieza;

	/**
	 * Constructor que nos genera la celda.
	 * 
	 * @param fila
	 * @param columna
	 */
	public Celda(int fila, int columna) {
		this.fila = fila;
		this.columna = columna;
	}

	/**
	 * Devuelve la pieza.
	 * 
	 * @return pieza
	 */
	public Pieza obtenerPieza() {
		return this.pieza;
	}

	/**
	 * Asociamos la pieza con la celda.
	 * 
	 * @param pieza
	 */
	public void establecerPieza(Pieza pieza) {
		this.pieza = pieza;
	}

	/**
	 * Nos indica si la celda esta vacia.
	 * 
	 * @return boolean
	 */
	public boolean estaVacia() {
		if (this.pieza == null) {
			return true;
		} else {
			return false;
		}
	}

	/**
	 * Nos devuelve la fila.
	 * 
	 * @return fila
	 */
	public int obtenerFila() {
		return this.fila;
	}

	/**
	 * Nos devuelve la columna.
	 * 
	 * @return columna
	 */
	public int obtenerColumna() {
		return this.columna;
	}

	/**
	 * Nos devulve caracteristicas de esta clase.
	 */
	public String toString() {
		return fila + " <-> " + columna + " <-> " + pieza;
	}

}
