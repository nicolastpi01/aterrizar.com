package ar.edu.unq.epers.aterrizar.model

import java.sql.Date
import org.eclipse.xtend.lib.annotations.Accessors
import org.eclipse.xtend.lib.annotations.EqualsHashCode


@Accessors
@EqualsHashCode
class Usuario {
    int id

    var String nombreDeUsuario
    var String nombreYApellido
    var String email
    var String contrasenia
    var Date nacimiento
    var boolean validado

    def getCodigoDeEmail(){
        nombreDeUsuario.hashCode
    }
}