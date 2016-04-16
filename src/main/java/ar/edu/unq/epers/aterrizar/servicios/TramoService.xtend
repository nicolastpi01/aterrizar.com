package ar.edu.unq.epers.aterrizar.servicios

import ar.edu.unq.epers.aterrizar.model.Tramo
import ar.edu.unq.epers.aterrizar.model.Usuario
import java.util.List
import ar.edu.unq.epers.aterrizar.model.Asiento

/**
 * Created by damian on 4/16/16.
 */
class TramoService {

    def guardarTramo(Tramo tramo){
        //TODO
    }

    def reservarAsientoParaUsuarioEnTramo(Asiento asiento, Usuario user,Tramo tramo){
        //TODO
        tramo.reservarAsientoParaUsuarioEnTramo(asiento,user)
    }

    def reservarAsientosParaUsuario(List<Asiento> listaAReservar, Usuario user, Tramo tramo){
        listaAReservar.forEach[asiento | this.reservarAsientoParaUsuarioEnTramo(asiento,user,tramo)]
    }

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

}