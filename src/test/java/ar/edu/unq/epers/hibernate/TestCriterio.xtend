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
    val CriterioPorAerolinea criterio1 = new CriterioPorAerolinea() => [aerolinea = "L.A.N."]
    val CriterioPorAerolinea criterio2 = new CriterioPorAerolinea() => [aerolinea = "Aerolineas Argentinas"]

    @Before
    def void setUp(){
        val CriterioPorAerolinea criterio1 = new CriterioPorAerolinea() => [aerolinea = "L.A.N."]
        val CriterioPorAerolinea criterio2 = new CriterioPorAerolinea() => [aerolinea = "Aerolineas Argentinas"]
    }

    @After
    def void tearDown(){

    }

    @Test
    def void criterioPorAerolinea(){

        var Busqueda busqueda = new Busqueda() => [criterio = criterio1]

        Assert.assertEquals("select vuelo from Aerolinea aerolinea join aerolinea.vuelos vuelo where aerolinea.nombre = L.A.N.", busqueda.getHQL)

    }

    @Test
    def void criterioPorUnaAerolineaUOtra(){

        var Busqueda busqueda = new Busqueda() => [criterio = criterio1.or(criterio2)]

        Assert.assertEquals("select vuelo from Aerolinea aerolinea join aerolinea.vuelos vuelo where aerolinea.nombre = L.A.N. or aerolinea.nombre = Aerolineas Argentinas", busqueda.getHQL)

    }

}