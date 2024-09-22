//
//  HomeCoordinator.swift
//  GavrilovWeatherApp
//
//  Created by Nikita Gavrilov on 21.09.2024.
//

import HomeUnit
import Combine

final class HomeCoordinator: BaseCoordinatorProtocol {
    var router: RouterProtocol
    var homeUnitFactory: HomeUnitFactoryProtocol
    
    private let updateHomeUnitsSubject = PassthroughSubject<HomeUnitEvent, Never>()
    
    init(router: RouterProtocol, homeUnitFactory: HomeUnitFactoryProtocol) {
        self.router = router
        self.homeUnitFactory = homeUnitFactory
    }
    
    func start() {
        let unit = homeUnitFactory.makeWeatherMainUnit(output: self, updateEventPublisher: updateHomeUnitsSubject.eraseToAnyPublisher())
        router.present(unit)
    }
}

// MARK: - WeatherMainUnitOutput

extension HomeCoordinator: WeatherMainUnitOutput {
    func openWeatherDetails(_ city: CityData) {
        let unit = homeUnitFactory.makeWeatherDetailsUnit(output: self, cityData: city)
        router.present(unit)
    }
    
    func openWeatherSearch() {
        let unit = homeUnitFactory.makeWeatherSearchUnit(output: self, updateEventPublisher: updateHomeUnitsSubject.eraseToAnyPublisher())
        router.present(unit)
    }
}

// MARK: - WeatherSearchUnitOutput

extension HomeCoordinator: WeatherSearchUnitOutput {
    func dismissSearch() {
        updateHomeUnitsSubject.send(.needUpdateMainScreen)
        router.dismissLastPresented()
    }
}

// MARK: - WeatherDetailsUnitOutput

extension HomeCoordinator: WeatherDetailsUnitOutput {}
