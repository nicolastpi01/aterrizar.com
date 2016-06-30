package ar.edu.unq.epers.aterrizar.model

import com.datastax.driver.mapping.annotations.Table
import org.eclipse.xtend.lib.annotations.Accessors
import com.datastax.driver.mapping.annotations.Frozen
import com.datastax.driver.mapping.annotations.PartitionKey
import com.datastax.driver.core.CodecRegistry
import com.datastax.driver.extras.codecs.enums.EnumNameCodec
import com.datastax.driver.mapping.annotations.FrozenValue

@Table(keyspace = "cassandra", name = "perfilCacheado",
readConsistency = "QUORUM",
writeConsistency = "QUORUM",
caseSensitiveKeyspace = false,
caseSensitiveTable = false)
@Accessors
class PerfilCacheado {
	@PartitionKey()
	private String username
	@PartitionKey(1)
	private Visibility visibility
	@FrozenValue
	private Perfil perfil
	
	new() {}
	
	new(String username, Visibility v, Perfil p) {
		this.username = username
		this.visibility = v
		this.perfil = p
	}
	
}