package ar.edu.unsam.politics.dao

import ar.edu.unsam.politics.domain.Zona
import java.util.List
import java.util.Optional
import javax.persistence.EntityManager
import javax.persistence.PersistenceContext
import javax.persistence.PersistenceException
import javax.persistence.criteria.CriteriaBuilder
import javax.persistence.criteria.CriteriaQuery
import javax.persistence.criteria.Root
import javax.transaction.Transactional
import org.springframework.stereotype.Repository

@Repository
class ZonaRepository {

	@PersistenceContext
	EntityManager entityManager

	def List<Zona> findAll() {
		this.findZonas([ CriteriaBuilder criteria, CriteriaQuery<Zona> query, Root<Zona> camposZona | ])
	}
	
	def findById(Long idABuscar) {
		val result = this.findZonas([ CriteriaBuilder criteria, CriteriaQuery<Zona> query, Root<Zona> camposZona | query.where(criteria.equal(camposZona.get("id"), idABuscar)) ])
		if (result.empty) Optional.empty else Optional.of(result.head)
	}

	def findByDescripcion(String descripcion) {
		val result = this.findZonas([ CriteriaBuilder criteria, CriteriaQuery<Zona> query, Root<Zona> camposZona | query.where(criteria.equal(camposZona.get("descripcion"), descripcion)) ])
		if (result.empty) Optional.empty else Optional.of(result.head)
	}
		
	def findZonas((CriteriaBuilder, CriteriaQuery<Zona>, Root<Zona>)=> void filtro) {
		try {
			val criteria = this.entityManager.criteriaBuilder
			val query = criteria.createQuery(Zona)
			val camposZona = query.from(Zona)
			filtro.apply(criteria, query, camposZona)
			query.select(camposZona)
			this.entityManager.createQuery(query).resultList
		} finally {
			this.entityManager?.close
		}
	}
	
	@Transactional
	def create(Zona zona) {
		try {
			this.entityManager => [
				persist(zona)
			]
		} catch (PersistenceException e) {
			e.printStackTrace
			throw new RuntimeException("Ocurrió un error, la operación no puede completarse", e)
		} finally {
			entityManager?.close
		}
	}

	@Transactional
	def update(Zona zona) {
		try {
			this.entityManager => [
				merge(zona)
			]
		} catch (PersistenceException e) {
			e.printStackTrace
			throw new RuntimeException("Ocurrió un error, la operación no puede completarse", e)
		} finally {
			entityManager?.close
		}
	}
	
}
