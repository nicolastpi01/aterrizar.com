package ar.edu.unq.epers.aterrizar.model

/**
 * Created by damian on 4/22/16.
 */
class MenorCosto extends Orden{

    override getOrderStatament() {
        "order by vuelo.precioBase desc"
    }

}