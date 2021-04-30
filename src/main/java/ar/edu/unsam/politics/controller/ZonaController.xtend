package ar.edu.unsam.politics.controller

import ar.edu.unsam.politics.serializer.View
import ar.edu.unsam.politics.service.ZonaService
import com.fasterxml.jackson.annotation.JsonView
import io.swagger.annotations.ApiOperation
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.web.bind.annotation.CrossOrigin
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PathVariable
import org.springframework.web.bind.annotation.RequestMethod
import org.springframework.web.bind.annotation.RestController

@RestController
@CrossOrigin(origins="*", methods=#[RequestMethod.GET])
class ZonaController {

	@Autowired
	ZonaService zonaService

	@GetMapping(value="/zonas")
	@JsonView(value=View.Zona.Plana)
	@ApiOperation("Trae la información de las zonas (sin sus relaciones, pensado para una selección inicial).")
	def getZonas() {
		zonaService.todasLasZonas()
	}

	@GetMapping(value="/zonas/{id}")
	@JsonView(value=View.Zona.Grilla)
	@ApiOperation("Permite traer la información de una zona, con las personas candidatas y las intenciones de voto incluidas.")
	def getZona(@PathVariable Long id) {
		zonaService.buscarPorId(id)
	}

}
