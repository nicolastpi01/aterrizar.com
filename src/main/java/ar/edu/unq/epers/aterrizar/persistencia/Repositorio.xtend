package ar.edu.unq.epers.aterrizar.persistencia
import java.sql.Connection;
import java.sql.DriverManager;
import ar.edu.unq.epers.aterrizar.model.Usuario
import java.util.Set
import java.sql.ResultSet

/**
 * Created by damian on 4/2/16.
 */
class Repositorio {

    def void guardarUsuario(Usuario usuario){
        excecute[conn|
            val ps = conn.prepareStatement("INSERT INTO usuario (nombreDeUsuario, nombreYApellido, email, contrasenia, codigoDeEmail, nacimiento, estaRegistradoEmail) VALUES (?,?,?,?,?,?,?)")
            ps.setString(1, usuario.nombreDeUsuario)
            ps.setString(2, usuario.getNombreYApellido)
            ps.setString(3, usuario.getEmail)
            ps.setString(4, usuario.getContrasenia)
            ps.setString(5, usuario.getCodigoDeEmail)
            ps.setString(6, usuario.getNacimiento.toString)
            ps.setBoolean(7, usuario.estaRegistradoEmail)


            ps.execute()

            ps.close()
            null
        ]
    }
    def getConnection() {
        Class.forName("com.mysql.jdbc.Driver");
        return DriverManager.getConnection("jdbc:mysql://localhost:3306/aterrizar?user=root&password=drl")
    }

    def Usuario obtenerPorNombreDeUsuario(String nomDeUsuario){
        excecute[conn|
            val ps = conn.prepareStatement("SELECT nombreDeUsuario FROM usuario")

            val ResultSet rs = ps.executeQuery
            var Usuario userRes2 = new Usuario =>[nombreDeUsuario = "none"];


            while(rs.next()){
                val nDeUs = rs.getString("nombreDeUsuario")
                if(nDeUs == nomDeUsuario )
                    userRes2 => [
                        setNombreDeUsuario = nomDeUsuario
                    ]
            }
            ps.close();

            userRes2
        ]




    }

    def <A> excecute(org.eclipse.xtext.xbase.lib.Functions.Function1<Connection, A> closure){
        var Connection conn = null
        try{
            conn = getConnection()
            return closure.apply(conn)
        }finally{
            if(conn != null)
                conn.close()
        }
    }






}