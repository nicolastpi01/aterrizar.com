package ar.edu.unq.epers.aterrizar.home

import ar.edu.unq.epers.aterrizar.model.Asiento
import ar.edu.unq.epers.aterrizar.model.Tramo
import ar.edu.unq.epers.aterrizar.model.Usuario
import ar.edu.unq.epers.aterrizar.servicios.AsientoService
import ar.edu.unq.epers.aterrizar.servicios.UsuarioService
import org.hibernate.Query
import java.util.List
import ar.edu.unq.epers.aterrizar.exceptions.AsientoReservadoException

/**
 * Created by damian on 4/16/16.
 */
class TramoHome {
	
	def getTramo(String idTramo){
		var q = "from Tramo as tramo where tramo.id = :idTramo"
		var query = SessionManager.getSession().createQuery(q) as Query
		
		query.setString("idTramo", idTramo)
		var tramos = query.list
		if(tramos.size == 0)
			null
			else 
		return tramos.get(0) as Tramo
	}

	def guardarTramo(Tramo a) {
		SessionManager.getSession().saveOrUpdate(a)
	}
	
	

	def reservarAsientoEnTramo(Tramo t, Asiento a, Usuario u){
		//considerar que esta todo actualizado
		
		t.reservarAsientoParaUsuarioEnTramo(a,u)
		this.guardarTramo(t)
		t
		
	}
	
	def reservarVariosAsientosEnTramo(Tramo t, List<Asiento> asientos, Usuario u){
		//Considerar que todo está actualizado
		
		var Asiento asiento
		var service = new AsientoService
		for(Asiento a : asientos){
			t.reservarAsientoParaUsuarioEnTramo(a, u)
		}
		
		this.guardarTramo(t)
		t
	}
	
	def asientosDisponiblesEnTramo(Tramo t){
		var Tramo tramo = this.getTramo(t.id)
		var List<Asiento> asientos = newArrayList
		for(Asiento each : tramo.asientos){
			if(each.estaDisponible){
				asientos.add(each)
			}
			return asientos
		}
	}
	
	
		
	
}