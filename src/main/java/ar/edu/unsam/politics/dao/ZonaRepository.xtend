package ar.edu.unsam.politics.dao

import ar.edu.unsam.politics.domain.Zona
import java.util.List
import java.util.Optional
import org.springframework.data.jpa.repository.EntityGraph
import org.springframework.data.repository.CrudRepository

interface ZonaRepository extends CrudRepository<Zona, Long> {
	def List<Zona> findByDescripcion(String descripcion)

	@EntityGraph(attributePaths=#[
		"candidates.promesas", 
		"candidates.partido",
		"candidates.opiniones"
	])
	override Optional<Zona> findById(Long id)

}
