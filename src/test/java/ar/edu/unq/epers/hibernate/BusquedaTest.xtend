package ar.edu.unq.epers.hibernate

import ar.edu.unq.epers.aterrizar.model.Aerolinea
import ar.edu.unq.epers.aterrizar.model.VueloOfertado
import ar.edu.unq.epers.aterrizar.servicios.BusquedaService
import ar.edu.unq.epers.aterrizar.model.Tramo
import ar.edu.unq.epers.aterrizar.model.Asiento
import ar.edu.unq.epers.aterrizar.home.BaseHome
import org.junit.Before
import ar.edu.unq.epers.aterrizar.home.SessionManager
import ar.edu.unq.epers.aterrizar.model.Usuario
import java.sql.Date
import ar.edu.unq.epers.aterrizar.model.Primera
import java.util.Calendar
import java.util.ArrayList
import org.junit.Test
import org.junit.Assert
import ar.edu.unq.epers.aterrizar.BusquedaHql.Busqueda
import ar.edu.unq.epers.aterrizar.BusquedaHql.CriterioPorAerolinea
import ar.edu.unq.epers.aterrizar.BusquedaHql.CriterioPorCategoriaDeAsiento
import ar.edu.unq.epers.aterrizar.model.Business
import ar.edu.unq.epers.aterrizar.BusquedaHql.CriterioPorFechaDeSalida
import ar.edu.unq.epers.aterrizar.BusquedaHql.CriterioPorFechaDeLlegada
import ar.edu.unq.epers.aterrizar.BusquedaHql.CriterioPorDestino
import ar.edu.unq.epers.aterrizar.BusquedaHql.CriterioCompuesto
import ar.edu.unq.epers.aterrizar.BusquedaHql.OperadorLogico
import ar.edu.unq.epers.aterrizar.BusquedaHql.Orden
import ar.edu.unq.epers.aterrizar.BusquedaHql.MenorCantidadDeEscalas
import ar.edu.unq.epers.aterrizar.model.Turista
import ar.edu.unq.epers.aterrizar.BusquedaHql.MenorCosto
import ar.edu.unq.epers.aterrizar.BusquedaHql.MenorDuracion
import org.junit.After

class BusquedaTest {
	BusquedaService service
	BaseHome baseHome
	Usuario usuario
	Usuario otroUsuario
	Aerolinea aerolineaAustral
	VueloOfertado vueloDisponible
	VueloOfertado vueloDisponible2
	VueloOfertado vueloNoDisponible
	Tramo tramoValido
	Tramo tramoInvalido
	Tramo tramoValido2
	Asiento asientoNoReservadoDisponible
    Asiento asientoReservadoNoDisponible0
    Asiento asientoReservadoNoDisponible1
    Asiento asientoReservadoNoDisponible2
    Asiento asientoReservadoDisponible0
    Asiento asientoReservadoDisponible1
    Asiento asientoReservadoDisponible2
    Asiento asientoReservadoDisponible3
    Busqueda busquedaPorAerolinea
    Busqueda busquedaPorCategoriaDeAsiento
    Busqueda busquedaPorFechaDeSalida
    Busqueda busquedaPorFechaDeLlegada
    Busqueda busquedaPorDestino
    Busqueda busquedaPorCriterioDestinoANDCategoriaDeAsiento
    Busqueda busquedaPorCriterioDestinoORCategoriaDeAsiento
    Busqueda busquedaPorCategoriaDeAsientoOrdenadoPorMenorEscalas
    Busqueda busquedaPorCategoriaDeAsientoOrdenadoPorMenorCosto
    Busqueda busquedaPorCategoriaDeAsientoOrdenadoPorMenorDuracion
    CriterioPorAerolinea criterioPorAerolineaAustral
    CriterioPorCategoriaDeAsiento criterioPorCategoriaDeAsientoBusiness
    CriterioPorFechaDeSalida criterioPorFechaDeSalida
    CriterioPorFechaDeLlegada criterioPorFechaDeLlegada
    CriterioPorDestino criterioPorDestinoBrasil
    CriterioCompuesto criterioPorDestinoANDCategoriaDeAsiento 
    CriterioCompuesto criterioPorDestinoORCategoriaDeAsiento
    Orden ordenPorEscalas
    Orden ordenPorMenorCosto
    Orden ordenPorMenorDuracion
    
