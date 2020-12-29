package ar.edu.unsam.politics.serializer

import ar.edu.unsam.politics.domain.Zona
import com.fasterxml.jackson.core.JsonGenerator
import com.fasterxml.jackson.databind.SerializerProvider
import com.fasterxml.jackson.databind.ser.std.StdSerializer
import java.io.IOException

class ZonaParaGrillaSerializer extends StdSerializer<Zona> {
	
	new() {
		super(Zona)
	}
	
	override serialize(Zona zona, JsonGenerator gen, SerializerProvider provider) throws IOException {
		gen => [
			writeStartObject
			if (zona.id !== null) {
				writeNumberField("id", zona.id)
			}
			writeStringField("descripcion", zona.descripcion)
			val candidatosDTO = zona.candidatos.map [ candidato |
				CandidatoPlanoDTO.fromCandidato(candidato)
			]
			writeObjectField("candidatos", candidatosDTO.toList)
			writeEndObject
		]
	}
	
}