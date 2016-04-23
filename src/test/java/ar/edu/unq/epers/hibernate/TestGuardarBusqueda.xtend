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
























}