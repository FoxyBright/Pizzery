package com.pizzery

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import com.pizzery.presentation.Navigation.Content
import com.pizzery.shared.theme.PizzeryTheme

class MainActivity: ComponentActivity() {
    
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent { PizzeryTheme { Content() } }
    }
}