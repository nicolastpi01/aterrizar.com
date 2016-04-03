package ar.edu.unq.epers.model

import org.junit.Test
import ar.edu.unq.epers.aterrizar.model.Usuario
import org.joda.time.DateTime
import org.junit.Before
import ar.edu.unq.epers.aterrizar.persistencia.Repositorio
import org.junit.Assert

/**
 * Created by damian on 4/2/16.
 */
class UsuarioTest {
    var Repositorio repositorio
    var Usuario usuario1

    @Before
    def void setUp(){
        repositorio = new Repositorio
        usuario1  = new Usuario() => [
            nombreYApellido = "foo bar"
            nombreDeUsuario = "foobar16"
            contrasenia = "12345"
            email = "foo@bar.com"
            codigoDeEmail = "abc123"
            nacimiento = new DateTime(new Long(3500))
            estaRegistradoEmail = false
        ]

    }


    @Test
    def void registrarUsuario(){
        repositorio.guardarUsuario(usuario1)
        val Usuario user = repositorio.obtenerPorNombreDeUsuario("foobar16")
        Assert.assertEquals("foobar16", user.getNombreDeUsuario)

        repositorio.tirarTablaConNombreDeUsuario("foobar16")
    }

}