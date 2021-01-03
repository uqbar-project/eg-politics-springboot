package ar.edu.unsam.politics.serializer

import ar.edu.unsam.politics.domain.Zona
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class ZonaPlanaDTO {
	
	Long id
	String descripcion

	private new() {}
	
	def static fromZona(Zona zona) {
		new ZonaPlanaDTO => [
			id = zona.id
			descripcion = zona.descripcion
		]
	}

}
