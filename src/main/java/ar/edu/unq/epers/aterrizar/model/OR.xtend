package ar.edu.unq.epers.aterrizar.model

import java.util.List
import java.util.ArrayList

class OR implements OperadorLogico{

    override String unirWhereClauses(List<String> criteriosSeleccionados) {
        criteriosSeleccionados.join(" or ")
    }

    override unirCriterios(List<Criterio> criteriosSeleccionados) {
        criteriosSeleccionados.map[it.getHQL].join("  ")
    }


}