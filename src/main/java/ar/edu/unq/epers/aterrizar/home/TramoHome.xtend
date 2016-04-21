package ar.edu.unq.epers.aterrizar.home

import ar.edu.unq.epers.aterrizar.model.Asiento
import ar.edu.unq.epers.aterrizar.model.Tramo
import ar.edu.unq.epers.aterrizar.model.Usuario
import ar.edu.unq.epers.aterrizar.servicios.AsientoService
import java.util.List
import org.hibernate.Query
import ar.edu.unq.epers.aterrizar.model.VueloOfertado
import javax.sound.midi.Track
import ar.edu.unq.epers.aterrizar.model.Aerolinea
import java.util.ArrayList
import java.util.LinkedHashSet
import java.util.Set
import java.util.HashSet

/**
 * Created by damian on 4/16/16.
 */
class TramoHome {

	def getTramo(int idTramo){
		var q = "from Tramo as tramo where tramo.id = :idTramo"
		var query = SessionManager.getSession().createQuery(q) as Query

		query.setInteger("idTramo", idTramo)
		var tramos = query.list
		if(tramos.size == 0)
			null
		else
			return tramos.get(0) as Tramo
	}

	def List<VueloOfertado> buscarVuelos(String hquery){
		var query = SessionManager.getSession().createQuery(hquery) as Query
		var list = query.list as List<VueloOfertado>
		list = list.filterNull.toList
		var Set<VueloOfertado> set = new HashSet
		set.addAll(list)
		var List<VueloOfertado> l = new ArrayList
		l.addAll(set)
		l
	}


	def guardarTramo(Tramo a) {
		SessionManager.getSession().saveOrUpdate(a)
	}

	def guardarAerolinea(Aerolinea a){
		SessionManager.getSession().saveOrUpdate(a)
	}

	def guardarVuelo(VueloOfertado vuelo){
		SessionManager.getSession().saveOrUpdate(vuelo)
	}


	def asientosDisponiblesEnTramo(Tramo t){
		var q = "select asientos from Tramo tramo join tramo.asientos as asientos where asientos.reservadoPorUsuario = null"
		var query = SessionManager.getSession().createQuery(q) as Query

		query.list as List<Asiento>

	}




}