package ar.edu.unq.epers.aterrizar.servicios

import ar.edu.unq.epers.aterrizar.home.SocialNetworkingHome
import ar.edu.unq.epers.aterrizar.model.Usuario
import org.neo4j.graphdb.GraphDatabaseService
import ar.edu.unq.epers.aterrizar.model.TipoDeRelaciones
import ar.edu.unq.epers.aterrizar.model.Message

class SocialNetworkingService {
	
	
	private def createHome(GraphDatabaseService graph) {
		new SocialNetworkingHome(graph)
	}
	
	def eliminarPersona(Usuario user) {
		GraphServiceRunner::run[
			createHome(it).eliminarNodo(user)
			null
		]
	}

	def agregarPersona(Usuario user) {
		GraphServiceRunner::run[
			createHome(it).crearNodo(user);
			null
		]
	}
	
	def agregarMensaje(Message msj) {
		GraphServiceRunner::run[
			createHome(it).crearNodo(msj); 
			null
		]
	}
	
	
	def amigoDe(Usuario usuarioYo, Usuario usuarioMiAmigo) {
		GraphServiceRunner::run[
			val home = createHome(it);
			home.relacionar(usuarioYo, usuarioMiAmigo, TipoDeRelaciones.AMIGO)
			home.relacionar(usuarioMiAmigo, usuarioYo, TipoDeRelaciones.AMIGO)
		]
	}
	
	def friends(Usuario user) {
		GraphServiceRunner::run[
			val home = createHome(it)
			home.getFriends(user)
		]
	}
	
	def allFriends(Usuario user) {
		GraphServiceRunner::run[
			val home = createHome(it)
			home.getAllFriends(user)
		]
	}
	
	def sendMessage(Usuario sender, Usuario receiver, Message msj) {
		GraphServiceRunner::run[
			val home = createHome(it)
			home.sendMsj(sender, receiver, msj)
		]
	}
	
	def theyAreFriends(Usuario miUser, Usuario anotherUser) {
		//var bool_friends = false
		//var my_friends = this.friends(miUser)
		//for(Usuario u : my_friends) {
			//bool_friends = bool_friends || u.id == anotherUser.id
		//}
			//bool_friends
			false
	}

	def getSender(String nombreUsuario) {
		GraphServiceRunner::run[
			val home = createHome(it)
			home.getMensajeRemitente(nombreUsuario) 
		]
	}

	def getReceiver(String nombreUsuario) {
		GraphServiceRunner::run[
			val home = createHome(it)
			home.getMensajeDestinatario(nombreUsuario)
		]
	}


}