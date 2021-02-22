package ar.edu.unsam.politics.controller

import ar.edu.unsam.politics.dao.CandidateRepository
import ar.edu.unsam.politics.domain.Candidate
import io.swagger.annotations.ApiOperation
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.CrossOrigin
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PathVariable
import org.springframework.web.bind.annotation.PutMapping
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.web.bind.annotation.RestController
import org.springframework.web.server.ResponseStatusException

@RestController
@CrossOrigin(origins = "*")
class CandidateController {

	@Autowired
	CandidateRepository candidateRepository

	@GetMapping("/candidates/{id}")
	@ApiOperation("Permite conocer los datos de una persona candidata en base al identificador.")
	def getCandidato(@PathVariable Long id) {
		this.candidateRepository.findById(id)
	}

	@PutMapping("/candidates/{id}")
	@ApiOperation("Permite actualizar las promesas o los votos de una persona candidata.")
	def actualizarCandidate(@RequestBody Candidate candidateNuevo, @PathVariable Long id) {

		candidateRepository.findById(id).map([ candidate |
			candidate => [
				// solo modificamos lo que está disponible para cambiar en la aplicación
				if (!candidateNuevo.promesas.isEmpty) {
					promesas = candidateNuevo.promesas
				}
				if (candidateNuevo.votos > 0) {
					votos = candidateNuevo.votos
				}
			]
			//
			candidateRepository.save(candidate)
		])
		.orElseThrow([
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "La persona candidata con identificador " + id + " no existe")
		])

		return ResponseEntity.ok.body("La persona candidata fue actualizada correctamente")
	}
}
