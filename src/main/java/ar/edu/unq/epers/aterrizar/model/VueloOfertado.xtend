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
	String id
    var List<Tramo> tramos = new ArrayList

    new (String id, List<Tramo> tramos){
    	this.id = id
        this.tramos = tramos
    }

    def destino(){
        tramos.last.destino
    }

    def tieneFechaLlegada(Date fechaDeLlegada){
        tramos.last.llegada == fechaDeLlegada
    }

    def estaDisponible(){
        tramos.fold(true)[ result, tramo|
            tramo.hayUnAsientoDisponible() && result
        ]
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