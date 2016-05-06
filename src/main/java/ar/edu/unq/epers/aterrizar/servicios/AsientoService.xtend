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

    def void reservarAsientoParaUsuario(int asientoId, Usuario user){
        SessionManager.runInSession([
            val asiento= buscar(new Asiento, asientoId)
            asiento.reservadoPorUsuario = user
            guardar(asiento)
            null
        ]);

    }





}
