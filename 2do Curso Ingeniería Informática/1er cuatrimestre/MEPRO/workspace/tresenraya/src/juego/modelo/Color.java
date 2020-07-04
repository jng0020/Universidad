/**
 * 
 */
package juego.modelo;

/**
 * Enumeracion del color.
 * 
 * @author Jorge Navarro González
 * @author Mario Ubierna San Mamés
 *
 */
public enum Color {
	BLANCO('O'), NEGRO('X');

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
