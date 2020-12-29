package ar.edu.unsam.politics.controller

import ar.edu.unsam.politics.dao.CandidatoRepository
import ar.edu.unsam.politics.domain.Candidato
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PathVariable
import org.springframework.web.bind.annotation.PutMapping
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.web.bind.annotation.RestController
import org.springframework.web.server.ResponseStatusException

@RestController
class CandidatoController {

	@Autowired
	CandidatoRepository candidatoRepository

	@GetMapping("/candidatos")
	def getCandidatos() {
		this.candidatoRepository.findAll()
	}

	@PutMapping("/candidatos/{id}")
	def actualizarCandidato(@RequestBody Candidato candidatoNuevo, @PathVariable Long id) {

		candidatoRepository.findById(id).map([ candidato |
			candidato => [
				// solo modificamos lo que está disponible para cambiar en la aplicación
				promesas = candidatoNuevo.promesas
				votos = candidatoNuevo.votos
			]
			//
			candidatoRepository.save(candidato)
		])
		.orElseThrow([
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "El candidato con identificador " + id + " no existe")
		])

		return ResponseEntity.ok.body("El candidato fue actualizado correctamente")
	}
}
