package ar.edu.unq.epers.aterrizar.BusquedaHql

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class CriterioPorOrigen extends Criterio {
    String origen

    override getHQL() {
        " left join vuelo.tramos as tramo "
    }

    override whereClause() {
        ''' tramo.origen = '«origen»' '''
    }

}