package ar.edu.unq.epers.hibernate

import org.junit.Before
import org.junit.After
import org.junit.Test
import ar.edu.unq.epers.aterrizar.model.CriterioPorAerolinea
import ar.edu.unq.epers.aterrizar.model.Busqueda
import org.junit.Assert

/**
 * Created by damian on 4/18/16.
 */
class TestCriterio {

    @Before
    def void setUp(){

    }

    @After
    def void tearDown(){

    }

    @Test
    def void criterioPorAerolinea(){

        val CriterioPorAerolinea criterio1 = new CriterioPorAerolinea() => [aerolinea = "L.A.N."]
        val CriterioPorAerolinea criterio2 = new CriterioPorAerolinea() => [aerolinea = "L.A.N. 2"]

        var Busqueda busqueda = new Busqueda() => [criterio = criterio1.and(criterio2)]

        Assert.assertEquals("select vuelo from Aerolinea aerolinea join aerolinea.vuelos vuelo where aerolinea.nombre = L.A.N. and aerolinea.nombre = L.A.N. 2", busqueda.getHQL)

    }

}