//
//  NetworkWeatherProtocol.swift
//  Modules
//
//  Created by Nikita Gavrilov on 21.09.2024.
//

import Combine

public protocol NetworkWeatherProtocol {
    func geocode(from city: String) -> AnyPublisher<[GeocodeCityData], Error>
    
    func getWeather(lat: Double, lon: Double) -> AnyPublisher<WeatherCity, Error>
    
    func getWeatherForecast(lat: Double, lon: Double) -> AnyPublisher<WeatherForecast, Error>
}
