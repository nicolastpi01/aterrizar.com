package ar.edu.unq.epers.aterrizar.servicios

import ar.edu.unq.epers.aterrizar.home.PerfilHome
import ar.edu.unq.epers.aterrizar.model.Destiny
import com.mongodb.BasicDBObject
import ar.edu.unq.epers.aterrizar.model.Comment
import ar.edu.unq.epers.aterrizar.model.Perfil
import ar.edu.unq.epers.aterrizar.model.Visibility

class PerfilService {
	PerfilHome<Perfil> perfilHome;
	
	new(PerfilHome<Perfil> perfilHome) {
		this.perfilHome = perfilHome;
	}
	
	def BasicDBObject toDBObjectPerfil(Perfil p) {
    var dBObjectPerfil = new BasicDBObject()
    dBObjectPerfil.append("userNme", p.userName)
		dBObjectPerfil
	}
	
	def addDestiny(Perfil p, Destiny d) {
		
	}
	
	def addComment(Destiny d, Comment c) {
		
	}
	
	def addMg(Destiny d) {
		
	}
	
	def addnMg(Destiny d) {
		
	}
	def addVisibilityTo(Destiny d, Visibility v) {
		
	}
	
	def addVisibilityTo(Comment c, Visibility v) {
		
	}
	
}