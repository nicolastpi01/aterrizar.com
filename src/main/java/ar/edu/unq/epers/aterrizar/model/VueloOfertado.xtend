package ar.edu.unq.epers.aterrizar.model

import java.util.ArrayList
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

/**
 * Created by damian on 4/16/16.
 */
@Accessors
class VueloOfertado {

    var List<Tramo> tramos = new ArrayList

    new (List<Tramo> tramos){
        this.tramos = tramos
    }

    def estaDisponible(){
        tramos.fold(true)[ result, tramo|
            tramo.hayUnAsientoDisponible() && result
        ]

    }

    def esDirecto(){
        tramos.size == 1
    }

}