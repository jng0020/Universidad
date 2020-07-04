/**
 * 
 */
package juego.control;

import juego.modelo.*;

/**
 * Clase que genera el arbitro abstraco.
 * 
 * @author Mario Ubierna San Mames
 * @author Jorge Navarro Gonzalez
 *
 */
public abstract class ArbitroAbstracto implements Arbitro {
	protected Tablero tablero;
	protected Jugador rojas;
	protected Jugador azules;
	protected Turno turno;

	public ArbitroAbstracto(Tablero tablero, Jugador rojas, Jugador azules) {
		this.tablero = tablero;
		this.rojas = rojas;
		this.azules = azules;
		turno = new Turno(this.rojas, this.azules);
	}

	/**
	 * Metodo que nos devuelve un boolean dependiendo si el movimiento es legal
	 * o no.
	 * 
	 * @param celda
	 *            le pasamos la celda para saber si el movimiento es legal o no
	 * @return boolean devuelve true si es legal el movimiento
	 */
	@Override
	public boolean esMovimientoLegal(Celda celda) {
		int x = celda.obtenerFila();
		int y = celda.obtenerColumna();
		if (tablero.obtenerCelda(x, y).esOcupable() == true) {
			if ((tablero.obtenerCelda(x, y).estaVacia()) || (tablero.obtenerCelda(x, y).obtenerAtomo()
					.obtenerColor() == turno.obtenerJugadorConTurno().obtenerColor()))
				return true;
			else
				return false;
		} else
			return false;
	}

	@Override
	public void cambiarTurno() {
		turno.cambiarTurno();
	}

	/**
	 * Nos devuelve el tablero.
	 * 
	 * @return tablero
	 */
	@Override
	public Tablero obtenerTablero() {
		return tablero;
	}

	/**
	 * Nos devuelve el turno.
	 * 
	 * @return turno
	 */
	@Override
	public Turno obtenerTurno() {
		return turno;
	}

	/*
	 * Nos indica si el juego tiene ganador o no.
	 * 
	 * @return jugador
	 * 
	 * @see juego.control.Arbitro#obtenerGanador()
	 */
	@Override
	public Jugador obtenerGanador() {
		if (estaAcabado() == true) {
			if (tablero.contarAtomosDeColor(Color.ROJO) == 0) {
				return azules;
			} else if (tablero.contarAtomosDeColor(Color.AZUL) == 0) {
				return rojas;
			} else {
				return null;
			}
		}
		return null;
	}

	/*
	 * Comprobamos si el juego esta acabado.
	 * 
	 * @return boolean
	 * 
	 * @see juego.control.Arbitro#estaAcabado()
	 */
	@Override
	public boolean estaAcabado() {
		if (rojas.estaIniciado() && azules.estaIniciado()) {
			if (tablero.contarAtomosDeColor(Color.ROJO) == 0 || tablero.contarAtomosDeColor(Color.AZUL) == 0) {
				return true;
			} else {
				return false;
			}
		}
		return false;
	}
}
