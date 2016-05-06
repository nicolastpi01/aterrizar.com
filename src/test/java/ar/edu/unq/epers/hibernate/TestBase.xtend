package ar.edu.unq.epers.hibernate

import ar.edu.unq.epers.aterrizar.home.SessionManager
import ar.edu.unq.epers.aterrizar.model.Asiento
import ar.edu.unq.epers.aterrizar.model.Primera
import ar.edu.unq.epers.aterrizar.model.Tramo
import ar.edu.unq.epers.aterrizar.model.Usuario
import ar.edu.unq.epers.aterrizar.model.VueloOfertado
import ar.edu.unq.epers.aterrizar.servicios.AsientoService
import ar.edu.unq.epers.aterrizar.servicios.TramoService
import java.sql.Date
import org.eclipse.xtend.lib.annotations.Accessors
import org.hibernate.Session
import org.hibernate.SessionFactory
import org.junit.Before
import ar.edu.unq.epers.aterrizar.model.Business
import ar.edu.unq.epers.aterrizar.servicios.BaseService

@Accessors
class TestBase {

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
    Tramo tramo2
    Tramo tramo3
    VueloOfertado vuelo1
    VueloOfertado vuelo2
    VueloOfertado vuelo3
    VueloOfertado vuelo4
    VueloOfertado vuelo5


    @Before
    def void setUp(){

        SessionManager::getSessionFactory().openSession()
        user = new Usuario => [
            nombreDeUsuario = "alan75"
            nombreYApellido = "alan ferreira"
            email = "abc@123.com"
            nacimiento = new Date(2015,10,1)
        ]
        serviceTramo = new TramoService
        serviceAsiento = new AsientoService

        asiento1 = new Asiento => [
            nombre = "c 1"
            categoria = new Primera(1000)
        ]
        asiento2 = new Asiento => [
            nombre = "c 2"
            categoria = new Primera(1000)
        ]
        asiento3 = new Asiento => [
            nombre = "c 3"
            categoria = new Primera(1000)
        ]

        tramo = new Tramo => [
            vuelos = #[vuelo1,vuelo2,vuelo3,vuelo5]

            origen = "Chile"
            destino = "Buenos Aires"
            llegada = new Date(1000)
            salida = new Date(1500)
            asientos = #[asiento1, asiento2, asiento3]
        ]

        tramo2 = new Tramo => [
            vuelos = #[vuelo1,vuelo2,vuelo3,vuelo5]

            origen = "Buenos Aires"
            destino = "Brasil"
            llegada = new Date(116,07,01)
            salida = new Date(1500)
            asientos = #[
                new Asiento => [
                    nombre = "c 1"
                    categoria = new Primera(1000)
                ],
                new Asiento => [
                    nombre = "c 2"
                    categoria = new Primera(1000)
                ]
            ]
        ]


        tramo3 = new Tramo => [

            vuelos = #[vuelo4,vuelo5]
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

        vuelo1 = new VueloOfertado(#[tramo,tramo2], 1000)
        vuelo2 = new VueloOfertado (#[tramo2,tramo] ,2500)
        vuelo3 = new VueloOfertado (#[tramo,tramo2],1600)
        vuelo4 = new VueloOfertado (#[tramo3] ,800)
        vuelo5 = new VueloOfertado (#[tramo3,tramo2,tramo,tramo3] , 8800)

    }
}