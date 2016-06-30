package ar.edu.unq.epers.aterrizar.servicios

import com.mongodb.DB
import com.mongodb.MongoClient
import java.net.UnknownHostException
import org.mongojack.JacksonDBCollection
import ar.edu.unq.epers.aterrizar.home.Home

class DocumentsServiceRunner {
	static DocumentsServiceRunner INSTANCE;
	MongoClient mongoClient;
	DB db;

	synchronized def static DocumentsServiceRunner instance() {
		if (INSTANCE == null) {
			INSTANCE = new DocumentsServiceRunner();
		}
		return INSTANCE;
	}

	private new() {
		try {
			mongoClient = new MongoClient("localhost", 27017);
		} catch (UnknownHostException e) {
			throw new RuntimeException(e);
		}
		db = mongoClient.getDB("admin");
	}
	
	def <T> Home<T> collection(Class<T> entityType){
		val dbCollection = db.getCollection(entityType.getSimpleName());
		new Home<T>(JacksonDBCollection.wrap(dbCollection, entityType, String), entityType);
	}
}