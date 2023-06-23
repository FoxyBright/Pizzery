package com.pizzery.shared.models

import androidx.compose.runtime.Stable

@Stable
data class ProductModel(
    val id: String,
    val name: String,
    val description: String,
    val img: String,
    val price: Int,
)