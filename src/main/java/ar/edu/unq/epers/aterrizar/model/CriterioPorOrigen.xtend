package ar.edu.unq.epers.aterrizar.model


import java.util.List

class CriterioPorOrigen extends Criterio {
    String origen

    override validarVuelos(List<VueloOfertado> vuelos) {
        vuelos.filter[vuelo | vuelo.tieneOrigen(origen)] as List<VueloOfertado>
    }

}