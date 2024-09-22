//
//  WeatherDetailsInteractorProtocol.swift
//  Modules
//
//  Created by Nikita Gavrilov on 21.09.2024.
//

import Combine

protocol WeatherDetailsInteractorProtocol {
    
    var cityForecast: AnyPublisher<CityForecast, Never> { get }
    
    func getForecast() -> AnyPublisher<Void, Error>
}
