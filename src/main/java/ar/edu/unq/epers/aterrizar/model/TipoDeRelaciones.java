package ar.edu.unq.epers.aterrizar.model;

import org.eclipse.xtend.lib.annotations.Accessors;
import org.neo4j.graphdb.RelationshipType;

@Accessors
public enum TipoDeRelaciones implements RelationshipType {
	AMIGO, SENDERMSJ, RECEIVER
}
