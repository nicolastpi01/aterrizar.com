package ar.edu.unq.epers.hibernate

import ar.edu.unq.epers.aterrizar.BusquedaHql.Busqueda
import ar.edu.unq.epers.aterrizar.BusquedaHql.MenorCantidadDeEscalas
import ar.edu.unq.epers.aterrizar.BusquedaHql.MenorCosto
import ar.edu.unq.epers.aterrizar.model.VueloOfertado
import java.util.List
import org.junit.Assert
import org.junit.Before
import org.junit.Test

/**
 * Created by damian on 4/23/16.
 */
class TestGuardarBusqueda extends TestBaseAerolinea{

    @Before
    override setUp(){
        super.setUp
    }

    @Test
    def void guardarBusquedaPorAerolinea(){

        busqueda = new Busqueda() => [criterio = criterio1]
        var vuelos = aerolineaService.buscar(busqueda)

        Assert.assertEquals(vuelos.get(0).getTramos.get(0).origen, "Chile")
        Assert.assertEquals(vuelos.size, 3)
        servicioBase.guardar(busqueda)
    }

    @Test
    def void guardarBusquedaPorCategoriaDeAsiento(){

        busqueda = new Busqueda() => [criterio = criterio3]
        var vuelos = aerolineaService.buscar(busqueda)

        Assert.assertEquals(vuelos.get(0).getTramos.get(0).origen, "Chile")
        Assert.assertEquals(vuelos.size, 3)
        servicioBase.guardar(busqueda)
    }

    @Test
    def void guardarBusquedaPorFechaDeSalida(){

        busqueda = new Busqueda() => [criterio = criterioPorFechaSalida]
        var vuelos = aerolineaService.buscar(busqueda)

        servicioBase.guardar(busqueda)
    }

    @Test
    def void guardarBusquedaPorFechaDeLlegada(){

        busqueda = new Busqueda() => [criterio = criterioPorFechaLlegada]
        var vuelos = aerolineaService.buscar(busqueda)

        servicioBase.guardar(busqueda)
    }
    @Test
    def void guardarBusquedaPorFechaDeOrigen(){

        busqueda = new Busqueda() => [criterio = criterio6]
        var vuelos = aerolineaService.buscar(busqueda)

        servicioBase.guardar(busqueda)
    }

    @Test
    def void guardarBusquedaPorFechaDeDestino(){

        busqueda = new Busqueda() => [criterio = criterio7]
        var vuelos = aerolineaService.buscar(busqueda)

        servicioBase.guardar(busqueda)
    }

    @Test
    def void guardarBusquedaConCriterioCompuesto(){

        busqueda = new Busqueda() => [criterio = criterio7.and(criterio7)]
        //        var vuelos = aerolineaService.buscar(busqueda)

        //        busqueda = new Busqueda

        servicioBase.guardar(busqueda)
    }

    @Test
    def void ordernarVuelosPorMenosCosto(){
        var busqueda = new Busqueda(new MenorCosto)
        var List<VueloOfertado> vuelos = aerolineaService.buscar(busqueda)
        vuelos.forEach[println("vuelo 1 : " + it.precioBase)]
        servicioBase.guardar(busqueda)
    }

    @Test
    def void ordernarVuelosPorMenorCantidadDeEscalas(){
        var busqueda = new Busqueda(new MenorCantidadDeEscalas)
        var List<VueloOfertado> vuelos = aerolineaService.buscar(busqueda)
        vuelos.forEach[println("vuelo 1 : " + it.precioBase)]
        aerolineaService.guardar(busqueda)

    }























}