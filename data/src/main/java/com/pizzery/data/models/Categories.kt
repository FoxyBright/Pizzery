package com.pizzery.data.models

import com.pizzery.shared.models.CategoryModel

internal enum class Categories(
    val value: String,
    private val ru: String,
) {
    
    BBQS("bbqs", "Барбекю"),
    BEST_FOODS("best-foods", "Лучшее"),
    BREADS("breads", "Хлебцы"),
    BURGERS("burgers", "Бургеры"),
    CHOCOLATES("chocolates", "Шоколад"),
    DESERTS("desserts", "Десерты"),
    DRINKS("drinks", "Напитки"),
    FRIED_CHICKEN("fried-chicken", "Курица"),
    ICE_CREAM("ice-cream", "Мороженное"),
    PIZZAS("pizzas", "Пицца"),
    PORKS("porks", "Свинина"),
    SANDWICHES("sandwiches", "Сендвичи"),
    SAUSAGES("sausages", "Сосиски"),
    STEAKS("steaks", "Стейки"),
    OUR("our-foods", "Наши");
    
    companion object {
        
        fun getCategory(value: String) =
            values().firstOrNull { it.value == value }
    }
    
    fun map() = CategoryModel(ru, value)
}