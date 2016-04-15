package ar.edu.unq.epers.hibernate

import ar.edu.unq.epers.aterrizar.home.SessionManager
import ar.edu.unq.epers.aterrizar.model.Usuario
import ar.edu.unq.epers.aterrizar.servicios.UsuarioService
import java.util.Calendar
import java.util.GregorianCalendar
import org.hibernate.Session
import org.hibernate.SessionFactory
import org.junit.After
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import java.sql.Date

class TestUsuario {
	
	var Usuario user
	var UsuarioService service
	
 		SessionFactory sessionFactory;
 		 Session session = null;
	
	
	@Before
	def void setUp(){

		SessionManager::getSessionFactory().openSession()
		user = new Usuario => [
			nombreDeUsuario = "alan75"
			nombreYApellido = "alan ferreira"
			email = "abc@123.com"
			nacimiento = new Date(2015,10,1)
		]
		service = new UsuarioService
		
		
	}
	
	
	@After
	def limpiar() {
    	SessionManager::resetSessionFactory
	}

	
	@Test
	def void guardoUnUsuarioEnLaDB(){
		 
		 service.crearUsuario(user)
	}
	

	@Test
	def void consultarUsuarioEnLaDB(){
	service.crearUsuario(user)
	val consulta = service.consultarUsuario(user.nombreDeUsuario)
	Assert.assertEquals(consulta.nombreDeUsuario, user.nombreDeUsuario)
	Assert.assertEquals(consulta.contrasenia, user.contrasenia)
	Assert.assertEquals(consulta.email, user.email)
	Assert.assertEquals(consulta.nacimiento, user.nacimiento)
		
	}
	
}
