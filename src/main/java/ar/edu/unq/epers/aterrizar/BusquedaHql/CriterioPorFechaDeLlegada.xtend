package ar.edu.unq.epers.aterrizar.BusquedaHql

import java.sql.Date
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class CriterioPorFechaDeLlegada extends Criterio {
    Date fechaLlegada

    override getHQL() {
        " "
    }

    override whereClause() {
        ''' trim(tramo.llegada)= '«fechaLlegada»' '''
    }

}