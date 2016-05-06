package ar.edu.unq.epers.hibernate

import ar.edu.unq.epers.aterrizar.BusquedaHql.Busqueda
import ar.edu.unq.epers.aterrizar.BusquedaHql.MenorCantidadDeEscalas
import ar.edu.unq.epers.aterrizar.BusquedaHql.MenorCosto
import ar.edu.unq.epers.aterrizar.BusquedaHql.MenorDuracion
import ar.edu.unq.epers.aterrizar.model.VueloOfertado
import java.util.List
import org.junit.Assert
import org.junit.Before
import org.junit.Test

/**
 * Created by damian on 4/22/16.
 */
class TestOrden extends TestBaseAerolinea {

    @Before
    override setUp(){
        super.setUp
    }

    @Test
    def void ordernarVuelosPorMenosCosto(){
        var busqueda = new Busqueda(new MenorCosto)
        var List<VueloOfertado> vuelos = aerolineaService.buscar(busqueda)
        Assert.assertEquals(vuelos.get(0).precioBase, 800)
        vuelos.forEach[println("vuelo 1 : " + it.precioBase)]
        Assert.assertEquals(4, vuelos.size)
    }

    @Test
    def void ordernarVuelosPorMenorCantidadDeEscalas(){
        var busqueda = new Busqueda(new MenorCantidadDeEscalas)
        var List<VueloOfertado> vuelos = aerolineaService.buscar(busqueda)
        vuelos.forEach[println("vuelo 1 : " + it.cantidadTramos)]
        Assert.assertEquals(vuelos.get(0).cantidadTramos, 1)
        Assert.assertEquals(4, vuelos.size)

    }

    @Test
    def void ordernarVuelosPorMenorDuracion(){
        var busqueda = new Busqueda(new MenorDuracion)
        var List<VueloOfertado> vuelos = aerolineaService.buscar(busqueda)
        vuelos.forEach[println("vuelo 1 : " + it.duracion)]
        Assert.assertEquals("-1470020398000", vuelos.get(0).duracion.toString)
        Assert.assertEquals(4, vuelos.size)
    }
}