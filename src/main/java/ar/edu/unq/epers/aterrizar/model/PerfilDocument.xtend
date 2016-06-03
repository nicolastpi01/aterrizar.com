package ar.edu.unq.epers.aterrizar.model

import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List
import java.util.ArrayList
import org.mongojack.ObjectId
import com.fasterxml.jackson.annotation.JsonProperty

@Accessors
class PerfilDocument {
	
	
	@ObjectId
	@JsonProperty("_id")
	public String username
	private Destiny destiny
	private List<Comment> comments
	private int likes
	private int dislikes
	private Visibility visibility
	String id
	
	
	
	new(String username, Destiny destiny) {
		this.username = username
		this.destiny = destiny
		this.comments = new ArrayList();
		this.likes = 0
		this.dislikes = 0
	}
	

	new(String username,  Destiny destiny, List<Comment> comments) {
		this.username = username
		this.destiny = destiny
		this.comments = comments
	}
	
	new(String username,  Destiny destiny, List<Comment> comments, Visibility visibility) {
		this.username = username
		this.destiny = destiny
		this.comments = comments
		this.visibility = visibility
	}
	
	def void addlike() {
		likes++
	}
	
	def void addDislike() {
		dislikes++
	}
	
	def void add(Comment c) {
		this.comments.add(c)
	}
	
}