    @Before
    def void setUp() {
    	SessionManager::getSessionFactory().openSession()
    	baseHome = new BaseHome
    	service = new BusquedaService
    	criterioPorAerolineaAustral = new CriterioPorAerolinea
    	criterioPorAerolineaAustral.aerolinea = "Austral"
    	criterioPorCategoriaDeAsientoBusiness = new CriterioPorCategoriaDeAsiento
    	criterioPorCategoriaDeAsientoBusiness.categoriaAsiento = new Business(100)
    	criterioPorFechaDeSalida = new CriterioPorFechaDeSalida
    	criterioPorFechaDeSalida.fechaSalida = new Date(2016, 07, 20)
    	criterioPorFechaDeLlegada = new CriterioPorFechaDeLlegada
    	criterioPorFechaDeLlegada.fechaLlegada = new Date(2016, 07, 22)
    	criterioPorDestinoBrasil = new CriterioPorDestino
    	criterioPorDestinoBrasil.destino = "Brasil"
    	criterioPorDestinoANDCategoriaDeAsiento = new CriterioCompuesto
    	criterioPorDestinoANDCategoriaDeAsiento.criteriosSeleccionados = new ArrayList
    	criterioPorDestinoANDCategoriaDeAsiento.criteriosSeleccionados.add(criterioPorDestinoBrasil)
    	criterioPorDestinoANDCategoriaDeAsiento.criteriosSeleccionados.add(criterioPorCategoriaDeAsientoBusiness)
    	criterioPorDestinoANDCategoriaDeAsiento.operador = new OperadorLogico
    	criterioPorDestinoANDCategoriaDeAsiento.operador.operadorAndOr = "AND"
    	criterioPorDestinoORCategoriaDeAsiento = new CriterioCompuesto
    	criterioPorDestinoORCategoriaDeAsiento.criteriosSeleccionados = new ArrayList
    	criterioPorDestinoORCategoriaDeAsiento.criteriosSeleccionados.add(criterioPorDestinoBrasil)
    	criterioPorDestinoORCategoriaDeAsiento.criteriosSeleccionados.add(criterioPorCategoriaDeAsientoBusiness)
    	criterioPorDestinoORCategoriaDeAsiento.operador = new OperadorLogico
    	criterioPorDestinoORCategoriaDeAsiento.operador.operadorAndOr = "OR"
    	busquedaPorAerolinea = new Busqueda(criterioPorAerolineaAustral)
    	busquedaPorCategoriaDeAsiento = new Busqueda(criterioPorCategoriaDeAsientoBusiness)
    	busquedaPorFechaDeSalida = new Busqueda(criterioPorFechaDeSalida)
    	busquedaPorFechaDeLlegada = new Busqueda(criterioPorFechaDeLlegada)
    	busquedaPorDestino = new Busqueda(criterioPorDestinoBrasil)
    	busquedaPorCriterioDestinoANDCategoriaDeAsiento = new Busqueda(criterioPorDestinoANDCategoriaDeAsiento)
    	busquedaPorCriterioDestinoORCategoriaDeAsiento = new Busqueda(criterioPorDestinoORCategoriaDeAsiento)
    	ordenPorEscalas = new MenorCantidadDeEscalas
    	ordenPorMenorCosto = new MenorCosto
    	ordenPorMenorDuracion = new MenorDuracion
    	busquedaPorCategoriaDeAsientoOrdenadoPorMenorEscalas = new Busqueda(ordenPorEscalas, criterioPorCategoriaDeAsientoBusiness)
    	busquedaPorCategoriaDeAsientoOrdenadoPorMenorCosto = new Busqueda(ordenPorMenorCosto, criterioPorCategoriaDeAsientoBusiness)
    	busquedaPorCategoriaDeAsientoOrdenadoPorMenorDuracion = new Busqueda(ordenPorMenorDuracion, criterioPorCategoriaDeAsientoBusiness)
    	
    	usuario = new Usuario => [
            nombreDeUsuario = "usuario"
            nombreYApellido = "usuario apellido"
            email = "abc@123.com"
            nacimiento = new Date(2015,10,1)
        ]
        
        otroUsuario = new Usuario => [
            nombreDeUsuario = "otroUsuario"
            nombreYApellido = "usuario otro"
            email = "abc@123.com"
            nacimiento = new Date(2015,10,1)
        ]
        
        asientoNoReservadoDisponible = new Asiento => [
        	nombre = "asientoNoReservado"
        	categoria = new Primera(1000)
        ]
                
        asientoReservadoNoDisponible0 = new Asiento => [
        	nombre = "asientoInvalido0"
        	categoria = new Primera(1000)
        	user = otroUsuario
        	fechaReserva = new java.util.Date
        ]
                
        
        asientoReservadoNoDisponible1 = new Asiento => [
            nombre = "asientoInvalido1"
        	categoria = new Primera(1000)
        	user = otroUsuario
        	var calendar = Calendar.getInstance()
			calendar.setTime(new java.util.Date())
			calendar.add(Calendar.MINUTE, -3)
            fechaReserva = calendar.getTime
          
        ]
        
        asientoReservadoNoDisponible2 = new Asiento => [
            nombre = "asientoInvalido2"
        	categoria = new Primera(1000)
        	user = otroUsuario
        	var calendar = Calendar.getInstance()
			calendar.setTime(new java.util.Date())
			calendar.add(Calendar.MINUTE, -4)
            fechaReserva = calendar.getTime
          
        ]
        
        asientoReservadoDisponible0 = new Asiento => [
            nombre = "asientoValido0"
        	categoria = new Primera(1000)
        	user = usuario
        	var calendar = Calendar.getInstance()
			calendar.setTime(new java.util.Date())
			calendar.add(Calendar.MINUTE, -7)
            fechaReserva = calendar.getTime
          
        ]
        
        asientoReservadoDisponible1 = new Asiento => [
            nombre = "asientoValido1"
        	categoria = new Business(100)
        	user = usuario
        	var calendar = Calendar.getInstance()
			calendar.setTime(new java.util.Date())
			calendar.add(Calendar.MINUTE, -3)
            fechaReserva = calendar.getTime
          
        ]
        
        asientoReservadoDisponible2 = new Asiento => [
            nombre = "asientoValido2"
        	categoria = new Business(100)
        	user = usuario
        	var calendar = Calendar.getInstance()
			calendar.setTime(new java.util.Date())
			calendar.add(Calendar.MINUTE, -15)
            fechaReserva = calendar.getTime
          
        ]
        
        asientoReservadoDisponible3 = new Asiento => [
            nombre = "asientoValido3"
        	categoria = new Turista(100)
        	user = usuario
        	var calendar = Calendar.getInstance()
			calendar.setTime(new java.util.Date())
			calendar.add(Calendar.MINUTE, -9)
            fechaReserva = calendar.getTime
          
        ]
        
        tramoValido = new Tramo => [
            origen = "Buenos Aires"
            destino = "Brasil"
            llegada = new Date(2016, 07, 22)
            salida = new Date(2016, 07, 20)
            reservas = new ArrayList
            compras = new ArrayList
            asientos = new ArrayList
        ]
        
        tramoValido2 = new Tramo => [
            origen = "Brasil"
            destino = "Paraguay"
            llegada = new Date(2016, 06, 22)
            salida = new Date(2016, 06, 20)
            reservas = new ArrayList
            compras = new ArrayList
            asientos = new ArrayList
        ]
        
        tramoInvalido = new Tramo => [
            origen = "Catamarca"
            destino = "Misiones"
            llegada = new Date(2016, 07, 24)
            salida = new Date(2016, 07, 22)
            reservas = new ArrayList
            compras = new ArrayList
            asientos = new ArrayList
        ]
        
        tramoInvalido.agregarAsiento(asientoReservadoNoDisponible0)
        tramoInvalido.agregarAsiento(asientoReservadoNoDisponible1)
        tramoInvalido.agregarAsiento(asientoReservadoNoDisponible2)
        tramoValido.agregarAsiento(asientoReservadoDisponible0)
        tramoValido.agregarAsiento(asientoReservadoDisponible1)
        tramoValido.agregarAsiento(asientoNoReservadoDisponible)
        tramoValido2.agregarAsiento(asientoReservadoDisponible2)
        tramoValido2.agregarAsiento(asientoReservadoDisponible3)
        
        var tramosDeVueloDisponible = new ArrayList
        tramosDeVueloDisponible.add(tramoValido)
        tramosDeVueloDisponible.add(tramoInvalido)
        var tramosDeVueloDisponible2 = new ArrayList
        tramosDeVueloDisponible2.add(tramoValido2)
        var tramosDeVueloNoDisponible = new ArrayList
        tramosDeVueloNoDisponible.add(tramoInvalido)
        
        vueloDisponible = new VueloOfertado(tramosDeVueloDisponible, 5000)
        vueloDisponible2 = new VueloOfertado(tramosDeVueloDisponible2, 4500)
        vueloNoDisponible = new VueloOfertado(tramosDeVueloNoDisponible, 7000)
        
        var vuelosOfertados = new ArrayList
        vuelosOfertados.add(vueloDisponible)
        vuelosOfertados.add(vueloDisponible2)
        vuelosOfertados.add(vueloNoDisponible)
        
        aerolineaAustral = new Aerolinea()
        aerolineaAustral.nombre = "Austral"
        aerolineaAustral.vuelosOfertados = vuelosOfertados
    }
    
