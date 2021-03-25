package ar.edu.unsam.politics.controller

import ar.edu.unsam.politics.dao.ZonaRepository
import ar.edu.unsam.politics.domain.Zona
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc
import org.springframework.boot.test.context.SpringBootTest
import org.springframework.test.context.ActiveProfiles
import org.springframework.test.web.servlet.MockMvc
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders

import static ar.edu.unsam.politics.controller.TestHelpers.*
import static org.junit.jupiter.api.Assertions.assertEquals
import static org.junit.jupiter.api.Assertions.assertFalse

@Accessors
class ZonaGrillaDTO {
	Long id
	String descripcion
	List<CandidateGrillaDTO> candidates
}

@Accessors
class CandidateGrillaDTO {
	Long id
	String partido
	String nombre
	int votos
}

@SpringBootTest
@AutoConfigureMockMvc
@ActiveProfiles("test")
@DisplayName("Dado un controller de zonas")
class ZonaControllerTest {

    @Autowired
    MockMvc mockMvc

    @Autowired
    ZonaRepository repoZonas

    @Test
    @DisplayName("las zonas solo traen los datos de primer nivel")
    def void todasLasZonas() {
        val responseEntity = mockMvc.perform(MockMvcRequestBuilders.get("/zonas")).andReturn().response
        val zonas = fromJsonToList(responseEntity.contentAsString, Zona)
        assertEquals(200, responseEntity.status)
        assertEquals(2, zonas.size)
        // los zonas no traen candidatos
        assertEquals(0, zonas.head.candidates.size)
    }

    @Test
    @DisplayName("al traer el dato de una zona trae las personas candidatas también")
    def zonaConCandidates() {
        val zonas = repoZonas.findAll().toList()
        assertFalse(zonas.isEmpty(), "No hay zonas cargadas en el sistema")
        val ID_ZONA = zonas.head.id
        val responseEntity = mockMvc.perform(MockMvcRequestBuilders.get('''/zonas/«ID_ZONA»''')).andReturn().response
        assertEquals(200, responseEntity.status)
        val zona = fromJson(responseEntity.contentAsString, Zona)
        assertFalse(zona.candidates.isEmpty(), "La zona debería tener candidates")
    }

    @Test
    @DisplayName("no podemos traer información de una zona inexistente")
    def zonaInexistente() {
        val responseEntity = mockMvc.perform(MockMvcRequestBuilders.get("/profesores/100")).andReturn().response
        assertEquals(404, responseEntity.status)
    }
	
}