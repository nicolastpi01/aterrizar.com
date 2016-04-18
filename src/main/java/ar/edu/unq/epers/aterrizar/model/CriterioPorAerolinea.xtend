package ar.edu.unq.epers.aterrizar.model

import java.util.List

class CriterioPorAerolinea extends Criterio {

    Aerolinea aerolinea

    override validarVuelos(List<VueloOfertado> vuelos) {
        vuelos.filter[this.aerolinea.nombre == aerolinea.nombre].toList
    }

}