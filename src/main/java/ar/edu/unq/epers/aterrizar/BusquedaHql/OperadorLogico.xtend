package ar.edu.unq.epers.aterrizar.BusquedaHql

import ar.edu.unq.epers.aterrizar.model.Criterio
import java.util.List

class OperadorLogico{
    String operador

    def unirCriterios(List<Criterio> criteriosSeleccionados) {
        criteriosSeleccionados.map[it.getHQL].join("  ")
    }

    def String unirWhereClauses (List<String> criteriosSeleccionados){
        criteriosSeleccionados.join(" " + operador + " ")
    }

}