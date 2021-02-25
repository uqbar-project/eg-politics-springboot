package ar.edu.unsam.politics.domain

import ar.edu.unsam.politics.UserException
import ar.edu.unsam.politics.serializer.ZonaParaGrillaSerializer
import com.fasterxml.jackson.databind.annotation.JsonSerialize
import java.util.HashSet
import java.util.Set
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.FetchType
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.OneToMany
import org.eclipse.xtend.lib.annotations.Accessors

@Entity
@Accessors
// Opción 1: definir como default este serializador
@JsonSerialize(using=ZonaParaGrillaSerializer)
class Zona {

	@Id
	@GeneratedValue
	Long id	

	@Column(length=150)
	String descripcion

	@OneToMany(fetch=FetchType.LAZY)
	Set<Candidate> candidates = new HashSet

	def void validar() {
		if (descripcion === null) {
			throw new UserException("Debe ingresar descripcion")
		}
		if (candidates.isEmpty) {
			throw new UserException("Debe haber al menos un candidato en la zona")
		}
	}

	override toString() {
		descripcion
	}

}