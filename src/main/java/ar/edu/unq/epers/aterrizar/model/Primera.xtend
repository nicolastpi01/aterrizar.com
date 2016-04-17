package ar.edu.unq.epers.aterrizar.model

import org.eclipse.xtend.lib.annotations.Accessors

/**
 * Created by damian on 4/16/16.
 */
@Accessors
class Primera extends Categoria{

    override precio() {
        precioBase + 2000
    }

    new (float precio) {
        super(precio)
    }
    
    new(int id, float precio){
		super(id, precio)
	}


}