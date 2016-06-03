package ar.edu.unq.epers.aterrizar.BusquedaHql


/**
 * Created by damian on 4/18/16.
 */

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class CriterioPorDestino extends Criterio{
    String destino

    override getHQL() {
        " left join vuelo.tramos as tramo "
    }

    override whereClause() {
        ''' tramo.origen = '«destino»' '''
    }



}