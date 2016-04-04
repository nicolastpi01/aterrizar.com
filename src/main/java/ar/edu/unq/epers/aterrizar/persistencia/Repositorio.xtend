package ar.edu.unq.epers.aterrizar.persistencia
import java.sql.Connection;
import java.sql.DriverManager;
import ar.edu.unq.epers.aterrizar.model.Usuario
import java.util.Set
import java.sql.ResultSet
import ar.edu.unq.epers.aterrizar.exceptions.YaExisteUsuarioConEseNombreException

/**
 * Created by damian on 4/2/16.
 */
class Repositorio {

    def void guardarUsuario(Usuario usuario) throws YaExisteUsuarioConEseNombreException{
        excecute[conn|

            val ps = conn.prepareStatement("SELECT * FROM usuario WHERE nombreDeUsuario = ?")

            ps.setString(1,usuario.getNombreDeUsuario)

            var rs = ps.executeQuery

            while(rs.next){
                throw new YaExisteUsuarioConEseNombreException
            }
        ]

        excecute[conn|

            val ps = conn.prepareStatement("INSERT INTO usuario (nombreDeUsuario, nombreYApellido, email, contrasenia, codigoDeEmail, nacimiento, estaRegistradoEmail) VALUES (?,?,?,?,?,?,?)")


            ps.setString(1, usuario.nombreDeUsuario)
            ps.setString(2, usuario.getNombreYApellido)
            ps.setString(3, usuario.getEmail)
            ps.setString(4, usuario.getContrasenia)
            ps.setInt(5, usuario.getCodigoDeEmail)
            ps.setString(6, usuario.getNacimiento.toString)
            ps.setBoolean(7, usuario.estaRegistradoEmail)

            ps.execute()



            ps.close()
            null
        ]
    }

    def void borrarTodosLosUsuario(){
        excecute[ conn |
            val ps = conn.prepareStatement("DELETE FROM usuario;")
            ps.execute()
        ]
    }

    def void tirarTablaConNombreDeUsuario(String nombreDeUsuario){

        excecute[conn|
            val ps = conn.prepareStatement("DELETE FROM usuario WHERE nombreDeUsuario = ?")
            ps.setString(1, nombreDeUsuario)

            ps.execute()

            ps.close

            null

        ]

    }



    def Usuario obtenerUsuarioPorNombreDeUsuario(String nomDeUsuario){
        excecute[conn|
            val ps = conn.prepareStatement("SELECT * FROM usuario WHERE nombreDeUsuario=?")
            ps.setString(1, nomDeUsuario)

            val ResultSet rs = ps.executeQuery
            var Usuario userResult = new Usuario =>[nombreDeUsuario = "none"];


            while(rs.next()){
                val nDeUs = rs.getString("nombreDeUsuario")
                if(nDeUs == nomDeUsuario )
                    userResult => [
                        setNombreDeUsuario = rs.getString("nombreDeUsuario")
                        nombreYApellido = rs.getString("nombreYApellido")
                        email = rs.getString("email")
                        contrasenia = rs.getString("contrasenia")
                        nacimiento = rs.getDate("nacimiento")
                        estaRegistradoEmail = rs.getBoolean("estaRegistradoEmail")
                        codigoDeEmail = rs.getInt("codigoDeEmail")
                    ]
            }
            ps.close();

            userResult
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

    def getConnection() {
        Class.forName("com.mysql.jdbc.Driver");
        return DriverManager.getConnection("jdbc:mysql://localhost:3306/aterrizar?user=root&password=drl")
    }





}