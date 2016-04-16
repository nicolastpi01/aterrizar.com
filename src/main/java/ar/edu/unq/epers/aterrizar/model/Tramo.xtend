package ar.edu.unq.epers.aterrizar.model

import java.sql.Date
import java.util.List

/**
 * Created by damian on 4/16/16.
 */
class Tramo {
    List<Asiento> totalidadDeAsientos
    var String origen
    var String estino
    var Date llegada
    var Date salida
    var float precioBase
}