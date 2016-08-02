package ar.edu.unq.epers.aterrizar.model

import org.eclipse.xtend.lib.annotations.Accessors
import java.util.Date

@Accessors
class Asiento {
    int id
    String nombre
    Usuario user
    Categoria categoria
	Date fechaReserva


}