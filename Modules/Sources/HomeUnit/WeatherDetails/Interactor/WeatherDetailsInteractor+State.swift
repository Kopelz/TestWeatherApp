//
//  WeatherDetailsInteractor+State.swift
//  Modules
//
//  Created by Nikita Gavrilov on 21.09.2024.
//

import Combine

extension WeatherDetailsInteractor {
    struct State {
        let cityForecast = CurrentValueSubject<CityForecast, Never>(.init())
        
        let cityData = CurrentValueSubject<CityData, Never>(.init())
    }
}
