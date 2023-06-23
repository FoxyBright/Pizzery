package com.pizzery.shared.common

import android.util.Size
import androidx.compose.animation.animateColorAsState
import androidx.compose.animation.core.tween
import androidx.compose.foundation.BorderStroke
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.*
import androidx.compose.material3.CardDefaults.cardColors
import androidx.compose.material3.MaterialTheme.colorScheme
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.ui.Alignment.Companion.Center
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.shadow
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.Color.Companion.Transparent
import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.text.font.FontWeight.Companion.Normal
import androidx.compose.ui.text.font.FontWeight.Companion.SemiBold
import androidx.compose.ui.unit.dp
import com.pizzery.shared.theme.ExtraTypography.chipLabel

@Composable
@OptIn(ExperimentalMaterial3Api::class)
fun Chip(
    label: String,
    enabled: Boolean = false,
    modifier: Modifier = Modifier,
    enabledColor: Color = colorScheme.primary,
    disabledColor: Color = colorScheme.surface,
    labelColor: Color = colorScheme.outline,
    size: Size = Size(88, 32),
    border: Boolean = false,
    font: TextStyle = chipLabel,
    onClick: () -> Unit,
) {
    val background by animateColorAsState(
        targetValue = if(enabled)
            enabledColor.copy(0.2f)
        else disabledColor,
        animationSpec = tween(200)
    )
    val textColor by animateColorAsState(
        targetValue = if(enabled)
            enabledColor else labelColor,
        animationSpec = tween(200)
    )
    Card(
        onClick = onClick,
        modifier = if(border) modifier
        else modifier.shadow(
            elevation = if(enabled) 0.dp else 10.dp,
            shape = RoundedCornerShape(5.dp),
            ambientColor = colorScheme.outline,
            spotColor = colorScheme.outline
        ),
        colors = cardColors(
            if(!border) background
            else Transparent
        ),
        border = if(border) BorderStroke(
            1.dp, colorScheme.primary
        ) else null,
        shape = RoundedCornerShape(6.dp),
    ) {
        Box(
            Modifier
                .size(
                    size.width.dp,
                    size.height.dp
                ),
            Center
        ) {
            Text(
                text = label,
                style = font.copy(
                    color = if(border)
                        colorScheme.primary
                    else textColor,
                    fontWeight = if(enabled)
                        SemiBold else Normal
                )
            )
        }
    }
}