    @Test
    def void buscarVuelosDisponiblesPorAerolinea() {
    	service.guardar(aerolineaAustral)
    	var vuelos = service.buscarVuelosDisponibles(busquedaPorAerolinea, usuario)
    	Assert.assertEquals(vuelos.size, 2)
    }
     
    @Test
    def void buscarVuelosDisponiblesPorCategoriaDeAsiento() {
    	service.guardar(aerolineaAustral)
    	var vuelos = service.buscarVuelosDisponibles(busquedaPorCategoriaDeAsiento, usuario)
    	Assert.assertEquals(vuelos.size, 2)
    }
    
    @Test
    def void buscarVuelosDisponiblesPorFechaDeSalida() {
    	service.guardar(aerolineaAustral)
    	var vuelos = service.buscarVuelosDisponibles(busquedaPorFechaDeSalida, usuario)
    	Assert.assertEquals(vuelos.size, 1)
    }
    
    @Test
    def void buscarVuelosDisponiblesPorFechaDeLlegada() {
    	service.guardar(aerolineaAustral)
    	var vuelos = service.buscarVuelosDisponibles(busquedaPorFechaDeLlegada, usuario)
    	Assert.assertEquals(vuelos.size, 1)
    }
    
    @Test
    def void buscarVuelosDisponiblesPorDestino() {
    	service.guardar(aerolineaAustral)
    	var vuelos = service.buscarVuelosDisponibles(busquedaPorDestino, usuario)
    	Assert.assertEquals(vuelos.size, 1)
    }
    
