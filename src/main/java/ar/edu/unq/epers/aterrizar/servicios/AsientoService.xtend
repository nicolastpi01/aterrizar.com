package ar.edu.unq.epers.aterrizar.servicios

import ar.edu.unq.epers.aterrizar.home.AsientoHome
import ar.edu.unq.epers.aterrizar.home.SessionManager
import ar.edu.unq.epers.aterrizar.model.Asiento
import ar.edu.unq.epers.aterrizar.model.Usuario

class AsientoService extends BaseService{


    def todosLosAsientos(){
        SessionManager.runInSession([
            return new AsientoHome().todosLosAsientos()

        ]);
    }

    def guardarAsiento(Asiento asiento){
        SessionManager.runInSession([
            this.guardar(asiento)
            asiento
        ]);
    }

    def buscarAsiento(Asiento asiento){
        SessionManager.runInSession([
            new AsientoHome().getAsiento(asiento)
        ]);
    }



}
