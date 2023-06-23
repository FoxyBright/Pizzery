package com.pizzery.shared.models

import com.pizzery.shared.R

data class AdvertisementModel(
    val img: Int,
)

private val OneAdv = AdvertisementModel(
    R.drawable.banner_one
)

private val TwoAdv = AdvertisementModel(
    R.drawable.banner_two
)

val DemoAdvertisementModelList =
    listOf(OneAdv, TwoAdv)