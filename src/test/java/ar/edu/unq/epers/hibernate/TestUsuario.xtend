package ar.edu.unq.epers.hibernate

import ar.edu.unq.epers.aterrizar.home.SessionManager
import java.util.ArrayList
import java.util.List
import org.junit.After
import org.junit.Assert
import org.junit.Before
import org.junit.Test

class TestUsuario extends TestBase{

    @Before
    override setUp(){
        super.setUp
    }

    @Test
    def void guardoUnUsuarioEnLaDB(){
        servicioBase.guardar(user)
    }


    @Test
    def void consultarUsuarioEnLaDB(){
        servicioBase.guardar(user)
        val usuario = servicioBase.buscar(user, user.id)
        Assert.assertEquals(usuario.nombreDeUsuario, user.nombreDeUsuario)
        Assert.assertEquals(usuario.contrasenia, user.contrasenia)
        Assert.assertEquals(usuario.email, user.email)
        Assert.assertEquals(usuario.nacimiento, user.nacimiento)
    }

    @Test
    def void reservarAsientoEnTramo(){
        serviceAsiento.guardar(tramo)
        serviceAsiento.reservarAsientoParaUsuario(asiento1, user)

        Assert.assertEquals(user.id, serviceAsiento.buscar(asiento1, asiento1.id).reservadoPorUsuario.id)
    }



    @Test
    def void reservarVariosAsientosYComprarTodos(){
        serviceAsiento.guardar(tramo)
        serviceAsiento.guardar(user)

        serviceAsiento.reservarAsientoParaUsuario(asiento1, user)
        serviceAsiento.reservarAsientoParaUsuario(asiento2, user)
        serviceAsiento.reservarAsientoParaUsuario(asiento3, user)


        Assert.assertEquals(user.id, servicioBase.buscar(asiento1, asiento1.id).reservadoPorUsuario.id)
        Assert.assertEquals(user.id, servicioBase.buscar(asiento2, asiento2.id).reservadoPorUsuario.id)
        Assert.assertEquals(user.id, servicioBase.buscar(asiento3, asiento3.id).reservadoPorUsuario.id)

    }

    @Test
    def void consultarAsientosDisponiblesParaUnTramo(){

        serviceAsiento.guardar(tramo)
        serviceAsiento.reservarAsientoParaUsuario(asiento1, user)
        serviceAsiento.reservarAsientoParaUsuario(asiento3, user)


        var asientosDisponibles = serviceTramo.asientosDisponibles(tramo).map[it.id].toList


        Assert.assertEquals(4, asientosDisponibles.size)

    }

}
