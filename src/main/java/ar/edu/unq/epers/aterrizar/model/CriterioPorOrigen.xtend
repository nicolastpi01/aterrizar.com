package ar.edu.unq.epers.aterrizar.model

import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class CriterioPorOrigen extends Criterio {
    String origen

    override getHQL() {
        "vuelo.tramos as tramo where tramo.origen = " + origen
    }

}