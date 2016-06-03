package ar.edu.unq.epers.aterrizar.model

import org.eclipse.xtend.lib.annotations.Accessors
import org.mongojack.ObjectId
import com.fasterxml.jackson.annotation.JsonProperty

@Accessors
class PerfilDocument {
	@ObjectId
	@JsonProperty("_id")
	public String username
	private Destiny destiny
	private String comment
	private int like
	private int dislike
	private Visibility visibility
	
	
	new(String username,  Destiny destiny) {
		this.username = username
		this.destiny = destiny
	}
	
	new(String username,  Destiny destiny, String comment) {
		
		this.username = username
		this.destiny = destiny
		this.comment = comment
	}
	
	new(String username,  Destiny destiny, String comment, Visibility visibility) {
		this.username = username
		this.destiny = destiny
		this.comment = comment
		this.visibility = visibility
	}
	
	def void addlike() {
		like++
	}
	
	def void addDislike() {
		dislike++
	}
	
}