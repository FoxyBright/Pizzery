package com.pizzery.data.database

import androidx.room.Entity
import androidx.room.PrimaryKey
import com.pizzery.shared.models.ProductModel
import kotlin.math.roundToInt


@Entity(tableName = "product")
class ProductTable(
    @PrimaryKey
    val id: String,
    val img: String,
    val name: String,
    val dsc: String,
    val price: Double,
    val rate: Int,
    val country: String,
) {
    
    fun map() = ProductModel(
        id = id,
        img = img,
        description = dsc,
        price = price.roundToInt(),
        name = name
    )
}