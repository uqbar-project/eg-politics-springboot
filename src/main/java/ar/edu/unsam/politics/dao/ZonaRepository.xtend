package ar.edu.unsam.politics.dao

import ar.edu.unsam.politics.domain.Zona
import java.util.Optional
import javax.persistence.criteria.CriteriaBuilder
import javax.persistence.criteria.CriteriaQuery
import javax.persistence.criteria.Root
import org.springframework.stereotype.Repository

@Repository
class ZonaRepository extends AbstractRepository<Zona> {

	override getQuery(CriteriaBuilder criteria) {
		criteria.createQuery(Zona)
	}
	
	override generateWhere(CriteriaBuilder criteria, CriteriaQuery<Zona> query, Root<Zona> camposZona, Zona zona) {
		if (zona.descripcion !== null) {
			query.where(criteria.equal(camposZona.get("descripcion"), zona.descripcion))
		}		
	}
	
	override getFrom(CriteriaQuery<Zona> query) {
		query.from(Zona)
	}
	
	def findById(Long idABuscar) {
		try {
			val criteria = this.entityManager.criteriaBuilder
			val query = criteria.query
			val camposZona = query.from
			query.select(camposZona)
			query.where(criteria.equal(camposZona.get("id"), idABuscar))
			val result = this.entityManager.createQuery(query).resultList
			if (result.empty) Optional.empty else Optional.of(result)
		} finally {
			this.entityManager?.close
		}
	}
}
