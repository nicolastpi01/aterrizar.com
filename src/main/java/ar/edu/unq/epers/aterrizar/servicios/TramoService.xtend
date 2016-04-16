package ar.edu.unq.epers.aterrizar.servicios

import ar.edu.unq.epers.aterrizar.model.Tramo
import ar.edu.unq.epers.aterrizar.model.Usuario

/**
 * Created by damian on 4/16/16.
 */
class TramoService {

    def guardarTramo(Tramo tramo){
        //TODO
    }

    def reservarAsientoParaUsuarioEnTramo(String codigo, Usuario user,Tramo tramo){
        tramo.reservarAsientoParaUsuarioEnTramo(codigo,user)
    }

}