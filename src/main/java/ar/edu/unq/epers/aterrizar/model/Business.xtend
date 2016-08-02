package ar.edu.unq.epers.aterrizar.model

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Business extends Categoria {

    override def precio() {
        precioBase + 1000
    }

    public new (float precio) {
        this.precioBase = precio

    }

    new() {}


}