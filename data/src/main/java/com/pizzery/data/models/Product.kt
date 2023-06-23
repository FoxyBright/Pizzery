package com.pizzery.data.models

import androidx.compose.runtime.Stable
import com.pizzery.data.database.ProductTable
import com.pizzery.shared.models.ProductModel
import kotlin.math.roundToInt

@Stable
data class Product(
    val id: String,
    val img: String,
    val name: String,
    val dsc: String,
    val price: Double,
    val rate: Int,
    val country: String,
) {
    
    fun map() = ProductTable(
        id = id,
        img = img,
        name = name,
        dsc = dsc,
        price = price,
        rate = rate,
        country = country
    )
}