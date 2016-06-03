package ar.edu.unq.epers.aterrizar.servicios

import ar.edu.unq.epers.aterrizar.home.ComentariosHome
import ar.edu.unq.epers.aterrizar.model.Comentario
import ar.edu.unq.epers.aterrizar.model.Destino
import ar.edu.unq.epers.aterrizar.model.Puntuacion
import ar.edu.unq.epers.aterrizar.model.Usuario
import ar.edu.unq.epers.aterrizar.model.Visibilidad

class ComentarioService {
	
	ComentariosHome homeComentario
	SocialNetworkingService redSocial
	
	
	new(ComentariosHome homeComentario,SocialNetworkingService redSocial) {
		this.homeComentario = homeComentario
		this.redSocial = redSocial
	}

	def hacerComentario(Destino destino,Visibilidad visibilidad,Puntuacion puntuacion,String comentario,Usuario user){
		var Comentario newComentario = new Comentario(patenteAuto,visibilidad,calificacion,comentario,user)
		
		var Destino = new Comentario =>[
			
			
			
			
		]
		homeComentario.insertarComentario(newComentario)	
	}
	
	
	def sonAmigos(Usuario usuario1,Usuario usuario2){
		return redSocial.esAmigoDe(usuario1,usuario2)
	}
	
	//Como usuario quiero 
	//poder ver el perfil público de otro usuario, viendo lo que me corresponde según si soy amigo o no.
	
	def soyYo(Usuario usuario1,Usuario usuario2){
		usuario1.nombreDeUsuario.equals(usuario2.nombreDeUsuario)
	}
	
	def verPerfilDe(Usuario usuario1, Usuario usuario2){
		if(soyYo(usuario1,usuario2)){
			homeComentario.traerComentarios(Visibilidad.PRIVADO,usuario2)
		}else if (sonAmigos(usuario1,usuario2)){
			homeComentario.traerComentarios(Visibilidad.AMIGO,usuario2)
		}else{
			homeComentario.traerComentarios(Visibilidad.PUBLICO,usuario2)
		}
	}
}