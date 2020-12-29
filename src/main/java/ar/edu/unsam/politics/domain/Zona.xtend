package ar.edu.unsam.politics.domain

import ar.edu.unsam.politics.UserException
//import com.fasterxml.jackson.databind.annotation.JsonSerialize
import java.util.HashSet
import java.util.Set
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.FetchType
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.OneToMany
import org.eclipse.xtend.lib.annotations.Accessors
//import ar.edu.unsam.politics.serializer.ZonaParaGrillaSerializer

@Entity
@Accessors
// Opción 2: definir como default este serializador
// @JsonSerialize(using=ZonaParaGrillaSerializer)
class Zona {

	@Id
	@GeneratedValue
	Long id	

	@Column(length=150)
	String descripcion

	@OneToMany(fetch=FetchType.LAZY)
	Set<Candidato> candidatos = new HashSet

	def void validar() {
		if (descripcion === null) {
			throw new UserException("Debe ingresar descripcion")
		}
		if (candidatos.isEmpty) {
			throw new UserException("Debe haber al menos un candidato en la zona")
		}
	}

	override toString() {
		descripcion
	}

//	override equals(Object obj) {
//		try {
//			val other = obj as Zona
//			id == other?.id
//		} catch (ClassCastException e) {
//			return false
//		}
//	}
//
//	override hashCode() {
//		if (id !== null) id.hashCode else super.hashCode
//	}
	
}