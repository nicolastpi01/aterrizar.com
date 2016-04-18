package ar.edu.unq.epers.aterrizar.model

import org.eclipse.xtend.lib.annotations.Accessors

/**
 * Created by damian on 4/16/16.
 */
 @Accessors
class Turista extends Categoria {

   override def precio() {
        precioBase
    }

public new (float precio) {
                this.precioBase = precio

    }

new(){}

}