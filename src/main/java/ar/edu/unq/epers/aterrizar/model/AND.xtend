package ar.edu.unq.epers.aterrizar.model

import java.util.ArrayList
import java.util.List

class AND extends OperadorLogico {


    override operar(List<VueloOfertado> vuelos1, List<VueloOfertado> vuelos2) {

        var List<VueloOfertado> retList = new ArrayList

        vuelos1.fold(retList)[ result, vuelo |
            if(this.existeVuelo(vuelo, vuelos2))
                result.add(vuelo)
            result
        ]

    }



}