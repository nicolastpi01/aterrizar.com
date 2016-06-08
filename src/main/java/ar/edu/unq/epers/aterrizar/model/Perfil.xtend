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
	private int likes
	private int dislikes
	@ObjectId
	@JsonProperty("_id")
	String id
	
	new() {}
	
	new(String username, Destiny destiny) {
		this.username = username
		this.destinations = new ArrayList()
		this.comments = new ArrayList()
		this.likes = 0
		this.dislikes = 0
	}
	

	new(String username,  Destiny destiny, List<Comment> comments) {
		this.username = username
		this.destinations = new ArrayList()
		this.comments = comments
	}
	
	
	def void addlike() {
		likes++
	}
	
	def void addDislike() {
		dislikes++
	}
	
	def void addComment(Comment c) {
		this.comments.add(c)
	}
	
	def addDestiny(Destiny d) {
		this.destinations.add(d)
	}
	
}