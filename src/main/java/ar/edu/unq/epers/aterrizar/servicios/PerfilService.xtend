package ar.edu.unq.epers.aterrizar.servicios

import ar.edu.unq.epers.aterrizar.model.Destiny
import ar.edu.unq.epers.aterrizar.model.Comment
import ar.edu.unq.epers.aterrizar.model.Perfil
import ar.edu.unq.epers.aterrizar.model.Visibility
import org.eclipse.xtend.lib.annotations.Accessors
import org.mongojack.DBQuery
import ar.edu.unq.epers.aterrizar.home.Collection

@Accessors
class PerfilService {
	Collection<Perfil> perfilHome;
	
	new(Collection<Perfil> perfilHome) {
		this.perfilHome = perfilHome;
	}
	
	def Perfil findPerfil(Perfil p) {
		var perfiles = perfilHome.find(DBQuery.is("userName", p.userName))
		var perfil = perfiles.get(0)
			perfil
	}
	
	def addDestiny(Perfil p, Destiny d) {
		var perfil = findPerfil(p)	
		perfil.add(d)
		insertPerfil(perfil)
	}
	
		def insertPerfil(Perfil p) {
		perfilHome.insert(p)
	}
	/* 
	def Destiny findDestiny(Perfil p, Destiny d) {
		
	}
	

	
	
	
	def addComment(Perfil p, Destiny d, Comment c) {
		
	}
	
	def addMg(Destiny d) {
		
	}
	
	def addnMg(Destiny d) {
		
	}
	def addVisibilityTo(Destiny d, Visibility v) {
		
	}
	
	def addVisibilityTo(Comment c, Visibility v) {
		
	}
	*/
}