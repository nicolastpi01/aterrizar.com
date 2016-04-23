package ar.edu.unq.epers.aterrizar.model

/**
 * Created by damian on 4/23/16.
 */
class MenorDuracion extends Orden{

    override getOrderStatament() {
        "order by vuelo.duracion desc"
    }

}