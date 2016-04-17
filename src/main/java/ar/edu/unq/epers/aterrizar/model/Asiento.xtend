package ar.edu.unq.epers.aterrizar.model

import org.eclipse.xtend.lib.annotations.Accessors
import ar.edu.unq.epers.aterrizar.exceptions.AsientoReservadoException

/**
 * Created by damian on 4/16/16.
 */
@Accessors
class Asiento {
    int id
    Usuario reservadoPorUsuario
    Usuario vendidoAUsuario
    Categoria categoria
    
    
    def reservarAsiento(Usuario u){
    	if(estaDisponible)
    	reservadoPorUsuario = u
    	else
    	throw new AsientoReservadoException() 
    }
    
    def estaDisponible(){
    	return reservadoPorUsuario.equals(null)
    }
}