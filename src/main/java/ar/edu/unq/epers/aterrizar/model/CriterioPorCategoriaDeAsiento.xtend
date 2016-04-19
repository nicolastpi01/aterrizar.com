package ar.edu.unq.epers.aterrizar.model


import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class CriterioPorCategoriaDeAsiento extends Criterio {
    Categoria categoriaAsiento

    override getHQL() {
        "vuelo.tramos" + categoriaAsiento.getCategoria
    }


}