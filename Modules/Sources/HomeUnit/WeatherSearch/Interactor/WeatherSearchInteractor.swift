//
//  WeatherSearchInteractor.swift
//  Modules
//
//  Created by Nikita Gavrilov on 21.09.2024.
//

import Combine
import NetworkLayer

final class WeatherSearchInteractor {
    
    // MARK: Properties
    
    private let state: State
    private let networkManager: NetworkWeatherProtocol
    private let coreDataStorage: CoreDataWeatherProtocol
    private var cancellable = Set<AnyCancellable>()
    
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

// MARK: - WeatherSearchInteractorProtocol

extension WeatherSearchInteractor: WeatherSearchInteractorProtocol {
    var cityData: AnyPublisher<[CitySuggest], Never> {
        state.geocodeCityData.eraseToAnyPublisher()
    }
    
    func geocode(from city: String) -> AnyPublisher<Void, Error> {
        Future<Void, Error> { [unowned self, state] promise in
            var cancellable = Set<AnyCancellable>()
            networkManager.geocode(from: city)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .failure(let error):
                        state.geocodeCityData.send([])
                        promise(.failure(error))
                    case .finished:
                        cancellable.removeAll()
                    }
                }, receiveValue: { geocodeCityData in
                    let data = geocodeCityData as [CitySuggest]
                    state.geocodeCityData.send(data)
                    promise(.success(Void()))
                })
                .store(in: &cancellable)
        }
        .eraseToAnyPublisher()
    }
    
    func selectedCity(_ name: String) {
        state.geocodeCityData.first()
            .compactMap { $0.first(where: { $0.name == name }) }
            .sink { [coreDataStorage] city in
                coreDataStorage.addCity(city.name, lat: city.lat, lon: city.lon)
            }
            .store(in: &cancellable)
    }
}
