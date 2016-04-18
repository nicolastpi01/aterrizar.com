package ar.edu.unq.epers.aterrizar.model


import java.util.List
import java.sql.Date

class CriterioPorFechaDeSalida extends Criterio {
    Date fechaSalida

    override validarVuelos(List<VueloOfertado> vuelos) {
        vuelos.filter[vuelo | vuelo.tieneFechaSalida(fechaSalida)].toList
    }

}