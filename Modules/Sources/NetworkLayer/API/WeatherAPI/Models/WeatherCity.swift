//
//  WeatherCity.swift
//  Modules
//
//  Created by Nikita Gavrilov on 21.09.2024.
//

public struct WeatherCity: Decodable {
    public let coord: CityCoordinate
    public let main: CurrentWeather
}

public struct CityCoordinate: Decodable {
    public let lon: Double
    public let lat: Double
}

public struct CurrentWeather: Decodable {
    public let temp: Double
}
