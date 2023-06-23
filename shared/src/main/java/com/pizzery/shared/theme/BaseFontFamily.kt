package com.pizzery.shared.theme

import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.text.font.Font
import androidx.compose.ui.text.font.FontFamily
import androidx.compose.ui.text.font.FontStyle.Companion.Normal
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.font.FontWeight.Companion.Bold
import androidx.compose.ui.text.font.FontWeight.Companion.Medium
import androidx.compose.ui.text.font.FontWeight.Companion.SemiBold
import com.pizzery.shared.R.font.*

val robotoTextStyle = TextStyle(
    fontFamily = FontFamily(
        Font(
            resId = roboto_regular,
            weight = FontWeight.Normal,
            style = Normal
        ),
        Font(
            resId = roboto_medium,
            weight = Medium,
            style = Normal
        ),
        Font(
            resId = roboto_bold,
            weight = Bold,
            style = Normal
        )
    )

)

val interTextStyle = TextStyle(
    fontFamily = FontFamily(
        Font(
            resId = inter_regular,
            weight = FontWeight.Normal,
            style = Normal
        ),
        Font(
            resId = inter_medium,
            weight = Medium,
            style = Normal
        ),
        Font(
            resId = inter_semibold,
            weight = SemiBold,
            style = Normal
        ),
        Font(
            resId = inter_bold,
            weight = Bold,
            style = Normal
        )
    )
)

val sfUITextStyle = TextStyle(
    fontFamily = FontFamily(
        Font(
            resId = sf_ui_display_medium,
            weight = Medium,
            style = Normal
        ),
        Font(
            resId = sf_ui_display_semibold,
            weight = SemiBold,
            style = Normal
        ),
        Font(
            resId = sf_ui_display_bold,
            weight = Bold,
            style = Normal
        ),
    )
)