package ar.edu.unq.epers.aterrizar.model
import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List

@Accessors
class OperadorCriterio extends Criterio{

    var OperadorLogico op
    var Criterio c1
    var Criterio c2

    new(Criterio c1, Criterio c2, OperadorLogico op){
        this.c1 = c1
        this.c2 = c2
        this.op = op
    }

    override validarVuelos(List<VueloOfertado> vuelos) {
        op.operar(c1.validarVuelos(vuelos), c2.validarVuelos(vuelos))
    }



}