package ar.edu.unq.epers.aterrizar.model

import java.util.List

/**
 * Created by damian on 4/17/16.
 */
abstract class OperadorLogico {

    def abstract List<VueloOfertado> operar(List<VueloOfertado> l1, List<VueloOfertado> l2)
}