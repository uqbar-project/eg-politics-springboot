package ar.edu.unsam.politics.serializer

import org.eclipse.xtend.lib.annotations.Accessors
import ar.edu.unsam.politics.domain.Candidate

@Accessors
class CandidatoPlanoDTO {
	String partido
	String nombre
	int votos
	
	private new() {}
	
	def static fromCandidato(Candidate candidato) {
		new CandidatoPlanoDTO() => [
			partido = candidato.partido.nombre
			nombre = candidato.nombre
			votos = candidato.votos
		]	
	}
	
}