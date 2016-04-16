package ar.edu.unq.epers.hibernate

import ar.edu.unq.epers.aterrizar.home.SessionManager
import ar.edu.unq.epers.aterrizar.model.Usuario
import ar.edu.unq.epers.aterrizar.servicios.UsuarioService
import java.sql.Date
import org.hibernate.Session
import org.hibernate.SessionFactory
import org.junit.After
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import ar.edu.unq.epers.aterrizar.model.Tramo
import ar.edu.unq.epers.aterrizar.model.Asiento
import ar.edu.unq.epers.aterrizar.model.Primera
import ar.edu.unq.epers.aterrizar.servicios.TramoService
import java.util.ArrayList
import java.util.List

class TestUsuario {

    var Usuario user
    var UsuarioService service
    var TramoService serviceTramo

    SessionFactory sessionFactory;
    Session session = null;
    Asiento asiento1
    Asiento asiento2
    Asiento asiento3
    Tramo tramo


    @Before
    def void setUp(){

        SessionManager::getSessionFactory().openSession()
        user = new Usuario => [
            nombreDeUsuario = "alan75"
            nombreYApellido = "alan ferreira"
            email = "abc@123.com"
            nacimiento = new Date(2015,10,1)
        ]
        service = new UsuarioService
        serviceTramo = new TramoService

        asiento1 = new Asiento => [
            codigo = "c 1"
            categoria = new Primera
        ]
        asiento2 = new Asiento => [
            codigo = "c 2"
            categoria = new Primera
        ]
        asiento3 = new Asiento => [
            codigo = "c 3"
            categoria = new Primera
        ]

        tramo = new Tramo => [

            origen = "Buenos Aires"
            destino = "Chubut"
            llegada = new Date(1000)
            salida = new Date(1500)
            precioBase = 1500
        ]


    }


    @After
    def limpiar() {
        SessionManager::resetSessionFactory
    }


    @Test
    def void guardoUnUsuarioEnLaDB(){
        service.guardarUsuario(user)
    }


    @Test
    def void consultarUsuarioEnLaDB(){
        service.guardarUsuario(user)
        val consulta = service.consultarUsuario(user.nombreDeUsuario)
        Assert.assertEquals(consulta.nombreDeUsuario, user.nombreDeUsuario)
        Assert.assertEquals(consulta.contrasenia, user.contrasenia)
        Assert.assertEquals(consulta.email, user.email)
        Assert.assertEquals(consulta.nacimiento, user.nacimiento)
    }

    @Test
    def void reservarAsientoEnTramo(){

        tramo.agregarAsiento(asiento1)

        serviceTramo.guardarTramo(tramo)
        serviceTramo.reservarAsientoParaUsuarioEnTramo(asiento1, user, tramo)

        Assert.assertEquals(user, asiento1.reservadoPorUsuario)
    }

    @Test
    def void reservarVariosAsientosYComprarTodos(){

        tramo.agregarAsiento(asiento1)
        tramo.agregarAsiento(asiento2)
        tramo.agregarAsiento(asiento3)

        var List listaAReservar = new ArrayList<Asiento>
        listaAReservar.add(asiento1)
        listaAReservar.add(asiento2)
        listaAReservar.add(asiento3)

        serviceTramo.reservarAsientosParaUsuario(listaAReservar, user, tramo)
        var listaAComprar = listaAReservar
        serviceTramo.comprarAsientosParaUsuario(listaAComprar,user , tramo)

        Assert.assertEquals(user, asiento1.vendidoAUsuario)
        Assert.assertEquals(user, asiento2.vendidoAUsuario)
        Assert.assertEquals(user, asiento3.vendidoAUsuario)

    }

}
