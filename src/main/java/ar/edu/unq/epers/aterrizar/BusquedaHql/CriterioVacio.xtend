package ar.edu.unq.epers.aterrizar.BusquedaHql

class CriterioVacio extends Criterio {

    override getHQL() {
        ""
    }

    override whereClause() {
        "1=1"
    }

}