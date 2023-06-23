package com.pizzery.presentation.screen

import androidx.compose.foundation.layout.*
import androidx.compose.foundation.layout.Arrangement.Center
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults.buttonColors
import androidx.compose.material3.MaterialTheme.colorScheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment.Companion.CenterHorizontally
import androidx.compose.ui.Modifier
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.font.FontWeight.Companion.Bold
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.navigation.NavHostController
import com.pizzery.shared.R
import com.pizzery.shared.theme.ExtraTypography.menuLabel

@Composable
fun EmptyScreen(nav: NavHostController) {
    Column(
        Modifier.fillMaxSize(),
        Center, CenterHorizontally
    ) {
        Text(
            text = stringResource(
                R.string.empty_screen_label
            ),
            modifier = Modifier.padding(bottom = 20.dp),
            style = menuLabel.copy(
                fontSize = 20.sp,
                textAlign = TextAlign.Center
            )
        )
        Button(
            onClick = { nav.navigate("main") },
            shape = RoundedCornerShape(12.dp),
            colors = buttonColors(colorScheme.primary)
        ) {
            Text(
                text = stringResource(
                    R.string.empty_screen_return_button
                ),
                style = menuLabel.copy(
                    fontWeight = Bold
                )
            )
        }
    }
}