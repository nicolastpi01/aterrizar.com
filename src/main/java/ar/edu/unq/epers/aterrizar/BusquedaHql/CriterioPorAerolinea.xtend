package ar.edu.unq.epers.aterrizar.model

import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class CriterioPorAerolinea extends Criterio {

    String aerolinea

    override getHQL() {
        ""
    }

    override whereClause() {
        ''' aerolinea.nombre = '«aerolinea»' '''
    }




}