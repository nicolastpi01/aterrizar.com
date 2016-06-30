package ar.edu.unq.epers.aterrizar.servicios

import ar.edu.unq.epers.aterrizar.model.PerfilCacheado
import ar.edu.unq.epers.aterrizar.model.Visibility
import com.datastax.driver.core.Cluster
import com.datastax.driver.core.CodecRegistry
import com.datastax.driver.core.Session
import com.datastax.driver.extras.codecs.enums.EnumNameCodec
import com.datastax.driver.mapping.Mapper
import com.datastax.driver.mapping.MappingManager
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class CassandraServiceRunner {
   private Session session	
   private Cluster cluster
   private Mapper<PerfilCacheado> perfilmapper 
   
	def addPoint(String addres) {
		cluster = Cluster.builder.addContactPoint(addres).build
	}
	
	def getSession() {
		session = cluster.connect
	}
	
	def initializeMapper() {
		this.perfilmapper = new MappingManager(session).mapper(PerfilCacheado)
	}
	
	def defineKeyspace() {
		var query = "CREATE KEYSPACE IF NOT EXISTS cassandra WITH replication "
         + "= {'class':'SimpleStrategy', 'replication_factor':1};"
		session.execute(query)
		session.execute("USE cassandra")
	}
	
	def dropTable() {
		var query = "DROP TABLE perfilCacheado; "
		session.execute(query)
	}
	
	def createTablePerfilCacheado() {
		var query = "CREATE TABLE IF NOT EXISTS perfilCacheado(username text, "
		+ "visibility text, "
        + "perfil frozen <perfil> , "
        + "PRIMARY KEY (username, visibility) ); " 
         session.execute(query)
	}
	
	def createTypePerfil() {
		var query = "CREATE TYPE IF NOT EXISTS perfil(username text, "
         + "destinations list <frozen  <destiny> >, "
         + "id text );  "
         session.execute(query)
	}
	
	def createTypeDestiny() {
		var query = "CREATE TYPE IF NOT EXISTS destiny(id text, "
		+ "nombre text, "
		+ "likes list< frozen <like> >, "
		+ "dislikes list< frozen <dislike> >, "
		+ "comments list< frozen <comment> >, "
        + "visibility text ); "
         session.execute(query)
	}
	
	def createTypeLike() {
		var query = "CREATE TYPE IF NOT EXISTS like(username text ); "
        session.execute(query)
	}
	
	def createTypeDislike() {
		var query = "CREATE TYPE IF NOT EXISTS dislike(username text ); "
        session.execute(query)
	}
	
	def createTypeComment() {
		var query = "CREATE TYPE IF NOT EXISTS comment(id text, "
		+ "description text, "
        + "visibility text ); "
        session.execute(query)
	}
	
	def dropKeyspace() {
		var query = "DROP KEYSPACE cassandra; "
		session.execute(query)
	}
	
	def initializeModel() {
		CodecRegistry.DEFAULT_INSTANCE
    	.register(new EnumNameCodec <Visibility>(Visibility))
		defineKeyspace
		createTypeLike
		createTypeDislike
		createTypeComment
		createTypeDestiny
		createTypePerfil
		createTablePerfilCacheado
	}
	
}