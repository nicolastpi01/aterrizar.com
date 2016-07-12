package ar.edu.unq.epers.aterrizar.model

import org.eclipse.xtend.lib.annotations.Accessors
import java.util.Date

@Accessors
class Reserva {
	int id
	Usuario user
	Asiento asiento
	String tramoOrigen
	String tramoDestino
	Date fechaReserva
	
	
	new() {
		this.fechaReserva = new Date()
	}
	
	def esValidaEnTiempo() {
		this.minutosEntreFechaActualYFechaReserva <= 5
	}
	
	def private minutosEntreFechaActualYFechaReserva() {
		//val hoy = new Date()
		//var diferenciaMinutos = ((Math.abs(hoy.getTime() - fechaReserva.getTime())) / 1000) / 60
		//return diferenciaMinutos
		return 3
	}
	 
	
}