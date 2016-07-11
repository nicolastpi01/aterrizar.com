package ar.edu.unq.epers.aterrizar.servicios

import ar.edu.unq.epers.aterrizar.home.AsientoHome
import ar.edu.unq.epers.aterrizar.home.SessionManager
import ar.edu.unq.epers.aterrizar.model.Asiento
import ar.edu.unq.epers.aterrizar.model.Usuario
import java.util.List

class AsientoService extends BaseService{


    def todosLosAsientos(){
        SessionManager.runInSession([
            return new AsientoHome().todosLosAsientos()

        ]);
    }

    def void reservarAsientoParaUsuario(Asiento asiento, Usuario user){
        SessionManager.runInSession([
            asiento.reservarAsiento(user)
            guardar(asiento)
            null
        ]);

    }

    def void reservarUnConjuntoDeAsientosParaUsuario(List<Asiento> asientos, Usuario user){
        asientos.forEach[reservarAsientoParaUsuario(it, user)]
    }





}
