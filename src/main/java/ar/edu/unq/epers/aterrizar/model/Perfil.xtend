package ar.edu.unq.epers.aterrizar.model

import java.util.ArrayList

class Perfil {
	ArrayList<Destiny> destinys
	String userName
	
	new() {
		destinys = new ArrayList
	}
	
	new(String userName) {
		destinys = new ArrayList
		this.userName = userName
	}
}