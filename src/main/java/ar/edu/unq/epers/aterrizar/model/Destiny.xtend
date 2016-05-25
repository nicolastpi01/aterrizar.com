package ar.edu.unq.epers.aterrizar.model

import com.fasterxml.jackson.annotation.JsonProperty
import org.eclipse.xtend.lib.annotations.Accessors
import org.mongojack.ObjectId

@Accessors
class Destiny {
	String codigo
	@ObjectId
	@JsonProperty("_id")
	String id
	String nombre;
	int precioEstadia;
	
	new() {
	}

	new(String codigo) {
		this.codigo = codigo
	}
}