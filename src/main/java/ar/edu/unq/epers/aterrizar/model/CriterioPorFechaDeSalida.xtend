package ar.edu.unq.epers.aterrizar.model


import java.util.List
import java.sql.Date
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class CriterioPorFechaDeSalida extends Criterio {
    Date fechaSalida

    override getHQL() {
        "vuelo.tramos as tramo where tramo.salida = " + fechaSalida
    }



}