package ar.edu.unq.epers.aterrizar.model

/**
 * Created by damian on 4/23/16.
 */
class CriterioVacio extends Criterio{

    override getHQL() {
        ""
    }

    override whereClause() {
        "1=1 "
    }

}