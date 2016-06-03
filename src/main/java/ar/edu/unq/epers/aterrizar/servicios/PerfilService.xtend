package ar.edu.unq.epers.aterrizar.servicios

import ar.edu.unq.epers.aterrizar.model.Destiny
import ar.edu.unq.epers.aterrizar.model.Comment
import ar.edu.unq.epers.aterrizar.model.Perfil
import ar.edu.unq.epers.aterrizar.model.Visibility
import org.eclipse.xtend.lib.annotations.Accessors
import org.mongojack.DBQuery
import ar.edu.unq.epers.aterrizar.home.MongoHome

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
	
	def addDestiny(Perfil p, Destiny d) {
		var perfil = findPerfil(p)
		perfil.add(d)
		updatePerfil(perfil)
	}
	
	
		def insertPerfil(Perfil p) {
		perfilHome.insert(p)
	}
	
	def Destiny findDestiny(Perfil p, Destiny d){
		//var destinos = perfilHome.find(DBQuery.is("_id", d.id))
	    var perfil = findPerfil(p)
		var destino = perfil.destinys.findLast[it.nombre == d.nombre]
		destino
		
		
	}
	
	
	
	def addComment(Perfil p, Destiny d, Comment c){
		var perfil = findPerfil(p)
		var destiny = findDestiny(perfil, d)
		destiny.add(c)
		//p.removeDestino(d)
		//d.add(c)
		//p.add(d)
		//perfilHome.update(p)
		
		perfil.add(destiny)
		updatePerfil(perfil)
		
	} 
	
	def Comment findComment(Perfil p, Destiny d, Comment c){
		var perfil= this.findPerfil(p) 
		var destiny = this.findDestiny(perfil, d)
		var comentario = destiny.comments.findLast[it.description == c.description]
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