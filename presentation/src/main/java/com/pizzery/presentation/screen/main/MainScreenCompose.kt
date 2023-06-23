package com.pizzery.presentation.screen.main

import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.lazy.*
import androidx.compose.material3.Scaffold
import androidx.compose.runtime.*
import androidx.compose.ui.Modifier
import com.google.accompanist.swiperefresh.SwipeRefresh
import com.google.accompanist.swiperefresh.rememberSwipeRefreshState
import com.pizzery.presentation.screen.main.components.*
import com.pizzery.shared.models.AdvertisementModel
import com.pizzery.shared.models.CategoryModel
import com.pizzery.shared.models.ProductModel

data class MainScreenState(
    val selectCity: String,
    val selectCategory: CategoryModel?,
    val advertisements: List<AdvertisementModel>,
    val cities: List<String>,
    val categories: List<CategoryModel>,
    val pizzas: List<ProductModel>,
)

interface MainScreenCallback {
    
    fun onPizzaClick(pizza: ProductModel)
    fun onCategorySelect(category: CategoryModel)
    fun onAdvertisementClick(adv: AdvertisementModel)
    fun onPriceClick(pizza: ProductModel)
    fun onCityClick()
    fun onQRClick()
    fun onRefresh()
}

@Composable
fun MainScreenContent(
    state: MainScreenState,
    callback: MainScreenCallback? = null,
) {
    val listState = rememberLazyListState()
    val rowState = rememberLazyListState()
    var refreshing by remember {
        mutableStateOf(false)
    }
    
    val refreshState = rememberSwipeRefreshState(
        isRefreshing = refreshing
    )
    
    Scaffold(
        modifier = Modifier
            .fillMaxSize(),
        topBar = {
            Column {
                TopBar(
                    selectCity = state.selectCity,
                    callback = callback
                )
                if(listState.firstVisibleItemIndex >= 1)
                    CategoriesRow(
                        categories = state.categories,
                        selected = state.selectCategory,
                        listState = rowState,
                    ) { callback?.onCategorySelect(it) }
            }
        }
    ) {
        SwipeRefresh(
            state = refreshState,
            onRefresh = {
                refreshing = true
                callback?.onRefresh()
                refreshing = false
            },
        ) {
            Content(
                state = state,
                listState = listState,
                rowState = rowState,
                modifier = Modifier.padding(it),
                callback = callback
            )
        }
    }
}

@Composable
private fun Content(
    state: MainScreenState,
    listState: LazyListState,
    rowState: LazyListState,
    modifier: Modifier = Modifier,
    callback: MainScreenCallback?,
) {
    LazyColumn(modifier, listState) {
        item {
            AdvertisementCompose(state.advertisements) {
                callback?.onAdvertisementClick(it)
            }
        }
        if(listState.firstVisibleItemIndex < 1)
            item(key = 1) {
                CategoriesRow(
                    categories = state.categories,
                    selected = state.selectCategory,
                    listState = rowState
                ) { callback?.onCategorySelect(it) }
            }
        tabs(state, callback)
    }
}

private fun LazyListScope.tabs(
    state: MainScreenState,
    callback: MainScreenCallback?,
) {
    itemsIndexed(state.pizzas) { i, it ->
        ProductItem(
            index = i, pizza = it,
            onClick = { callback?.onPizzaClick(it) },
        ) { callback?.onPriceClick(it) }
    }
}