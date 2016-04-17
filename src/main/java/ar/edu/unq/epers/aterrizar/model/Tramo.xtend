package ar.edu.unq.epers.aterrizar.model

import java.sql.Date
import java.util.ArrayList
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

/**
 * Created by damian on 4/16/16.
 */
@Accessors
class Tramo {
	String id
    List<Asiento> asientos = new ArrayList
    var String origen
    var String destino
    var Date llegada
    var Date salida
    var float precioBase

    def agregarAsiento(Asiento asiento){
        asientos.add(asiento)
    }

    def reservarAsientoParaUsuarioEnTramo(Asiento asiento, Usuario user){
        var Asiento asientoAReservar = asientos.filter[asient | asient.codigo == asiento.codigo].get(0)

        asientoAReservar.reservadoPorUsuario = user
    }

    def comprarAsientoParaUsuarioEnTramo(Asiento asiento, Usuario user){
        var Asiento asientoAComprar = asientos.filter[asient | asient.codigo == asiento.codigo].get(0)

        asientoAComprar.vendidoAUsuario = user
    }

    def liberarAsientosNoCompradosDeUsuario(Usuario user){
        asientos.forEach[asiento |
            if(asiento.reservadoPorUsuario == user && !(asiento.vendidoAUsuario == user))
                asiento.reservadoPorUsuario = null
        ]
    }

    def List<Asiento> asientosDisponibles(){
        asientos.filter[asiento | asiento.reservadoPorUsuario == null].toList
    }

    def hayUnAsientoDisponible(){
        asientos.fold(false) [result, asiento |

            asiento.reservadoPorUsuario == null || result

        ]
    }
}