//
//  CityWeatherForecast.swift
//  Modules
//
//  Created by Nikita Gavrilov on 22.09.2024.
//

public protocol CityWeatherForecast {
    var daysTemperature: [WeatherDay] { get }
}

public protocol WeatherDay {
    var date: String { get }
    var temperature: Double { get }
}
