package ar.edu.unq.epers.aterrizar.model

import java.util.List
import java.util.ArrayList

class OR extends OperadorLogico {

    override unirCriterios(List<Criterio> criteriosSeleccionados) {
        criteriosSeleccionados.map['(' + it.getHQL + ')'].join(" or ")
    }

}