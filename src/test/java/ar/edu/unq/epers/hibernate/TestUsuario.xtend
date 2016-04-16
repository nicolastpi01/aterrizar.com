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

class TestUsuario {

    var Usuario user
    var UsuarioService service
    var TramoService serviceTramo

    SessionFactory sessionFactory;
    Session session = null;


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
        var asiento = new Asiento => [
            categoria = new Primera
        ]
        var tramo = new Tramo => [

            origen = "Buenos Aires"
            destino = "Chubut"
            llegada = new Date(1000)
            salida = new Date(1500)
            precioBase = 1500
        ]

        tramo.agregarAsiento(asiento)

        serviceTramo.guardarTramo(tramo)
        serviceTramo.

    }

}
