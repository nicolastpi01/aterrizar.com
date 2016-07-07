package ar.edu.unq.epers.hibernate

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
import ar.edu.unq.epers.aterrizar.exceptions.AsientoReservadoException
import java.util.List
import ar.edu.unq.epers.aterrizar.home.BaseHome

class TestAsiento {

    var Usuario user
    var Usuario user2
    var AsientoService service
    var BaseHome homeBase

    SessionFactory sessionFactory
    Session session = null
    Asiento asiento1
    Asiento asiento2
    Asiento asiento3
    Categoria unaCategoria


    @Before
    def void setUp(){
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
        ]
        asiento2 = new Asiento => [
            categoria = new Primera(1000)
        ]
        asiento3 = new Asiento => [
            categoria = new Primera(1000)
        ]

        homeBase = new BaseHome
    }


    @After
    def void limpiar() {
        homeBase.hqlTruncate('asiento')
        homeBase.hqlTruncate('usuario')

    }



    @Test
    def void guardoUnAsientoEnLaDB(){
        //        Assert.assertEquals(service.todosLosAsientos.length, 0)
        service.guardar(asiento1)
        service.guardar(asiento2)
        service.guardar(asiento3)

        var Asiento a = service.buscar(asiento1, asiento1.id)
        Assert.assertEquals(a.categoria.precioBase, asiento1.categoria.precioBase, 0.002)
        Assert.assertEquals(a.categoria.precio, asiento1.categoria.precio, 0.002)

        Assert.assertEquals(service.todosLosAsientos.length, 3)
    }

    @Test
    def void reservarUnAsiento(){

        service.guardar(asiento1)
        service.reservarAsientoParaUsuario(asiento1, user)

        Assert.assertEquals(service.buscar(asiento1, asiento1.id).reservadoPorUsuario.nombreDeUsuario, user.nombreDeUsuario)
    }

    @Test
    def void reservarUnConjuntoDeAsientos(){
        Assert.assertEquals(service.todosLosAsientos.length, 0)

        service.guardar(asiento1)
        service.guardar(asiento2)
        service.guardar(asiento3)

        val List<Asiento> listaAReservar = #[asiento1,asiento2,asiento3]
        service.reservarUnConjuntoDeAsientosParaUsuario(listaAReservar, user)

        Assert.assertEquals(service.buscar(asiento1, asiento1.id).reservadoPorUsuario.nombreDeUsuario, user.nombreDeUsuario)
        Assert.assertEquals(service.buscar(asiento2, asiento2.id).reservadoPorUsuario.nombreDeUsuario, user.nombreDeUsuario)
        Assert.assertEquals(service.buscar(asiento3, asiento3.id).reservadoPorUsuario.nombreDeUsuario, user.nombreDeUsuario)

        Assert.assertEquals(service.todosLosAsientos.length, 3)
    }

    @Test
    def void intentarReservarUnAsientoYaReservado(){

        service.guardar(asiento1)
        service.reservarAsientoParaUsuario(asiento1, user)
        try {
            service.reservarAsientoParaUsuario(asiento1, user)
        } catch(RuntimeException e) {
            Assert.assertEquals(e.getMessage, "ar.edu.unq.epers.aterrizar.exceptions.AsientoReservadoException: El siento ya está reservado")
        }
    }

}
