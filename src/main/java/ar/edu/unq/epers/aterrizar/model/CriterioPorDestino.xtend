package ar.edu.unq.epers.aterrizar.model

/**
 * Created by damian on 4/18/16.
 */

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class CriterioPorDestino extends Criterio{
    String destino

    override getHQL() {
        "vuelo.tramos as tramo where tramo.destino = " + destino
    }
}