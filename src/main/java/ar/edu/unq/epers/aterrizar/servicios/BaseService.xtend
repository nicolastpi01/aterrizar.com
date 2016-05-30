package ar.edu.unq.epers.aterrizar.servicios

import ar.edu.unq.epers.aterrizar.home.SessionManager
import ar.edu.unq.epers.aterrizar.model.Usuario
import ar.edu.unq.epers.aterrizar.servicios.SocialNetworkingService
/**
 * Created by damian on 5/4/16.
 */
class BaseService {

    def <T> void guardar(T objectToBeSaved) {
        SessionManager.runInSession([
        	if(objectToBeSaved.getClass.equals(Usuario))
        		{
        		var s = new SocialNetworkingService()
        		s.agregarPersona(objectToBeSaved as Usuario)	
        		}
        	
            SessionManager.getSession().saveOrUpdate(objectToBeSaved)
            null
        ]);


    }

    def <T> buscar(T objectToSearch, int id){
        SessionManager.runInSession([
            SessionManager.getSession().get(objectToSearch.getClass, id) as T
        ])
    }
}