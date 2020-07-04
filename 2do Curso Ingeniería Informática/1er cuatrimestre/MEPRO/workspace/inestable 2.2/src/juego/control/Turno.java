/**
 *
 */
package juego.control;

import juego.modelo.*;

/**
 * Clase que nos crea el turno.
 * 
 * @author Mario Ubiena San Mames
 * @author Jorge Navarro Gonzalez
 *
 */
public class Turno {
	/**
	 * Variable rojas de tipo Jugador.
	 */
	private Jugador rojas;
	/**
	 * Variable azules de tipo Jugador.
	 */
	private Jugador azules;
	/**
	 * Variable turno de tipo boolean.
	 */
	private boolean turno = true;
	/**
	 * Variable turnoactual de tipo Jugador.
	 */
	private Jugador turnoacutal;
	/**
	 * Variable sinturnoactual de tipo Jugador.
	 */
	private Jugador sinturnoactual;

	/**
	 * Constructor de la clase Turno.
	 * 
	 * @param rojas
	 *            jugador con fichas rojas
	 * @param azules
	 *            jugador con fichas azules
	 */
	public Turno(Jugador rojas, Jugador azules) {
		this.rojas = rojas;
		this.azules = azules;
		cambiarTurno();
	}

	/**
	 * Camabiamos el turno a los jugadores.
	 */
	public void cambiarTurno() {
		if (turno == true) {
			this.turnoacutal = rojas;
			this.sinturnoactual = azules;
			turno = false;
		} else {
			this.turnoacutal = azules;
			this.sinturnoactual = rojas;
			turno = true;
		}
	}

	/**
	 * Devolvemos el jugador con turno actual.
	 * 
	 * @return turnoactual
	 */
	public Jugador obtenerJugadorConTurno() {
		return this.turnoacutal;
	}

	/**
	 * Devolvemos al jugador sin turno actual.
	 * 
	 * @return sinturnoactual
	 */
	public Jugador obtenerJugadorSinTurno() {
		return this.sinturnoactual;
	}

	/**
	 * Nos muestra el estado del objeto.
	 */
	public String toString() {
		return obtenerJugadorConTurno() + " <-> " + obtenerJugadorSinTurno();
	}

}
