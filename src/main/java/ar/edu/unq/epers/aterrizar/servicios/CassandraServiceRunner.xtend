package ar.edu.unq.epers.aterrizar.servicios

import com.datastax.driver.core.Cluster;
import com.datastax.driver.core.Session;
import com.datastax.driver.mapping.Mapper
import org.eclipse.xtend.lib.annotations.Accessors
import ar.edu.unq.epers.aterrizar.model.Perfil
import com.datastax.driver.mapping.MappingManager

@Accessors
class CassandraServiceRunner {
   private Cluster cluster
   private Session session
   Mapper<Perfil> mapper
   
   
   	def static Session createSession() {
		val cluster = Cluster.builder().addContactPoint("localhost").build()
		return cluster.connect()
	}
	
	def getSession() {
	if (session == null) {
		session = createSession()
	}
		return session
	}
	
	def createCacheSchema(){
				
		session.execute("CREATE KEYSPACE IF NOT EXISTS simplex WITH replication = {'class':'SimpleStrategy', 'replication_factor':3};")
		
		session.execute("CREATE TYPE IF NOT EXISTS simplex.Destiny (" +
			"nombre text, " + 
			"id text, " +
			"likes list< frozen<Like> >, " +
			"dislikes list< frozen<Dislike> >," +
            "comments list< frozen<Comment> >," +
            "visibility text);"       
        )
        
        session.execute("CREATE TYPE IF NOT EXISTS simplex.Comment (" + 
			"id text, " +
			"description text, " +
            "visibility text);"       
        )
        
        session.execute("CREATE TYPE IF NOT EXISTS simplex.Like (" + 
			"username text); "       
        )
        
        session.execute("CREATE TYPE IF NOT EXISTS simplex.Dislike (" + 
			"username text); "       
        )
		 
		session.execute("CREATE TABLE IF NOT EXISTS simplex.Perfil (" +
            "username text PRIMARY KEY," +
            "destinations list< frozen<Destiny> >," +      
            ");");
                
		mapper = new MappingManager(session).mapper(Perfil)
	}

   def close() {
      cluster.close()
   }
   
   def eliminarTablas(){
		session.execute("DROP KEYSPACE IF EXISTS simplex");
		cluster.close();
	}
	
}