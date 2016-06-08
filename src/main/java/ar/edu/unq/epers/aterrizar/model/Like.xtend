package ar.edu.unq.epers.aterrizar.model

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Like {
	private String username
	
	
	new() {}
	
	new(String username) {
		this.username = username
	}
}