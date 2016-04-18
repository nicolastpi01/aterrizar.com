package ar.edu.unq.epers.aterrizar.servicios

import ar.edu.unq.epers.aterrizar.home.AsientoHome
import ar.edu.unq.epers.aterrizar.home.SessionManager
import ar.edu.unq.epers.aterrizar.home.TramoHome
import ar.edu.unq.epers.aterrizar.model.Asiento
import ar.edu.unq.epers.aterrizar.model.Tramo
import ar.edu.unq.epers.aterrizar.model.Usuario
import java.util.List

/**
 * Created by damian on 4/16/16.
 */
class TramoService {

	def guardarTramo(Tramo tramo){
		SessionManager.runInSession([
			new TramoHome().guardarTramo(tramo)
			Usuario
		]);
	}

	def reservarAsientosParaUsuario(Usuario user, Tramo tramo, Asiento... listaAReservar){
		reservarAsientosParaUsuario(user, tramo, listaAReservar.toList)
	}

	def reservarAsientosParaUsuario(Usuario user, Tramo tramo, List<Asiento> listaAReservar){
		SessionManager.runInSession([
			val asientoHome = new AsientoHome()
			listaAReservar.forEach[asiento|
				tramo.validarAsiento(asiento)
				asiento.reservarAsiento(user)
				asientoHome.guardarAsiento(asiento)
			]
			null
		])
	}




	def liberarAsientosNoCompradosDeUsuario(Tramo tramo, Usuario user){
		tramo.liberarAsientosNoCompradosDeUsuario(user)
	}


	def asientosDisponibles(Tramo tramo){

		SessionManager.runInSession([
			new TramoHome().asientosDisponiblesEnTramo(tramo)
		]);
		//tramo.asientosDisponibles
	}



}