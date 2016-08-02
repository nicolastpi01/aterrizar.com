package ar.edu.unq.epers.aterrizar.model

import org.eclipse.xtend.lib.annotations.Accessors


@Accessors
abstract class Categoria {

    int id
    float precioBase

    abstract def float precio()

}