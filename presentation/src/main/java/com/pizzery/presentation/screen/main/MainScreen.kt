package com.pizzery.presentation.screen.main

import android.util.Log
import androidx.compose.runtime.*
import androidx.compose.ui.platform.LocalContext
import androidx.navigation.NavHostController
import com.pizzery.presentation.screen.system.Loader
import com.pizzery.presentation.viewmodel.MainScreenViewModel
import com.pizzery.shared.extentions.makeToast
import com.pizzery.shared.models.AdvertisementModel
import com.pizzery.shared.models.CategoryModel
import com.pizzery.shared.models.ProductModel
import kotlinx.coroutines.Dispatchers.IO
import kotlinx.coroutines.launch

@Composable
fun MainScreen(
    vm: MainScreenViewModel,
    nav: NavHostController,
) {
    val selectCategory by vm.selectCategory.collectAsState()
    val categories by vm.categories.collectAsState()
    val cities by vm.cities.collectAsState()
    val selectCity by vm.selectCity.collectAsState()
    val pizzas by vm.products.collectAsState()
    val scope = rememberCoroutineScope()
    val advertisements by vm.advertisements.collectAsState()
    val context = LocalContext.current
    
    LaunchedEffect(Unit) {
        scope.launch(IO) {
            vm.getAdvertisement()
            vm.getCategories()
            vm.getCities()
        }
    }
    
    LaunchedEffect(categories) {
        scope.launch(IO) {
            if(selectCategory == null)
                vm.getProducts(
                    category = categories.firstOrNull()
                        ?.value,
                    forceWeb = false
                )
            vm.selectCategory(
                categories.firstOrNull()
            )
        }
    }
    
    LaunchedEffect(selectCategory?.value) {
        scope.launch(IO) {
            vm.getProducts(selectCategory?.value)
        }
    }
    
    if(
        categories.isEmpty()
        || pizzas.isEmpty()
        || advertisements.isEmpty()
    ) Loader() else MainScreenContent(
        state = MainScreenState(
            selectCity = selectCity,
            selectCategory = selectCategory,
            advertisements = advertisements,
            categories = categories,
            cities = cities,
            pizzas = pizzas,
        ),
        callback = object: MainScreenCallback {
            override fun onPriceClick(pizza: ProductModel) {
                context.makeToast("${pizza.name} - добавлена в корзину")
            }
            
            override fun onCityClick() {
                context.makeToast("Ваш город Москва")
            }
            
            override fun onRefresh() {
                scope.launch(IO) {
                    vm.getCategories(true)
                    vm.getAdvertisement()
                    vm.getCities()
                    vm.getProducts(
                        category = selectCategory?.value,
                        forceWeb = true
                    )
                }
            }
            
            override fun onCategorySelect(category: CategoryModel) {
                Log.d("", "cat-> $category")
                scope.launch(IO) {
                    vm.selectCategory(category)
                }
            }
            
            override fun onAdvertisementClick(adv: AdvertisementModel) {
                nav.navigate("other")
            }
            
            override fun onQRClick() {
                context.makeToast("QR-код не доступен")
            }
            
            override fun onPizzaClick(pizza: ProductModel) {
                nav.navigate("other")
            }
        }
    )
}