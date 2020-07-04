/**
 * 
 */
package juego.control;

import juego.modelo.*;
import juego.util.*;

/**
 * @author Mario Ubierna San Mamés y Jorge Navarro González
 *
 */
public class ArbitroTresEnRaya {

	/**
	 * @param args
	 */

	private static final int NUM_GANADOR = 3;
	private int numeroJugadores;
	private Tablero tablero;
	private boolean juegoAcabado=tablero.estaCompleto();
	private Jugador[] jugadores = new Jugador[2];
	private static boolean obturno = false;
	private static int jugadoresJuegan=0;

	public ArbitroTresEnRaya(int numeroJugadores) {
		this.numeroJugadores = numeroJugadores;
		this.tablero = new Tablero(3, 3);
	}

	public void registrarJugador(String nombre) {
		Color color = null;
		if (jugadoresJuegan == 0)
			color = Color.BLANCO;
		else
			color = Color.NEGRO;
		this.jugadores[jugadoresJuegan++] = new Jugador(nombre, color);
	}

	public Jugador obtenerTurno() {
		if (obturno==true)
			return jugadores[1];
		else
			return jugadores[0];
	}
	
	public boolean esMovimientoLegal(int x, int y) {
		if (tablero.obtenerCelda(x, y).estaVacia())
			return true;
		else
			return false;
	}
	
	public Tablero obtenerTablero() {
		return tablero;
	}
	
	public boolean estaAcabado() {
		if (juegoAcabado==true)
			return true;
		else
			return false;
	}

	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}

}
