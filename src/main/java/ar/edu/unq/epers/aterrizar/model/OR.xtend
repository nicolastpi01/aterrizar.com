package ar.edu.unq.epers.aterrizar.model

import java.util.List
import java.util.ArrayList

class OR extends OperadorLogico {

    override operar(List<VueloOfertado> vuelos1, List<VueloOfertado> vuelos2) {

        var List<VueloOfertado> retList = new ArrayList

        vuelos1.fold(retList)[ result, vuelo |
            if(this.noExisteVuelo(vuelo, vuelos2))
                result.add(vuelo)
            result
        ]

    }

    def noExisteVuelo(VueloOfertado vuelo1, List<VueloOfertado> vuelos1){
        vuelos1.fold(false)[ result, vuelo |
            vuelo.id == vuelo1.id || result
        ]
    }
}