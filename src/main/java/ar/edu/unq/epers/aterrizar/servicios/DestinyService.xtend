package ar.edu.unq.epers.aterrizar.servicios

import ar.edu.unq.epers.aterrizar.home.DestinyHome
import ar.edu.unq.epers.aterrizar.model.Destiny

class DestinyService {
	DestinyHome<Destiny> destinyHome;
	
	new(DestinyHome<Destiny> destinyHome) {
		this.destinyHome = destinyHome;
	}
	
	def addDestiny(Destiny d) {
		this.destinyHome.insert(d)
	}
}