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

	def borrarAsientos(){
		this.borrarCategorias()
		var q = "delete from Asiento "

		SessionManager.getSession().createQuery(q) as Query

	}

	def borrarCategorias(){
		var q = "delete from Categoria "

		SessionManager.getSession().createQuery(q) as Query
	}



}