package ar.edu.unq.epers.aterrizar.model

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Compra {
	int id
	Usuario user
	Asiento asiento
	String origenTramo
	String destinoTramo
	
	
}