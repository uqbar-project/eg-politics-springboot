package ar.edu.unsam.politics.domain

import ar.edu.unsam.politics.UserException
import java.util.List
import javax.persistence.CascadeType
import javax.persistence.Column
import javax.persistence.ElementCollection
import javax.persistence.Entity
import javax.persistence.FetchType
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.ManyToOne
import javax.persistence.OneToMany
import javax.persistence.OrderColumn
import org.eclipse.xtend.lib.annotations.Accessors

@Entity
@Accessors
class Candidate {

	@Id @GeneratedValue
	Long id

	@Column(length=150)
	String nombre

	@ManyToOne
	Partido partido

	int votos = 0

	@OneToMany(fetch=FetchType.LAZY, cascade=CascadeType.ALL)
	@OrderColumn
	List<Promesa> promesas = newArrayList

	@ElementCollection
	@OrderColumn
	List<String> opiniones = newArrayList

	def void validar() {
		if (nombre === null) {
			throw new UserException("Debe ingresar descripcion")
		}
		if (partido === null) {
			throw new UserException("El candidato debe estar participando en un partido político")
		}
	}

	override toString() {
		nombre
	}

	def agregarPromesa(String nuevaPromesa) {
		promesas.add(new Promesa(nuevaPromesa))
	}

	def agregarOpinion(String opinion) {
		opiniones.add(opinion)
	}

	def votar() {
		votos++
	}

	def reset() {
		promesas = newArrayList
		opiniones = newArrayList
	}

}
