//
//  HomeUnitFactory.swift
//  GavrilovWeatherApp
//
//  Created by Nikita Gavrilov on 21.09.2024.
//

import UIKit
import HomeUnit
import Combine

final class HomeUnitFactory {
    let layerProvider: LayerProviderProtocol
    
    init(layerProvider: LayerProviderProtocol) {
        self.layerProvider = layerProvider
    }
}

// MARK: - HomeUnitFactoryProtocol

extension HomeUnitFactory: HomeUnitFactoryProtocol {
    func makeWeatherMainUnit(
        output: WeatherMainUnitOutput,
        updateEventPublisher: AnyPublisher<HomeUnitEvent, Never>
    ) -> PresentableProtocol {
        let config = WeatherMainDepsConfig(output: output,
                                           networkManager: layerProvider.networkManager,
                                           coreDataStorage: layerProvider.coreDataManager,
                                           updateEventPublisher: updateEventPublisher)
        let configuration = HomeUnitConfiguration(config: config)
        let controller = try! configuration.createWeatherMainConfigurator().configureController()
        
        return controller
    }
    
    func makeWeatherSearchUnit(
        output: WeatherSearchUnitOutput,
        updateEventPublisher: AnyPublisher<HomeUnitEvent, Never>
    ) -> PresentableProtocol {
        let config = WeatherSearchDepsConfig(output: output,
                                             networkManager: layerProvider.networkManager,
                                             coreDataStorage: layerProvider.coreDataManager,
                                             updateEventPublisher: updateEventPublisher)
        let configuration = HomeUnitConfiguration(config: config)
        let controller = try! configuration.createWeatherSearchConfigurator().configureController()
        
        return controller
    }
    
    func makeWeatherDetailsUnit(
        output: WeatherDetailsUnitOutput,
        cityData: CityData
    ) -> PresentableProtocol {
        let config = WeatherDetailsDepsConfig(output: output,
                                              networkManager: layerProvider.networkManager,
                                              cityData: cityData
        )
        let configuration = HomeUnitConfiguration(config: config)
        let controller = try! configuration.createWeatherDetailsConfigurator().configureController()
        
        return controller
    }
}
