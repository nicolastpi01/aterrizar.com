package ar.edu.unq.epers.aterrizar.home

class BaseHome {

    def void hqlTruncate(String myTable) {
        SessionManager.runInSession([
            var hql3 = "DELETE FROM " + myTable
            SessionManager.getSession().createSQLQuery(hql3).executeUpdate

        ]);

    }
}