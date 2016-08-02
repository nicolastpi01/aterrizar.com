package ar.edu.unq.epers.aterrizar.BusquedaHql

import ar.edu.unq.epers.aterrizar.model.Categoria
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class CriterioPorCategoriaDeAsiento extends Criterio {
    Categoria categoriaAsiento

    override getHQL() {
        ''' left outer join asiento.categoria as cat '''
    }

    override whereClause() {
        ''' cat.class = «categoriaAsiento.class.getSimpleName» '''
    }

}