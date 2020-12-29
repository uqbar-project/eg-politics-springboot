package ar.edu.unsam.politics.dao

import ar.edu.unsam.politics.domain.Partido
import org.springframework.data.repository.CrudRepository

interface PartidoRepository extends CrudRepository<Partido, Long> {
	
	def Partido findByNombre(String nombre)

}