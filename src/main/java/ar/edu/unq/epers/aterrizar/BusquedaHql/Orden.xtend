package ar.edu.unq.epers.aterrizar.BusquedaHql

import org.eclipse.xtend.lib.annotations.Accessors

/**
 * Created by damian on 4/18/16.
 */
@Accessors
abstract class Orden {
    int id
    def abstract String getOrderStatament()
}