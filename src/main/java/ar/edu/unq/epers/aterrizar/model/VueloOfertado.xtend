package ar.edu.unq.epers.aterrizar.model

import java.util.List

/**
 * Created by damian on 4/16/16.
 */
class VueloOfertado {

    var List<Tramo> tramos

    def esDirecto(){
        tramos.size == 1
    }

}