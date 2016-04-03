package ar.edu.unq.epers.aterrizar.model

import org.joda.time.DateTime
import org.eclipse.xtend.lib.annotations.Accessors

/**
 * Created by damian on 4/2/16.
 */
@Accessors
class Usuario {

    private var String nombreDeUsuario
    private var String nombreYApellido
    private var String email
    private var String contrasenia
    private var String codigoDeEmail
    private var DateTime nacimiento
    private var boolean estaRegistradoEmail

}