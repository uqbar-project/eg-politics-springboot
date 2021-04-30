package ar.edu.unsam.politics.domain

import ar.edu.unsam.politics.errorHandling.UserException
import java.time.LocalDate
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id
import org.eclipse.xtend.lib.annotations.Accessors

@Entity
@Accessors
class Promesa {
	
	@Id @GeneratedValue
	Long id

	@Column
	LocalDate fecha

	@Column(length=255)
	String accionPrometida

	// constructor necesario para JPA / Hibernate
	new() {
	}

	new(String accionPrometida) {
		fecha = LocalDate.now
		this.accionPrometida = accionPrometida
	}

	def void validar() {
		if (fecha === null) {
			throw new UserException("Debe ingresar fecha")
		}
		if (accionPrometida === null) {
			throw new UserException("Debe ingresar una acción en la promesa")
		}
	}

}
