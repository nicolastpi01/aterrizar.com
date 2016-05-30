package ar.edu.unq.epers.aterrizar.model

import com.fasterxml.jackson.annotation.JsonProperty
import java.util.ArrayList
import org.eclipse.xtend.lib.annotations.Accessors
import org.mongojack.ObjectId

@Accessors
class Perfil {
	ArrayList<Destiny> destinys
	String userName
	@ObjectId
	@JsonProperty("_id")
	String _id;
	new() {
		destinys = new ArrayList
	}
	
	new(String userName, ArrayList<Destiny> destinys) {
		this.userName = userName
		this.destinys = destinys
	}
	
	new(String id) {
		this._id = id
	}
	
	def add(Destiny d) {
		destinys.add(d)
	}
	
}