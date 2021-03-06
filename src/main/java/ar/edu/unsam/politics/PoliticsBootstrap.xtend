package ar.edu.unsam.politics

import ar.edu.unsam.politics.dao.PartidoRepository
import ar.edu.unsam.politics.dao.ZonaRepository
import ar.edu.unsam.politics.domain.Partido
import ar.edu.unsam.politics.domain.Peronista
import ar.edu.unsam.politics.domain.Preservativo
import ar.edu.unsam.politics.domain.Promesa
import ar.edu.unsam.politics.domain.Zona
import java.time.LocalDate
import org.springframework.beans.factory.InitializingBean
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Service
import ar.edu.unsam.politics.dao.CandidateRepository
import ar.edu.unsam.politics.domain.Candidate

/**
 * 
 * Para explorar otras opciones
 * https://stackoverflow.com/questions/38040572/spring-boot-loading-initial-data
 */
@Service
class PoliticsBootstrap implements InitializingBean {

	@Autowired
	ZonaRepository repoZonas
	
	@Autowired
	PartidoRepository repoPartidos
	
	@Autowired
	CandidateRepository repoCandidatos
	
	Partido frejuli
	Partido perone
	Partido prime

	Candidate sosa
	Candidate benitez
	Candidate yapura
	Candidate ramos
	Candidate monti
	Candidate rota
	Candidate cafrune

	Zona nacional
	Zona springfield

	def void initPartidos() {
		frejuli = new Peronista => [
			afiliados = 60000
			nombre = "FREJULI"
			populista = true
		]

		perone = new Peronista => [
			afiliados = 5000
			nombre = "Perone"
			populista = false
		]

		prime = new Preservativo => [
			afiliados = 1200
			nombre = "PRIME"
			fechaCreacion = LocalDate.parse("2009-06-16")
		]

		this.crearPartidos(frejuli)
		this.crearPartidos(perone)
		this.crearPartidos(prime)
	}

	def void crearPartidos(Partido partido) {
		val partidoEnRepo = repoPartidos.findByNombre(partido.nombre)
		if (partidoEnRepo === null) {
			repoPartidos.save(partido)
			println("Candidato " + partido.nombre + " creado")
		} else {
			partido.id = partidoEnRepo.id
			repoPartidos.save(partido)
		}
	}

	def void initCandidatos() {
		sosa = new Candidate() =>
			[
				nombre = "Julio Sosa"
				partido = frejuli
				promesas = newArrayList(new Promesa("Terminar con la inseguridad"),
					new Promesa("Aborto para unos, banderitas para otros"))
			]
		benitez = new Candidate() => [
			nombre = "Myriam Benitez"
			partido = frejuli
			promesas = newArrayList(new Promesa("Girar y girar hacia la libertad"))
		]
		yapura = new Candidate() =>
			[
				nombre = "Marcelo Yapura"
				partido = frejuli
				promesas = newArrayList(new Promesa("Terminar con la pobreza"),
					new Promesa("Que todos los docentes de la UTN cobren en euros"))
			]
		ramos = new Candidate() =>
			[
				nombre = "Manuel Ramos"
				partido = perone
				promesas = newArrayList(new Promesa("Terminar con la inseguridad"),
					new Promesa("Recuperar la confianza de los argentinos"))
			]
		monti = new Candidate() => [
			nombre = "Yaco Monti"
			partido = perone
			promesas = newArrayList(new Promesa("Terminar con la inseguridad"), new Promesa("Recuperar la dignidad"))
		]
		rota = new Candidate() =>
			[
				nombre = "Nino Rota"
				partido = prime
				promesas = newArrayList(new Promesa("Ganarle a la pobreza"),
					new Promesa("Sacar el cepo a la moneda extranjera"),
					new Promesa("Eliminar el impuesto a las ganancias"))
			]
		cafrune = new Candidate() =>
			[
				nombre = "Yamila Cafrune"
				partido = prime
				promesas = newArrayList(new Promesa("Terminar con Futbol para Todos"),
					new Promesa("Privatizar las empresas del estado"), new Promesa("Dolarizar la economia"))
			]
		this.crearCandidato(sosa)
		this.crearCandidato(benitez)
		this.crearCandidato(yapura)
		this.crearCandidato(ramos)
		this.crearCandidato(monti)
		this.crearCandidato(rota)
		this.crearCandidato(cafrune)
	}

	def crearCandidato(Candidate candidato) {
		val candidatoEnElRepo = repoCandidatos.findByNombre(candidato.nombre)
		if (candidatoEnElRepo !== null) {
			candidato.id = candidatoEnElRepo.id
		}
		repoCandidatos.save(candidato)
		println("Candidato " + candidato.nombre + if (candidatoEnElRepo === null) " creado" else " actualizado")
	}

	def initZonas() {
		nacional = new Zona => [
			descripcion = "Elecciones nacionales"
			setCandidates = newHashSet(sosa, benitez, ramos, rota)
		]
		springfield = new Zona => [
			descripcion = "Springfield"
			setCandidates = newHashSet(yapura, monti, cafrune)
		]
		this.crearZona(nacional)
		this.crearZona(springfield)
	}

	def crearZona(Zona zona) {
		val listaZonas = repoZonas.findByDescripcion(zona.descripcion)
		if (listaZonas.isEmpty) {
			repoZonas.save(zona)
			println("Zona " + zona.descripcion + " creada")
		} else {
			val zonaBD = listaZonas.head
			zona.id = zonaBD.id
			repoZonas.save(zona)
		}
	}

	override afterPropertiesSet() throws Exception {
		println("************************************************************************")
		println("Running initialization")
		println("************************************************************************")
		initPartidos
		initCandidatos
		initZonas
	}

}