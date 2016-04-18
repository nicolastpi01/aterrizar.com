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
    boolean reservado
    
    
    def reservarAsiento(Usuario u){
    	
    	
    	
    	reservadoPorUsuario = u
    	reservado = true
    	
    	 
    }
    
    def estaDisponible(){
    	return reservado
    }
	
	def chequear() {
		if(reservado)
		throw new AsientoReservadoException
	}
	
}