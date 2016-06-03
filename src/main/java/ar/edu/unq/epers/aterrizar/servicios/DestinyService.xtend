package ar.edu.unq.epers.aterrizar.servicios

import ar.edu.unq.epers.aterrizar.home.MongoHome
import ar.edu.unq.epers.aterrizar.model.Destiny
import org.mongojack.DBQuery

class DestinyService {
	MongoHome<Destiny> destinyHome;
	/* 
	new(MongoHome<Destiny> destinyHome) {
		this.destinyHome = destinyHome;
	}
	
	def addDestiny(Destiny d) {
		this.destinyHome.insert(d)
	}
	
	def get(Destiny d) {
		var destinys = destinyHome.find(DBQuery.is("_id", d._id))
		var destiny = destinys.get(0)
			destiny
	}
	
	def insert(Destiny d) {
		this.destinyHome.insert(d)
	}
	* 
	*/
}