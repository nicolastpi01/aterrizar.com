package ar.edu.unq.epers.aterrizar.model

import org.eclipse.xtend.lib.annotations.Accessors

/**
 * Created by damian on 4/16/16.
 */

@Accessors
abstract class Categoria {

    int id
    float precioBase

    abstract def float precio()

}