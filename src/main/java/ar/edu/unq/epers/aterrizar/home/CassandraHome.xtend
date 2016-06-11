package ar.edu.unq.epers.aterrizar.home

import ar.edu.unq.epers.aterrizar.model.Perfil
import com.datastax.driver.core.Session

class CassandraHome {
	private Session cassandraSession
	
	
	new(Session cassandraSession) {
		this.cassandraSession = cassandraSession
	}
	
	
}