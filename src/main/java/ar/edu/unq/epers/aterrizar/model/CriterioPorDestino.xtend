package ar.edu.unq.epers.aterrizar.model

import java.util.List

class CriterioPorDestino extends Criterio {
    String destino

    override validarVuelos(List<VueloOfertado> vuelos) {
        vuelos.filter[vuelo | vuelo.destino == destino].toList
    }

}