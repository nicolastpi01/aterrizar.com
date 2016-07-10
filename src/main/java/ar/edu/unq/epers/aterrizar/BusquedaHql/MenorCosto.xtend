package ar.edu.unq.epers.aterrizar.BusquedaHql

class MenorCosto extends Orden{

    override getOrderStatament() {
        "order by vuelo.precioBase ASC"
    }

}