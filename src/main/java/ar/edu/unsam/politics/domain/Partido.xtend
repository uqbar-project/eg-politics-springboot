package ar.edu.unsam.politics.domain

import ar.edu.unsam.politics.errorHandling.UserException
import com.fasterxml.jackson.annotation.JsonSubTypes
import com.fasterxml.jackson.annotation.JsonTypeInfo
import java.time.LocalDate
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.Inheritance
import javax.persistence.InheritanceType
import org.eclipse.xtend.lib.annotations.Accessors

@Entity
@JsonTypeInfo(use = JsonTypeInfo.Id.NAME, include = JsonTypeInfo.As.PROPERTY, property = "type") 
@JsonSubTypes(#[
	@JsonSubTypes.Type(value = Peronista, name = "PJ"), 
	@JsonSubTypes.Type(value = Preservativo, name= "PRE")
]) 
@Inheritance(strategy=InheritanceType.JOINED)
@Accessors
abstract class Partido {
	
	@Id @GeneratedValue
	Long id
	
	@Column(length=150)
	String nombre
	
	@Column
	int afiliados
	
	def void validar() {
		if (nombre === null) {
			throw new UserException("Debe ingresar nombre")
		}
		if (afiliados < 1000) {
			throw new UserException("El partido no tiene suficientes afiliados")
		}
	}
	
	override toString() {
		nombre
	}
	
}

@Accessors
@Entity
class Peronista extends Partido {
	
	@Column
	boolean populista
	
}

@Accessors
@Entity
class Preservativo extends Partido {

	@Column
	LocalDate fechaCreacion
	
	override validar() {
		super.validar()
		if (fechaCreacion === null) {
			throw new UserException("Debe ingresar fecha de creación")
		}
		if (fechaCreacion.compareTo(LocalDate.now) > 0) {
			throw new UserException("La fecha de creación debe ser anterior a la de hoy")
		}	
	}	

}