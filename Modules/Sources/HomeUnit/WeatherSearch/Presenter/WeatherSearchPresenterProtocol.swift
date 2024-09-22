//
//  WeatherSearchPresenterProtocol.swift
//  Modules
//
//  Created by Nikita Gavrilov on 21.09.2024.
//

import Combine
import Traits

protocol WeatherSearchPresenterProtocol: GenericPresenter where ViewEvent == WeatherSearchViewEvent {
    
    var searchSuggest: AnyPublisher<[WeatherSearchItem], Never> { get }
}
