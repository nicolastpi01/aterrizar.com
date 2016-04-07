package ar.edu.unq.epers.aterrizar.hibernateTesting

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
	//Categoria categoria
	//Ubicacion ubicacion
	
	
 		SessionFactory sessionFactory;
 		 Session session = null;
	
	
	@Before
	def void setUp(){
		
		//sessionFactory = 
		SessionManager::getSessionFactory().openSession()
		//session = sessionFactory.openSession();
		//categoria = new Familiar=>[nombre="MiCategoria"]
		//ubicacion = new Ubicacion("La Plata")
		user = new Usuario => [
			nombreDeUsuario = "alan75"
			nombreYApellido = "alan ferreira"
			email = "abc@123.com"
			//nacimiento = new Date(2015,10,1)
				//nacimiento = cal.getTime() as Date
				nacimiento = new Date(2015,10,1)
		]
		service = new UsuarioService
		
		
	}
	
	
	@After
	def limpiar() {
    	SessionManager::resetSessionFactory
    	//SessionManager::getSession().close
    	//SessionManager::getSessionFactory().close
    	
	}
	
	
	/*
@After
 def void after() {
  session.close();
  sessionFactory.close();
 }*/

	
	
	@Test
	def void guardoUnUsuarioEnLaDB(){
		/*
		 service.crearAuto(auto)
		service.crearAuto(auto)
		service.crearAuto(auto)
		service.crearAuto(auto)
		service.crearAuto(auto)
		service.crearAuto(auto)
		service.crearAuto(auto)
		service.crearAuto(auto)
		service.crearAuto(auto)
		 */
		 
		 service.crearUsuario(user)
		//var  unUsuario = auto.getPatente
		//var result = service.consultarAuto(n)
		//Assert.assertEquals(result.size, 0)
		//Assert.assertEquals(result.getId, auto.getId)
		//Assert.assertEquals(result.getId, auto.getId)
		//Assert.assertEquals(result.getPatente, auto.getPatente)
		
	}
	
	
	/*
	@Test
	
	def void guardoUnAutoEnLaDB(){
		service.crearAuto(auto)
		service.crearAuto(auto)
		service.crearAuto(auto)
		service.crearAuto(auto)
		service.crearAuto(auto)
		service.crearAuto(auto)
		service.crearAuto(auto)
		service.crearAuto(auto)
		
		var  n = auto.getPatente
		var result = service.consultarAuto(n)
		//Assert.assertEquals(result.size, 0)
		//Assert.assertEquals(result.getId, auto.getId)
		Assert.assertEquals(result.getId, auto.getId)
		Assert.assertEquals(result.getPatente, auto.getPatente)
		
	}
	 */
	
}