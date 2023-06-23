package com.pizzery.data.apiConfig

import com.fasterxml.jackson.annotation.JsonInclude.Include.NON_NULL
import com.fasterxml.jackson.databind.DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES
import com.fasterxml.jackson.databind.PropertyNamingStrategies.SnakeCaseStrategy
import io.ktor.client.HttpClient
import io.ktor.client.engine.okhttp.OkHttp
import io.ktor.client.plugins.HttpRequestRetry
import io.ktor.client.plugins.UserAgent
import io.ktor.client.plugins.contentnegotiation.ContentNegotiation
import io.ktor.client.plugins.defaultRequest
import io.ktor.client.request.HttpRequestBuilder
import io.ktor.client.request.get
import io.ktor.http.ContentType.Application.Json
import io.ktor.http.contentType
import io.ktor.serialization.jackson.jackson
import java.io.IOException
import java.util.concurrent.TimeUnit.MINUTES

open class KtorSource {
    
    private val protocol = "https://"
    private val hostUrl =
        "free-food-menus-api-production.up.railway.app"
    
    private val baseClient by lazy {
        HttpClient(OkHttp) {
            engine { config { writeTimeout(5, MINUTES) } }
            install(HttpRequestRetry) {
                exponentialDelay()
                maxRetries = 3
                retryOnExceptionIf { _, throwable -> throwable is IOException }
            }
            install(ContentNegotiation) {
                jackson {
                    configure(FAIL_ON_UNKNOWN_PROPERTIES, false)
                    propertyNamingStrategy = SnakeCaseStrategy()
                    setSerializationInclusion(NON_NULL)
                }
            }
            defaultRequest { contentType(Json); host = hostUrl }
            install(UserAgent) { agent = hostUrl }
        }
    }
    
    private val client by lazy { baseClient.config {} }
    
    suspend fun get(
        url: String,
        block: HttpRequestBuilder.() -> Unit = {},
        setPage: Boolean = false,
    ) = client.get(
        "$protocol$hostUrl/$url${
            if(setPage) "?_page=0&_limit=8" else ""
        }", block
    )
}