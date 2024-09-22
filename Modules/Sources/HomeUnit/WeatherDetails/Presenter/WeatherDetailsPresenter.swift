//
//  WeatherDetailsPresenter.swift
//  Modules
//
//  Created by Nikita Gavrilov on 21.09.2024.
//

import Combine
import Dispatch

final class WeatherDetailsPresenter {
    
    // MARK: Properties
    
    private var interactor: WeatherDetailsInteractorProtocol
    private var router: WeatherDetailsRouterProtocol
    
    private let eventListenerSubject = PassthroughSubject<WeatherDetailsViewEvent, Never>()
    private let weatherForecastSubject = CurrentValueSubject<[WeatherDetailsItem], Never>([])
    private let cityNameSubject = CurrentValueSubject<String, Never>(.init())
    
    private var cancellable = Set<AnyCancellable>()
    
    // MARK: Init
    
    init(
        interactor: WeatherDetailsInteractorProtocol,
        router: WeatherDetailsRouterProtocol
    ) {
        self.interactor = interactor
        self.router = router
        
        subscribeUpdates()
    }
}

// MARK: - WeatherDetailsPresenterProtocol

extension WeatherDetailsPresenter: WeatherDetailsPresenterProtocol {
    var weatherForecast: AnyPublisher<[WeatherDetailsItem], Never> {
        weatherForecastSubject.eraseToAnyPublisher()
    }
    
    var cityName: AnyPublisher<String, Never> {
        cityNameSubject.eraseToAnyPublisher()
    }
    
    func onEvent(_ event: WeatherDetailsViewEvent) {
        eventListenerSubject.send(event)
    }
}

// MARK: - Private methods

private extension WeatherDetailsPresenter {
    func subscribeUpdates() {
        let interactor = self.interactor
        
        // Отправляем запрос на загрузку прогноза погоды
        eventListenerSubject
            .filter {
                $0 == .viewLoaded
            }
            .map { [interactor] _ in
                interactor.getForecast()
            }
            .sink(receiveCompletion: { _ in
            }, receiveValue: { _ in })
            .store(in: &cancellable)
        
        // Получаем прогноз погоды
        let cityForecastShared = interactor.cityForecast.share()
        
        // Маппинг для таблицы
        cityForecastShared
            .map { cityForecast -> [WeatherDetailsItem] in
                cityForecast.daysTemperature.map { day -> WeatherDetailsItem in
                    return .dayDate(model: .init(dayDate: day.date, temperature: "\(day.temperature) °C"))
                }
            }
            .sink { [weatherForecastSubject] value in
                weatherForecastSubject.send(value)
            }
            .store(in: &cancellable)
        
        // Маппинг для заголовка 
        cityForecastShared
            .map { cityForecast -> String in
                cityForecast.name
            }
            .sink { [cityNameSubject] value in
                cityNameSubject.send(value)
            }
            .store(in: &cancellable)
    }
}
