package ar.edu.unq.epers.aterrizar.model

import java.sql.Date
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class CriterioPorFechaDeSalida extends Criterio {
    Date fechaSalida


    override getHQL() {
        " left join vuelo.tramos as tramo "
    }

    override whereClause() {
        ''' trim(tramo.salida)= '«fechaSalida»' '''
    }




}