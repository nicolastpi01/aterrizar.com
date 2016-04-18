package ar.edu.unq.epers.aterrizar.model

import java.util.List

abstract class OperadorLogico {

    abstract def String unirCriterios (List<Criterio> criteriosSeleccionados)

}