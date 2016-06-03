import com.datastax.driver.core.Cluster;
import com.datastax.driver.core.Row;
import com.datastax.driver.core.Session;

public class CassandraConnection {

	public static void main(String[] args) {
		String serverIp = "166.78.10.41";
		String keyspace = "gamma";
		CassandraConnection connection;

		Cluster cluster = Cluster.builder()
			.addContactPoints(serverIp)
            .build();

		Session session = cluster.connect(keyspace);
		String cqlStatement = "SELECT * FROM TestCF";
    	for (Row row : session.execute(cqlStatement)) {
        System.out.println(row.toString());
    	}
	}
}
