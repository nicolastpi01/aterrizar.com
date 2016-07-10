package ar.edu.unq.epers.aterrizar.model

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Reserva {
	int id
	String username
	String nombreAsiento
	String tramoOrigen
	String tramoDestino
}