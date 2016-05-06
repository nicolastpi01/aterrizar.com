package ar.edu.unq.epers.aterrizar.home

import ar.edu.unq.epers.aterrizar.model.Asiento
import ar.edu.unq.epers.aterrizar.model.Usuario
import java.util.List
import org.hibernate.Query
import java.io.Serializable
import javax.persistence.Id

class AsientoHome {


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

//    def <T extends Id> get(T t){
//        var q = ''' from «t.getClass» as asiento where «t.id» = :unAsiento '''
//
//        var query = SessionManager.getSession().createQuery(q) as Query
//        query.setInteger("unAsiento", t.id)
//        var asientos = query.list
//        if(asientos.size == 0)
//            null
//        else
//            return asientos.get(0) as Asiento
//
//    }

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
		for(Asiento a : asientos) {
			aRetornar.add(this.getAsiento(a))
		}
		return aRetornar
	}


}