package ar.edu.unsam.politics.serializer

import ar.edu.unsam.politics.domain.Candidato
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class CandidatoPlanoDTO {
	String partido
	String nombre
	int votos
	
	private new() {}
	
	def static fromCandidato(Candidato candidato) {
		new CandidatoPlanoDTO() => [
			partido = candidato.partido.nombre
			nombre = candidato.nombre
			votos = candidato.votos
		]	
	}
	
}