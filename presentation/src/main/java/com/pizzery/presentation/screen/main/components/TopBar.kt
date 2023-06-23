package com.pizzery.presentation.screen.main.components

import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.interaction.MutableInteractionSource
import androidx.compose.foundation.layout.*
import androidx.compose.material3.Icon
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.unit.dp
import com.pizzery.presentation.screen.main.MainScreenCallback
import com.pizzery.shared.R
import com.pizzery.shared.theme.ExtraTypography


@Composable
fun TopBar(
    selectCity: String,
    callback: MainScreenCallback?,
) {
    Row(
        Modifier
            .fillMaxWidth()
            .background(MaterialTheme.colorScheme.surface)
            .padding(16.dp),
        Arrangement.SpaceBetween, Alignment.CenterVertically
    ) {
        CitySelector(selectCity) {
            callback?.onCityClick()
        }
        Icon(
            painter = painterResource(
                R.drawable.ic_qr
            ),
            contentDescription = null,
            modifier = Modifier
                .size(24.dp)
                .clickable(
                    MutableInteractionSource(),
                    indication = null
                ) { callback?.onQRClick() },
        )
    }
}


@Composable
private fun CitySelector(
    selectCity: String,
    modifier: Modifier = Modifier,
    onOpen: () -> Unit,
) {
    Row(
        modifier.clickable(
            MutableInteractionSource(),
            indication = null
        ) { onOpen() },
        Arrangement.Start, Alignment.CenterVertically
    ) {
        Text(
            text = selectCity,
            modifier = Modifier
                .padding(end = 9.dp),
            style = ExtraTypography.cityLabel
        )
        Icon(
            painter = painterResource(
                R.drawable.ic_keyboard_arrow_down
            ),
            contentDescription = null,
            modifier = Modifier.size(24.dp)
        )
    }
}