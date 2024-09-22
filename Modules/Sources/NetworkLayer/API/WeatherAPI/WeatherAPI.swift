//
//  WeatherAPI.swift
//  Modules
//
//  Created by Nikita Gavrilov on 21.09.2024.
//

import Foundation

enum WeatherAPI {
    
    case geocode(city: String)
    
    case weather(latitude: Double, longitude: Double)
    
    case forecast(latitude: Double, longitude: Double)
}

extension WeatherAPI: Endpoint {
    var basePath: String {
        "api.openweathermap.org"
    }
    
    var path: String {
        switch self {
        case .geocode:
            return "/geo/1.0/direct"
        case .weather:
            return "/data/2.5/weather"
        case .forecast:
            return "/data/2.5/forecast"
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case let .geocode(city):
            [
                .init(name: "q", value: city),
                .init(name: "limit", value: "5")
            ]
        case let .weather(latitude, longitude):
            [
                .init(name: "lat", value: String(latitude)),
                .init(name: "lon", value: String(longitude)),
                .init(name: "units", value: "metric")
            ]
        case let .forecast(latitude, longitude):
            [
                .init(name: "lat", value: String(latitude)),
                .init(name: "lon", value: String(longitude)),
                .init(name: "units", value: "metric")
            ]
        }
    }
    
    var httpMethod: HTTPMethod {
        .get
    }
    
    var apiKey: [String : APIKey]? {
        ["appid" : .weather]
    }
}
