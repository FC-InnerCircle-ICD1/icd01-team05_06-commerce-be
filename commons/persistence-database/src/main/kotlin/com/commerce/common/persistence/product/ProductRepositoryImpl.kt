package com.commerce.common.persistence.product

import com.commerce.common.model.product.PaginationInfo
import com.commerce.common.model.product.Product
import com.commerce.common.model.product.ProductPaginationInfo
import com.commerce.common.model.product.ProductRepository
import com.commerce.common.persistence.category.CategoryJpaRepository
import com.linecorp.kotlinjdsl.dsl.jpql.jpql
import com.linecorp.kotlinjdsl.render.jpql.JpqlRenderContext
import com.linecorp.kotlinjdsl.support.spring.data.jpa.extension.createQuery
import jakarta.persistence.EntityManager
import jakarta.persistence.EntityNotFoundException
import org.springframework.stereotype.Repository

@Repository
class ProductRepositoryImpl (
    private val productJpaRepository: ProductJpaRepository,
    private val categoryJpaRepository: CategoryJpaRepository,
    private val entityManager: EntityManager,
    private val jpqlRenderContext: JpqlRenderContext,
) : ProductRepository {

    override fun findByProductIdIn(ids: List<Long>): List<Product> {
        return productJpaRepository.findByIdIn(ids)
            .map { product ->
                val category = product.categoryId?.let { categoryId ->
                    categoryJpaRepository.findById(categoryId)
                        .map { it.toProductModel() }
                        .orElse(null)
                }
                product.toModel(category)
            }
            .toList()
    }

    override fun findById(productId: Long): Product {
        val product = productJpaRepository.findById(productId)
            .orElseThrow{ throw EntityNotFoundException("해당 제품이 존재하지 않습니다.") }

        val category = product.categoryId?.let { categoryId ->
            categoryJpaRepository.findById(categoryId)
                .map { it.toProductModel() }
                .orElse(null)
        }

        return product.toModel(category)
    }

    override fun findBySearchWord(searchWord: String?, categoryId: Long?, page: Int, size: Int): ProductPaginationInfo {

        val jpql = jpql {
            select(
                entity(ProductJpaEntity::class),
            ).from(
                entity(ProductJpaEntity::class)
            ).whereAnd(
                searchWord?.let { path(ProductJpaEntity::title).like("%$searchWord%") },
                categoryId?.let { path(ProductJpaEntity::categoryId).eq(categoryId) }
            )
        }

        val countJpql = jpql {
            select(
                count(entity(ProductJpaEntity::class))
            ).from(
                entity(ProductJpaEntity::class)
            ).whereAnd(
                searchWord?.let { path(ProductJpaEntity::title).like("%$searchWord%") },
                categoryId?.let { path(ProductJpaEntity::categoryId).eq(categoryId) }
            )
        }

        val totalCount = entityManager.createQuery(countJpql, jpqlRenderContext).singleResult
        val totalPage = if (totalCount % size == 0L) {
            (totalCount / size).toInt()
        } else {
            (totalCount / size).toInt()
        }

        val query = entityManager.createQuery(jpql, jpqlRenderContext)

        // 페이징 처리
        query.firstResult = (page - 1) * size
        query.maxResults = size

      val resultResult = query.resultList.map { product ->
            val category = product.categoryId?.let { categoryId ->
                categoryJpaRepository.findById(categoryId)
                    .map{ it.toProductModel() }
                    .orElse(null)
            }
            product.toModel(category)
        }
            .toList()

        val paginationInfo = PaginationInfo(
            currentPage = page,
            totalCount = totalCount,
            totalPage = totalPage,
            pageSize = size,
            hasNextPage = page < totalPage,
            hasPreviousPage = page > 1,
        )

        return ProductPaginationInfo(
            data = resultResult,
            pagination = paginationInfo,
        )
    }
}