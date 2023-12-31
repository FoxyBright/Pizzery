@file:Suppress("DEPRECATION")

package com.pizzery.shared.theme

import android.app.Activity
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.lightColorScheme
import androidx.compose.runtime.Composable
import androidx.compose.runtime.SideEffect
import androidx.compose.ui.graphics.Color.Companion.White
import androidx.compose.ui.graphics.toArgb
import androidx.compose.ui.platform.LocalView
import androidx.core.view.ViewCompat.getWindowInsetsController

private val LightColorScheme = lightColorScheme(
    primary = PrimaryPink,
    secondary = SecondaryGray,
    tertiary = TertiaryBlack,
    background = White,
    surface = White,
    outline = OutlineGray,
    onSecondary = OnSecondaryGray,
    outlineVariant = OutlineVariantGray
    
    /* Other default colors to override
    background = Color(0xFFFFFBFE),
    surface = Color(0xFFFFFBFE),
    onPrimary = Color.White,
    onSecondary = Color.White,
    onTertiary = Color.White,
    onBackground = Color(0xFF1C1B1F),
    onSurface = Color(0xFF1C1B1F),
    */
)

@Composable
fun PizzeryTheme(content: @Composable () -> Unit) {
    val view = LocalView.current
    if(!view.isInEditMode) {
        SideEffect {
            (view.context as Activity)
                .window.statusBarColor =
                LightColorScheme.surface.toArgb()
            getWindowInsetsController(view)
                ?.isAppearanceLightStatusBars = true
        }
    }
    MaterialTheme(
        colorScheme = LightColorScheme,
        typography = Typography,
        content = content
    )
}