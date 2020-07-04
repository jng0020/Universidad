/**
 * 
 */
package juego.modelo;

/**
 * Clase Jugador.
 * 
 * @author Mario Ubierna San Mamés
 * @author Jorge Navarro González
 */
public class Jugador {
	/**
	 * nombre del jugador.
	 */
	private String nombre;
	/**
	 * color asociado al jugador.
	 */
	private Color color;

	/**
	 * Constructor del Jugador.
	 * 
	 * @param nombre
	 * @param color
	 */
	public Jugador(String nombre, Color color) {
		this.nombre = nombre;
		this.color = color;
	}

	/**
	 * No devuelve el color.
	 * 
	 * @return color
	 */
	public Color obtenerColor() {
		return this.color;
	}

	/**
	 * Nos devuelve el nombre del jugador.
	 * 
	 * @return nombre
	 */
	public String obtenerNombre() {
		return this.nombre;
	}

	/**
	 * Nos devuelve la pieza con el color.
	 * 
	 * @return nuevaPieza
	 */
	public Pieza generarPieza() {
		Pieza nuevaPieza = new Pieza(this.color);
		return nuevaPieza;
	}

	/**
	 * Nos devuelve un resumen del jugador.
	 */
	public String toString() {
		return obtenerNombre() + " <-> " + obtenerColor().toChar();
	}
}
