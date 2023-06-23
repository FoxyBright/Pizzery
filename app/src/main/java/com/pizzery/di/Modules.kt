package com.pizzery.di

object Modules {
    
    fun getKoinModules() = listOf(
        dataModule, viewModelModule
    )
}