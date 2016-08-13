package ar.edu.unq.epers.aterrizar.servicios

import ar.edu.unq.epers.aterrizar.BusquedaHql.Busqueda
import ar.edu.unq.epers.aterrizar.model.VueloOfertado
import java.util.List
import ar.edu.unq.epers.aterrizar.home.SessionManager
import ar.edu.unq.epers.aterrizar.home.BusquedaHome
import ar.edu.unq.epers.aterrizar.model.Usuario

class BusquedaService extends BaseService {
	
	
	def List<VueloOfertado> buscarVuelosDisponibles(Busqueda b, Usuario u) {
        SessionManager.runInSession([
        return new BusquedaHome().buscarVuelosDisponibles(b, u)
    ])
    }
	
}