package ar.edu.unq.epers.aterrizar.BusquedaHql

import java.util.List
import ar.edu.unq.epers.aterrizar.model.Criterio

interface OperadorLogico {

    def String unirCriterios (List<Criterio> criteriosSeleccionados)
    def String unirWhereClauses (List<String> criteriosSeleccionados)

}