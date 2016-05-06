package ar.edu.unq.epers.aterrizar.model

import org.eclipse.xtend.lib.annotations.Accessors

/**
 * Created by damian on 4/18/16.
 */
@Accessors
class Busqueda {
    int id
    Criterio criterio
    Orden orden


    def getHQL(){
        "select distinct vuelo from Aerolinea aerolinea inner join aerolinea.vuelosOfertados as vuelo " +
                criterio.getHQL +
                " where " +
                criterio.whereClause +
                orden.getOrderStatament
    }

    new(){
        criterio = new CriterioVacio
        orden = new OrdenVacio
    }

    new(Criterio c){
        criterio = c
        orden = new OrdenVacio
    }

    new(Orden o){
        criterio = criterio = new CriterioVacio
        orden = o
    }

}