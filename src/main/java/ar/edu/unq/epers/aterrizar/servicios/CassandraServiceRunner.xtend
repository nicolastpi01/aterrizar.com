package ar.edu.unq.epers.aterrizar.servicios

import com.datastax.driver.core.Cluster
import com.datastax.driver.core.Session
import org.eclipse.xtend.lib.annotations.Accessors
import ar.edu.unq.epers.aterrizar.model.Perfil
import com.datastax.driver.mapping.Mapper
import com.datastax.driver.mapping.MappingManager
import ar.edu.unq.epers.aterrizar.model.Usuario

@Accessors
class CassandraServiceRunner {
   private Session session	
   private Cluster cluster
   private Mapper<Perfil> perfilmapper
   //private String contactPoint   
   
   /* 
    new(String contactPoint) {
   		this.contactPoint = contactPoint
    }
   
   /* 
 	def createSession() {
		cluster = Cluster.builder().addContactPoint(contactPoint).build()
		return cluster.connect()
  	}
	
	def getSession() {
	if (session == null) session = createSession
		return session
	}
	*/
	def addPoint(String addres) {
		cluster = Cluster.builder.addContactPoint(addres).build
	}
	
	def getSession() {
		session = cluster.connect
	}
	
	def initializeMapper() {
		this.perfilmapper = new MappingManager(session).mapper(Perfil)
	}
	
	def defineKeyspace() {
		var query = "CREATE KEYSPACE IF NOT EXISTS cassandra WITH replication "
         + "= {'class':'SimpleStrategy', 'replication_factor':1};"
		session.execute(query)
		session.execute("USE cassandra")
	}
	
	def dropTable() {
		var query = "DROP TABLE perfiles; "
		session.execute(query)
	}
	
	def createTable() {
		var query = "CREATE TABLE IF NOT EXISTS perfiles(username text PRIMARY KEY, "
         + "destinations list< frozen <destiny> >, "
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
		defineKeyspace
		createTypeLike
		createTypeDislike
		createTypeComment
		createTypeDestiny
		createTable
	}
	
	def stalkearFriend(Usuario u) {
		var query = "SELECT * FROM cassandra.perfiles "
		session.execute(query)	
	}
	
	def stalkearNoFriend(Usuario u) {
		var query = "SELECT * FROM cassandra.perfiles "
		session.execute(query)
	}
	
}