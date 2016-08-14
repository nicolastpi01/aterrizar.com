package ar.edu.unq.epers.aterrizar.servicios

import ar.edu.unq.epers.aterrizar.home.AsientoHome
import ar.edu.unq.epers.aterrizar.home.SessionManager
import ar.edu.unq.epers.aterrizar.model.Asiento
import java.util.List
import ar.edu.unq.epers.aterrizar.model.Tramo

class AsientoService extends BaseService{

    def List<Asiento> todosLosAsientos() {
        SessionManager.runInSession([
            return new AsientoHome().todosLosAsientos()
        ])
    }
    
    def List<Asiento> asientosDisponibles(Tramo t) {
    	SessionManager.runInSession([
            return new AsientoHome().asientosDisponibles(t)
        ])
    }
	

}
