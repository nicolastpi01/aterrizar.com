package ar.edu.unq.epers.aterrizar.home

class BaseHome {

    def void hqlTruncate(String myTable){
        SessionManager.runInSession([
//            var hql = "DISABLE TRIGGER ALL ON "+ myTable
//            var hql2 = "ALTER TABLE "+ myTable + " NOCHECK CONSTRAINT ALL"
            var hql3 = "DELETE FROM " + myTable
//            var hql4 = "ALTER TABLE "+ myTable + " CHECK CONSTRAINT ALL"
//            var hql5 = "ENABLE TRIGGER ALL ON " + myTable

//            SessionManager.getSession().createSQLQuery(hql).executeUpdate
//            SessionManager.getSession().createSQLQuery(hql2).executeUpdate
            SessionManager.getSession().createSQLQuery(hql3).executeUpdate
//            SessionManager.getSession().createSQLQuery(hql4).executeUpdate
//            SessionManager.getSession().createSQLQuery(hql5).executeUpdate
        ]);

    }
}