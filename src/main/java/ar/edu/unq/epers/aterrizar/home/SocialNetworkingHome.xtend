package ar.edu.unq.epers.aterrizar.home

class SocialNetworkingHome {
import ar.edu.unq.epers.aterrizar.model.Usuario
import ar.edu.unq.epers.aterrizar.model.TipoDeRelaciones
import org.eclipse.xtend.lib.annotations.Accessors
import org.neo4j.graphdb.Direction
import org.neo4j.graphdb.DynamicLabel
import org.neo4j.graphdb.GraphDatabaseService
import org.neo4j.graphdb.Node
import org.neo4j.graphdb.RelationshipType
import java.sql.Date

class SocialNetworkingHome {
	GraphDatabaseService graph
	
	new(GraphDatabaseService graph) {
		this.graph = graph
	}
	
	private def userLabel() {
		DynamicLabel.label("User")
	}
	
	def eliminarNodo(Usuario usuario) {
		val nodo = this.getNodo(usuario)
		nodo.relationships.forEach[delete]
		nodo.delete
	}
	
	def crearNodo(Usuario usuario) {
		val node = this.graph.createNode(userLabel)
		node.setProperty("nombreDeUsuario", usuario.nombreDeUsuario)
		node.setProperty("nombreYApellido", usuario.nombreYApellido)
		node.setProperty("email", usuario.email)
		node.setProperty("contrasenia", usuario.contrasenia)
		node.setProperty("nacimiento", usuario.nacimiento)
		node.setProperty("validado", usuario.validado)
	}
	
	def getNodo(Usuario usuario) {
		this.getNodo(usuario.nombreDeUsuario)
	}
	
	def getNodo(String nombreUsuario) {
		this.graph.findNodes(userLabel, "nombreUsuario", nombreUsuario).head
	}
	
	def relacionar(Usuario usuario0, Usuario usuario1, TipoDeRelaciones relacion) {
		val nodo1 = this.getNodo(usuario0);
		val nodo2 = this.getNodo(usuario1);
		nodo1.createRelationshipTo(nodo2, relacion);
	}
	
	def getFriends(Usuario usuario) {
		val nodoUsuario = this.getNodo(usuario)
		val nodoAmigos = this.nodosRelacionados(nodoUsuario, TipoDeRelaciones.AMIGO, Direction.INCOMING)
		nodoAmigos.map[toUsuario].toSet
	}
	
	def getAllFriends(Usuario usuario) {
		
	}
	
	private def toUsuario(Node nodo) {
		new Usuario => [
			nombreDeUsuario = nodo.getProperty("nombreDeUsuario") as String
			nombreYApellido = nodo.getProperty("nombreYApellido") as String
			email = nodo.getProperty("email") as String
			contrasenia = nodo.getProperty("contrasenia") as String
			nacimiento = nodo.getProperty("nacimiento") as Date
			validado = nodo.getProperty("validado") as Boolean
		]
	}
	
	protected def nodosRelacionados(Node nodo, RelationshipType tipo, Direction direccion) {
		nodo.getRelationships(tipo, direccion).map[it.getOtherNode(nodo)]
	}
}