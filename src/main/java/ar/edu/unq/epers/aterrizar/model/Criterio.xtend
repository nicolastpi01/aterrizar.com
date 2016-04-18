package ar.edu.unq.epers.aterrizar.model

import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List

/**
 * Created by damian on 4/17/16.
 */
@Accessors
abstract class Criterio {
    int id

    def abstract String getHQL()


    def and(Criterio criterio){
        new CriterioCompuesto =>[
            operador = new AND
            criteriosSeleccionados = #[this, criterio]
        ]
    }

}
