/**
 * 
 */
package juego.modelo;

import java.util.ArrayList;
import java.util.List;

import juego.util.Sentido;

/**
 * Clase que nos crea el Tablero Especial.
 * 
 * @author Mario Ubierna San Mames
 * @author Jorge Navarro Gonzalez
 *
 */
public class TableroEspecial extends Tablero {
	/**
	 * Constructor del Tablero Especial.
	 * 
	 * @param filas
	 *            numero de filas
	 * @param columnas
	 *            numero de columnas
	 */

	public TableroEspecial(int filas, int columnas) {
		super(filas, columnas);
		// Indicamos que las esquinas no pueden ser ocupables
		matriz.get(0).set(0, new Celda(0, 0, false));
		matriz.get(0).set(columnas - 1, new Celda(0, columnas - 1, false));
		matriz.get(filas - 1).set(0, new Celda(filas - 1, 0, false));
		matriz.get(filas - 1).set(columnas-1, new Celda(filas - 1, columnas - 1, false));

	}

	/**
	 * Almacenamos en un arraylist las celdas contiguas del tablero especial a
	 * una dada.
	 * 
	 * @param celda
	 *            le pasamos la celda
	 * @return lista nos deuelve las celdas contiguas
	 */
	@Override
	public List<Celda> obtenerCeldasContiguas(Celda celda) {
		List<Celda> lista = new ArrayList<Celda>();
		Sentido[] sentido = Sentido.values();
		int filacelda = 0, columnacelda = 0;
		filacelda = celda.obtenerFila();
		columnacelda = celda.obtenerColumna();

		for (int i = 0; i < sentido.length; ++i) {
			if (this.estaEnTablero(filacelda + sentido[i].obtenerDesplazamientoFila(),
					columnacelda + sentido[i].obtenerDesplazamientoColumna())) {
				if (obtenerCelda(filacelda + sentido[i].obtenerDesplazamientoFila(),
						columnacelda + sentido[i].obtenerDesplazamientoColumna()).esOcupable() == true) {
					lista.add(obtenerCelda(filacelda + sentido[i].obtenerDesplazamientoFila(),
							columnacelda + sentido[i].obtenerDesplazamientoColumna()));
				}
			}
		}
		return lista;
	}
}
