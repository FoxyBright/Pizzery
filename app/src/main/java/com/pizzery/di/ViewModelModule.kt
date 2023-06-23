package com.pizzery.di

import com.pizzery.presentation.viewmodel.MainScreenViewModel
import org.koin.dsl.module

val viewModelModule = module {
    
    single { MainScreenViewModel() }
}