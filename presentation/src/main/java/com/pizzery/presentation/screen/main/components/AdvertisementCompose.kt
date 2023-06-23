package com.pizzery.presentation.screen.main.components

import androidx.compose.foundation.Image
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.*
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults.cardColors
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color.Companion.Transparent
import androidx.compose.ui.layout.ContentScale.Companion.Crop
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.unit.dp
import com.google.accompanist.pager.ExperimentalPagerApi
import com.google.accompanist.pager.HorizontalPager
import com.google.accompanist.pager.rememberPagerState
import com.pizzery.shared.models.AdvertisementModel

@Composable
@OptIn(ExperimentalPagerApi::class)
fun AdvertisementCompose(
    list: List<AdvertisementModel>,
    modifier: Modifier = Modifier,
    onClick: (AdvertisementModel) -> Unit,
) {
    HorizontalPager(
        count = list.size,
        modifier = modifier.fillMaxWidth(),
        state = rememberPagerState(),
        contentPadding = PaddingValues(
            end = 40.dp,
            start = 16.dp
        ),
    ) { page ->
        Card(
            Modifier.fillMaxWidth(),
            RoundedCornerShape(8.dp),
            cardColors(Transparent)
        ) {
            Advertisement(
                item = list[page],
                modifier = Modifier
            ) { onClick(list[page]) }
        }
    }
}

@Composable
@OptIn(ExperimentalMaterial3Api::class)
private fun Advertisement(
    item: AdvertisementModel,
    modifier: Modifier = Modifier,
    onClick: () -> Unit,
) {
    Card(
        onClick = onClick,
        modifier = modifier
            .fillMaxWidth()
            .height(140.dp),
        shape = RoundedCornerShape(10.dp),
        colors = cardColors(Transparent)
    ) {
        Image(
            painterResource(item.img),
            contentDescription = null,
            modifier = Modifier.fillMaxSize(),
            contentScale = Crop
        )
    }
}