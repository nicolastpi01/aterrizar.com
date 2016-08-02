package ar.edu.unq.epers.aterrizar.BusquedaHql


class MenorDuracion extends Orden{

    override getOrderStatament() {
        "order by vuelo.duracion ASC"
    }

}