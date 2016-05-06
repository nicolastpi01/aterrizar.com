package ar.edu.unq.epers.aterrizar.servicios

import ar.edu.unq.epers.aterrizar.home.AsientoHome
import ar.edu.unq.epers.aterrizar.home.SessionManager
import ar.edu.unq.epers.aterrizar.home.TramoHome
import ar.edu.unq.epers.aterrizar.model.Asiento
import ar.edu.unq.epers.aterrizar.model.Tramo
import ar.edu.unq.epers.aterrizar.model.Usuario
import java.util.List
import ar.edu.unq.epers.aterrizar.model.VueloOfertado

/**
 * Created by damian on 4/16/16.
 */
class TramoService extends BaseService{


	def guardarTramosEnVuelo(VueloOfertado vuelo, Tramo... listaTramos){
		guardarVueloConTramos(vuelo, listaTramos.toList)
	}

	def guardarVueloConTramos(VueloOfertado vuelo, List<Tramo> listaTramos){

		SessionManager.runInSession([
			val tramoHome = new TramoHome()
			listaTramos.forEach[tramo|
				vuelo.guardarTramo(tramo)
				tramoHome.guardarVuelo(vuelo)
			]
			null
		])

	}


	def asientosDisponibles(Tramo tramo){

		SessionManager.runInSession([
			new TramoHome().asientosDisponiblesEnTramo(tramo)
		]);
	}



}