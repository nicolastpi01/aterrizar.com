package ar.edu.unq.epers.aterrizar.BusquedaHql

import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class OperadorLogico {
    String operadorAndOr

    def unirCriterios(List<Criterio> criteriosSeleccionados) {
        criteriosSeleccionados.map[it.getHQL].join("  ")
    }

    def String unirWhereClauses (List<String> criteriosSeleccionados) {
        criteriosSeleccionados.join(" " + operadorAndOr + " ")
    }

}