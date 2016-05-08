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

    def void reservarAsientoParaUsuario(Asiento asiento, Usuario user){
        SessionManager.runInSession([
            val Asiento asiento1 = buscar(asiento, asiento.id)
            asiento1.reservarAsiento(user)
            guardar(asiento1)
            null
        ]);

    }





}
