//
//  WeatherMainInteractor.swift
//  Modules
//
//  Created by Nikita Gavrilov on 21.09.2024.
//

import Combine
import NetworkLayer

final class WeatherMainInteractor {
    
    // MARK: Properties
    
    private let state: State
    private let networkManager: NetworkWeatherProtocol
    private let coreDataStorage: CoreDataWeatherProtocol
    
    // MARK: Init
    
    init(
        state: State,
        networkManager: NetworkWeatherProtocol,
        coreDataStorage: CoreDataWeatherProtocol
    ) {
        self.state = state
        self.networkManager = networkManager
        self.coreDataStorage = coreDataStorage
    }
}

// MARK: - WeatherMainInteractorProtocol

extension WeatherMainInteractor: WeatherMainInteractorProtocol {
    var citiesData: AnyPublisher<[CityData], Never> {
        state.citiesData.eraseToAnyPublisher()
    }
    
    func fetchWeatherDataForSavedCities() -> AnyPublisher<Void, Error> {
        Deferred { [unowned self] in
            Just(coreDataStorage.fetchCities())
                .map {
                    Publishers.MergeMany(
                        $0.map { city in
                            getWeather(city: city)
                        }
                    )
                }
                .setFailureType(to: Error.self)
                .switchToLatest()
                .collect()
                .map { [state] value in
                    state.citiesData.send(value)
                    return Void()
                }
        }
        .eraseToAnyPublisher()
    }
    
    func needDeleteCity(_ name: String) -> AnyPublisher<Void, Error> {
        Deferred { [unowned self] in
            Just(coreDataStorage.deleteCity(name))
                .setFailureType(to: Error.self)
                .flatMap { [unowned self]  _ in
                    fetchWeatherDataForSavedCities()
                }
                .map { _ in Void() }
                .eraseToAnyPublisher()
        }
        .eraseToAnyPublisher()
    }
}

private extension WeatherMainInteractor {
    func getWeather(city: CitySaved) -> AnyPublisher<CityData, Error> {
        Future<CityData, Error> { [unowned self] promise in
            var cancellable = Set<AnyCancellable>()
            networkManager.getWeather(lat: city.lat, lon: city.lon)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .failure(let error):
                        promise(.failure(error))
                    case .finished:
                        cancellable.removeAll()
                    }
                }, receiveValue: { value in
                    promise(.success(.init(name: city.name, lat: value.lat, lon: value.lon, temp: value.temperature)))
                })
                .store(in: &cancellable)
        }
        .eraseToAnyPublisher()
    }
}
