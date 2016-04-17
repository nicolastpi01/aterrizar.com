package ar.edu.unq.epers.aterrizar.model

import org.eclipse.xtend.lib.annotations.Accessors

/**
 * Created by damian on 4/16/16.
 */

@Accessors
class Categoria {
	String id
	float precio
    def float precio(){
    	return precio
    }

}