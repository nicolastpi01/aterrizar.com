package ar.edu.unq.epers.aterrizar.BusquedaHql

import java.sql.Date
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class CriterioPorFechaDeSalida extends Criterio {
    Date fechaSalida


    override getHQL() {
        " "
    }

    override whereClause() {
        ''' trim(tramo.salida)= '«fechaSalida»' '''
    }

}

