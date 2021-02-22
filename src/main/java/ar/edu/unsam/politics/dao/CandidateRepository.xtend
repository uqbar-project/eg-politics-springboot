package ar.edu.unsam.politics.dao

import java.util.Optional
import org.springframework.data.jpa.repository.EntityGraph
import org.springframework.data.repository.CrudRepository
import ar.edu.unsam.politics.domain.Candidate

interface CandidateRepository extends CrudRepository<Candidate, Long> {

	def Candidate findByNombre(String nombre)

	@EntityGraph(attributePaths = #["partido", "promesas", "opiniones"])
	override Optional<Candidate> findById(Long id)
}
