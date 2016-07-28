package ar.edu.unq.epers.aterrizar.home

import java.util.List
import ar.edu.unq.epers.aterrizar.model.Compra
import org.hibernate.Query
import ar.edu.unq.epers.aterrizar.model.Usuario
import ar.edu.unq.epers.aterrizar.model.Tramo
import ar.edu.unq.epers.aterrizar.model.Destiny

class CompraHome {
	
	def todasLasCompras() {
		var q = "from Compra"
		var query = SessionManager.getSession().createQuery(q) as Query
        return query.list as List<Compra>
	}
	
	def todasLasComprasDeUsuario(Usuario usuario) {
    var q = "select compras from Tramo tramo join tramo.compras as compras where compras.user.nombreDeUsuario = :username "
        var query = SessionManager.getSession().createQuery(q) as Query
        query.setString("username", usuario.nombreDeUsuario)
        return query.list as List<Compra>
        	
    }
    
    def todasLasComprasDeTramoConOrigen(String origTramo) {
    	var q = "select compras from Tramo tramo join tramo.compras as compras where compras.origenTramo = :origenTramo"
        var query = SessionManager.getSession().createQuery(q) as Query
        query.setString("origenTramo", origTramo)
        return query.list as List<Compra>
    }
    
    def todasLasComprasDeTramoConDestino(String destTramo) {
    	var q = "select compras from Tramo tramo join tramo.compras as compras where compras.destinoTramo = :destinoTramo"
        var query = SessionManager.getSession().createQuery(q) as Query
        query.setString("destinoTramo", destTramo)
        return query.list as List<Compra>
    }
    
    def tieneCompraEnDestino(Usuario u, Destiny d) {
    	var q = "select compras from Tramo tramo join tramo.compras as compras where compras.destinoTramo = :destinoTramo and compras.username = :username"
        var query = SessionManager.getSession().createQuery(q) as Query
        query.setString("destinoTramo", d.nombre)
        query.setString("username", u.nombreDeUsuario)
        var comprasAux = query.list as List<Compra>
        return comprasAux.size > 0
    }
}