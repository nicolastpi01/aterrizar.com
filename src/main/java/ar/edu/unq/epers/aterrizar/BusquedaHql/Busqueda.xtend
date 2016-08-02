package ar.edu.unq.epers.aterrizar.BusquedaHql

import org.eclipse.xtend.lib.annotations.Accessors


@Accessors
class Busqueda {
    int id
    Criterio criterio
    Orden orden

    new() {
        criterio = new CriterioVacio
        orden = new OrdenVacio
    }

    new(Criterio c) {
        criterio = c
        orden = new OrdenVacio
    }

    new(Orden o) {
        criterio = criterio = new CriterioVacio
        orden = o
    }
    
    new(Orden o, Criterio c) {
    	this.criterio = c
    	this.orden = o
    }

}