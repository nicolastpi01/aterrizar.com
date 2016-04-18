package ar.edu.unq.epers.aterrizar.model

import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

/**
 * Created by damian on 4/18/16.
 */
@Accessors
class CriterioCompuesto extends Criterio{
    List<Criterio> criteriosSeleccionados
    OperadorLogico operador


    override getHQL() {
        operador.unirCriterios(criteriosSeleccionados)
    }


}