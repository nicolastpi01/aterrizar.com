package ar.edu.unq.epers.aterrizar.BusquedaHql

/**
 * Created by damian on 4/22/16.
 */
class MenorCosto extends Orden{

    override getOrderStatament() {
        "order by vuelo.precioBase ASC"
    }

}