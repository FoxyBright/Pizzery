package com.pizzery.data.database

import androidx.room.*
import androidx.room.OnConflictStrategy.Companion.IGNORE

@Dao
interface ProductDao {
    
    @Insert(onConflict = IGNORE)
    suspend fun addProduct(product: ProductTable)
    
    @Query("SELECT * FROM product")
    suspend fun getProducts(): List<ProductTable>
    
    @Query("DELETE FROM product")
    suspend fun clearProducts()
}