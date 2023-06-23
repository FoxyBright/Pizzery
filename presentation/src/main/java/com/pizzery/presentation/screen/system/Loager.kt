package com.pizzery.presentation.screen.system

import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.size
import androidx.compose.material.CircularProgressIndicator
import androidx.compose.material3.MaterialTheme.colorScheme
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment.Companion.Center
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp

@Composable
fun Loader() {
    Box(Modifier.fillMaxSize(), Center) {
        CircularProgressIndicator(
            modifier = Modifier.size(32.dp),
            color = colorScheme.primary,
            strokeWidth = 3.dp
        )
    }
}