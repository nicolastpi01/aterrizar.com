package ar.edu.unq.epers.aterrizar.BusquedaHql

import org.eclipse.xtend.lib.annotations.Accessors
import ar.edu.unq.epers.aterrizar.model.Categoria

@Accessors
class CriterioPorCategoriaDeAsiento extends Criterio {
    Categoria categoriaAsiento

    override getHQL() {
        ''' left outer join vuelo.tramos as tramo left outer join tramo.asientos as asiento left outer join asiento.categoria as cat '''
    }

    override whereClause() {
        ''' cat.class = «categoriaAsiento.class.getSimpleName»'''
    }



}