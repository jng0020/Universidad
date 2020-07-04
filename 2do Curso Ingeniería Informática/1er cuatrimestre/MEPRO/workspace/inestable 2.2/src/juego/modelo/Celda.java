/**
 *
 */
package juego.modelo;

/**
 * Clase que nos genera la celda.
 * 
 * @author Mario Ubierna San Mames
 * @author Jorge Navarro Gonzalez
 *
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
	 * Atomo que asociamos a cada celda.
	 */
	private Atomo atomo;
	/**
	 * variable booleana que asociamos a una celda para saber si es ocupable o
	 * no.
	 */
	private boolean ocupable;

	/**
	 * Constructor que nos genera la celda.
	 *
	 * @param fila
	 *            numero de fila
	 * @param columna
	 *            numero de columna
	 */
	public Celda(int fila, int columna) {
		this.fila = fila;
		this.columna = columna;
		ocupable = true;
	}

	/**
	 * Constructor que nos genera la celda y nos genera si es ocupable o no.
	 * 
	 * @param fila
	 *            numero de fila
	 * @param columna
	 *            numero de columna
	 * @param ocupable
	 *            variable de tipo boolean
	 */
	public Celda(int fila, int columna, boolean ocupable) {
		this(fila, columna);
		this.ocupable = ocupable;
	}

	/**
	 * Nos devuelve un boolean dependiendo si la celda es ocupable o no.
	 * 
	 * @return ocupable
	 */
	public boolean esOcupable() {
		return this.ocupable;
	}

	/**
	 * Devuelve el atomo.
	 *
	 * @return atomo
	 */
	public Atomo obtenerAtomo() {
		return this.atomo;
	}

	/**
	 * Asociamos el atomo con la celda.
	 *
	 * @param atomo
	 *            establecemos el atomo
	 */
	public void establecerAtomo(Atomo atomo) {
		this.atomo = atomo;
	}

	/**
	 * Nos indica si la celda esta vacia.
	 *
	 * @return boolean
	 */
	public boolean estaVacia() {
		if (this.atomo == null) {
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
	 * Nos vacia la celda del atomo.
	 */
	public void vaciar() {
		this.atomo.establecerCelda(null);
		this.atomo = null;

	}

	/**
	 * Nos devuelve caracteristicas de esta clase.
	 */
	public String toString() {
		return fila + " <-> " + columna + " <-> " + atomo;
	}

}
