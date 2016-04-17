package ar.edu.unq.epers.aterrizar.model

import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List

/**
 * Created by damian on 4/17/16.
 */
@Accessors
abstract class Criterio {
    String id

    def abstract List<VueloOfertado> validarVuelos(List<VueloOfertado> vuelos)

}
