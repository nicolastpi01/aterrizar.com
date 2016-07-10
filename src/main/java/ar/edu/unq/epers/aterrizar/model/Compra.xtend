package ar.edu.unq.epers.aterrizar.model

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Compra {
	int id
	String username
	String nombreAsiento
	String origenTramo
	String destinoTramo
}