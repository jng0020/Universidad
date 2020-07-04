package juego.textui;

import juego.util.*;

import java.util.Scanner;

import juego.control.ArbitroAbstracto;
import juego.control.ArbitroInestable;
import juego.modelo.*;
import juego.control.*;

/**
 * Programa principal del juego inestable.
 * 
 * @author Mario Ubierna San Mames
 * @author Jorge Navarro Gonzalez
 */
public class Inestable {
	/**
	 * Nombre de los jugadores.
	 */
	private static String jugadorrojas, jugadorazules;
	/**
	 * Dimensiones del tablero.
	 */
	private static int fila, columna;
	/**
	 * Arbitro.
	 */
	private static String arbitro;
	private static String tablero;
	private static Tablero tableroA = null;
	private static Arbitro arbitroA = null;
	/**
	 * Captura de los datos.
	 */
	private static Scanner scan = new Scanner(System.in);

	/**
	 * Programa Principal.
	 * 
	 * @param args
	 *            argumentos del programa principal
	 */
	public static void main(String[] args) {
		if (args.length == 1 || args.length == 3 || args.length == 5) {
			System.out.println("ERROR: ARGUMENTOS INCOMPLETOS/INCORRECTOS");
			System.exit(0);
		} else if (args.length >= 2) {
			jugadorrojas = args[0];
			jugadorazules = args[1];
			if (args.length >= 4) {
				fila = Integer.parseInt(args[2]);
				columna = Integer.parseInt(args[3]);
				if (fila < 5 || columna < 5 || fila > 9 || columna > 9) {
					System.out.println("ERROR: ARGUMENTOS INCOMPLETOS/INCORRECTOS");
					System.exit(0);
				}
				if (args.length >= 6) {
					arbitro = args[4];
					tablero = args[5];
				}
			}
		}
		if (args.length < 6) {
			arbitro = "clasico";
			tablero = "clasico";
			if (args.length < 4) {
				fila = 5;
				columna = 5;
				if (args.length < 2) {
					jugadorrojas = "ROJAS";
					jugadorazules = "AZULES";
				}
			}
		}
		juego();
	}

	/**
	 * Procedimiento para jugar al inestable.
	 */
	private static void juego() {
		Jugador rojo = new Jugador(jugadorrojas, Color.ROJO);
		Jugador azul = new Jugador(jugadorazules, Color.AZUL);
		if (tablero.compareTo("clasico") == 0) {
			tableroA = new Tablero(fila, columna);
		} else {
			tableroA = new TableroEspecial(fila, columna);
		}
		if (arbitro.compareTo("clasico") == 0) {
			arbitroA = new ArbitroInestable(tableroA, rojo, azul);
		} else {
			arbitroA = new ArbitroInestableOptimizado(tableroA, rojo, azul);
		}

		Jugador ganador;
		Celda celda;
		System.out.println("Bienvenidos " + arbitroA.obtenerTurno().obtenerJugadorConTurno().obtenerNombre() + " y "
				+ arbitroA.obtenerTurno().obtenerJugadorSinTurno().obtenerNombre());
		do {
			System.out.println(tablero());
			do {
				System.out.print("TURNO de " + arbitroA.obtenerTurno().obtenerJugadorConTurno().obtenerNombre()
						+ "\nIntroduzca Coordenadas: ");
				celda = capturarJugada();
			} while (celda == null);
			if (arbitroA.esMovimientoLegal(celda) == true) {
				arbitroA.jugar(celda);
				ganador = arbitroA.obtenerGanador();
			} else {
				System.out.println("");
				System.out.println("Movimiento Incorrecto");
				System.out.println("");
				ganador = null;
			}
		} while (ganador == null);
		System.out.println(tablero());
		System.out.println("\t El GANADOR es: " + ganador.obtenerNombre());
		System.out.println("");
		System.out.println("\t ----GAME OVER----");
		scan.close();
	}

	/**
	 * Transformamos la coordenadas a una celda.
	 * 
	 * @return celda
	 */
	private static Celda capturarJugada() {
		Celda celda = null;
		String valor = scan.nextLine();
		try {
			celda = ConversorJugada.convertir(valor, arbitroA.obtenerTablero());
		} catch (CoordenadasIncorrectasException e) {
			System.out.println("");
			System.out.println("Coordenadas Incorrectas");
			System.out.println("");
		}
		return celda;
	}

	/**
	 * Creamos el tablero con la informacion correspondiente.
	 * 
	 * @return palabra
	 */
	private static String tablero() {
		Tablero tablero = arbitroA.obtenerTablero();
		String palabra = "";
		for (int i = 0; i < tablero.obtenerNumeroFilas(); i++) {
			for (int j = 0; j < tablero.obtenerNumeroColumnas(); j++) {
				if (j == 0) {
					palabra += i + "\t";
				}
				if (tablero.obtenerCelda(i, j).esOcupable() == false) {
					palabra += " || ";
				} else if (tablero.obtenerCelda(i, j).estaVacia()) {
					palabra += " -- ";
				} else {
					palabra += " " + tablero.obtenerCelda(i, j).obtenerAtomo().obtenerColor().toChar()
							+ tablero.obtenerCelda(i, j).obtenerAtomo().obtenerCarga() + " ";
				}
			}
			palabra += "\n";
		}

		palabra += "  \t";
		char caracter = '\u0061';
		for (int i = 0; i < tablero.obtenerNumeroColumnas(); i++) {
			palabra += " " + caracter + "  ";
			caracter++;
		}

		return palabra;

	}
}
