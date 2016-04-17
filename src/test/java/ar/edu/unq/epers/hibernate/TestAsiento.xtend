package ar.edu.unq.epers.hibernate

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
            //id = "c 1"
            categoria = unaCategoria
        ]
        asiento2 = new Asiento => [
            //id = "c 2"
            categoria = unaCategoria
        ]
        asiento3 = new Asiento => [
            //id = "c 3"
            categoria = unaCategoria
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
        //new AsientoHome().guardarAsiento(asiento2)
        //new AsientoHome().guardarAsiento(asiento3)
        //Assert.assertEquals(service.todosLosAsientos.length, 1)
    }


	/*
    @Test
    def void consultarUsuarioEnLaDB(){
        service.guardarUsuario(user)
        val consulta = service.consultarUsuario(user.nombreDeUsuario)
        Assert.assertEquals(consulta.nombreDeUsuario, user.nombreDeUsuario)
        Assert.assertEquals(consulta.contrasenia, user.contrasenia)
        Assert.assertEquals(consulta.email, user.email)
        Assert.assertEquals(consulta.nacimiento, user.nacimiento)
    }
     */
     
    /*
    @Test
    def void consultarAsientoEnLaDB(){
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

    @Test
    def void consultarAsientosDisponiblesParaUnTramo(){

        var List listaAReservar = new ArrayList<Asiento>
        listaAReservar.add(asiento1)
        listaAReservar.add(asiento3)

        serviceTramo.reservarAsientosParaUsuario(listaAReservar, user, tramo)

        var List<Asiento> asientosDisponibles = serviceTramo.asientosDisponibles(tramo)

        var List<Asiento> asientosEsperados = new ArrayList

        asientosEsperados.add(asiento2)

        Assert.assertEquals(asientosDisponibles, asientosEsperados)

    }
 */

}
