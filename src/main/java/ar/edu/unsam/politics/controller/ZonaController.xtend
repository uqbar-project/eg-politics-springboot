package ar.edu.unsam.politics.controller

import ar.edu.unsam.politics.dao.ZonaRepository
import ar.edu.unsam.politics.serializer.ZonaPlanaDTO
import io.swagger.annotations.ApiOperation
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.http.HttpStatus
import org.springframework.web.bind.annotation.CrossOrigin
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PathVariable
import org.springframework.web.bind.annotation.RequestMethod
import org.springframework.web.bind.annotation.RestController
import org.springframework.web.server.ResponseStatusException

@RestController
@CrossOrigin(origins = "*", methods= #[RequestMethod.GET])
class ZonaController {
	
	@Autowired
	ZonaRepository zonaRepository
	
	@GetMapping(value = "/zonas")
	@ApiOperation("Trae la información de las zonas (sin sus relaciones, pensado para una selección inicial).")
	def getZonas() {
		this.zonaRepository.findAll().toList.map [ ZonaPlanaDTO.fromZona(it) ]
	}
  
	@GetMapping(value="/zonas/{id}")
	@ApiOperation("Permite traer la información de una zona, con las personas candidatas y las intenciones de voto incluidas.")
  def getZona(@PathVariable Long id) {
  	this
  		.zonaRepository
  		.findById(id)
  		.orElseThrow([ 
  			 throw new ResponseStatusException(HttpStatus.NOT_FOUND, "La zona con identificador " + id + " no existe") 
  		])
  }

}