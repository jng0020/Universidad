/**
 * 
 */
package juego.control;

import juego.modelo.*;

/**
 * Clase que nos genera el arbitro sin las explosiones infinitas.
 * 
 * @author Mario Ubierna San Mames
 * @author Jorge Navarro Gonzalez
 *
 */
public class ArbitroInestableOptimizado extends ArbitroAbstracto {

	/**
	 * Constructor de la clase.
	 * 
	 * @param tablero
	 *            tablero del juego
	 * @param rojas
	 *            jugador con fichas rojas
	 * @param azules
	 *            jugador con fichas azules
	 */
	public ArbitroInestableOptimizado(Tablero tablero, Jugador rojas, Jugador azules) {
		super(tablero, rojas, azules);
	}

	/*
	 * Le pasamos una celda y comenzamos el juego.
	 * 
	 * @param destino pasamos la celda
	 * 
	 * @see juego.control.Arbitro#jugar(juego.modelo.Celda)
	 */
	@Override
	public void jugar(Celda destino) {
		jugando(destino);
		turno.cambiarTurno();
	}

	/**
	 * Le pasamos la celda con la que jugar y realizamos las jugadas.
	 * 
	 * @param destino
	 *            comprobamos todas las condiciones de la celda
	 */
	private void jugando(Celda destino) {
		if (destino.estaVacia() == true) {
			tablero.colocar(turno.obtenerJugadorConTurno().generarAtomo(), destino);
		} else {
			destino.obtenerAtomo().incrementarCarga();
			if (tablero.obtenerCeldasContiguas(destino).size() == destino.obtenerAtomo().obtenerCarga()) {
				destino.vaciar();
				for (int i = 0; i < tablero.obtenerCeldasContiguas(destino).size(); ++i) {
					Celda celda = (Celda) tablero.obtenerCeldasContiguas(destino).get(i);
					boolean seManda = true;
					if (celda.estaVacia() == true) {
						tablero.colocar(turno.obtenerJugadorConTurno().generarAtomo(), celda);
						seManda = false;
					} else {
						if (celda.obtenerAtomo().obtenerColor() != turno.obtenerJugadorConTurno().obtenerColor()) {
							celda.obtenerAtomo().cambiarColor();
						}
					}
					if (seManda == true && estaAcabado() == false) {
						jugando(celda);
					}
				}
			}
		}
	}

	/**
	 * Nos muestra el estado de nuestro objeto.
	 */
	public String toString() {
		return "" + tablero + "<->" + turno;
	}

}
