package ar.edu.unq.epers.aterrizar.model

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
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