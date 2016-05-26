package ar.edu.unq.epers.aterrizar.servicios

import ar.edu.unq.epers.aterrizar.home.PerfilHome
import ar.edu.unq.epers.aterrizar.model.Destiny
import com.mongodb.BasicDBObject
import ar.edu.unq.epers.aterrizar.model.Comment
import ar.edu.unq.epers.aterrizar.model.Perfil

class PerfilService {
	PerfilHome<Perfil> perfilHome;
	
	new(PerfilHome<Perfil> perfilHome) {
		this.perfilHome = perfilHome;
	}
	
	def BasicDBObject toDBObjectPerfil(Destiny d) {
    var dBObjectDestiny = new BasicDBObject()
    dBObjectDestiny.append("nombre", d.nombre)
		dBObjectDestiny
	}
	
	def addDestiny(Perfil p) {
		this.perfilHome.insert(p)
	}
	
	def addComment(Destiny d, Comment c) {
		
	}
	
}