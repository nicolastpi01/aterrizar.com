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

/**
 * Created by damian on 4/18/16.
 */
class TestCriterio extends TestBase{

    val criterio1 = new CriterioPorAerolinea() => [aerolinea = "Austral"]
    val criterio2 = new CriterioPorAerolinea() => [aerolinea = "Aerolineas Argentinas"]
    val criterio8 = new CriterioPorAerolinea() => [aerolinea = "Lan"]
    val criterio3 = new CriterioPorCategoriaDeAsiento() => [categoriaAsiento = new Primera]
    val criterio10 = new CriterioPorCategoriaDeAsiento() => [categoriaAsiento = new Turista]
    val criterio11 = new CriterioPorCategoriaDeAsiento() => [categoriaAsiento = new Business]
    val criterio4 = new CriterioPorFechaDeSalida() => [fechaSalida = new Date(116,6,16)]
    val criterio5 = new CriterioPorFechaDeLlegada() => [fechaLlegada = new Date(116,07,01)]
    val criterio6 = new CriterioPorOrigen() => [origen = "Buenos Aires"]
    val criterio7 = new CriterioPorDestino() => [destino = "Chubut"]


    var Busqueda busqueda

    var Aerolinea aerolinea1
    var Aerolinea aerolinea2
    var Aerolinea aerolinea3
    var AerolineaService aerolineaService = new AerolineaService


