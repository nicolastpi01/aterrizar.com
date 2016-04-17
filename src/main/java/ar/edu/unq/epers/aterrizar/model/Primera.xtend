package ar.edu.unq.epers.aterrizar.model

/**
 * Created by damian on 4/16/16.
 */
class Primera extends Categoria{

    override precio() {
        precioBase + 2000
    }

    new (float precio) {
        super(precio)
    }


}