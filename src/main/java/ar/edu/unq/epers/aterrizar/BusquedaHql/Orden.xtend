package ar.edu.unq.epers.aterrizar.BusquedaHql

import org.eclipse.xtend.lib.annotations.Accessors


@Accessors
abstract class Orden {
    int id
    
    def abstract String getOrderStatament()
}