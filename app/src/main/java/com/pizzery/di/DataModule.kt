package com.pizzery.di

import android.content.Context
import android.provider.ContactsContract.Data
import androidx.room.Room
import com.pizzery.data.database.DataBase
import com.pizzery.data.database.DataBase.Companion.getDataBase
import com.pizzery.data.repositories.Repository
import com.pizzery.data.sources.WebSource
import org.koin.core.module.dsl.singleOf
import org.koin.dsl.module

val dataModule = module {

    singleOf(::getDataBase)

    single { get<DataBase>().productDao() }
    
    singleOf(::WebSource)
    singleOf(::Repository)
}
