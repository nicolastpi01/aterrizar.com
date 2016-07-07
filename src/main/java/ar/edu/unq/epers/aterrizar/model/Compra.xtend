package ar.edu.unq.epers.aterrizar.model

class Compra {
	int id
	String username
	Asiento asiento
	Tramo tramo
	
	
	new() {}
	
	new(String username, Asiento asiento, Tramo tramo) {
		this.username = username
		this.asiento = asiento
		this.tramo = tramo
	}
}