package ar.edu.unq.epers.aterrizar.model


import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

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