    @After
    def void limpiar(){
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


    //    @Test
    //    def void criterioPorAerolinea(){
    //
    //        busqueda = new Busqueda() => [criterio = criterio1]
    //        //        Assert.assertEquals("select vuelo from Aerolinea aerolinea join aerolinea.vuelosOfertados as vuelo where aerolinea.nombre = 'Austral' ", busqueda.getHQL)
    //        var vuelos = aerolineaService.buscar(busqueda)
    //
    //        Assert.assertEquals(vuelos.get(0).getTramos.get(0).origen, "Chile")
    //        Assert.assertEquals(vuelos.size, 3)
    //    }
    //
    //    @Test
    //    def void criterioPorUnaAerolineaUOtra(){
    //
    //        busqueda = new Busqueda() => [criterio = criterio1.or(criterio2)]
    //
    //        //        Assert.assertEquals("select vuelo from Aerolinea aerolinea join aerolinea.vuelosOfertados as vuelo where (aerolinea.nombre = 'Austral' ) or (aerolinea.nombre = 'Aerolineas Argentinas' )", busqueda.getHQL)
    //        var vuelos = aerolineaService.buscar(busqueda)
    //        Assert.assertTrue(vuelos.exists[vuelo | vuelo.id == 1])
    //        Assert.assertTrue(vuelos.exists[vuelo | vuelo.id == 2])
    //        Assert.assertTrue(vuelos.exists[vuelo | vuelo.id == 4])
    //        Assert.assertEquals(vuelos.size, 4)
    //    }
    //
    //    @Test
    //    def void criterioPorUnaAerolineaUOtra2(){
    //
    //        busqueda = new Busqueda() => [criterio = criterio2.or(criterio8)]
    //
    //        //        Assert.assertEquals("select vuelo from Aerolinea aerolinea join aerolinea.vuelosOfertados as vuelo where (aerolinea.nombre = 'Austral' ) or (aerolinea.nombre = 'Aerolineas Argentinas' )", busqueda.getHQL)
    //        var vuelos = aerolineaService.buscar(busqueda)
    //        Assert.assertTrue(vuelos.exists[vuelo | vuelo.id == 4])
    //        Assert.assertTrue(vuelos.exists[vuelo | vuelo == null]) //????????????
    //        Assert.assertEquals(vuelos.size, 2) // ??????????
    //
    //    }

    @Test
    def void filtrarPorCategoriaDeAsiento(){

        busqueda = new Busqueda() => [criterio = criterio3]
        //        Assert.assertEquals("select vuelo from Aerolinea aerolinea join aerolinea.vuelos vuelo where vuelo.tramos as tramo join tramo.asientos as asiento where asiento.categoria.getCategoria = Primera", busqueda.getHQL)
        var List<VueloOfertado> vuelos = aerolineaService.buscar(busqueda)
        //        Assert.assertTrue(vuelos.exists[vuelo | vuelo.tieneCategoriaDeAsientoEnCadaTramo(new Primera)])
        Assert.assertEquals(vuelos.size, 3)
    }

    @Test
    def void filtrarPorCategoriaDeAsiento2(){

        busqueda = new Busqueda() => [criterio = criterio10]
        //        Assert.assertEquals("select vuelo from Aerolinea aerolinea join aerolinea.vuelos vuelo where vuelo.tramos as tramo join tramo.asientos as asiento where asiento.categoria.getCategoria = Primera", busqueda.getHQL)
        var List<VueloOfertado> vuelos = aerolineaService.buscar(busqueda)
        //        Assert.assertTrue(vuelos.exists[vuelo | vuelo.tieneCategoriaDeAsientoEnCadaTramo(new Primera)])
        Assert.assertEquals(vuelos.size, 0)
    }
    @Test
    def void filtrarPorCategoriaDeAsiento3(){

        busqueda = new Busqueda() => [criterio = criterio11]
        //        Assert.assertEquals("select vuelo from Aerolinea aerolinea join aerolinea.vuelos vuelo where vuelo.tramos as tramo join tramo.asientos as asiento where asiento.categoria.getCategoria = Primera", busqueda.getHQL)
        var List<VueloOfertado> vuelos = aerolineaService.buscar(busqueda)
        Assert.assertEquals(vuelos.size, 1)
    }

    @Test
    def void filtrarPorCategoriaDeAsiento4(){

        busqueda = new Busqueda() => [criterio = criterio11.and(criterio3)]
        //        Assert.assertEquals("select vuelo from Aerolinea aerolinea join aerolinea.vuelos vuelo where vuelo.tramos as tramo join tramo.asientos as asiento where asiento.categoria.getCategoria = Primera", busqueda.getHQL)
        var List<VueloOfertado> vuelos = aerolineaService.buscar(busqueda)
        Assert.assertEquals(vuelos.size, 0)
    }

    @Test
    def void filtrarPorCategoriaDeAsiento5(){

        busqueda = new Busqueda() => [criterio = criterio11.or(criterio3)]
        //        Assert.assertEquals("select vuelo from Aerolinea aerolinea join aerolinea.vuelos vuelo where vuelo.tramos as tramo join tramo.asientos as asiento where asiento.categoria.getCategoria = Primera", busqueda.getHQL)
        var List<VueloOfertado> vuelos = aerolineaService.buscar(busqueda)
        Assert.assertEquals(vuelos.size, 4)
    }
    //
    //    @Test
    //    def void filtrarPorFechaDeSalida(){
    //
    //        busqueda = new Busqueda() => [criterio = criterio4]
    //        Assert.assertEquals("select vuelo from Aerolinea aerolinea join aerolinea.vuelos vuelo where vuelo.tramos as tramo where tramo.salida = 2016-07-16", busqueda.getHQL)
    //
    //    }
    //
    //    @Test
    //    def void filtrarPorFechaDeLlegada(){
    //
    //        busqueda = new Busqueda() => [criterio = criterio5]
    //        Assert.assertEquals("select vuelo from Aerolinea aerolinea join aerolinea.vuelos vuelo where vuelo.tramos as tramo where tramo.salida = 2016-08-01", busqueda.getHQL)
    //
    //    }
    //
    //    @Test
    //    def void filtrarPorOrigen(){
    //
    //        busqueda = new Busqueda() => [criterio = criterio6]
    //        Assert.assertEquals("select vuelo from Aerolinea aerolinea join aerolinea.vuelos vuelo where vuelo.tramos as tramo where tramo.origen = Buenos Aires", busqueda.getHQL)
    //
    //    }
    //
    //    @Test
    //    def void filtrarPorDestino(){
    //
    //        busqueda = new Busqueda() => [criterio = criterio7]
    //        Assert.assertEquals("select vuelo from Aerolinea aerolinea join aerolinea.vuelos vuelo where vuelo.tramos as tramo where tramo.destino = Chubut", busqueda.getHQL)
    //
    //    }
    //
    //    @Test
    //    def void combinarFiltrosConAndYOr(){
    //
    //        busqueda = new Busqueda() => [criterio = criterio1.and(criterio3.or(criterio4.and(criterio6)))]
    //
    //        Assert.assertEquals('select vuelo from Aerolinea aerolinea join aerolinea.vuelos vuelo where aerolinea.nombre = L.A.N. and vuelo.tramos as tramo join tramo.asientos as asiento where asiento.categoria.getCategoria = Primera or vuelo.tramos as tramo where tramo.salida = 2016-07-16 and vuelo.tramos as tramo where tramo.origen = Buenos Aires', busqueda.getHQL)
    //
    //    }

}