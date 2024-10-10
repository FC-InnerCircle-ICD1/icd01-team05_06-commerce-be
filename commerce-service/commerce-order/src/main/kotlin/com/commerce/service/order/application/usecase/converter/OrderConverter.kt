package com.commerce.service.order.application.usecase.converter

import com.commerce.common.model.orderProduct.OrderProduct
import com.commerce.common.model.orders.Orders
import com.commerce.service.order.application.usecase.dto.OrdersDto
import com.commerce.service.order.controller.response.OrderSummary
import java.math.BigDecimal
import java.time.LocalDateTime

fun Orders.toOrderSummary(): OrderSummary {
    return OrderSummary(
        id = this.id.toString(),
        orderNumber = this.orderNumber,
        content = this.content,
        orderDate = this.orderDate.toString(),
        status = this.status.toString(),
        price = this.price.toDouble(),
        discountedPrice = this.discountedPrice.toDouble(),
        memberName = "Customer-${this.memberId}", // 임시 처리
        recipient = this.recipient
    )
}

fun OrdersDto.createOrder(): Orders {
    return Orders(
        id = 0, // Assuming new order, set id to 0 or handle as needed
        memberId = this.member.id,
        streetAddress = this.deliveryInfo.streetAddress,
        detailAddress = this.deliveryInfo.detailAddress,
        postalCode = this.deliveryInfo.postalCode,
        orderNumber = this.orderNumber,
        paymentMethod = this.paymentInfo.method,
        recipient = this.deliveryInfo.recipient,
        content = this.ordersInfo.content,
        discountedPrice = BigDecimal.ZERO, // Set as needed
        price = this.paymentInfo.totalAmount,
        status = this.ordersInfo.OrderStatus,
        orderDate = LocalDateTime.now(),
        orderProducts = this.products.map { it ->
            OrderProduct(
                id = 0, // Assuming new order product, set id to 0 or handle as needed
                orderId = 0, // Will be set when saving the order
                productId = it.product.id ?: 0,
                quantity = it.quantity.toLong(),
                price = it.product.price,
                discountedPrice = it.product.discountedPrice ?: BigDecimal.ZERO
            )
        }.toMutableList()
    )
}