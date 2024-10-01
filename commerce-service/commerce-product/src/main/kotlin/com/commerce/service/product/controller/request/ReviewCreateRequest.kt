package com.commerce.service.product.controller.request

import com.commerce.service.product.application.usecase.command.AddReviewCommand
import java.math.BigDecimal

data class ReviewCreateRequest(
    val productId: Long,
    val memberId: String,
    val content: String,
    val score: BigDecimal,
    val orderProductId: Long?
) {
    fun toCommand(): AddReviewCommand {
        return AddReviewCommand(
            productId = productId,
            memberId = memberId,
            content = content,
            score = score,
            orderProductId = orderProductId,
        )
    }
}