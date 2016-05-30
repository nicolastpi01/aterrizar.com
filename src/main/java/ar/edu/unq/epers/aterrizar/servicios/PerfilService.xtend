package ar.edu.unq.epers.aterrizar.servicios

import ar.edu.unq.epers.aterrizar.model.Destiny
import ar.edu.unq.epers.aterrizar.model.Comment
import ar.edu.unq.epers.aterrizar.model.Perfil
import ar.edu.unq.epers.aterrizar.model.Visibility
import org.eclipse.xtend.lib.annotations.Accessors
import org.mongojack.DBQuery
import ar.edu.unq.epers.aterrizar.home.MongoHome
import com.mongodb.BasicDBObject

@Accessors
class PerfilService {
	MongoHome<Perfil> perfilHome;
	
	new(MongoHome<Perfil> perfilHome) {
		this.perfilHome = perfilHome;
	}
	
	def Perfil findPerfil(Perfil p) {
		var perfiles = perfilHome.find(DBQuery.is("userName", p.userName))
		var perfil = perfiles.get(0)
			perfil
	}
	
	def insertPerfil(Perfil p) {
		perfilHome.save(p)
	}
	
	
	def addDestiny(Perfil p, Destiny d) {
		var perfil = findPerfil(p)	
		perfil.add(d)
		insertPerfil(perfil)
	}
	
	def findDestiny(Perfil p, Destiny d) {
		var perfil = findPerfil(p)
		var destino = perfil.destinys.findFirst[it.nombre == d.nombre]
		return destino
	}
	  
	def addComment(Perfil p, Destiny d, Comment c) { 
		var dest = findDestiny(p, d)
		dest.add(c)
		p.add(dest)
		insertPerfil(p) 
	}
	
	def addMg(Perfil p, Destiny d) {
		var dest = findDestiny(p, d)
		dest.addMg
		p.add(dest)
		insertPerfil(p)
	}
	
	def addnMg(Perfil p, Destiny d) {
		var dest = findDestiny(p, d)
		dest.addNMg
		p.add(dest)
		insertPerfil(p)
	}
	def addVisibilityTo(Destiny d, Visibility v) {
		
	}
	
	def addVisibilityTo(Comment c, Visibility v) {
		
	}
	
}