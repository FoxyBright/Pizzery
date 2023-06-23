package com.pizzery

import android.app.Application
import com.pizzery.di.Modules.getKoinModules
import org.koin.android.ext.koin.androidContext
import org.koin.android.ext.koin.androidLogger
import org.koin.core.context.startKoin
import org.koin.core.logger.Level.NONE

class ApplicationConfig: Application() {
    
    override fun onCreate() {
        super.onCreate()
        
        startKoin {
            androidLogger(NONE)
            androidContext(this@ApplicationConfig)
            modules(getKoinModules())
        }
    }
}