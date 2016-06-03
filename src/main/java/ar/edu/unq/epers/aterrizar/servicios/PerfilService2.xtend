package ar.edu.unq.epers.aterrizar.servicios

import ar.edu.unq.epers.aterrizar.model.Destiny
import ar.edu.unq.epers.aterrizar.model.Comment
import ar.edu.unq.epers.aterrizar.model.Perfil
import ar.edu.unq.epers.aterrizar.model.Visibility
import org.eclipse.xtend.lib.annotations.Accessors
import org.mongojack.DBQuery
import ar.edu.unq.epers.aterrizar.home.MongoHome

@Accessors
class PerfilService2 {
	MongoHome<Perfil> perfilHome;
	
	
	new(MongoHome<Perfil> perfilHome) {
		this.perfilHome = perfilHome;
	}
	
	/* 
	def insertDestiny(Perfil p, Destiny d) {
		var PerfilAggregation = new Aggregation(perfilHome)
		//
		//
		//
		//
		var perfiles = perfilHome.find(PerfilAggregation)
		var perfil = perfiles.get(0)
	}
	*/
	def printPerfilUser(Perfil p) {
		var perfiles = perfilHome.aggregate
			.match("userName", "pepe")
			.execute
	}
	
	
}