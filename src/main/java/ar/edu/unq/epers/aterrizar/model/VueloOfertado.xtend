package ar.edu.unq.epers.aterrizar.model

import java.util.ArrayList
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import java.sql.Date

/**
 * Created by damian on 4/16/16.
 */
@Accessors
class VueloOfertado {
	int id
    var List<Tramo> tramos
    var int precioBase
    var int cantidadTramos
    var long duracion

    protected new(){}

    new(List<Tramo> tramos2, int precio){
        tramos = tramos2
        precioBase = precio
        cantidadTramos = tramos.size
        duracion = this.duracion()
    }

    def cantidadDeTramos(){
        this.tramos.size
    }

    def duracion(){
        tramos.fold(0 as long)[res, tramo | tramo.duracion + res]
    }

    def destino(){
        tramos.last.destino
    }

    def guardarTramo(Tramo tramo){
        this.tramos.add(tramo)
    }

    def tieneFechaLlegada(Date fechaDeLlegada){
        tramos.last.llegada == fechaDeLlegada
    }

    def tieneFechaSalida(Date fechaSalida){
        tramos.last.salida == fechaSalida
    }

    def estaDisponible(){
        tramos.fold(true)[ result, tramo|
            tramo.hayUnAsientoDisponible() && result
        ]
    }

    def tieneOrigen(String origen){
        tramos.last.origen == origen
    }

    def esDirecto(){
        tramos.size == 1
    }

    def tieneCategoriaDeAsientoEnCadaTramo(Categoria cat){
        tramos.fold(true)[result, tramo |
            tramo.tieneCategoriaDeAsiento(cat) && result
        ]
    }

}