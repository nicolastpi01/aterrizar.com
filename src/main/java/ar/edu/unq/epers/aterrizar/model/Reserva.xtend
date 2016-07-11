package ar.edu.unq.epers.aterrizar.model

import org.eclipse.xtend.lib.annotations.Accessors
import java.sql.Date

@Accessors
class Reserva {
	int id
	String username
	String nombreAsiento
	String tramoOrigen
	String tramoDestino
	Date fechaReserva
	
	
	new() {
		this.fechaReserva = new Date(0)
	}
	
	def esValida(String username) {
		this.username == username && !this.estaVencida
	}
	
	def estaVencida() {
		false
	} 
	
}