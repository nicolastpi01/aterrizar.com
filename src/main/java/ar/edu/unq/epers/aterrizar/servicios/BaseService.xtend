package ar.edu.unq.epers.aterrizar.servicios

import ar.edu.unq.epers.aterrizar.home.SessionManager
import java.io.Serializable
import javax.persistence.Id
import org.hibernate.annotations.Entity
import ar.edu.unq.epers.aterrizar.model.hasId
import org.hibernate.metadata.ClassMetadata
import org.hibernate.SessionFactory

/**
 * Created by damian on 5/4/16.
 */
class BaseService {

    def <T> void guardar(T objectToBeSaved) {
        SessionManager.runInSession([
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