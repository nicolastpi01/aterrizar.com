package ar.edu.unq.epers.aterrizar.model

import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors


@Accessors
class Aerolinea {
    int id
    String nombre
    var List<VueloOfertado> vuelosOfertados
}