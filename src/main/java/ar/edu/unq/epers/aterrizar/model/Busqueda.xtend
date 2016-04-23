package ar.edu.unq.epers.aterrizar.model

import org.eclipse.xtend.lib.annotations.Accessors

/**
 * Created by damian on 4/18/16.
 */
@Accessors
class Busqueda {

    Criterio criterio
    Orden orden

    new(){
        criterio = new Criterio{
            override getHQL() {
                ""
            }
            override whereClause() {
                "1=1 "
            }
        }
        orden = new Orden{

            override getOrderStatament() {
                ""
            }
        }
    }

    new(Criterio c){
        criterio = c
        orden = new Orden{

            override getOrderStatament() {
                ""
            }
        }
    }

    new(Orden o){
        criterio = criterio = new Criterio{
            override getHQL() {
                ""
            }
            override whereClause() {
                "1=1 "
            }
        }
        orden = o
    }

    def getHQL(){
        "select distinct vuelo from Aerolinea aerolinea inner join aerolinea.vuelosOfertados as vuelo " + criterio.getHQL + " where " + criterio.whereClause + orden.getOrderStatament
    }
}