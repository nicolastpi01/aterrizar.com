package ar.edu.unq.epers.aterrizar.model

import ar.edu.unq.epers.aterrizar.exceptions.AsientoReservadoException
import org.eclipse.xtend.lib.annotations.Accessors
import com.sun.swing.internal.plaf.synth.resources.synth

/**
 * Created by damian on 4/16/16.
 */
@Accessors
class Asiento{
    int id
    String nombre
    Usuario reservadoPorUsuario
    Categoria categoria

    def reservarAsiento(Usuario u){
        chequearSiEstaReservado
        reservadoPorUsuario = u
    }

    def chequearSiEstaReservado() {
        if(this.estaReservado)
            throw new AsientoReservadoException("El siento ya está reservado")
    }

    def estaReservado(){
        this.reservadoPorUsuario != null
    }


}