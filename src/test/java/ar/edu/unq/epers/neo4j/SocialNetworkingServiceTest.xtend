package ar.edu.unq.epers.neo4j

import static org.junit.Assert.*
import ar.edu.unq.epers.aterrizar.model.Usuario
import ar.edu.unq.epers.aterrizar.servicios.SocialNetworkingService

import org.junit.Before
import java.sql.Date
import org.junit.After
import org.junit.Test
import org.junit.Assert
import ar.edu.unq.epers.aterrizar.model.Message
import ar.edu.unq.epers.aterrizar.home.SocialNetworkingHome

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
    def void getAmigos(){
        var amigos = service.friends(usuario1)
        Assert.assertEquals(3, amigos.length)
    }

    @After
    def void after(){
        service.eliminarPersona(usuario1)
        service.eliminarPersona(usuario2)


        service.eliminarPersona(usuario3AmigoDe1)
        service.eliminarPersona(usuario4AmigoDe1)
        service.eliminarPersona(usuario5AmigoDe1)
        service.eliminarPersona(usuario6AmigoDe2)
        service.eliminarPersona(usuario7AmigoDe2)
        service.eliminarPersona(usuario8AmigoDe3)
        service.eliminarPersona(usuario9AmigoDe4)
        service.eliminarPersona(usuario10AmigoDe6)

    }


    @Before
    def void setup(){

        service = new SocialNetworkingService

        usuario1 = new Usuario => [
            nombreDeUsuario = "alan75"
            nombreYApellido = "alan ferreira"
            email = "abc@123.com"
            //       nacimiento = new Date(2015,10,1)
            validado = true
            contrasenia = "abc123"
        ]


        usuario2 = new Usuario => [
            nombreDeUsuario = "piter23"
            nombreYApellido = "piter castro"
            email = "abcd@123.com"
            //    nacimiento = new Date(2015,10,1)
            validado = true
            contrasenia = "abc123"


        ]



        usuario3AmigoDe1 = new Usuario => [
            nombreDeUsuario = "abelAlgo"
            nombreYApellido = "Abel Pintos"
            email = "abel@123.com"
            //nacimiento = new Date(2015,10,1)
            validado = true
            contrasenia = "abc123"
        ]

        usuario4AmigoDe1 = new Usuario => [
            nombreDeUsuario = "Mauro"
            nombreYApellido = "Abel Pintos"
            email = "abel@123.com"
            //nacimiento = new Date(2015,10,1)
            validado = true
            contrasenia = "abc123"
        ]

        usuario5AmigoDe1 = new Usuario => [
            nombreDeUsuario = "Irenne"
            nombreYApellido = " Diana Perez"
            email = "diann@24.com"
            //nacimiento = new Date(2015,10,1)
            validado = true
            contrasenia = "abc123"
        ]

        usuario6AmigoDe2 = new Usuario => [
            nombreDeUsuario = "CarlosJ"
            nombreYApellido = " Diana Perez"
            email = "diann@24.com"
            //nacimiento = new Date(2015,10,1)
            validado = true
            contrasenia = "abc123"
        ]

        usuario7AmigoDe2 = new Usuario => [
            nombreDeUsuario = "Sebastian"
            nombreYApellido = " Diana Perez"
            email = "diann@24.com"
            //nacimiento = new Date(2015,10,1)
            validado = true
            contrasenia = "abc123"
        ]

        usuario8AmigoDe3 = new Usuario => [
            nombreDeUsuario = "Yamila"
            nombreYApellido = " Diana Perez"
            email = "diann@24.com"
            //nacimiento = new Date(2015,10,1)
            validado = true
            contrasenia = "abc123"
        ]

        usuario9AmigoDe4 = new Usuario => [
            nombreDeUsuario = "Marcos"
            nombreYApellido = " Diana Perez"
            email = "diann@24.com"
            //nacimiento = new Date(2015,10,1)
            validado = true
            contrasenia = "abc123"
        ]

        usuario10AmigoDe6 = new Usuario => [
            nombreDeUsuario = "Patricio"
            nombreYApellido = " Diana Perez"
            email = "diann@24.com"
            //nacimiento = new Date(2015,10,1)
            validado = true
            contrasenia = "abc123"
        ]




        service.agregarPersona(usuario1)
        service.agregarPersona(usuario2)


        service.agregarPersona(usuario3AmigoDe1)
        service.agregarPersona(usuario4AmigoDe1)
        service.agregarPersona(usuario5AmigoDe1)
        service.agregarPersona(usuario6AmigoDe2)
        service.agregarPersona(usuario7AmigoDe2)
        service.agregarPersona(usuario8AmigoDe3)
        service.agregarPersona(usuario9AmigoDe4)
        service.agregarPersona(usuario10AmigoDe6)




        service.amigoDe(usuario1, usuario3AmigoDe1)
        service.amigoDe(usuario1, usuario4AmigoDe1)
        service.amigoDe(usuario1, usuario5AmigoDe1)
        service.amigoDe(usuario2, usuario6AmigoDe2)
        service.amigoDe(usuario2, usuario7AmigoDe2)
        service.amigoDe(usuario3AmigoDe1, usuario8AmigoDe3)
        service.amigoDe(usuario4AmigoDe1, usuario9AmigoDe4)
        service.amigoDe(usuario6AmigoDe2, usuario10AmigoDe6)


    }

    @Test
    def void getAmigosDeAmigos(){
        var amigos = service.allFriends(usuario1)
        Assert.assertEquals(5, amigos.length)
    }

    @Test
    def void getAmigosDeAmigos2(){
        var amigos = service.allFriends(usuario2)
        Assert.assertEquals(3, amigos.length)
    }

    @Test
    def void enviarUnMensaje(){
        var mensaje = new Message() => [
            descripcion = "descripcion 1"
            sender = usuario1
            receiver = usuario2
        ]

        service.agregarMensaje(mensaje)
        service.sendMessage(usuario1,usuario2,mensaje)
        Assert.assertEquals(service.getSender(mensaje).nombreDeUsuario, usuario1.nombreDeUsuario)
        Assert.assertEquals(service.getReceiver(mensaje).nombreDeUsuario, usuario2.nombreDeUsuario)

    }
}
