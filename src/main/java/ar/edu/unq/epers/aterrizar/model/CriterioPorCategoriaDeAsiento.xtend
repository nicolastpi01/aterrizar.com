package ar.edu.unq.epers.aterrizar.model


import java.util.List

class CriterioPorCategoriaDeAsiento extends Criterio {
    Categoria categoriaAsiento

    override validarVuelos(List<VueloOfertado> vuelos) {
        vuelos.filter[vuelo | vuelo.tieneCategoriaDeAsientoEnCadaTramo(categoriaAsiento)].toList
    }
}