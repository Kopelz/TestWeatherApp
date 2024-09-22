//
//  WeatherMainPresenterProtocol.swift
//  Modules
//
//  Created by Nikita Gavrilov on 21.09.2024.
//

import Traits
import Combine

protocol WeatherMainPresenterProtocol: GenericPresenter where ViewEvent == WeatherMainViewEvent {
    var weatherCities: AnyPublisher<[WeatherMainItem], Never> { get }
}
