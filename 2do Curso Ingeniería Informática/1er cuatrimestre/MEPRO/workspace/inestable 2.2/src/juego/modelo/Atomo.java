/**
 *
 */
package juego.modelo;

/**
 * Clase del atomo de la celda.
 * 
 * @author Mario Ubierna San Mames
 * @author Jorge Navarro Gonzalez
 *
 */
public class Atomo {
	/**
	 * Color asociado al atomo.
	 */
	private Color color;
	/**
	 * Celda asociada al atomo.
	 */
	private Celda celda;
	/**
	 * Carga del atomo.
	 */
	private int carga = 1;

	/**
	 * Constructor del Atomo.
	 *
	 * @param color
	 */
	Atomo(Color color) {
		this.establecerColor(color);
	}

	/**
	 * Incrementa la carga actual del atomo.
	 */
	public void incrementarCarga() {
		++carga;
	}

	/**
	 * Cambia el color del atomo dependiendo del color actual.
	 */
	public void cambiarColor() {
		if (color == Color.ROJO) {
			this.color = Color.AZUL;
		} else {
			this.color = Color.ROJO;
		}
	}

	/**
	 * Asociamos el color.
	 *
	 * @param color
	 */
	private void establecerColor(Color color) {
		this.color = color;
	}

	/**
	 * Nos devuelve el color.
	 *
	 * @return color
	 */
	public Color obtenerColor() {
		return this.color;
	}

	/**
	 * Nos devuelve la carga.
	 * 
	 * @return carga
	 */
	public int obtenerCarga() {
		return this.carga;
	}

	/**
	 * Asociamos la celda.
	 *
	 * @param celda
	 *            celda que establecemos
	 */
	public void establecerCelda(Celda celda) {
		this.celda = celda;
	}

	/**
	 * Devuelve la celda.
	 *
	 * @return celda
	 */
	public Celda obtenerCelda() {
		return this.celda;
	}

	/**
	 * Nos devuele el estado del objeto Atomo.
	 *
	 */
	public String toString() {
		return obtenerColor() + " <-> " + obtenerCelda();
	}
}
