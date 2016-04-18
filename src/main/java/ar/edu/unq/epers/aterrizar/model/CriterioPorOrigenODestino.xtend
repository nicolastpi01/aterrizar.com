package ar.edu.unq.epers.aterrizar.model

import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class CriterioPorOrigenODestino extends Criterio {
    String origenODestino

    override getHQL() {
        "vuelo.tramos as tramo where tramo.salida = " + origenODestino
    }

}