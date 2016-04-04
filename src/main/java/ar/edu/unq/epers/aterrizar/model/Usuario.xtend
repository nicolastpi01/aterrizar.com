package ar.edu.unq.epers.aterrizar.model


import org.eclipse.xtend.lib.annotations.Accessors
import java.sql.Date

/**
 * Created by damian on 4/2/16.
 */
@Accessors
class Usuario {

    private var String nombreDeUsuario
    private var String nombreYApellido
    private var String email
    private var String contrasenia
    private var int codigoDeEmail
    private var Date nacimiento
    private var boolean estaRegistradoEmail

}