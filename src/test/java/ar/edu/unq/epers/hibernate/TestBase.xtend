package ar.edu.unq.epers.hibernate

import ar.edu.unq.epers.aterrizar.home.SessionManager
import ar.edu.unq.epers.aterrizar.model.Asiento
import ar.edu.unq.epers.aterrizar.model.Business
import ar.edu.unq.epers.aterrizar.model.Primera
import ar.edu.unq.epers.aterrizar.model.Tramo
import ar.edu.unq.epers.aterrizar.model.Usuario
import ar.edu.unq.epers.aterrizar.model.VueloOfertado
import ar.edu.unq.epers.aterrizar.servicios.AsientoService
import ar.edu.unq.epers.aterrizar.servicios.BaseService
import ar.edu.unq.epers.aterrizar.servicios.TramoService
import java.sql.Date
import org.eclipse.xtend.lib.annotations.Accessors
import org.hibernate.Session
import org.hibernate.SessionFactory
import org.junit.Before
import org.junit.After
import ar.edu.unq.epers.aterrizar.home.BaseHome

@Accessors
class TestBase {

    var BaseHome homeBase
    var Usuario user
    var TramoService serviceTramo
    var AsientoService serviceAsiento
    var BaseService servicioBase = new BaseService

    SessionFactory sessionFactory;
    Session session = null;
    Asiento asiento1
    Asiento asiento2
    Asiento asiento3
    Tramo tramo
    Tramo tramo3
    VueloOfertado vuelo1
    VueloOfertado vuelo2
    VueloOfertado vuelo3
    VueloOfertado vuelo4
    VueloOfertado vuelo5


    @Before
    def void setUp(){

        homeBase = new BaseHome()

        SessionManager::getSessionFactory().openSession()
        user = new Usuario => [
            nombreDeUsuario = "alan1000"
            nombreYApellido = "alan ferreira"
            email = "abc@123.com"
            nacimiento = new Date(2015,10,1)
        ]
        serviceTramo = new TramoService
        serviceAsiento = new AsientoService




        tramo = new Tramo => [

            origen = "Buenos Aires"
            destino = "Brasil"
            llegada = new Date(116,07,01)
            salida = new Date(1500)
            
            asiento1 = new Asiento => [
                    nombre = "c 1"
                    categoria = new Primera(1000)
                ]
               
            asiento2 =  new Asiento => [
                    nombre = "c 2"
                    categoria = new Primera(1000)
                ]

            asiento3 = new Asiento => [
                nombre = "c 3"
                categoria = new Primera(1000)
            ]

            asientos = #[
                asiento1,
                asiento2,
                asiento3
            ]
        ]


        tramo3 = new Tramo => [

            origen = "Brasil"
            destino = "Mexico"
            llegada = new Date(1000)
            salida = new Date(116,6,16)
            
            asientos = #[
                new Asiento => [
                    nombre = "c 1"
                    categoria = new Business(500)
                ],
                new Asiento => [
                    nombre = "c 2"
                    categoria = new Business(500)
                ]
            ]
        ]



        vuelo1 = new VueloOfertado (#[new Tramo("Paris", "Italia"),tramo], 1000)
        vuelo2 = new VueloOfertado (#[tramo3, new Tramo("Mexico", "España")] ,2500)
        vuelo3 = new VueloOfertado (#[new Tramo("Paris", "Italia"), new Tramo("Italia", "Grecia")],1600)
        vuelo4 = new VueloOfertado (#[new Tramo("Paris", "Italia"), new Tramo("Italia", "Venezuela")] ,800)
        vuelo5 = new VueloOfertado (#[new Tramo("Paris", "Italia"), new Tramo("Italia", "Venezuela"), new Tramo("Venezuela", "Peru")] , 8800)

    }


    @After
    def void truncarTodasLasTablasDeLaBase() {
        homeBase.hqlTruncate("asiento")
        homeBase.hqlTruncate("criterioCompuesto")
        homeBase.hqlTruncate("ordenVacio")
        homeBase.hqlTruncate("MenorCosto")
        homeBase.hqlTruncate("MenorDuracion")
        homeBase.hqlTruncate("MenorCantidadDeEscalas")
        homeBase.hqlTruncate("busqueda")
        homeBase.hqlTruncate("criterioCompuesto")
        homeBase.hqlTruncate("criterioVacio")
        homeBase.hqlTruncate("criterioPorAerolinea")
        homeBase.hqlTruncate("criterioPorCategoriaDeAsiento")
        homeBase.hqlTruncate("criterioPorFechaDeLlegada")
        homeBase.hqlTruncate("criterioPorFechaDeSalida")
        homeBase.hqlTruncate("criterioPorOrigen")
        homeBase.hqlTruncate("criterioPorDestino")

        homeBase.hqlTruncate("primera")
        homeBase.hqlTruncate("turista")
        homeBase.hqlTruncate("business")
        homeBase.hqlTruncate("categoria")
        homeBase.hqlTruncate("criterio")
        homeBase.hqlTruncate("tramo")
        homeBase.hqlTruncate("usuario")
        homeBase.hqlTruncate("vueloOfertado")
        
    }
}