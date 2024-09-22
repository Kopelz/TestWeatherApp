//
//  WeatherMainInteractor+State.swift
//  Modules
//
//  Created by Nikita Gavrilov on 21.09.2024.
//

import Combine

extension WeatherMainInteractor {
    struct State {
        let citiesData = CurrentValueSubject<[CityData], Never>([])
    }
}
