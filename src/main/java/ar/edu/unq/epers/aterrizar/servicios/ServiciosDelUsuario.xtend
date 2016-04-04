package ar.edu.unq.epers.aterrizar.servicios

import ar.edu.unq.epers.aterrizar.utils.EnviadorDeMails
import ar.edu.unq.epers.aterrizar.model.Usuario
import ar.edu.unq.epers.aterrizar.exceptions.YaExisteUsuarioConEseNombreException
import ar.edu.unq.epers.aterrizar.exceptions.NoExisteUsuarioConEseNombreException
import ar.edu.unq.epers.aterrizar.exceptions.ContraseniaIgualALaAnteriorException
import ar.edu.unq.epers.aterrizar.exceptions.ContraseniaIncorrectaException
import org.mockito.internal.stubbing.answers.ThrowsException
import ar.edu.unq.epers.aterrizar.persistencia.Repositorio

/**
 * Created by damian on 4/3/16.
 */
class ServiciosDelUsuario {

    var Repositorio repositorio
    var EnviadorDeMails enviadorDeMails

    new(Repositorio repo, EnviadorDeMails enviadorDeM){
        this.repositorio = repo
        this. enviadorDeMails = enviadorDeM
    }

    def void registrarUsuario(Usuario usuario){

        if (repositorio.obtenerUsuarioPorNombreDeUsuario(usuario.nombreDeUsuario) == null)
            repositorio.guardarUsuario(usuario)
        else
            throw new YaExisteUsuarioConEseNombreException

    }

    def Usuario obtenerUsuarioSiExiste(String nombreDeUs){
        if(repositorio.obtenerUsuarioPorNombreDeUsuario(nombreDeUs) != null)
            repositorio.obtenerUsuarioPorNombreDeUsuario(nombreDeUs)
        else
            throw new NoExisteUsuarioConEseNombreException
    }

    def cambiarContrasenia(String nombreDeUsuario, String password){
        if(obtenerUsuarioSiExiste(nombreDeUsuario).contrasenia == password)
            throw new ContraseniaIgualALaAnteriorException
        else repositorio.cambiarContrasenia(nombreDeUsuario, password)
    }

    def boolean login(String nombreDeUsuario, String password){
        if(this.obtenerUsuarioSiExiste(nombreDeUsuario).contrasenia == password)
            return true
        else
            throw new ContraseniaIncorrectaException
    }

    def validarUsuario(String nombreDeUsuario, int hashCode){

        val usuario = this.obtenerUsuarioSiExiste(nombreDeUsuario)
        if (usuario.getCodigoDeEmail() == hashCode && (! usuario.validado)) {
            repositorio.validarUsuario(nombreDeUsuario)
            usuario.validado = true
        }
        val x = usuario.nacimiento
        usuario.isValidado

    }



}