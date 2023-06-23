package com.pizzery.shared.theme

import androidx.compose.ui.text.font.FontWeight.Companion.Bold
import androidx.compose.ui.text.font.FontWeight.Companion.Medium
import androidx.compose.ui.text.font.FontWeight.Companion.Normal
import androidx.compose.ui.unit.sp

object ExtraTypography {
    
    val cityLabel = interTextStyle
        .copy(
            fontSize = 16.sp,
            fontWeight = Medium
        )
    
    val chipLabel = sfUITextStyle
        .copy(
            fontSize = 13.sp,
            fontWeight = Normal
        )
    
    val pizzaName = robotoTextStyle
        .copy(
            fontSize = 16.sp,
            fontWeight = Bold
        )
    
    val pizzaDescription = sfUITextStyle
        .copy(
            fontSize = 14.sp,
            fontWeight = Normal
        )
    
    val pizzaPrice = sfUITextStyle
        .copy(
            fontSize = 13.sp,
            fontWeight = Normal
        )
    
    val menuLabel = interTextStyle
        .copy(
            fontSize = 12.sp,
            fontWeight = Medium
        )
}