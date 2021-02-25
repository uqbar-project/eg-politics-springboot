package ar.edu.unsam.politics.controller

import ar.edu.unsam.politics.dao.CandidateRepository
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc
import org.springframework.boot.test.context.SpringBootTest
import org.springframework.http.MediaType
import org.springframework.test.context.ActiveProfiles
import org.springframework.test.web.servlet.MockMvc
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders

import static ar.edu.unsam.politics.controller.TestHelpers.*
import static org.junit.jupiter.api.Assertions.assertEquals

@SpringBootTest
@AutoConfigureMockMvc
@ActiveProfiles("test")
@DisplayName("Dado un controller de zonas")
class CandidateControllerTest {

    @Autowired
    MockMvc mockMvc

    @Autowired
    CandidateRepository repoCandidates

    val CANDIDATE_NOMBRE = "Julio Sosa"

    @Test
    @DisplayName("podemos actualizar la información de una persona candidata")
    def void actualizarProfesor() {
        val candidate = repoCandidates.findByNombre(CANDIDATE_NOMBRE)
        assertEquals(0, candidate.votos)
        candidate.reset()
        candidate.votar()
        val responseEntity = mockMvc.perform(
            MockMvcRequestBuilders.put('''/candidates/«candidate.id»''')
                .contentType(MediaType.APPLICATION_JSON)
                .content(mapper.writeValueAsString(candidate))
        ).andReturn().response
				assertEquals(200, responseEntity.status)
				
				val candidateActualizado = repoCandidates.findByNombre(CANDIDATE_NOMBRE)
        assertEquals(1, candidateActualizado.votos)
        
        // Pero ojo, como esto tiene efecto colateral, vamos a volver atrás el cambio
        candidate.votos = 0
        repoCandidates.save(candidate)
    }

}