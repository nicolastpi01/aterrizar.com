package ar.edu.unq.epers.aterrizar.model

import java.sql.Date
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class VueloOfertado {
    int id
    List<Tramo> tramos
    int precioBase
    int cantidadTramos
    long duracion

    protected new() {}

    new(List<Tramo> tramos, int precio) {
        this.tramos = tramos
        this.precioBase = precio
        this.cantidadTramos = tramos.size
        this.duracion = this.getDuracionTotal
        this.tramos.forEach[it.vuelo = this]
    }


    def getDuracionTotal() {
        tramos.fold(0 as long) [res, tramo | tramo.duracion() + res]
    }

    def destino() {
        tramos.last.destino
    }

    def guardarTramo(Tramo tramo) {
        this.tramos.add(tramo)
    }

    def tieneFechaLlegada(Date fechaDeLlegada) {
        tramos.last.llegada == fechaDeLlegada
    }

    def tieneFechaSalida(Date fechaSalida) {
        tramos.last.salida == fechaSalida
    }
	
    def tieneOrigen(String origen) {
        tramos.last.origen == origen
    }

    def esDirecto() {
        tramos.size == 1
    }

    def tieneCategoriaDeAsientoEnCadaTramo(Categoria cat) {
        tramos.fold(true) [result, tramo |
            tramo.tieneCategoriaDeAsiento(cat) && result
        ]
    }

}