//
//  WeatherDetailsInteractor.swift
//  Modules
//
//  Created by Nikita Gavrilov on 21.09.2024.
//

import Combine
import NetworkLayer

final class WeatherDetailsInteractor {
    
    // MARK: Properties
    
    private let state: State
    private let networkManager: NetworkWeatherProtocol
    
    // MARK: Init
    
    init(
        state: State,
        networkManager: NetworkWeatherProtocol
    ) {
        self.state = state
        self.networkManager = networkManager
    }
}

// MARK: - WeatherDetailsInteractorProtocol

extension WeatherDetailsInteractor: WeatherDetailsInteractorProtocol {
    var cityForecast: AnyPublisher<CityForecast, Never> {
        state.cityForecast.eraseToAnyPublisher()
    }
    
    func getForecast() -> AnyPublisher<Void, Error> {
        Future<Void, Error> { [networkManager, state] promise in
            var cancellable = Set<AnyCancellable>()
            
            Just(Void())
                .combineLatest(state.cityData.first())
                .sink { _, city in
                    networkManager.getWeatherForecast(lat: city.lat, lon: city.lon)
                        .sink(receiveCompletion: { completion in
                            switch completion {
                            case .failure(let error):
                                state.cityForecast.send(.init())
                                promise(.failure(error))
                            case .finished:
                                cancellable.removeAll()
                            }
                        }, receiveValue: { forecast in
                            let data = forecast as CityWeatherForecast
                            state.cityForecast.send(.init(name: city.name, daysTemperature: data.daysTemperature))
                            promise(.success(Void()))
                        })
                        .store(in: &cancellable)
                }
                .store(in: &cancellable)
        }
        .eraseToAnyPublisher()
    }
}
