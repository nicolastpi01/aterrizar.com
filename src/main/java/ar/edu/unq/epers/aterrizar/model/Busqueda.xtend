package ar.edu.unq.epers.aterrizar.model

import org.eclipse.xtend.lib.annotations.Accessors

/**
 * Created by damian on 4/18/16.
 */
@Accessors
class Busqueda {

    Criterio criterio
    Orden orden

    def getHQL(){

        "from VueloOfertado"

//        "select vuelo from Aerolinea aerolinea join (select aerolinea.vuelosOfertados vuelo) where " + criterio.getHQL
    }



}