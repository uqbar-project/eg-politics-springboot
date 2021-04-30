package ar.edu.unsam.politics.service

import ar.edu.unsam.politics.dao.CandidateRepository
import ar.edu.unsam.politics.domain.Candidate
import ar.edu.unsam.politics.errorHandling.NotFoundException
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Service

@Service
class CandidateService {
	
	@Autowired
	CandidateRepository candidateRepository
	
	def actualizarCandidate(Candidate candidateNuevo, Long id) {
		candidateRepository
			.findById(id)
			.map([ candidate |
				candidate => [
					// solo modificamos lo que está disponible para cambiar en la aplicación
					if (!candidateNuevo.tienePromesas) {
						promesas = candidateNuevo.promesas
					}
					if (candidateNuevo.tieneVotos) {
						votos = candidateNuevo.votos
					}
				]
				//
				candidateRepository.save(candidate)
			]
		)
		.orElseThrow([ new NotFoundException("La persona candidata con identificador " + id + " no existe") ])
	}
	
	def buscarPorId(Long id) {
		this
			.candidateRepository
			.findById(id)
			.orElseThrow [ new NotFoundException("La persona candidata con identificador " + id + " no existe") ]
	}
}