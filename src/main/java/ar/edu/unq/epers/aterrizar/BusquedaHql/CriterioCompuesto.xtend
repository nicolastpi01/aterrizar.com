package ar.edu.unq.epers.aterrizar.BusquedaHql

import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors


@Accessors
class CriterioCompuesto extends Criterio{
    List<Criterio> criteriosSeleccionados
    OperadorLogico operador

    override getHQL() {
        operador.unirCriterios(criteriosSeleccionados)
    }

    override whereClause() {
        operador.unirWhereClauses(criteriosSeleccionados.map[it.whereClause].toList)
    }


}