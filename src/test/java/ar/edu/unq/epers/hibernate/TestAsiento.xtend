package ar.edu.unq.epers.hibernate

import ar.edu.unq.epers.aterrizar.exceptions.AsientoReservadoException
import ar.edu.unq.epers.aterrizar.home.AsientoHome
import ar.edu.unq.epers.aterrizar.home.SessionManager
import ar.edu.unq.epers.aterrizar.model.Asiento
import ar.edu.unq.epers.aterrizar.model.Categoria
import ar.edu.unq.epers.aterrizar.model.Primera
import ar.edu.unq.epers.aterrizar.model.Usuario
import ar.edu.unq.epers.aterrizar.servicios.AsientoService
import java.sql.Date
import org.hibernate.Session
import org.hibernate.SessionFactory
import org.junit.After
import org.junit.Assert
import org.junit.Before
import org.junit.Test

class TestAsiento {

    var Usuario user
    var Usuario user2
    var AsientoService service

    SessionFactory sessionFactory;
    Session session = null;
    Asiento asiento1
    Asiento asiento2
    Asiento asiento3
    Categoria unaCategoria


    @Before
    def void setUp(){

        SessionManager::getSessionFactory().openSession()
        user = new Usuario => [
            nombreDeUsuario = "alan75"
            nombreYApellido = "alan ferreira"
            email = "abc@123.com"
            nacimiento = new Date(2015,10,1)
        ]
        user2 = new Usuario => [
            nombreDeUsuario = "piter23"
            nombreYApellido = "piter castro"
            email = "abcd@123.com"
            nacimiento = new Date(2015,10,1)
        ]
        service = new AsientoService

        unaCategoria = new Primera(1000)
        asiento1 = new Asiento => [
            categoria = new Primera(1000)
            reservado = false
        ]
        asiento2 = new Asiento => [
            categoria = new Primera(1000)
            reservado = false
        ]
        asiento3 = new Asiento => [
            categoria = new Primera(1000)
            reservado = false
        ]


    }


    @After
    def limpiar() {
        SessionManager::resetSessionFactory
    }



    @Test
    def void guardoUnAsientoEnLaDB(){
        Assert.assertEquals(service.todosLosAsientos.length, 0)

        service.guardarAsiento(asiento1)
        service.guardarAsiento(asiento2)
        service.guardarAsiento(asiento3)

        var Asiento a = service.buscarAsiento(asiento1)
        Assert.assertEquals(a.categoria.precioBase, asiento1.categoria.precioBase, 0.002)
        Assert.assertEquals(a.categoria.precio, asiento1.categoria.precio, 0.002)

        Assert.assertEquals(service.todosLosAsientos.length, 3)
    }




    @Test(expected = AsientoReservadoException)
    def void reservarUnAsientoYFalle(){

        service.guardarAsiento(asiento1)
        service.guardarAsiento(asiento2)
        service.guardarAsiento(asiento3)

        service.reservarAsiento(user, service.buscarAsiento(asiento1))
        service.reservarAsiento(user, service.buscarAsiento(asiento1))
        Assert.assertEquals(service.buscarAsiento(asiento1).reservadoPorUsuario.nombreDeUsuario, user.nombreDeUsuario)
    }


    def borrarTodo() {
        SessionManager.runInSession([
            new AsientoHome().borrarAsientos()
            Asiento
        ]);
    }

}
