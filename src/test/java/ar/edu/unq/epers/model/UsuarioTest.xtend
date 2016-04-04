package ar.edu.unq.epers.model


import org.junit.Test
import ar.edu.unq.epers.aterrizar.model.Usuario
import org.junit.Before
import ar.edu.unq.epers.aterrizar.persistencia.Repositorio
import static org.junit.Assert.*
import java.sql.Date
import ar.edu.unq.epers.aterrizar.exceptions.YaExisteUsuarioConEseNombreException
import org.junit.After
import ar.edu.unq.epers.aterrizar.exceptions.NoExisteUsuarioConEseNombreException
import ar.edu.unq.epers.aterrizar.persistencia.ServiciosDelUsuario
import ar.edu.unq.epers.aterrizar.utils.EnviadorDeMails
import org.mockito.Mockito
import ar.edu.unq.epers.aterrizar.exceptions.ContraseniaIgualALaAnteriorException
import ar.edu.unq.epers.aterrizar.exceptions.ContraseniaIncorrectaException

/**
 * Created by damian on 4/2/16.
 */
class UsuarioTest {
    var Repositorio repositorio
    var Usuario usuario1
    var ServiciosDelUsuario serviciosDelUsuario
    var EnviadorDeMails enviador

    @Before
    def void setUp(){
        repositorio = new Repositorio
        usuario1  = new Usuario() => [
            nombreYApellido = "foo bar"
            nombreDeUsuario = "foobar11"
            contrasenia = "12345"
            email = "foo@bar.com"
            nacimiento = new Date(3000)
            validado = false
        ]
        enviador = Mockito.mock(typeof(EnviadorDeMails))
        serviciosDelUsuario = new ServiciosDelUsuario(repositorio, enviador)

    }


    @Test
    def void testRegistrarUsuarioTest(){
        serviciosDelUsuario.registrarUsuario(usuario1)
        val Usuario user = serviciosDelUsuario.obtenerUsuarioSiExiste("foobar11")
        assertEquals("foobar11", user.getNombreDeUsuario)
        assertFalse(user.validado)

        repositorio.tirarTablaConNombreDeUsuario("foobar11")
    }

    @After
    def void limpiarTablaUsuarios(){
        repositorio.borrarTodosLosUsuario()
    }

    @Test(expected = YaExisteUsuarioConEseNombreException)
    def void testRegistrarUsuarioConMismoNombreDosVecesTest(){
        serviciosDelUsuario.registrarUsuario(usuario1)
        serviciosDelUsuario.registrarUsuario(usuario1)
    }

    @Test(expected = NoExisteUsuarioConEseNombreException)
    def void testPedirUsuarioInexistente(){
        serviciosDelUsuario.obtenerUsuarioSiExiste("nadie")
    }

    @Test
    def void testCambiarContrasenia() {
        serviciosDelUsuario.registrarUsuario(usuario1)
        serviciosDelUsuario.cambiarContrasenia(usuario1.nombreDeUsuario, "abcd")
        assertEquals(serviciosDelUsuario.obtenerUsuarioSiExiste(usuario1.nombreDeUsuario).contrasenia, "abcd")
    }

    @Test(expected = ContraseniaIgualALaAnteriorException )
    def void testCambiarContraseniaPorLaMisma() {
        serviciosDelUsuario.registrarUsuario(usuario1)
        serviciosDelUsuario.cambiarContrasenia(usuario1.nombreDeUsuario, "12345")
    }

    @Test
    def testUsuarioLoginCorrecto() {
        serviciosDelUsuario.registrarUsuario(usuario1)
        assertTrue(serviciosDelUsuario.login(usuario1.nombreDeUsuario, usuario1.contrasenia))
    }

    @Test(expected=NoExisteUsuarioConEseNombreException)
    def void testUsuarioLoginFallaPorNoExistir() {
        serviciosDelUsuario.registrarUsuario(usuario1)
        serviciosDelUsuario.login("nadie", "nada")
    }

    @Test(expected = ContraseniaIncorrectaException)
    def void testUsuarioLoginFallaPorContraseniaInvalida() {
        serviciosDelUsuario.registrarUsuario(usuario1)
        assertFalse(serviciosDelUsuario.login(usuario1.nombreDeUsuario, "incorrecta"))
    }

    @Test
    def void testUsuarioValidadoCorrectamente() {
        serviciosDelUsuario.registrarUsuario(usuario1)
        assertTrue(serviciosDelUsuario.validarUsuario(usuario1.nombreDeUsuario, usuario1.nombreDeUsuario.hashCode))
    }


}