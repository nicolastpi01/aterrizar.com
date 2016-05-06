package ar.edu.unq.epers.aterrizar.BusquedaHql

import org.eclipse.xtend.lib.annotations.Accessors

/**
 * Created by damian on 4/17/16.
 */
@Accessors
abstract class Criterio {
    int id

    def abstract String getHQL()

    def abstract String whereClause()


    def and(Criterio criterio){
        new CriterioCompuesto =>[
            operador = new OperadorLogico => [operadorAndOr = "and"]
            criteriosSeleccionados = #[this, criterio]
        ]
    }

    def or(Criterio criterio){
        new CriterioCompuesto =>[
            operador = new OperadorLogico => [operadorAndOr = "or"]
            criteriosSeleccionados = #[this, criterio]
        ]
    }

}
