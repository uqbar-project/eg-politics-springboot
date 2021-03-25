package ar.edu.unsam.politics.controller

import ar.edu.unsam.politics.dao.ZonaRepository
import io.swagger.annotations.ApiOperation
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.http.HttpStatus
import org.springframework.web.bind.annotation.CrossOrigin
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PathVariable
import org.springframework.web.bind.annotation.RequestMethod
import org.springframework.web.bind.annotation.RestController
import org.springframework.web.server.ResponseStatusException
import com.fasterxml.jackson.annotation.JsonView
import ar.edu.unsam.politics.serializer.View

@RestController
@CrossOrigin(origins = "*", methods= #[RequestMethod.GET])
class ZonaController {
	
	@Autowired
	ZonaRepository zonaRepository
	
	@GetMapping(value = "/zonas")
	@JsonView(value=View.Zona.Plana)
	@ApiOperation("Trae la información de las zonas (sin sus relaciones, pensado para una selección inicial).")
	def getZonas() {
		this.zonaRepository.findAll().toList
	}
  
	@GetMapping(value="/zonas/{id}")
	@JsonView(value=View.Zona.Grilla)
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