//
//  WeatherMainPresenter.swift
//  Modules
//
//  Created by Nikita Gavrilov on 21.09.2024.
//

import Combine
import Dispatch

final class WeatherMainPresenter {
    
    // MARK: Properties
    
    private var interactor: WeatherMainInteractorProtocol
    private var router: WeatherMainRouterProtocol
    private var updateEventPublisher: AnyPublisher<HomeUnitEvent, Never>
    
    private let eventListenerSubject = PassthroughSubject<WeatherMainViewEvent, Never>()
    private let weatherCitiesSubject = CurrentValueSubject<[WeatherMainItem], Never>([])
    
    private var cancellable = Set<AnyCancellable>()
    
    // MARK: Init
    
    init(
        interactor: WeatherMainInteractorProtocol,
        router: WeatherMainRouterProtocol,
        updateEventPublisher: AnyPublisher<HomeUnitEvent, Never>
    ) {
        self.interactor = interactor
        self.router = router
        self.updateEventPublisher = updateEventPublisher
        
        subscribeUpdates()
    }
}

// MARK: - WeatherMainPresenterProtocol

extension WeatherMainPresenter: WeatherMainPresenterProtocol {
    var weatherCities: AnyPublisher<[WeatherMainItem], Never> {
        weatherCitiesSubject.eraseToAnyPublisher()
    }
    
    func onEvent(_ event: WeatherMainViewEvent) {
        eventListenerSubject.send(event)
    }
}

// MARK: - Private methods

private extension WeatherMainPresenter {
    func subscribeUpdates() {
        
        // Обработка сценария после загрузки вью
        eventListenerSubject
            .filter {
                $0.equals == .viewLoaded
            }
            .flatMap { [interactor] _ in
                interactor.fetchWeatherDataForSavedCities()
            }
            .sink { _ in
            } receiveValue: { _ in }
            .store(in: &cancellable)
        
        // Обработка нажатия на ячейку
        eventListenerSubject
            .compactMap {
                $0.needOpenDetails
            }
            .map { [interactor] cityName in
                interactor.citiesData.first().map { ($0, cityName) }
            }
            .switchToLatest()
            .receive(on: DispatchQueue.main)
            .sink { [router] citiesData, cityName in
                if let city = citiesData.first(where: { $0.name == cityName }) {
                    router.openWeatherDetails(city)
                }
            }
            .store(in: &cancellable)
        
        // Обработка нажатия на Добавить город
        eventListenerSubject
            .filter {
                $0.equals == .tappedAddCity
            }
            .receive(on: DispatchQueue.main)
            .sink { [router] _ in
                router.openWeatherSearch()
            }
            .store(in: &cancellable)
        
        // Обработка удаления ячейки
        eventListenerSubject
            .compactMap {
                $0.needDelete
            }
            .flatMap { [interactor] cityName in
                interactor.needDeleteCity(cityName)
            }
            .sink { _ in
            } receiveValue: { _ in }
            .store(in: &cancellable)
        
        // Маппинг данных для таблицы
        interactor.citiesData
            .map { cities -> [WeatherMainItem] in
                cities.map { city -> WeatherMainItem in
                    .weatherCity(model: .init(cityName: city.name, temperature: "\(city.temp) °C"))
                }
            }
            .sink { [weatherCitiesSubject] value in
                weatherCitiesSubject.send(value)
            }
            .store(in: &cancellable)
        
        // Посылаем запрос на обновление данных
        updateEventPublisher
            .filter {
                $0 == .needUpdateMainScreen
            }
            .flatMap { [interactor] _ in
                interactor.fetchWeatherDataForSavedCities()
            }
            .sink { _ in
            } receiveValue: { _ in }
            .store(in: &cancellable)
    }
}
