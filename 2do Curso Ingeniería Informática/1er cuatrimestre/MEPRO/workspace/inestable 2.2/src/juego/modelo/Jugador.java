/**
 *
 */
package juego.modelo;

/**
 * Clase que nos crea el jugador.
 * 
 * @author Mario Ubierna San Mames
 * @author Jorge Navarro Gonzalez
 *
 */
public class Jugador {
	/**
	 * Nombre del jugador.
	 */
	private String nombre;
	/**
	 * Color asociado al jugador.
	 */
	private Color color;
	/**
	 * Variable de tipo boolean.
	 */
	private boolean iniciado;

	/**
	 * Constructor del Jugador.
	 *
	 * @param nombre
	 *            nombre del jugador
	 * @param color
	 *            color asociado al jugador
	 */
	public Jugador(String nombre, Color color) {
		this.nombre = nombre;
		this.color = color;
	}

	/**
	 * Nos indicda si el jugador esta iniciado o no.
	 * 
	 * @return iniciado
	 */
	public boolean estaIniciado() {
		return iniciado;
	}

	/**
	 * Nos genera el atomo y nos lo devuelve.
	 * 
	 * @return nuevoAtomo
	 */
	public Atomo generarAtomo() {
		Atomo nuevoAtomo = new Atomo(this.color);
		iniciado = true;
		return nuevoAtomo;
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
	 * Nos devuelve un resumen del jugador.
	 */
	public String toString() {
		return obtenerNombre() + " <-> " + obtenerColor().toChar();
	}
}
