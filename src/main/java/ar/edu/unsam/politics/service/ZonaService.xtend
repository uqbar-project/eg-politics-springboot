package ar.edu.unsam.politics.service

import ar.edu.unsam.politics.dao.ZonaRepository
import ar.edu.unsam.politics.errorHandling.NotFoundException
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Service

@Service
class ZonaService {
	
	@Autowired
	ZonaRepository zonaRepository
	
	def buscarPorId(Long id) {
		zonaRepository.findById(id).orElseThrow([
			throw new NotFoundException("La zona con identificador " + id + " no existe")
		])
	}
	
	def todasLasZonas() {
		/*
		 * Con la opción de DTO
		 * this.zonaRepository.findAll().toList.map[ZonaPlanaDTO.fromZona(it)]
		 * */
		this.zonaRepository.findAll().toList
	}
	
}