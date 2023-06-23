package com.pizzery.data.sources

import com.fasterxml.jackson.module.kotlin.readValue
import com.pizzery.data.apiConfig.KtorSource
import com.pizzery.data.apiConfig.mapper
import com.pizzery.data.models.Categories.Companion.getCategory
import com.pizzery.data.models.Product
import io.ktor.client.call.body
import kotlinx.coroutines.Dispatchers.IO
import kotlinx.coroutines.withContext

class WebSource: KtorSource() {
    
    suspend fun getProducts(
        category: String?,
    ) = withContext(IO) {
        if(!category.isNullOrBlank())
            get(category, setPage = true)
                .body<List<Product>>()
        else emptyList()
    }
    
    suspend fun getCategories() = withContext(IO) {
        get("pagination", setPage = false)
            .body<String>().replace("{", "[")
            .replace("}", "]")
            .replace(": ", "")
            .replace(Regex("\\d"), "")
            .let { mapper.readValue<List<String>>(it) }
            .mapNotNull { getCategory(it)?.map() }
    }
}