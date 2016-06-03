package ar.edu.unq.epers.aterrizar.model

import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

/**
 * Created by damian on 4/16/16.
 */
@Accessors
class Aerolinea {
    int id
    String nombre
    var List<VueloOfertado> vuelosOfertados
}