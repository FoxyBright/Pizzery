package com.pizzery.data.database

import android.content.Context
import androidx.room.Database
import androidx.room.Room
import androidx.room.RoomDatabase

@Database(
    entities = [ProductTable::class],
    version = 1,
    exportSchema = false
)
abstract class DataBase: RoomDatabase() {
    
    abstract fun productDao(): ProductDao
    
    companion object {
        
        @Volatile
        private var INSTANCE: DataBase? = null
        
        fun getDataBase(context: Context): DataBase {
            val tempInstance = INSTANCE
            tempInstance?.let { return it }
            
            synchronized(this) {
                val instance = Room.databaseBuilder(
                    context.applicationContext,
                    DataBase::class.java,
                    "database"
                ).build()
                INSTANCE = instance
                return instance
            }
        }
    }
}