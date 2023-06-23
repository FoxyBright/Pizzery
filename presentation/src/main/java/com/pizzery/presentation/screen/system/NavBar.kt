package com.pizzery.presentation.screen.system

import androidx.compose.animation.animateColorAsState
import androidx.compose.animation.core.tween
import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.layout.Arrangement.SpaceEvenly
import androidx.compose.foundation.layout.Arrangement.Top
import androidx.compose.material3.Icon
import androidx.compose.material3.MaterialTheme.colorScheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.ui.Alignment.Companion.CenterHorizontally
import androidx.compose.ui.Alignment.Companion.CenterVertically
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.unit.dp
import androidx.navigation.NavHostController
import com.pizzery.presentation.screen.system.NavBarStates.BASKET
import com.pizzery.presentation.screen.system.NavBarStates.MENU
import com.pizzery.presentation.screen.system.NavBarStates.PROFILE
import com.pizzery.shared.R
import com.pizzery.shared.R.drawable.ic_basket
import com.pizzery.shared.R.drawable.ic_food
import com.pizzery.shared.R.drawable.ic_profile
import com.pizzery.shared.theme.ExtraTypography.menuLabel

enum class NavBarStates(val value: Int) {
    MENU(0), PROFILE(1), BASKET(2)
}

@Composable
fun NavigationBar(
    nav: NavHostController,
    select: NavBarStates,
    modifier: Modifier = Modifier,
) {
    Row(
        modifier
            .fillMaxWidth()
            .background(colorScheme.surface)
            .padding(top = 5.dp, bottom = 10.dp),
        SpaceEvenly, CenterVertically
    ) {
        Item(
            icon = ic_food,
            label = R.string.food_menu_label,
            enabled = select == MENU,
            modifier = Modifier.weight(1f)
        ) {
            if(select != MENU)
                nav.navigate("main")
        }
        Item(
            icon = ic_profile,
            label = R.string.food_profile_label,
            enabled = select == PROFILE,
            modifier = Modifier.weight(1f)
        ) {
            if(select != PROFILE)
                nav.navigate("profile")
        }
        Item(
            icon = ic_basket,
            label = R.string.food_basket_label,
            enabled = select == BASKET,
            modifier = Modifier.weight(1f)
        ) {
            if(select != BASKET)
                nav.navigate("basket")
        }
    }
}

@Composable
private fun Item(
    icon: Int,
    label: Int,
    enabled: Boolean,
    modifier: Modifier = Modifier,
    enabledColor: Color = colorScheme.primary,
    disabledColor: Color = colorScheme.secondary,
    onClick: () -> Unit,
) {
    val color by animateColorAsState(
        targetValue = if(enabled) enabledColor
        else disabledColor,
        animationSpec = tween(200)
    )
    Column(
        modifier.clickable { onClick() },
        Top, CenterHorizontally
    ) {
        Icon(
            painter = painterResource(icon),
            contentDescription = null,
            modifier = Modifier.size(24.dp),
            tint = color
        )
        Text(
            text = stringResource(label),
            modifier = Modifier
                .padding(top = 4.dp),
            style = menuLabel.copy(color)
        )
    }
}