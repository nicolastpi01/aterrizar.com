package ar.edu.unq.epers.aterrizar.servicios

import ar.edu.unq.epers.aterrizar.home.AsientoHome
import ar.edu.unq.epers.aterrizar.home.SessionManager
import ar.edu.unq.epers.aterrizar.model.Asiento
import ar.edu.unq.epers.aterrizar.model.Usuario

class AsientoService {
	
       def reservarAsiento(Usuario user, Asiento asiento) {
       	SessionManager.runInSession([
            new AsientoHome().reservarAsiento(user, asiento)
            Asiento
        ]);
       }
       
       
       def todosLosAsientos(){
		SessionManager.runInSession([
            new AsientoHome().todosLosAsientos
            
            ]);
            }
            
def guardarAsiento(Asiento asiento){
	SessionManager.runInSession([
        new AsientoHome().guardarAsiento(asiento)
        Asiento
            ]);
            }
       
       
        	
    }
