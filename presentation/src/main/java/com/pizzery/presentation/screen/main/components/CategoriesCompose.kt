package com.pizzery.presentation.screen.main.components

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.lazy.*
import androidx.compose.material3.MaterialTheme.colorScheme
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import com.pizzery.shared.common.Chip
import com.pizzery.shared.models.CategoryModel

@Composable
fun CategoriesRow(
    categories: List<CategoryModel>,
    selected: CategoryModel?,
    listState: LazyListState,
    modifier: Modifier = Modifier,
    onSelect: (CategoryModel) -> Unit,
) {
    LazyRow(
        modifier = modifier.background(
            colorScheme.background
        ),
        state = listState
    ) {
        space(16)
        items(categories) {
            Chip(
                label = it.name,
                enabled = it == selected,
                modifier = Modifier
                    .padding(end = 8.dp)
            ) { onSelect(it) }
        }
        space(8)
    }
}

private fun LazyListScope.space(
    width: Int,
) = item {
    Spacer(
        Modifier.width(width.dp)
    )
}
