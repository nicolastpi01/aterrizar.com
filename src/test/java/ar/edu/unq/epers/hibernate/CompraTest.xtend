package ar.edu.unq.epers.hibernate

import ar.edu.unq.epers.aterrizar.servicios.CompraService
import ar.edu.unq.epers.aterrizar.model.Compra
import ar.edu.unq.epers.aterrizar.model.Reserva
import ar.edu.unq.epers.aterrizar.home.BaseHome
import ar.edu.unq.epers.aterrizar.model.Tramo
import ar.edu.unq.epers.aterrizar.model.Usuario
import org.junit.Before
import ar.edu.unq.epers.aterrizar.home.SessionManager
import java.sql.Date
import org.junit.Test
import org.junit.Assert
import org.junit.After
import ar.edu.unq.epers.aterrizar.model.Destiny
import ar.edu.unq.epers.aterrizar.model.Asiento
import ar.edu.unq.epers.aterrizar.model.Primera

class CompraTest {
	CompraService service
	Reserva reserva0
	Reserva reserva1
	Reserva reserva2
	BaseHome baseHome
	Tramo tramo
    Usuario usuario0
    Usuario usuario1
    Usuario usuario2
    Compra compra0
    Compra compra1
    Compra compra2
    Destiny destinoBrasil
    Destiny destinoParaguay
    Asiento asiento0
    Asiento asiento1
    Asiento asiento2
	
	 
	@Before
	def void setUp() {
		service = new CompraService
		baseHome = new BaseHome
		SessionManager::getSessionFactory().openSession()
		
		usuario0 = new Usuario => [
            nombreDeUsuario = "usuario0"
            nombreYApellido = "usuario0 apellido"
            email = "abc@123.com"
            nacimiento = new Date(2015,10,1)
        ]
        
        usuario1 = new Usuario => [
            nombreDeUsuario = "usuario1"
            nombreYApellido = "usuario1 apellido"
            email = "abc1@123.com"
            nacimiento = new Date(2015,10,1)
        ]
        
        usuario2 = new Usuario => [
            nombreDeUsuario = "usuario2"
            nombreYApellido = "usuario2 apellido"
            email = "abc1@123.com"
            nacimiento = new Date(2015,10,1)
        ]
        
        asiento0 = new Asiento => [
                    nombre = "a0"
                    categoria = new Primera(1000)
                ]
                
        asiento1 = new Asiento => [
                    nombre = "a1"
                    categoria = new Primera(1000)
                ]
                
        asiento2 = new Asiento => [
                    nombre = "a2"
                    categoria = new Primera(1000)
                ]
        
        compra0 = new Compra => [
            user = usuario0
            asiento = asiento0
            origenTramo = "Buenos Aires"
            destinoTramo = "Brasil"
        ]
        
        compra1 = new Compra => [
            user = usuario1
            asiento = asiento1
            origenTramo = "Brasil"
            destinoTramo = "Paraguay"
        ]
        
        compra2 = new Compra => [
            user = usuario2
            asiento = asiento2
            origenTramo = "Paraguay"
            destinoTramo = "Chile"
        ]
		
		reserva0 = new Reserva => [
            user = usuario0
            asiento = asiento0
            tramoOrigen = "Buenos Aires"
            tramoDestino = "Brasil"
         
        ]
        
        reserva1 = new Reserva => [
            user = usuario1
            asiento = asiento1
            tramoOrigen = "Brasil"
            tramoDestino = "Paraguay"
           
        ]
        
        reserva2 = new Reserva => [
            user = usuario2
            asiento = asiento2
            tramoOrigen = "Paraguay"
            tramoDestino = "Mexico"
            
        ]
        
        tramo = new Tramo => [
            origen = "Buenos Aires"
            destino = "Brasil"
            llegada = new Date(2000)
            salida = new Date(1500)
            compras = #[compra0, compra1, compra2]
            
        ]
        
        destinoBrasil = new Destiny => [
        	nombre = "Brasil"
        ]
        
        destinoParaguay = new Destiny => [
        	nombre = "Paraguay"
        ]
	}
	
	
	@Test
	def void guardarCompraTest() {
		
		service.guardar(compra0)
		service.guardar(compra1)
		service.guardar(compra2)
		var compra0Aux = service.buscar(compra0, compra0.id)
		var compra1Aux = service.buscar(compra1, compra1.id)
		var compra2Aux = service.buscar(compra2, compra2.id)
		Assert.assertEquals(compra0Aux.user.nombreDeUsuario, "usuario0")
		Assert.assertEquals(compra0Aux.asiento.nombre, "asiento0")
		Assert.assertEquals(compra0Aux.origenTramo, "Buenos Aires")
		Assert.assertEquals(compra0Aux.destinoTramo, "Brasil")
		Assert.assertEquals(compra1Aux.user.nombreDeUsuario, "usuario1")
		Assert.assertEquals(compra2Aux.user.nombreDeUsuario, "usuario2")
	
	}
	/* 
	@Test
	def void todasLasComprasTest() {
		service.guardar(tramo)
		var compras = service.todasLasCompras()
		Assert.assertEquals(compras.size, 3)
		Assert.assertEquals(compras.get(0).username, "usuario0")
		Assert.assertEquals(compras.get(0).nombreAsiento, "asiento0")
		Assert.assertEquals(compras.get(0).origenTramo, "Buenos Aires")
		Assert.assertEquals(compras.get(0).destinoTramo, "Brasil")
	}
	
	@Test
	def void todasLasComprasDeUsuarioTest() {
		service.guardar(tramo)
		var comprasUsuario0 = service.todasLasComprasDeUsuario(usuario0)
		Assert.assertEquals(comprasUsuario0.size, 1)
		Assert.assertEquals(comprasUsuario0.get(0).username, "usuario0")
		Assert.assertEquals(comprasUsuario0.get(0).nombreAsiento, "asiento0")
		Assert.assertEquals(comprasUsuario0.get(0).origenTramo, "Buenos Aires")
		Assert.assertEquals(comprasUsuario0.get(0).destinoTramo, "Brasil")
	}
	
	@Test
	def void todasLasComprasDeTramoConDestinoTest() {
		service.guardar(tramo)
		var comprasConDestinoBrasil = service.todasLasComprasDeTramoConDestino("Brasil")
		Assert.assertEquals(comprasConDestinoBrasil.size, 1)
		Assert.assertEquals(comprasConDestinoBrasil.get(0).username, "usuario0")
		Assert.assertEquals(comprasConDestinoBrasil.get(0).nombreAsiento, "asiento0")
		Assert.assertEquals(comprasConDestinoBrasil.get(0).origenTramo, "Buenos Aires")
		Assert.assertEquals(comprasConDestinoBrasil.get(0).destinoTramo, "Brasil")
	}
	
	@Test
	def void todasLasComprasDeTramoConOrigenTest() {
		service.guardar(tramo)
		var comprasConOrigenArgentina = service.todasLasComprasDeTramoConOrigen("Buenos Aires")
		Assert.assertEquals(comprasConOrigenArgentina.size, 1)
		Assert.assertEquals(comprasConOrigenArgentina.get(0).username, "usuario0")
		Assert.assertEquals(comprasConOrigenArgentina.get(0).nombreAsiento, "asiento0")
		Assert.assertEquals(comprasConOrigenArgentina.get(0).origenTramo, "Buenos Aires")
		Assert.assertEquals(comprasConOrigenArgentina.get(0).destinoTramo, "Brasil")
	}
	
	@Test
	def void tieneCompraEnDestinoTest() {
		service.guardar(tramo)
		Assert.assertTrue(service.tieneCompraEnDestino(usuario0, destinoBrasil))
		Assert.assertTrue(service.tieneCompraEnDestino(usuario1, destinoParaguay))
	}
	
	@After
    def void limpiar() {
        baseHome.hqlTruncate('compra')
        baseHome.hqlTruncate('tramo')
       
    }
    */
}