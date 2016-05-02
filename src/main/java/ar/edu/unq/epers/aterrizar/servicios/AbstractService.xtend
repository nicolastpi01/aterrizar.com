package ar.edu.unq.epers.aterrizar.servicios

import ar.edu.unq.epers.aterrizar.home.AbstractHome

abstract class AbstractService {
	
	var AbstractHome home
	
	new(AbstractHome home){
		this.home = home
	}
	
	abstract def Object get(Object o)
	
	
}