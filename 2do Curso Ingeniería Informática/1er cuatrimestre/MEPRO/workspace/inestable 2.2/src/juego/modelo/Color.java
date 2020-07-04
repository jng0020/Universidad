/**
 * 
 */
package juego.modelo;

/**
 * Enumeracion del color del atomo.
 * 
 * @author Mario Ubierna San Mames
 * @author Jorge Navarro Gonzalez
 *
 */
public enum Color {
	ROJO('O'), AZUL('X');

	/**
	 * El caracter que asociamos al color.
	 */
	private char caracter;

	/**
	 * Asiganmos al caracter el color.
	 * 
	 * @param c
	 */
	private Color(char c) {
		this.caracter = c;
	}

	/**
	 * Nos devuelve la variable caracter.
	 * 
	 * @return caracter
	 */
	public char toChar() {
		return this.caracter;
	}

}
