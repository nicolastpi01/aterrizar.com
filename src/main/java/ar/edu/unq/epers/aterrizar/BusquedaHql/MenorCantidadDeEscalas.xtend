package ar.edu.unq.epers.aterrizar.BusquedaHql

class MenorCantidadDeEscalas extends Orden {

    override getOrderStatament() {
        "order by vuelo.cantidadTramos ASC"
    }

}