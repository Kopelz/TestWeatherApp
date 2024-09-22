//
//  HomeUnitAdapter.swift
//  Modules
//
//  Created by Nikita Gavrilov on 21.09.2024.
//

import NetworkLayer

extension GeocodeCityData: CitySuggest {}

extension WeatherCity: CityTemperature {
    var lat: Double {
        coord.lat
    }
    
    var lon: Double {
        coord.lon
    }
    
    var temperature: Double {
        main.temp
    }
}

extension WeatherForecast: CityWeatherForecast {
    public var daysTemperature: [WeatherDay] {
        list
    }
}

extension WeatherForecastList: WeatherDay {
    public var temperature: Double {
        main.temp
    }
}
