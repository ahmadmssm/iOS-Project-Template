//
//  Endpoints.swift
//  DataModule
//
//  Created by Ahmad Mahmoud on 22/02/2021.
//

// enum and not class or struct, so it cannot be instantiated
public enum Endpoints {
    static var refreshToken: String { "/refresh/" }
    static var worldCountries: String { "all" }
    static var trendingMovies: String { "movie/popular" }
    static var devicePublicIP: String { "?format=json2" }
    static var locationCoordinates: String { "/" }
    static var fiveDaysWeatherForecast: String { "/forecast" }
}
