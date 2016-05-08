package ar.edu.unq.epers.aterrizar.model

import org.eclipse.xtend.lib.annotations.Accessors

/**
 * Created by damian on 4/16/16.
 */
@Accessors
class Primera extends Categoria{

    override def precio() {
        precioBase + 2000
    }

    public new (float precio) {
        this.precioBase = precio


    }

    new(){
    }


}