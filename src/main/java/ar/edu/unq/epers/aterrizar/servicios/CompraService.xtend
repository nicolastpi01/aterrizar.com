package ar.edu.unq.epers.aterrizar.servicios

import ar.edu.unq.epers.aterrizar.home.SessionManager
import java.util.List
import ar.edu.unq.epers.aterrizar.model.Compra
import ar.edu.unq.epers.aterrizar.home.CompraHome
import ar.edu.unq.epers.aterrizar.model.Usuario
import ar.edu.unq.epers.aterrizar.model.Destiny
import ar.edu.unq.epers.aterrizar.model.Tramo

class CompraService extends BaseService {
	
	def List<Compra> todasLasCompras() {
        SessionManager.runInSession([
        return new CompraHome().todasLasCompras()
    ])
    }
     
    def List<Compra> todasLasCompras(Usuario u, Tramo t) {
        SessionManager.runInSession([
        return new CompraHome().todasLasCompras(u, t)
    ])
    }
    
    
    def List<Compra> todasLasComprasConDestino(Usuario u, Tramo t, String destTramo) {
        SessionManager.runInSession([
        return new CompraHome().todasLasComprasConDestino(u, t, destTramo)
    ])
    }
    
    
    def List<Compra> todasLasComprasConOrigen(Usuario u, Tramo t, String origTramo) {
        SessionManager.runInSession([
        return new CompraHome().todasLasComprasConOrigen(u, t, origTramo)
    ])
    }
    
    // Asi sabemos si un usuario visito un destino
    def tieneCompraEnDestino(Usuario u, Destiny d) {
    	SessionManager.runInSession([
        return new CompraHome().tieneCompraEnDestino(u, d)
    ])
    }
	
}