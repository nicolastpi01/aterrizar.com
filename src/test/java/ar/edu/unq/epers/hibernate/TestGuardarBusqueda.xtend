package ar.edu.unq.epers.hibernate

import ar.edu.unq.epers.aterrizar.model.Aerolinea
import ar.edu.unq.epers.aterrizar.model.Business
import ar.edu.unq.epers.aterrizar.model.Busqueda
import ar.edu.unq.epers.aterrizar.model.CriterioPorAerolinea
import ar.edu.unq.epers.aterrizar.model.CriterioPorCategoriaDeAsiento
import ar.edu.unq.epers.aterrizar.model.CriterioPorDestino
import ar.edu.unq.epers.aterrizar.model.CriterioPorFechaDeLlegada
import ar.edu.unq.epers.aterrizar.model.CriterioPorFechaDeSalida
import ar.edu.unq.epers.aterrizar.model.CriterioPorOrigen
import ar.edu.unq.epers.aterrizar.model.Primera
import ar.edu.unq.epers.aterrizar.model.Turista
import ar.edu.unq.epers.aterrizar.model.VueloOfertado
import ar.edu.unq.epers.aterrizar.servicios.AerolineaService
import java.sql.Date
import java.util.List
import org.junit.After
import org.junit.Assert
import org.junit.Before
import org.junit.Test

import static ar.edu.unq.epers.aterrizar.home.SessionManager.resetSessionFactory
import ar.edu.unq.epers.aterrizar.model.MenorCosto
import ar.edu.unq.epers.aterrizar.model.MenorCantidadDeEscalas

/**
 * Created by damian on 4/23/16.
 */
class TestGuardarBusqueda extends TestBase{

    val criterio1 = new CriterioPorAerolinea() => [aerolinea = "Austral"]
    val criterio2 = new CriterioPorAerolinea() => [aerolinea = "Aerolineas Argentinas"]
    val criterio8 = new CriterioPorAerolinea() => [aerolinea = "Lan"]
    val criterio3 = new CriterioPorCategoriaDeAsiento() => [categoriaAsiento = new Primera]
    val criterio10 = new CriterioPorCategoriaDeAsiento() => [categoriaAsiento = new Turista]
    val criterio11 = new CriterioPorCategoriaDeAsiento() => [categoriaAsiento = new Business]
    val criterio4 = new CriterioPorFechaDeSalida() => [fechaSalida = new Date(116,6,16)]
    val criterio5 = new CriterioPorFechaDeLlegada() => [fechaLlegada = new Date(116,07,01)]
    val criterio6 = new CriterioPorOrigen() => [origen = "Buenos Aires"]
    val criterio7 = new CriterioPorDestino() => [destino = "Brasil"]


    var Busqueda busqueda

    var Aerolinea aerolinea1
    var Aerolinea aerolinea2
    var Aerolinea aerolinea3
    var AerolineaService aerolineaService = new AerolineaService


    @After
    def void limpiar(){
        resetSessionFactory
        resetSessionFactory
    }

    @Before
    override setUp(){
        super.setUp
        aerolinea1 = new Aerolinea => [vuelosOfertados = #[vuelo1,vuelo2,vuelo3]
            nombre = "Austral"
        ]
        aerolinea2 = new Aerolinea => [vuelosOfertados = #[vuelo4]
            nombre = "Aerolineas Argentinas"
        ]
        aerolinea3 = new Aerolinea => [vuelosOfertados = #[]
            nombre = "Lan"
        ]


        aerolineaService.guardarAerolinea(aerolinea1)
        aerolineaService.guardarAerolinea(aerolinea2)
        aerolineaService.guardarAerolinea(aerolinea3)

    }

    @Test
    def void guardarBusquedaPorAerolinea(){

        busqueda = new Busqueda() => [criterio = criterio1]
        var vuelos = aerolineaService.buscar(busqueda)

        Assert.assertEquals(vuelos.get(0).getTramos.get(0).origen, "Chile")
        Assert.assertEquals(vuelos.size, 3)
        aerolineaService.guardarBusqueda(busqueda)
    }

    @Test
    def void guardarBusquedaPorCategoriaDeAsiento(){

        busqueda = new Busqueda() => [criterio = criterio3]
        var vuelos = aerolineaService.buscar(busqueda)

        Assert.assertEquals(vuelos.get(0).getTramos.get(0).origen, "Chile")
        Assert.assertEquals(vuelos.size, 3)
        aerolineaService.guardarBusqueda(busqueda)
    }

    @Test
    def void guardarBusquedaPorFechaDeSalida(){

        busqueda = new Busqueda() => [criterio = criterio4]
        var vuelos = aerolineaService.buscar(busqueda)

        aerolineaService.guardarBusqueda(busqueda)
    }

    @Test
    def void guardarBusquedaPorFechaDeLlegada(){

        busqueda = new Busqueda() => [criterio = criterio5]
        var vuelos = aerolineaService.buscar(busqueda)

        aerolineaService.guardarBusqueda(busqueda)
    }
    @Test
    def void guardarBusquedaPorFechaDeOrigen(){

        busqueda = new Busqueda() => [criterio = criterio6]
        var vuelos = aerolineaService.buscar(busqueda)

        aerolineaService.guardarBusqueda(busqueda)
    }

    @Test
    def void guardarBusquedaPorFechaDeDestino(){

        busqueda = new Busqueda() => [criterio = criterio7]
        var vuelos = aerolineaService.buscar(busqueda)

        aerolineaService.guardarBusqueda(busqueda)
    }

    @Test
    def void guardarBusquedaConCriterioCompuesto(){

        busqueda = new Busqueda() => [criterio = criterio7.and(criterio6).or(criterio3)]
        var vuelos = aerolineaService.buscar(busqueda)

        aerolineaService.guardarBusqueda(busqueda)
    }

    @Test
    def void ordernarVuelosPorMenosCosto(){
        var busqueda = new Busqueda(new MenorCosto)
        var List<VueloOfertado> vuelos = aerolineaService.buscar(busqueda)
        vuelos.forEach[println("vuelo 1 : " + it.precioBase)]
        aerolineaService.guardarBusqueda(busqueda)
    }

    @Test
    def void ordernarVuelosPorMenorCantidadDeEscalas(){
        var busqueda = new Busqueda(new MenorCantidadDeEscalas)
        var List<VueloOfertado> vuelos = aerolineaService.buscar(busqueda)
        vuelos.forEach[println("vuelo 1 : " + it.precioBase)]
        aerolineaService.guardarBusqueda(busqueda)

    }




















}