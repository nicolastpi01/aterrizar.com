package ar.edu.unq.epers.aterrizar.model

import com.fasterxml.jackson.annotation.JsonProperty
import org.eclipse.xtend.lib.annotations.Accessors
import org.mongojack.ObjectId

@Accessors
class Comment {
	@ObjectId
	@JsonProperty("_id")
	String id
	String description
	Visibility visibility
	
	
	new() {}
	
	new(String desc) {
		this.description = desc
	}
}