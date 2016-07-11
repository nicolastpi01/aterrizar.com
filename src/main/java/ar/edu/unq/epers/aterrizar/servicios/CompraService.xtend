package ar.edu.unq.epers.aterrizar.servicios

import ar.edu.unq.epers.aterrizar.home.SessionManager
import java.util.List
import ar.edu.unq.epers.aterrizar.model.Compra
import ar.edu.unq.epers.aterrizar.home.CompraHome
import ar.edu.unq.epers.aterrizar.model.Usuario
import ar.edu.unq.epers.aterrizar.model.Destiny

class CompraService extends BaseService {
	
	def List<Compra> todasLasCompras() {
        SessionManager.runInSession([
        return new CompraHome().todasLasCompras()
    ])
    }
    
    def List<Compra> todasLasComprasDeUsuario(Usuario u) {
        SessionManager.runInSession([
        return new CompraHome().todasLasComprasDeUsuario(u)
    ])
    }
    
    def List<Compra> todasLasComprasDeTramoConDestino(String destTramo) {
        SessionManager.runInSession([
        return new CompraHome().todasLasComprasDeTramoConDestino(destTramo)
    ])
    }
    
    def List<Compra> todasLasComprasDeTramoConOrigen(String origTramo) {
        SessionManager.runInSession([
        return new CompraHome().todasLasComprasDeTramoConOrigen(origTramo)
    ])
    }
    
    def tieneCompraEnDestino(Usuario u, Destiny d) {
    	SessionManager.runInSession([
        return new CompraHome().tieneCompraEnDestino(u, d)
    ])
    }
	
}