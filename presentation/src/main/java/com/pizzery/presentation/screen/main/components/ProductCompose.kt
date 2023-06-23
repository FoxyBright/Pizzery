package com.pizzery.presentation.screen.main.components

import androidx.compose.foundation.layout.*
import androidx.compose.foundation.layout.Arrangement.SpaceBetween
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.material3.*
import androidx.compose.material3.CardDefaults.cardColors
import androidx.compose.material3.MaterialTheme.colorScheme
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment.Companion.BottomEnd
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.RectangleShape
import androidx.compose.ui.layout.ContentScale.Companion.FillHeight
import androidx.compose.ui.text.style.TextOverflow.Companion.Ellipsis
import androidx.compose.ui.unit.dp
import coil.compose.AsyncImage
import com.pizzery.shared.common.Chip
import com.pizzery.shared.models.ProductModel
import com.pizzery.shared.theme.ExtraTypography.pizzaDescription
import com.pizzery.shared.theme.ExtraTypography.pizzaName
import com.pizzery.shared.theme.ExtraTypography.pizzaPrice

@Composable
@OptIn(ExperimentalMaterial3Api::class)
fun ProductItem(
    index: Int,
    pizza: ProductModel,
    modifier: Modifier = Modifier,
    onClick: (ProductModel) -> Unit,
    onPriceClick: (ProductModel) -> Unit,
) {
    Column(modifier) {
        if(index == 0) Divide()
        Card(
            onClick = { onClick(pizza) },
            modifier = Modifier.fillMaxWidth(),
            shape = RectangleShape,
            colors = cardColors(
                colorScheme.surface
            )
        ) {
            Row {
                ProductImage(
                    img = pizza.img,
                    modifier = Modifier
                        .padding(
                            start = 16.dp,
                            end = 22.dp
                        )
                        .padding(vertical = 16.dp)
                )
                ProductInformation(
                    name = pizza.name,
                    description = pizza.description,
                    price = pizza.price,
                ) { onPriceClick(pizza) }
            }
        }
        Divide()
    }
}

@Composable
private fun Divide() {
    Divider(
        thickness = 1.dp,
        color = colorScheme.outlineVariant
    )
}

@Composable
private fun ProductInformation(
    name: String,
    description: String,
    price: Int,
    modifier: Modifier = Modifier,
    onPriceClick: () -> Unit,
) {
    Column(
        modifier.height(168.dp),
        SpaceBetween
    ) {
        Column(modifier) {
            Text(
                text = name,
                modifier = Modifier
                    .padding(bottom = 8.dp),
                style = pizzaName.copy(
                    colorScheme.tertiary
                )
            )
            Text(
                text = description,
                style = pizzaDescription.copy(
                    colorScheme.onSecondary
                ),
                modifier = Modifier
                    .heightIn(min = 70.dp),
                maxLines = 4,
                overflow = Ellipsis
            )
        }
        Box(
            Modifier
                .fillMaxWidth()
                .padding(
                    bottom = 8.dp,
                    end = 16.dp
                ),
            BottomEnd
        ) {
            Chip(
                label = "от $price р",
                border = true,
                font = pizzaPrice
            ) { onPriceClick() }
        }
    }
}

@Composable
private fun ProductImage(
    img: String,
    modifier: Modifier = Modifier,
) {
    AsyncImage(
        model = img,
        contentDescription = null,
        modifier = modifier
            .size(135.dp)
            .clip(CircleShape),
        contentScale = FillHeight
    )
}