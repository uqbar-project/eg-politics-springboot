package ar.edu.unsam.politics.domain

import ar.edu.unsam.politics.UserException
import ar.edu.unsam.politics.serializer.View
import com.fasterxml.jackson.annotation.JsonView
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
//@JsonSerialize(using=ZonaParaGrillaSerializer)

// Opción 2: utilizar la annotation @JsonView
class Zona {

	@Id
	@GeneratedValue
	@JsonView(View.Zona.Plana, View.Zona.Grilla)
	Long id	

	@Column(length=150)
	@JsonView(View.Zona.Plana, View.Zona.Grilla)
	String descripcion

	@OneToMany(fetch=FetchType.LAZY)
	@JsonView(View.Zona.Grilla)
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