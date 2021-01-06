package ar.edu.unsam.politics.dao

import ar.edu.unsam.politics.domain.Candidato
import java.util.Optional
import org.springframework.data.jpa.repository.EntityGraph
import org.springframework.data.repository.CrudRepository

interface CandidatoRepository extends CrudRepository<Candidato, Long> {

	def Candidato findByNombre(String nombre)

	@EntityGraph(attributePaths = #["partido", "promesas", "opiniones"])
	override Optional<Candidato> findById(Long id)
}
