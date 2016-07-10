package ar.edu.unq.epers.aterrizar.BusquedaHql


import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class CriterioPorDestino extends Criterio {
    String destino

    override getHQL() {
        " left join vuelo.tramos as tramo "
    }

    override whereClause() {
        ''' tramo.origen = '«destino»' '''
    }

}