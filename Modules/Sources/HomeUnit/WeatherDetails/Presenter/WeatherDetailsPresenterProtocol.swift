//
//  WeatherDetailsPresenterProtocol.swift
//  Modules
//
//  Created by Nikita Gavrilov on 21.09.2024.
//

import Traits
import Combine

protocol WeatherDetailsPresenterProtocol: GenericPresenter where ViewEvent == WeatherDetailsViewEvent {
    var weatherForecast: AnyPublisher<[WeatherDetailsItem], Never> { get }
    
    var cityName: AnyPublisher<String, Never> { get }
}
