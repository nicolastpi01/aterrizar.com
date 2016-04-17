package ar.edu.unq.epers.aterrizar.model

/**
 * Created by damian on 4/16/16.
 */
class Business extends Categoria{

    override precio() {
        precioBase + 1000
    }

    new (float precio) {
        super(precio)
    }


}