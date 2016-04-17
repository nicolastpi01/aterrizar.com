package ar.edu.unq.epers.aterrizar.home

import ar.edu.unq.epers.aterrizar.model.Asiento
import ar.edu.unq.epers.aterrizar.model.Usuario
import org.hibernate.Query

class AsientoHome {
	
	def getAsiento(int id){
		var q = "from Asiento as asiento where asiento.id = :nombreAsiento"
		var query = SessionManager.getSession().createQuery(q) as Query
		
		query.setInteger("nombreAsiento", id)
		var asientos = query.list
		if(asientos.size == 0)
			null
			else 
		return asientos.get(0) as Asiento
	}

	def guardarAsiento(Asiento a) {
		SessionManager.getSession().saveOrUpdate(a)
	}
	
	def reservarAsiento(Usuario u, Asiento a){
		var Asiento asiento = this.getAsiento(a.id)
		asiento.reservarAsiento(u)
		this.guardarAsiento(asiento)
	}
	
	def todosLosAsientos(){
		var q = "from Asiento"
		var query = SessionManager.getSession().createQuery(q) as Query
		
		var asientos = query.list
		asientos
	}
	
	
	
	
}