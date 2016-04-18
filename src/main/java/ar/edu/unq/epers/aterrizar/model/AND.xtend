package ar.edu.unq.epers.aterrizar.model

import java.util.ArrayList
import java.util.List

class AND extends OperadorLogico {

    override unirCriterios(List<Criterio> criteriosSeleccionados) {
        criteriosSeleccionados.map[it.getHQL].join(" and ")
    }


}