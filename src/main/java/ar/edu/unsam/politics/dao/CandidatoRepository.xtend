package ar.edu.unsam.politics.dao

import ar.edu.unsam.politics.domain.Candidato
import org.springframework.data.jpa.repository.EntityGraph
import org.springframework.data.repository.CrudRepository
import java.util.List

interface CandidatoRepository extends CrudRepository<Candidato, Long> {

	def Candidato findByNombre(String nombre)

	@EntityGraph(attributePaths = #["partido", "promesas", "opiniones"])
	override List<Candidato> findAll()
}
