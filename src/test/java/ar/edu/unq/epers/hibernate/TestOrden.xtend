package ar.edu.unq.epers.hibernate

import ar.edu.unq.epers.aterrizar.model.Aerolinea
import ar.edu.unq.epers.aterrizar.model.Busqueda
import ar.edu.unq.epers.aterrizar.model.MenorCantidadDeEscalas
import ar.edu.unq.epers.aterrizar.model.MenorCosto
import ar.edu.unq.epers.aterrizar.model.MenorDuracion
import ar.edu.unq.epers.aterrizar.model.VueloOfertado
import ar.edu.unq.epers.aterrizar.servicios.AerolineaService
import java.util.List
import org.junit.After
import org.junit.Assert
import org.junit.Before
import org.junit.Test

import static ar.edu.unq.epers.aterrizar.home.SessionManager.resetSessionFactory

/**
 * Created by damian on 4/22/16.
 */
class TestOrden extends TestBase {

    var aerolineaService = new AerolineaService

    @Before
    override setUp(){
        super.setUp
        var aerolinea1 = new Aerolinea => [vuelosOfertados = #[vuelo1,vuelo3]
            nombre = "Austral"
        ]
        var aerolinea2 = new Aerolinea => [vuelosOfertados = #[vuelo4]
            nombre = "Aerolineas Argentinas"
        ]
        var aerolinea3 = new Aerolinea => [vuelosOfertados = #[vuelo5,vuelo2]
            nombre = "Lan"
        ]


        aerolineaService.guardarAerolinea(aerolinea1)
        aerolineaService.guardarAerolinea(aerolinea2)
        aerolineaService.guardarAerolinea(aerolinea3)

    }

    @After
    def void cleanUp(){
        resetSessionFactory
    }

    @Test
    def void ordernarVuelosPorMenosCosto(){
        var busqueda = new Busqueda(new MenorCosto)
        var List<VueloOfertado> vuelos = aerolineaService.buscar(busqueda)
        Assert.assertEquals(vuelos.get(0).precioBase, 800)
        vuelos.forEach[println("vuelo 1 : " + it.precioBase)]
        Assert.assertEquals(5, vuelos.size)
    }

    @Test
    def void ordernarVuelosPorMenorCantidadDeEscalas(){
        var busqueda = new Busqueda(new MenorCantidadDeEscalas)
        var List<VueloOfertado> vuelos = aerolineaService.buscar(busqueda)
        vuelos.forEach[println("vuelo 1 : " + it.cantidadTramos)]
        Assert.assertEquals(vuelos.get(0).cantidadTramos, 1)
        Assert.assertEquals(5, vuelos.size)

    }

    @Test
    def void ordernarVuelosPorMenorDuracion(){
        var busqueda = new Busqueda(new MenorDuracion)
        var List<VueloOfertado> vuelos = aerolineaService.buscar(busqueda)
        Assert.assertEquals(5, vuelos.size)

    }
}