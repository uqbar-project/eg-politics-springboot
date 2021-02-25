package ar.edu.unsam.politics.serializer

import org.eclipse.xtend.lib.annotations.Accessors
import ar.edu.unsam.politics.domain.Candidate

@Accessors
class CandidatoPlanoDTO {
	Long id
	String partido
	String nombre
	int votos
	
	private new() {}
	
	def static fromCandidato(Candidate candidato) {
		new CandidatoPlanoDTO() => [
			id = candidato.id
			partido = candidato.partido.nombre
			nombre = candidato.nombre
			votos = candidato.votos
		]
	}
	
}