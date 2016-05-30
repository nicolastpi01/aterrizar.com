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
			
		p.add(d)
		updatePerfil(p)
	}
	
		def insertPerfil(Perfil p) {
		perfilHome.insert(p)
	}
	
	def Destiny findDestiny(Perfil p, Destiny d){
		var perfil = findPerfil(p)
		var destino = perfil.destinys.findFirst[it.nombre == d.nombre]
		destino
		
		
	}
	
	def addComment(Perfil p, Destiny d, Comment c){
		var perfil = findPerfil(p)
		var destino = findDestiny(perfil,d)
		perfil.removeDestino(destino)
		destino.add(c)
		perfil.add(destino)
		perfilHome.update(perfil)
		
	} 
	
	def Comment findComment(Destiny d, Comment c){
		var comentario = d.comments.findFirst[it.description == c.description]
		comentario
	}
	
	def updatePerfil(Perfil p){
		perfilHome.update(p)
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