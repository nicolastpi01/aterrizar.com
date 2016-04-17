package ar.edu.unq.epers.aterrizar.model

import java.util.List

abstract class OperadorLogico {

    def abstract List<VueloOfertado> operar(List<VueloOfertado> l1, List<VueloOfertado> l2)

    def existeVuelo(VueloOfertado vuelo1, List<VueloOfertado> vuelos1){
        vuelos1.fold(false)[ result, vuelo |
            vuelo.id == vuelo1.id || result
        ]
    }
}