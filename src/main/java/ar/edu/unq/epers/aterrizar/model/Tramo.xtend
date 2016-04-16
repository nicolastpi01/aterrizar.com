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
    List<Asiento> asientos = new ArrayList
    var String origen
    var String destino
    var Date llegada
    var Date salida
    var float precioBase

    def agregarAsiento(Asiento asiento){
        asientos.add(asiento)
    }
}