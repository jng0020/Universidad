/**
 * 
 */
package juego.modelo;

/**
 * Clase Pieza.
 * 
 * @author Mario Ubierna San Mamés
 * @author Jorge Navarro González
 *
 */
public class Pieza {
	/**
	 * Color asociado a la pieza.
	 */
	private Color color;
	/**
	 * Celda asociada a la pieza.
	 */
	private Celda celda;

	/**
	 * Constructor de Pieza.
	 * 
	 * @param color
	 */
	public Pieza(Color color) {
		this.establecerColor(color);
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
	 * Asociamos la celda.
	 * 
	 * @param celda
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
	 * Nos devuele el estado del objeto Pieza.
	 * 
	 */
	public String toString() {
		return obtenerColor() + " <-> " + obtenerCelda();
	}
}
