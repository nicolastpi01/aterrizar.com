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
	
	def addComment(Destiny d, Comment c) {
		for(Destiny dest : destinations) {
			if(dest.nombre == d.nombre) dest.add(c)
		}
	}
	
	def addLike(Destiny d, Like l, Usuario u) {
		for(Destiny dest : destinations) {
			if(dest.nombre == d.nombre) dest.addLike(u, l)
		}
	}
	
	def addDislike(Destiny d, Dislike dislike, Usuario u) {
		for(Destiny dest : destinations) {
			if(dest.nombre == d.nombre) dest.addDisLike(u, dislike)
		}
	}
	
	def addVisibility(Destiny d, Visibility visibility) {
		for(Destiny dest : destinations) {
			if(dest.nombre == d.nombre) dest.setVisibility(visibility)
		}
	}
	
	def addVisibility(Destiny d,Comment c, Visibility v) {
		for(Destiny dest : destinations) {
			if(dest.nombre == d.nombre) dest.getComment(c).setVisibility(v)
		}
	}	
	
}