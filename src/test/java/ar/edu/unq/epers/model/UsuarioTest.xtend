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

    var Repositorio repositorio = new Repositorio
    var Usuario usuario1  = new Usuario() => [
        nombreYApellido = "foo bar"
        nombreDeUsuario = "foobar1"
        contrasenia = "12345"
        email = "foo@bar.com"
        codigoDeEmail = "abc123"
        nacimiento = new DateTime(new Long(3500))
        estaRegistradoEmail = false
    ]

    @Test
    def void registrarUsuario(){

        repositorio.guardarUsuario(usuario1)
        val Usuario user = repositorio.obtenerPorNombreDeUsuario("foobar1")
        Assert.assertEquals("foobar1", user.getNombreDeUsuario)
    }

}