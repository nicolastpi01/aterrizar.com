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
	 
	def todasLasCompras(Usuario usuario, Tramo tramo) {
    var q = "select compras from Tramo tramo join tramo.compras as compras where tramo.id = :tramoId AND compras.user.nombreDeUsuario = :username "
        var query = SessionManager.getSession().createQuery(q) as Query
        query.setString("username", usuario.nombreDeUsuario)
        query.setString("tramoId", tramo.id.toString)
        return query.list as List<Compra>
        	
    }
    
    
    def todasLasComprasConDestino(Usuario usuario, Tramo tramo, String destTramo) {
    	var q = "select compras from Tramo tramo join tramo.compras as compras where tramo.id = :tramoId AND compras.destinoTramo = :destinoTramo AND compras.user.nombreDeUsuario = :username "
        var query = SessionManager.getSession().createQuery(q) as Query
        query.setString("destinoTramo", destTramo)
        query.setString("tramoId", tramo.id.toString)
        query.setString("username", usuario.nombreDeUsuario)
        return query.list as List<Compra>
    }
    
    def todasLasComprasConOrigen(Usuario usuario, Tramo tramo, String origTramo) {
    	var q = "select compras from Tramo tramo join tramo.compras as compras where compras.origenTramo = :origenTramo AND tramo.id = :tramoId AND compras.user.nombreDeUsuario = :username "
        var query = SessionManager.getSession().createQuery(q) as Query
        query.setString("origenTramo", origTramo)
        query.setString("tramoId", tramo.id.toString)
        query.setString("username", usuario.nombreDeUsuario)
        return query.list as List<Compra>
    }
    
    def tieneCompraEnDestino(Usuario usuario, Destiny destino) {
    	var q = "select compras from Tramo tramo join tramo.compras as compras where compras.destinoTramo = :destinoTramo AND compras.user.nombreDeUsuario = :username "
        var query = SessionManager.getSession().createQuery(q) as Query
        query.setString("destinoTramo", destino.nombre) 
        query.setString("username", usuario.nombreDeUsuario)
        var compras = query.list as List<Compra>
        return compras.size > 0
    }
     
    
}