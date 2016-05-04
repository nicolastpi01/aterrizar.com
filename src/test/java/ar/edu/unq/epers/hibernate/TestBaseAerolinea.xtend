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
import ar.edu.unq.epers.aterrizar.servicios.AerolineaService
import java.sql.Date
import org.junit.After
import org.junit.Before

import static ar.edu.unq.epers.aterrizar.home.SessionManager.resetSessionFactory
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class TestBaseAerolinea extends TestBase{


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




    var Aerolinea aerolinea1
    var Aerolinea aerolinea2
    var Aerolinea aerolinea3
    val AerolineaService aerolineaService = new AerolineaService
    var Busqueda busqueda = new Busqueda




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


        aerolineaService.guardar(aerolinea1)
        aerolineaService.guardar(aerolinea2)
        aerolineaService.guardar(aerolinea3)

    }

    @After
    def void limpiar(){
        resetSessionFactory
    }


}