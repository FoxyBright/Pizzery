package com.pizzery.presentation

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.padding
import androidx.compose.material3.MaterialTheme.colorScheme
import androidx.compose.material3.Scaffold
import androidx.compose.runtime.*
import androidx.compose.ui.Modifier
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.compose.rememberNavController
import com.pizzery.presentation.screen.EmptyScreen
import com.pizzery.presentation.screen.main.MainScreen
import com.pizzery.presentation.screen.system.NavBarStates.BASKET
import com.pizzery.presentation.screen.system.NavBarStates.MENU
import com.pizzery.presentation.screen.system.NavBarStates.PROFILE
import com.pizzery.presentation.screen.system.NavigationBar
import com.pizzery.presentation.viewmodel.MainScreenViewModel
import org.koin.java.KoinJavaComponent.get

object Navigation {
    
    private val mainVM =
        get<MainScreenViewModel>(MainScreenViewModel::class.java)
    
    @Composable
    fun Content() {
        val nav = rememberNavController()
        var hideNavBar by remember {
            mutableStateOf(false)
        }
        
        var selectedMenu by remember {
            mutableStateOf(MENU)
        }
        
        Scaffold(
            modifier = Modifier
                .fillMaxSize()
                .background(colorScheme.background),
            bottomBar = {
                if(!hideNavBar) NavigationBar(
                    nav, selectedMenu
                )
            }
        ) {
            Box(
                Modifier
                    .fillMaxSize()
                    .padding(it)
            ) {
                NavHost(nav, "main") {
                    composable("main") {
                        hideNavBar = false
                        selectedMenu = MENU
                        MainScreen(mainVM, nav)
                    }
                    composable("profile") {
                        hideNavBar = false
                        selectedMenu = PROFILE
                        EmptyScreen(nav)
                    }
                    composable("basket") {
                        hideNavBar = false
                        selectedMenu = BASKET
                        EmptyScreen(nav)
                    }
                    composable("other") {
                        hideNavBar = true
                        EmptyScreen(nav)
                    }
                }
            }
        }
    }
}