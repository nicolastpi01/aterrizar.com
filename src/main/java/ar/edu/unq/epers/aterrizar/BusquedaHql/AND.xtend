package ar.edu.unq.epers.aterrizar.model

import java.util.ArrayList
import java.util.List

class AND implements OperadorLogico{

    override unirCriterios(List<Criterio> criteriosSeleccionados) {
        criteriosSeleccionados.map[it.getHQL].join("  ")
    }


    override String unirWhereClauses(List<String> criteriosSeleccionados) {
        criteriosSeleccionados.join(" and ")
    }




}