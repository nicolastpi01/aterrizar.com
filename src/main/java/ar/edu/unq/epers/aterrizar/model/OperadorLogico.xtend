package ar.edu.unq.epers.aterrizar.model

import java.util.List

interface OperadorLogico {

    def String unirCriterios (List<Criterio> criteriosSeleccionados)
    def String unirWhereClauses (List<String> criteriosSeleccionados)

}