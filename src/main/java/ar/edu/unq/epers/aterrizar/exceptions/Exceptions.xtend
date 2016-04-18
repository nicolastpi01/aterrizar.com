package ar.edu.unq.epers.aterrizar.exceptions

import org.eclipse.xtend.lib.annotations.Accessors

/**
 * Created by damian on 4/3/16.
 */

class YaExisteUsuarioConEseNombreException extends Exception{}
class NoExisteUsuarioConEseNombreException extends Exception{}
class ContraseniaIgualALaAnteriorException extends Exception{}
class ContraseniaIncorrectaException extends Exception{}
class EnviarMailException extends Exception{}
class NoHayAsientoConEsaIdException extends Exception{}

class AsientoReservadoException extends Exception{}