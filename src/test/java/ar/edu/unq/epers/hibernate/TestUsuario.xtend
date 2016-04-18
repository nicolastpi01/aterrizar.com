package ar.edu.unq.epers.hibernate

import ar.edu.unq.epers.aterrizar.home.SessionManager
import ar.edu.unq.epers.aterrizar.model.Asiento
import ar.edu.unq.epers.aterrizar.model.Primera
import ar.edu.unq.epers.aterrizar.model.Tramo
import ar.edu.unq.epers.aterrizar.model.Usuario
import ar.edu.unq.epers.aterrizar.model.VueloOfertado
import ar.edu.unq.epers.aterrizar.servicios.TramoService
import ar.edu.unq.epers.aterrizar.servicios.UsuarioService
import java.sql.Date
import java.util.ArrayList
import java.util.List
import org.hibernate.Session
import org.hibernate.SessionFactory
import org.junit.After
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import ar.edu.unq.epers.aterrizar.servicios.AsientoService

class TestUsuario {

    var Usuario user
    var UsuarioService serviceUsuario
    var TramoService serviceTramo
    var AsientoService serviceAsiento

    SessionFactory sessionFactory;
    Session session = null;
    Asiento asiento1
    Asiento asiento2
    Asiento asiento3
    Tramo tramo
    Tramo tramo2
    Tramo tramo3


    @Before
    def void setUp(){

        SessionManager::getSessionFactory().openSession()
        user = new Usuario => [
            nombreDeUsuario = "alan75"
            nombreYApellido = "alan ferreira"
            email = "abc@123.com"
            nacimiento = new Date(2015,10,1)
        ]
        serviceUsuario = new UsuarioService
        serviceTramo = new TramoService
        serviceAsiento = new AsientoService

        asiento1 = new Asiento => [
            categoria = new Primera(1000)
        ]
        asiento2 = new Asiento => [
            categoria = new Primera(1000)
        ]
        asiento3 = new Asiento => [
            categoria = new Primera(1000)
        ]

        tramo = new Tramo => [

            origen = "Chile"
            destino = "Buenos Aires"
            llegada = new Date(1000)
            salida = new Date(1500)
            precioBase = 1500
            asientos = #[asiento1, asiento2, asiento3]
        ]

        tramo2 = new Tramo => [

            origen = "Buenos Aires"
            destino = "Brasil"
            llegada = new Date(1000)
            salida = new Date(1500)
            precioBase = 1500
            asientos = #[
                new Asiento => [
                    categoria = new Primera(1000)
                ],
                new Asiento => [
                    categoria = new Primera(1000)
                ]
            ]
        ]


        tramo3 = new Tramo => [

            origen = "Brasil"
            destino = "Mexico"
            llegada = new Date(1000)
            salida = new Date(1500)
            precioBase = 1500
        ]

    }


    @After
    def void limpiar() {
        SessionManager::resetSessionFactory
    }


    @Test
    def void guardoUnUsuarioEnLaDB(){
        serviceUsuario.guardarUsuario(user)

    }


    @Test
    def void consultarUsuarioEnLaDB(){
        serviceUsuario.guardarUsuario(user)
        val consulta = serviceUsuario.consultarUsuario(user.nombreDeUsuario)
        Assert.assertEquals(consulta.nombreDeUsuario, user.nombreDeUsuario)
        Assert.assertEquals(consulta.contrasenia, user.contrasenia)
        Assert.assertEquals(consulta.email, user.email)
        Assert.assertEquals(consulta.nacimiento, user.nacimiento)
    }

    @Test
    def void reservarAsientoEnTramo(){
        serviceTramo.guardarTramo(tramo)
        serviceTramo.reservarAsientosParaUsuario(user, tramo, asiento1)

        Assert.assertEquals(user, asiento1.reservadoPorUsuario)
    }



    @Test
    def void reservarVariosAsientosYComprarTodos(){



        var List listaAReservar = new ArrayList<Asiento>
        listaAReservar.add(asiento1)
        listaAReservar.add(asiento2)
        listaAReservar.add(asiento3)

        serviceTramo.reservarAsientosParaUsuario(user, tramo, listaAReservar)

        var listaAComprar = listaAReservar
        serviceTramo.comprarAsientosParaUsuario(listaAComprar,user , tramo)

        Assert.assertEquals(user, asiento1.vendidoAUsuario)
        Assert.assertEquals(user, asiento2.vendidoAUsuario)
        Assert.assertEquals(user, asiento3.vendidoAUsuario)

    }
    /*
        @Test
        def void reservarAsientosYComprarAlgunos(){

            var List listaAReservar = new ArrayList<Asiento>
            listaAReservar.add(asiento1)
            listaAReservar.add(asiento2)
            listaAReservar.add(asiento3)

            serviceTramo.reservarAsientosParaUsuario(listaAReservar, user, tramo)

            var List listaAComprar = new ArrayList<Asiento>
            listaAComprar.add(asiento1)
            listaAComprar.add(asiento3)


            Assert.assertEquals(user, asiento1.reservadoPorUsuario)
            Assert.assertEquals(user, asiento2.reservadoPorUsuario)
            Assert.assertEquals(user, asiento3.reservadoPorUsuario)


            serviceTramo.comprarAsientosParaUsuario(listaAComprar,user , tramo)

            Assert.assertEquals(user, asiento1.vendidoAUsuario)
            Assert.assertEquals(null, asiento2.vendidoAUsuario)
            Assert.assertEquals(null, asiento2.reservadoPorUsuario)
            Assert.assertEquals(user, asiento3.vendidoAUsuario)

        }

        @Test
        def void reservarAsientosYNoComprarNinguno(){

            var List listaAReservar = new ArrayList<Asiento>
            listaAReservar.add(asiento1)
            listaAReservar.add(asiento2)
            listaAReservar.add(asiento3)

            serviceTramo.reservarAsientosParaUsuario(listaAReservar, user, tramo)

            var List listaAComprar = new ArrayList<Asiento>

            Assert.assertEquals(user, asiento1.reservadoPorUsuario)
            Assert.assertEquals(user, asiento2.reservadoPorUsuario)
            Assert.assertEquals(user, asiento3.reservadoPorUsuario)


            serviceTramo.comprarAsientosParaUsuario(listaAComprar,user , tramo)

            Assert.assertEquals(null, asiento1.vendidoAUsuario)
            Assert.assertEquals(null, asiento2.vendidoAUsuario)
            Assert.assertEquals(null, asiento3.vendidoAUsuario)
            Assert.assertEquals(null, asiento1.reservadoPorUsuario)
            Assert.assertEquals(null, asiento2.reservadoPorUsuario)
            Assert.assertEquals(null, asiento3.reservadoPorUsuario)

        }
    */

//    @Test
//    def void consultarAsientosDisponiblesParaUnTramo(){
//
//        var List listaAReservar = new ArrayList<Asiento>
//        listaAReservar.add(asiento1)
//        listaAReservar.add(asiento3)
//
//        serviceTramo.reservarAsientosParaUsuario(listaAReservar, user, tramo)
//
//        var List<Asiento> asientosDisponibles = serviceTramo.asientosDisponibles(tramo)
//
//        var List<Asiento> asientosEsperados = new ArrayList
//
//        asientosEsperados.add(asiento2)
//
//        Assert.assertEquals(asientosDisponibles, asientosEsperados)
//
//    }


}
