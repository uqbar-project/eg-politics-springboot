package ar.edu.unsam.politics.controller

import ar.edu.unsam.politics.domain.Candidate
import ar.edu.unsam.politics.service.CandidateService
import io.swagger.annotations.ApiOperation
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.CrossOrigin
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PathVariable
import org.springframework.web.bind.annotation.PutMapping
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.web.bind.annotation.RestController

@RestController
@CrossOrigin(origins = "*")
class CandidateController {

	@Autowired
	CandidateService candidateService
	
	@GetMapping("/candidates/{id}")
	@ApiOperation("Permite conocer los datos de una persona candidata en base al identificador.")
	def getCandidato(@PathVariable Long id) {
		candidateService.buscarPorId(id)
	}

	@PutMapping("/candidates/{id}")
	@ApiOperation("Permite actualizar las promesas o los votos de una persona candidata.")
	def actualizarCandidate(@RequestBody Candidate candidateNuevo, @PathVariable Long id) {
		candidateService.actualizarCandidate(candidateNuevo, id)	
		return ResponseEntity.ok.body("La persona candidata fue actualizada correctamente")
	}
}
