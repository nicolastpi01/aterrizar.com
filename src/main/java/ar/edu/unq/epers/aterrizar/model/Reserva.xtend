package ar.edu.unq.epers.aterrizar.model

import ar.edu.unq.epers.aterrizar.exceptions.ImposibleComprarReservaException
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Reserva {
	int id
	Asiento asiento
	String username
	// date? tiempoExpiracion
	
	
	new() {}
	
	new(Asiento asiento) {
		this.asiento = asiento
	}
	
	def reservar(String username) {
		this.username = username
		// inicializar date
	}
	
	def comprar(String username, Tramo tramo) {
		if(esComprable(username)) generarCompra(username, tramo)
		else throw new ImposibleComprarReservaException
	}
	
	def esComprable(String username) {
		return username == username // && esReservaValida(o sea esta dentro de los 5 minutos desde que fue realizada)	
	}
	
	def generarCompra(String username, Tramo tramo) {
		var compra = new Compra(username, asiento, tramo)
		tramo.agregarCompra(compra)
		tramo.sacarReserva(this)
	} 
		
}