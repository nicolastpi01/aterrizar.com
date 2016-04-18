package ar.edu.unq.epers.aterrizar.model

import java.sql.Date
import java.util.ArrayList
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import ar.edu.unq.epers.aterrizar.exceptions.NoHayAsientoConEsaIdException

/**
 * Created by damian on 4/16/16.
 */
@Accessors
class Tramo {
	int id
    List<Asiento> asientos = new ArrayList
    var String origen
    var String destino
    var Date llegada
    var Date salida
    var float precioBase
    
    new(){}

    def agregarAsiento(Asiento asiento){
        asientos.add(asiento)
    }

    def tieneCategoriaDeAsiento(Categoria cat){
        asientos.fold(false)[result, asiento |
            asiento.categoria.getClass == cat.getClass || result
        ]
    }

    def reservarAsientoParaUsuarioEnTramo(Asiento asiento, Usuario user){
        var res = asientos.findFirst[asient | asient.id == asiento.id]
        if(res == null)
            throw new NoHayAsientoConEsaIdException
        else
            res.reservadoPorUsuario = user
    }

    def comprarAsientoParaUsuarioEnTramo(Asiento asiento, Usuario user){
        var Asiento res = asientos.findFirst[asient | asient.id == asiento.id]
        if(res == null)
            throw new NoHayAsientoConEsaIdException
        else
            res.vendidoAUsuario = user
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

            asiento.reservado || result

        ]
    }
}