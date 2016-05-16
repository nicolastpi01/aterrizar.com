package ar.edu.unq.epers.neo4j

import static org.junit.Assert.*
import ar.edu.unq.epers.aterrizar.model.Usuario
import ar.edu.unq.epers.aterrizar.servicios.SocialNetworkingService
import org.junit.After
import org.junit.Before
import org.junit.Test
import org.junit.Assert

class SocialNetworkingServiceTest {


    Usuario usuario1
    Usuario usuario2
    Usuario usuario3AmigoDe1
    Usuario usuario4AmigoDe1
    Usuario usuario5AmigoDe1
    Usuario usuario6AmigoDe2
    Usuario usuario7AmigoDe2
    Usuario usuario8AmigoDe3
    Usuario usuario9AmigoDe4
    Usuario usuario10AmigoDe6
    SocialNetworkingService service


    @Test
    def void esPadre(){
        val padres = service.padres(hijo)
        Assert.assertEquals(1, padres.length)
        Assert.assertEquals(padres.head, padre)
    }

    @Test
    def void sonPrimos(){
        val primos = service.primosDe(hijo)

        Assert.assertEquals(2, primos.length)
        Assert.assertTrue(primos.contains(primo))
        Assert.assertTrue(primos.contains(primo2))
    }

    @After
    def void after(){
        service.eliminarPersona(padre)
        service.eliminarPersona(tio)
        service.eliminarPersona(hijo)
        service.eliminarPersona(primo)
        service.eliminarPersona(primo2)
    }


    @Before
    def void setup(){
    }
}