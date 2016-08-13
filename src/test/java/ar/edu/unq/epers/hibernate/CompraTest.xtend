package ar.edu.unq.epers.hibernate

import ar.edu.unq.epers.aterrizar.servicios.CompraService
import ar.edu.unq.epers.aterrizar.model.Compra
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
import java.util.ArrayList

class CompraTest {
	CompraService service
	BaseHome baseHome
	Tramo tramo
    Usuario usuario0
    Usuario usuario1
    Usuario usuario2
    Compra compra0
    Compra compra1
    Compra compra2
    Asiento asiento0
    Asiento asiento1
    Asiento asiento2
    Destiny destinoBrasil
    Destiny destinoParaguay
	
	 
	@Before
	def void setUp() {
		service = new CompraService
		baseHome = new BaseHome
		SessionManager::getSessionFactory().openSession()
		
		destinoBrasil = new Destiny
		destinoBrasil.nombre = "Brasil"
		destinoParaguay = new Destiny
		destinoParaguay.nombre = "Paraguay"
		
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
		
        
        tramo = new Tramo => [
            origen = "Buenos Aires"
            destino = "Brasil"
            llegada = new Date(2000)
            salida = new Date(1500)
            compras = new ArrayList   
        ]
        
        tramo.agregarCompra(compra0)
        tramo.agregarCompra(compra1)
        tramo.agregarCompra(compra2)
        
	}
	
	 
	@Test
	def void todasLasComprasTest() {
		service.guardar(tramo)
		var compras = service.todasLasCompras()
		Assert.assertEquals(compras.size, 3)
		Assert.assertEquals(compras.get(0).user.nombreDeUsuario, "usuario0")
		Assert.assertEquals(compras.get(0).asiento.nombre, "a0")
		Assert.assertEquals(compras.get(0).origenTramo, "Buenos Aires")
		Assert.assertEquals(compras.get(0).destinoTramo, "Brasil")
	}
	
	@Test
	def void todasLasComprasDeUsuarioTest() {
		service.guardar(tramo)
		var compras = service.todasLasCompras(usuario0, tramo)
		Assert.assertEquals(compras.size, 1)
		Assert.assertEquals(compras.get(0).user.nombreDeUsuario, "usuario0")
		Assert.assertEquals(compras.get(0).asiento.nombre, "a0")
		Assert.assertEquals(compras.get(0).origenTramo, "Buenos Aires")
		Assert.assertEquals(compras.get(0).destinoTramo, "Brasil")
	}
	
	
	@Test
	def void todasLasComprasConDestinoTest() {
		service.guardar(tramo)
		var compras = service.todasLasComprasConDestino(usuario0, tramo, "Brasil")
		Assert.assertEquals(compras.size, 1)
		Assert.assertEquals(compras.get(0).user.nombreDeUsuario, "usuario0")
		Assert.assertEquals(compras.get(0).asiento.nombre, "a0")
		Assert.assertEquals(compras.get(0).origenTramo, "Buenos Aires")
		Assert.assertEquals(compras.get(0).destinoTramo, "Brasil")
	}
	
	
	
	@Test
	def void todasLasComprasConOrigenTest() {
		service.guardar(tramo)
		var compras = service.todasLasComprasConOrigen(usuario0, tramo, "Buenos Aires")
		Assert.assertEquals(compras.size, 1)
		Assert.assertEquals(compras.get(0).user.nombreDeUsuario, "usuario0")
		Assert.assertEquals(compras.get(0).asiento.nombre, "a0")
		Assert.assertEquals(compras.get(0).origenTramo, "Buenos Aires")
		Assert.assertEquals(compras.get(0).destinoTramo, "Brasil")
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
        baseHome.hqlTruncate('asiento')
        baseHome.hqlTruncate('usuario')
    }
    
}