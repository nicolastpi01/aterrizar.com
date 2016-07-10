package ar.edu.unq.epers.aterrizar.home

import org.hibernate.Query
import java.util.List

class AsientoHome {


    def todosLosAsientos(){
        var q = "from Asiento"
        var query = SessionManager.getSession().createQuery(q) as Query

        return query.list

    }

    def borrarAsientos(){
        this.borrarCategorias()
        var q = "delete from Asiento "

        SessionManager.getSession().createQuery(q) as Query

    }

    def borrarCategorias(){
        var q = "delete from Categoria "
        SessionManager.getSession().createQuery(q) as Query
    }



}