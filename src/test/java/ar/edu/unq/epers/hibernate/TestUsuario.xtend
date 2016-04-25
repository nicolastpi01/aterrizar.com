package ar.edu.unq.epers.hibernate

import ar.edu.unq.epers.aterrizar.home.SessionManager
import ar.edu.unq.epers.aterrizar.model.Asiento
import ar.edu.unq.epers.aterrizar.model.VueloOfertado
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


        Assert.assertEquals(user, asiento1.reservadoPorUsuario)
        Assert.assertEquals(user, asiento2.reservadoPorUsuario)
        Assert.assertEquals(user, asiento3.reservadoPorUsuario)

    }

    @Test
    def void consultarAsientosDisponiblesParaUnTramo(){

        var List listaAReservar = new ArrayList<Asiento>
        listaAReservar.add(asiento1)
        listaAReservar.add(asiento3)

        serviceTramo.guardarTramo(tramo)
        serviceTramo.reservarAsientosParaUsuario(user, tramo, listaAReservar)


        var asientosDisponibles = serviceTramo.asientosDisponibles(tramo).map[it.nombre].toList

        var List asientosDisponiblesEsperados = new ArrayList

        asientosDisponiblesEsperados.add(asiento2.nombre)

        Assert.assertEquals(asientosDisponiblesEsperados, asientosDisponibles)

    }

    @Test
    def void guardarYTraerVuelo(){
        var VueloOfertado vuelo = new VueloOfertado()
        serviceTramo.guardarTramosEnVuelo(vuelo,tramo,tramo2)

    }

}
