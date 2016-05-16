package ar.edu.unq.epers.aterrizar.model

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Message {
	String descripcion
	Usuario sender
	Usuario receiver
	String id
	
}