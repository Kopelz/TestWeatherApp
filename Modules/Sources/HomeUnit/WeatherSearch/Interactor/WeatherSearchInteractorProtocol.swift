//
//  WeatherMainInteractorProtocol.swift
//  Modules
//
//  Created by Nikita Gavrilov on 21.09.2024.
//

import Combine

protocol WeatherSearchInteractorProtocol {
    var cityData: AnyPublisher<[CitySuggest], Never> { get }
    
    func geocode(from city: String) -> AnyPublisher<Void, Error>
    
    func selectedCity(_ name: String)
}
