package com.pizzery.presentation.viewmodel

import com.pizzery.data.repositories.Repository
import com.pizzery.shared.models.AdvertisementModel
import com.pizzery.shared.models.CategoryModel
import com.pizzery.shared.models.ProductModel
import kotlinx.coroutines.Dispatchers.IO
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.withContext
import org.koin.java.KoinJavaComponent.get

class MainScreenViewModel {
    
    private val repo = get<Repository>(
        Repository::class.java
    )
    
    private val _categories =
        MutableStateFlow(emptyList<CategoryModel>())
    val categories = _categories.asStateFlow()
    
    private val _cities =
        MutableStateFlow(emptyList<String>())
    val cities = _cities.asStateFlow()
    
    private val _advertisements =
        MutableStateFlow(emptyList<AdvertisementModel>())
    val advertisements = _advertisements.asStateFlow()
    
    private val _selectCategory =
        MutableStateFlow<CategoryModel?>(null)
    val selectCategory = _selectCategory.asStateFlow()
    
    private val _selectCity =
        MutableStateFlow("Москва")
    val selectCity = _selectCity.asStateFlow()
    
    private val _products =
        MutableStateFlow(emptyList<ProductModel>())
    val products = _products.asStateFlow()
    
    suspend fun getProducts(
        category: String?,
        forceWeb: Boolean = false,
    ) = withContext(IO) {
        _products.emit(
            repo.getProducts(
                category = category,
                forceWeb = forceWeb
            )
        )
    }
    
    suspend fun getCities() = withContext(IO) {
        _cities.emit(repo.getCities())
    }
    
    suspend fun getCategories(forceWeb: Boolean = false) =
        withContext(IO) {
            _categories.emit(repo.getCategories(forceWeb))
        }
    
    suspend fun getAdvertisement() = withContext(IO) {
        _advertisements.emit(repo.getAdvertisements())
    }
    
    suspend fun selectCategory(category: CategoryModel?) =
        withContext(IO) {
            _selectCategory.emit(category)
        }
}

