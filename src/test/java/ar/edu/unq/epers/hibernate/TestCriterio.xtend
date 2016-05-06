package ar.edu.unq.epers.hibernate

import ar.edu.unq.epers.aterrizar.BusquedaHql.Busqueda
import ar.edu.unq.epers.aterrizar.model.VueloOfertado
import java.util.List
import org.junit.Assert
import org.junit.Before
import org.junit.Test

/**
 * Created by damian on 4/18/16.
 */
class TestCriterio extends TestBaseAerolinea{

    @Before
    override setUp(){
        super.setUp
    }


    @Test
    def void criterioPorAerolinea(){

        busqueda = new Busqueda() => [criterio = criterio1]
        //        Assert.assertEquals("select vuelo from Aerolinea aerolinea join aerolinea.vuelosOfertados as vuelo where aerolinea.nombre = 'Austral' ", busqueda.getHQL)
        var vuelos = aerolineaService.buscar(busqueda)

        Assert.assertEquals(vuelos.get(0).getTramos.get(0).origen, "Chile")
        Assert.assertEquals(vuelos.size, 3)
    }

    @Test
    def void criterioPorUnaAerolineaUOtra(){

        busqueda = new Busqueda() => [criterio = criterio1.or(criterio2)]

        var vuelos = aerolineaService.buscar(busqueda)
        Assert.assertTrue(vuelos.exists[vuelo | vuelo.id == 1])
        Assert.assertTrue(vuelos.exists[vuelo | vuelo.id == 2])
        Assert.assertTrue(vuelos.exists[vuelo | vuelo.id == 4])
        Assert.assertTrue(vuelos.exists[vuelo | vuelo.id == 3])
        Assert.assertEquals(vuelos.size, 4)
    }



    @Test
    def void criterioPorUnaAerolineaUOtra2(){

        busqueda = new Busqueda() => [criterio = criterio2.or(criterio8)]

        var vuelos = aerolineaService.buscar(busqueda)
        Assert.assertEquals(vuelos.findFirst[vuelo | vuelo.id == 4].id, 4)
        Assert.assertEquals(vuelos.size, 1)

    }

    @Test
    def void filtrarPorCategoriaDeAsiento(){

        busqueda = new Busqueda() => [criterio = criterio3]
        var List<VueloOfertado> vuelos = aerolineaService.buscar(busqueda)
        Assert.assertEquals(vuelos.size, 3)
    }

    @Test
    def void filtrarPorCategoriaDeAsiento2(){

        busqueda = new Busqueda() => [criterio = criterio10]
        var List<VueloOfertado> vuelos = aerolineaService.buscar(busqueda)
        Assert.assertEquals(vuelos.size, 0)
    }
    @Test
    def void filtrarPorCategoriaDeAsiento3(){

        busqueda = new Busqueda() => [criterio = criterio11]
        var List<VueloOfertado> vuelos = aerolineaService.buscar(busqueda)
        Assert.assertEquals(vuelos.size, 1)
    }

    @Test
    def void filtrarPorCategoriaDeAsiento4(){

        busqueda = new Busqueda() => [criterio = criterio11.and(criterio3)]
        var List<VueloOfertado> vuelos = aerolineaService.buscar(busqueda)
        Assert.assertEquals(vuelos.size, 0)
    }

    @Test
    def void filtrarPorCategoriaDeAsiento5(){

        busqueda = new Busqueda() => [criterio = criterio11.or(criterio3)]
        var List<VueloOfertado> vuelos = aerolineaService.buscar(busqueda)
        Assert.assertEquals(vuelos.size, 4)
    }

    @Test
    def void filtrarPorOrigen(){
        busqueda = new Busqueda() => [criterio = criterio6]
        var List<VueloOfertado> vuelos = aerolineaService.buscar(busqueda)
        Assert.assertEquals(vuelos.size, 3)
    }


    @Test
    def void filtrarPorDestino(){

        busqueda = new Busqueda() => [criterio = criterio7]

        var List<VueloOfertado> vuelos = aerolineaService.buscar(busqueda)
        Assert.assertEquals(vuelos.size, 1)

    }


    @Test
    def void filtrarPorFechaDeLlegada(){

        busqueda = new Busqueda() => [criterio = criterioPorFechaLlegada]


        var List<VueloOfertado> vuelos = aerolineaService.buscar(busqueda)
        Assert.assertEquals(vuelos.size, 3)

    }

    @Test
    def void filtrarPorFechaDeSalida(){

        busqueda = new Busqueda() => [criterio = criterioPorFechaSalida]


        var List<VueloOfertado> vuelos = aerolineaService.buscar(busqueda)
        Assert.assertEquals(vuelos.size, 1)

    }

    @Test
    def void combinarFiltrosConAndYOr(){

        busqueda = new Busqueda() => [criterio = criterio1.and(criterio3.or(criterioPorFechaSalida.and(criterio6)))]
        var List<VueloOfertado> vuelos = aerolineaService.buscar(busqueda)
        Assert.assertEquals(vuelos.size, 3)

    }

    @Test
    def void combinarFiltrosConAndYOr2(){

        busqueda = new Busqueda() => [criterio = criterioPorFechaSalida.or(criterio1).and(criterio7)]
        var List<VueloOfertado> vuelos = aerolineaService.buscar(busqueda)
        Assert.assertEquals(vuelos.size, 1)

    }



}