    @Test
    def void buscarVuelosDisponiblesPorCriterioCompuestoAND() {
    	service.guardar(aerolineaAustral)
    	var vuelos = service.buscarVuelosDisponibles(busquedaPorCriterioDestinoANDCategoriaDeAsiento, usuario)
    	Assert.assertEquals(vuelos.size, 1)
    }
     
    @Test
    def void buscarVuelosDisponiblesPorCriterioCompuestoOR() {
    	service.guardar(aerolineaAustral)
    	var vuelos = service.buscarVuelosDisponibles(busquedaPorCriterioDestinoORCategoriaDeAsiento, usuario)
    	Assert.assertEquals(vuelos.size, 2)
    }
    
    @Test
    def void buscarVuelosDisponiblesPorCategoriaDeAsientoOrdenadoPorMenorEscalas() {
    	service.guardar(aerolineaAustral)
    	var vuelos = service.buscarVuelosDisponibles(busquedaPorCategoriaDeAsientoOrdenadoPorMenorEscalas, usuario)
    	Assert.assertEquals(vuelos.size, 2)
    	Assert.assertEquals(vuelos.get(0).cantidadTramos, 1)
    	Assert.assertEquals(vuelos.get(1).cantidadTramos, 2)
    }
    
    @Test
    def void buscarVuelosDisponiblesPorCategoriaDeAsientoOrdenadoPorMenorCosto() {
    	service.guardar(aerolineaAustral)
    	var vuelos = service.buscarVuelosDisponibles(busquedaPorCategoriaDeAsientoOrdenadoPorMenorCosto, usuario)
    	Assert.assertEquals(vuelos.size, 2)
    	Assert.assertEquals(vuelos.get(0).precioBase, 4500)
    	Assert.assertEquals(vuelos.get(1).precioBase, 5000)
    }
    
    @Test
    def void buscarVuelosDisponiblesPorCategoriaDeAsientoOrdenadoPorMenorDuracion() {
    	service.guardar(aerolineaAustral)
    	var vuelos = service.buscarVuelosDisponibles(busquedaPorCategoriaDeAsientoOrdenadoPorMenorDuracion, usuario)
    	Assert.assertEquals(vuelos.size, 2)
    	Assert.assertEquals(vuelos.get(0).cantidadTramos, 1)
    	Assert.assertEquals(vuelos.get(1).cantidadTramos, 2)
    }
    
    @After
    def void limpiar() {
        
       	baseHome.hqlTruncate('compra')
       	baseHome.hqlTruncate('reserva')
       	baseHome.hqlTruncate('asiento')
       	baseHome.hqlTruncate('turista')
       	baseHome.hqlTruncate('business')
       	baseHome.hqlTruncate('primera')
       	baseHome.hqlTruncate('categoria')
       	baseHome.hqlTruncate('usuario')
       	baseHome.hqlTruncate('tramo')
       	baseHome.hqlTruncate('vueloOfertado')
       	baseHome.hqlTruncate('aerolinea')
       	baseHome.hqlTruncate('criterio')
       	baseHome.hqlTruncate('orden')
       	baseHome.hqlTruncate('busqueda')   
    }
    
}