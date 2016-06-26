package ar.edu.unq.epers.aterrizar.model

import org.eclipse.xtend.lib.annotations.Accessors
import com.datastax.driver.mapping.annotations.UDT

@Accessors
@UDT(name = "like", keyspace = "cassandra")
class Like {
	private String username
	
	
	new() {}
	
	new(String username) {
		this.username = username
	}
}