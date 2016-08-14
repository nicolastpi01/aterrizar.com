package ar.edu.unq.epers.aterrizar.servicios

import ar.edu.unq.epers.aterrizar.home.SessionManager
import ar.edu.unq.epers.aterrizar.home.TramoHome
import ar.edu.unq.epers.aterrizar.model.Tramo
import ar.edu.unq.epers.aterrizar.model.VueloOfertado
import java.util.List
import ar.edu.unq.epers.aterrizar.model.Usuario
import ar.edu.unq.epers.aterrizar.model.Destiny

class TramoService extends BaseService {

    def asientosDisponibles(Tramo tramo) {
        SessionManager.runInSession([
            new TramoHome().asientosDisponiblesEnTramo(tramo)
        ]);
    }
    
}