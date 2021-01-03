package ar.edu.unsam.politics.dao

import java.util.List
import javax.persistence.EntityManager
import javax.persistence.PersistenceContext
import javax.persistence.PersistenceException
import javax.persistence.criteria.CriteriaBuilder
import javax.persistence.criteria.CriteriaQuery
import javax.persistence.criteria.Root
import javax.transaction.Transactional
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
abstract class AbstractRepository<T> {

	@PersistenceContext
	EntityManager entityManager

	abstract def CriteriaQuery<T> getQuery(CriteriaBuilder criteria)
	abstract def Root<T> getFrom(CriteriaQuery<T> query)
	
	def List<T> findAll() {
		try {
			val criteria = this.entityManager.criteriaBuilder
			val query = criteria.query
			query.select(query.from)
			this.entityManager.createQuery(query).resultList
		} finally {
			this.entityManager?.close
		}
	}

	def List<T> searchByExample(T t) {
		try {
			val criteria = this.entityManager.criteriaBuilder
			val query = criteria.query
			val from = query.from
			query.select(query.from)
			criteria.generateWhere(query, from, t)
			this.entityManager.createQuery(query).resultList
		} finally {
			entityManager?.close
		}
	}

	abstract def void generateWhere(CriteriaBuilder criteria, CriteriaQuery<T> query, Root<T> campos, T t)
	
	@Transactional
	def create(T t) {
		try {
			this.entityManager => [
				persist(t)
			]
		} catch (PersistenceException e) {
			e.printStackTrace
			throw new RuntimeException("Ocurrió un error, la operación no puede completarse", e)
		} finally {
			entityManager?.close
		}
	}

	@Transactional
	def update(T t) {
		try {
			this.entityManager => [
				merge(t)
			]
		} catch (PersistenceException e) {
			e.printStackTrace
			throw new RuntimeException("Ocurrió un error, la operación no puede completarse", e)
		} finally {
			entityManager?.close
		}
	}

}
