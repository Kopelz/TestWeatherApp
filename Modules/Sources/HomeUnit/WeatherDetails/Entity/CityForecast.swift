//
//  CityForecast.swift
//  Modules
//
//  Created by Nikita Gavrilov on 22.09.2024.
//

struct CityForecast {
    let name: String
    let daysTemperature: [WeatherDay]
    
    init(
        name: String = .init(),
        daysTemperature: [WeatherDay] = []
    ) {
        self.name = name
        self.daysTemperature = daysTemperature
    }
}
