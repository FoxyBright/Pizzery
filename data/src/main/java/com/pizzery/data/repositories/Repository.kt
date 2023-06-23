package com.pizzery.data.repositories

import com.pizzery.data.database.ProductDao
import com.pizzery.data.sources.WebSource
import com.pizzery.shared.models.DemoAdvertisementModelList
import com.pizzery.shared.models.ProductModel

class Repository(
    private val web: WebSource,
    private val store: ProductDao,
) {
    
    suspend fun getProducts(
        category: String?,
        forceWeb: Boolean,
    ): List<ProductModel> {
        if(forceWeb) store.getProducts()
            .map { it.map() }
            .let {
                if(it.isNotEmpty())
                    return it
            }
        
        val list = web
            .getProducts(category).map { it.map() }
        
        store.clearProducts()
        list.forEach { store.addProduct(it) }
        
        return list.map { it.map() }
    }
    
    fun getAdvertisements() =
        DemoAdvertisementModelList
    
    fun getCities() = listOf(
        "Moсква",
        "Рязань",
        "Санкт-Петербург",
        "Калуга",
        "Боровск",
    )
    
    suspend fun getCategories(
        forceWeb: Boolean,
    ) = web.getCategories()
}