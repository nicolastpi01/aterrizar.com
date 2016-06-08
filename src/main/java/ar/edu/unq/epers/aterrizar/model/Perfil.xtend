package ar.edu.unq.epers.aterrizar.model

import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List
import java.util.ArrayList
import com.fasterxml.jackson.annotation.JsonProperty
import org.mongojack.ObjectId
import org.mongojack.Id


@Accessors
class Perfil {

	private String username
	private List<Destiny> destinations
	private List<Comment> comments	
	@ObjectId
	@JsonProperty("_id")
	String id
	
	new() {}
	
	new(String username, Destiny destiny) {
		this.username = username
		this.destinations = new ArrayList()
	}
	

	new(String username,  Destiny destiny, List<Comment> comments) {
		this.username = username
		this.destinations = new ArrayList()
		this.comments = comments
	}
	
	def void addComment(Comment c) {
		this.comments.add(c)
	}
	
	def addDestiny(Destiny d) {
		this.destinations.add(d)
	}
	
	def exist(Destiny d) {
		var bool_ret = false
		for(Destiny dest : this.destinations) {
			bool_ret = bool_ret || dest.nombre == d.nombre
		}
			bool_ret
	}
	
	def update(Destiny d, Comment c) {
		for(Destiny dest : this.destinations) {
			if(d.nombre == dest.nombre) dest.addComment(c)
		}
	}
	
	
	
}