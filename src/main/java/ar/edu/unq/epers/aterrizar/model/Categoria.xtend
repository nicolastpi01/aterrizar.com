package ar.edu.unq.epers.aterrizar.model

import org.eclipse.xtend.lib.annotations.Accessors

/**
 * Created by damian on 4/16/16.
 */

@Accessors
abstract class Categoria {

    int id
    float precioBase

    new(float precio){
        this.precioBase = precio
    }
    
    new(int id, float precio){
    	this.id = id
        this.precioBase = precio
    }


    abstract def float precio()


}