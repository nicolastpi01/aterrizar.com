package ar.edu.unq.epers.aterrizar.utils
import com.datastax.driver.core.Cluster;
import com.datastax.driver.core.Session;

/**
 * Created by damian on 06/06/16.
 */
class Main {

    def static void main(String[] args) {



        //Query
        var String query = "CREATE TABLE emp(emp_id int PRIMARY KEY, "
        + "emp_name text, "
        + "emp_city text, "
        + "emp_sal varint, "
        + "emp_phone varint );";

        //Creating Cluster object
        var Cluster cluster = Cluster.builder().addContactPoint("127.0.0.1").build();

        //Creating Session object
        var Session session = cluster.connect("aterrizar");

        //Executing the query
        session.execute(query);

        System.out.println("Table created");
    }

}