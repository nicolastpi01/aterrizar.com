package ar.edu.unq.epers.aterrizar.servicios

import ar.edu.unq.epers.aterrizar.model.Tramo
import ar.edu.unq.epers.aterrizar.model.Usuario
import java.util.List
import ar.edu.unq.epers.aterrizar.model.Asiento
import ar.edu.unq.epers.aterrizar.home.TramoHome
import ar.edu.unq.epers.aterrizar.home.SessionManager
import ar.edu.unq.epers.aterrizar.home.AsientoHome
import ar.edu.unq.epers.aterrizar.home.UsuarioHome

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

    def reservarAsientoParaUsuarioEnTramo(Asiento asiento, Usuario usuario,Tramo tramo){
        SessionManager.runInSession([
        	tramo.reservarAsientoParaUsuarioEnTramo(asiento,usuario)
        	new AsientoHome().guardarAsiento(asiento)
			null
        ]);
        
    }

    def reservarAsientosParaUsuario(List<Asiento> listaAReservar, Usuario user, Tramo tramo){
    	SessionManager.runInSession([
    		var List<Asiento> disponibles = this.asientosDisponibles(tramo)
    		var asientosActualizados = new AsientoHome().asientosDeLista(listaAReservar)
    		for(Asiento a : asientosActualizados){
    			if(!disponibles.contains(a))
    			{
    			return Asiento
    			}
    		}
    		var Tramo t = new TramoHome().getTramo(tramo.id)
    		var Usuario u = new UsuarioHome().getUsuario(user.nombreDeUsuario)
    		new TramoHome().reservarVariosAsientosEnTramo(t, asientosActualizados, u) 
        ]);
        //listaAReservar.forEach[asiento | this.reservarAsientoParaUsuarioEnTramo(asiento,user,tramo)]
    }

	/*
    def comprarAsientosParaUsuario(List<Asiento> listaAComprar, Usuario user, Tramo tramo){
        listaAComprar.forEach[asiento | this.comprarAsientoParaUsuarioEnTramo(asiento,user,tramo)]
        this.liberarAsientosNoCompradosDeUsuario(tramo, user)
    }

    def comprarAsientoParaUsuarioEnTramo(Asiento asiento,Usuario user,Tramo tramo){
        tramo.comprarAsientoParaUsuarioEnTramo(asiento,user)
    }

    def liberarAsientosNoCompradosDeUsuario(Tramo tramo, Usuario user){
        tramo.liberarAsientosNoCompradosDeUsuario(user)
    }
    */

    def asientosDisponibles(Tramo tramo){
    	
    	SessionManager.runInSession([
        	new TramoHome().asientosDisponiblesEnTramo(tramo) 
        ]);
		//tramo.asientosDisponibles
    }
    
    
    
}