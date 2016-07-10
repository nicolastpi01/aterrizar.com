package ar.edu.unq.epers.aterrizar.model

import ar.edu.unq.epers.aterrizar.exceptions.NoHayAsientoConEsaIdException
import java.sql.Date
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors


@Accessors
class Tramo {

    int id
    var VueloOfertado vuelo
    var List<Asiento> asientos = #[]
    var List<Reserva> reservas = #[]
    var List<Compra> compras = #[]
    var String origen
    var String destino
    var Date llegada
    var Date salida

    new() {}

    new(String orig, String dest) {

        origen = orig
        destino = dest
        llegada = new Date(1000)
        salida = new Date(1500)
    }

    def long duracion() {
        salida.getTime - llegada.getTime
    }

    def agregarAsiento(Asiento asiento) {
        asientos.add(asiento)
    }

    def tieneCategoriaDeAsiento(Categoria cat) {
        asientos.fold(false) [result, asiento |
            asiento.categoria.getClass == cat.getClass || result
        ]
    }

    def validarAsiento(Asiento asiento){
        val valido = asientos.exists[asient | asient.nombre == asiento.nombre]
        if(!valido) {
            throw new NoHayAsientoConEsaIdException
        }
    }

    def List<Asiento> asientosDisponibles(){
        asientos.filter[asiento | asiento.reservadoPorUsuario == null].toList
    }

    def hayUnAsientoDisponible(){
        asientos.fold(false) [result, asiento |

            asiento.estaReservado || result

        ]
    }
    
    def agregarReserva(Reserva r) {
    	reservas.add(r)
    }
    
}