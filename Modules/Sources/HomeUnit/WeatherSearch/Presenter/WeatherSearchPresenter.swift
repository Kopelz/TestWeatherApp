//
//  WeatherSearchPresenter.swift
//  Modules
//
//  Created by Nikita Gavrilov on 21.09.2024.
//

import Foundation
import Combine
import Dispatch

final class WeatherSearchPresenter {
    
    // MARK: Properties
    
    private var interactor: WeatherSearchInteractorProtocol
    private var router: WeatherSearchRouterProtocol
    private var updateEventPublisher: AnyPublisher<HomeUnitEvent, Never>
    
    private let eventListenerSubject = PassthroughSubject<WeatherSearchViewEvent, Never>()
    private let searchSuggestSubject = CurrentValueSubject<[WeatherSearchItem], Never>([])
    
    private var cancellable = Set<AnyCancellable>()
    
    // MARK: Init
    
    init(
        interactor: WeatherSearchInteractorProtocol,
        router: WeatherSearchRouterProtocol,
        updateEventPublisher: AnyPublisher<HomeUnitEvent, Never>
    ) {
        self.interactor = interactor
        self.router = router
        self.updateEventPublisher = updateEventPublisher
        
        subscribeUpdates()
    }
}

// MARK: - WeatherSearchPresenterProtocol

extension WeatherSearchPresenter: WeatherSearchPresenterProtocol {
    var searchSuggest: AnyPublisher<[WeatherSearchItem], Never> {
        searchSuggestSubject.eraseToAnyPublisher()
    }
    
    
    func onEvent(_ event: WeatherSearchViewEvent) {
        eventListenerSubject.send(event)
    }
}

// MARK: - Private methods

private extension WeatherSearchPresenter {
    func subscribeUpdates() {
        
        let interactor = self.interactor
        
        // Обработка обновления текста из поисковой строки
        eventListenerSubject
            .compactMap {
                $0.searchTextChanged
            }
            .removeDuplicates()
            .map { [interactor] text in
                interactor.geocode(from: text)
            }
            .sink(receiveCompletion: { _ in
            }, receiveValue: { _ in })
            .store(in: &cancellable)
        
        // Маппинг городов в вью модель
        interactor.cityData
            .map { cities -> [WeatherSearchItem] in
                cities.map { city -> WeatherSearchItem in
                        .city(model: .init(cityName: city.name))
                }
            }
            .sink { [searchSuggestSubject] value in
                searchSuggestSubject.send(value)
            }
            .store(in: &cancellable)
        
        // Был выбран магазин
        let selectedSuggestCityShared = eventListenerSubject
            .compactMap {
                $0.selectedSuggestCity
            }
            .share()
        
        // Отправляем запрос на запись магазина в БД
        selectedSuggestCityShared
            .map { [interactor] name in
                interactor.selectedCity(name)
            }
            .sink(receiveCompletion: { _ in
                
            }, receiveValue: { _ in })
            .store(in: &cancellable)
        
        // Уходим с экрана
        selectedSuggestCityShared
            .receive(on: DispatchQueue.main)
            .sink { [router] _ in
                router.dismissSearch()
            }
            .store(in: &cancellable)
    }
}
