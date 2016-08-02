package ar.edu.unq.epers.aterrizar.model

import java.sql.Date
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import java.util.ArrayList

@Accessors
class Tramo {

    int id
    var VueloOfertado vuelo
    var List<Asiento> asientos = new ArrayList
    var List<Reserva> reservas = new ArrayList
    var List<Compra> compras = new ArrayList
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
         llegada.getTime - salida.getTime
    }


    def tieneCategoriaDeAsiento(Categoria cat) {
        asientos.fold(false) [result, asiento |
            asiento.categoria.getClass == cat.getClass || result
        ]
    }
    
    def agregarReserva(Reserva r) {
    	reservas.add(r)
    }
    
    def agregarCompra(Compra c) {
    	compras.add(c)
    }
    
    def agregarAsiento(Asiento asiento) {
        asientos.add(asiento)
    }
    
}