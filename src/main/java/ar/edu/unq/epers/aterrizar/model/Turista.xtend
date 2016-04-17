package ar.edu.unq.epers.aterrizar.model

/**
 * Created by damian on 4/16/16.
 */
class Turista extends Categoria {

    override precio() {
        precioBase
    }

    new (float precio) {
        super(precio)
    }


}