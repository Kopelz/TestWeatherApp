//
//  WeatherMainInteractor+State.swift
//  Modules
//
//  Created by Nikita Gavrilov on 21.09.2024.
//

import Combine

extension WeatherSearchInteractor {
    struct State {
        let geocodeCityData = CurrentValueSubject<[CitySuggest], Never>([])
    }
}
