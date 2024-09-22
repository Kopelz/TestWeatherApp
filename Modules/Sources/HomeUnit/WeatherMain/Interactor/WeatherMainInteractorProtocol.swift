//
//  WeatherMainInteractorProtocol.swift
//  Modules
//
//  Created by Nikita Gavrilov on 21.09.2024.
//

import Combine

protocol WeatherMainInteractorProtocol {
    
    var citiesData: AnyPublisher<[CityData], Never> { get }
    
    func fetchWeatherDataForSavedCities() -> AnyPublisher<Void, Error>
    
    func needDeleteCity(_ name: String) -> AnyPublisher<Void, Error>
}
