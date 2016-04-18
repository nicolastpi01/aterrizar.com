package ar.edu.unq.epers.aterrizar.home

import ar.edu.unq.epers.aterrizar.model.Asiento
import ar.edu.unq.epers.aterrizar.model.Usuario
import org.hibernate.Query

import ar.edu.unq.epers.aterrizar.exceptions.AsientoReservadoException
import java.util.List

class AsientoHome {

	def guardarAsiento(Asiento a) {
		SessionManager.getSession().saveOrUpdate(a)
	}
	
	def reservarAsiento(Usuario u, Asiento a){
		var Asiento asiento = this.getAsiento(a)
		
		
		asiento.reservarAsiento(u)
		this.guardarAsiento(asiento)
			
		}
	
	
	def todosLosAsientos(){
		var q = "from Asiento"
		var query = SessionManager.getSession().createQuery(q) as Query
		
		return query.list
		
	}
	
	def getAsiento(Asiento a){
		var q = "from Asiento as asiento where asiento.id = :unAsiento"
		
		var query = SessionManager.getSession().createQuery(q) as Query
		query.setInteger("unAsiento", a.id)
		var asientos = query.list
		if(asientos.size == 0)
			null
			else 
		return asientos.get(0) as Asiento
		
	}
	
	def borrarAsientos(){
		this.borrarCategorias()
		var q = "delete from Asiento "
		
		SessionManager.getSession().createQuery(q) as Query
		
	}
	
	def borrarCategorias(){
		var q = "delete from Categoria "
		
		SessionManager.getSession().createQuery(q) as Query
	}
	
	
	def asientosDeLista(List<Asiento> asientos){
		var List<Asiento> aRetornar
		for(Asiento a : asientos){
			aRetornar.add(this.getAsiento(a))
		}
		return aRetornar
	}
	
	
}