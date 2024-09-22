//
//  WeatherMainDepsConfig.swift
//  Modules
//
//  Created by Nikita Gavrilov on 21.09.2024.
//

import NetworkLayer
import Combine

public struct WeatherSearchDepsConfig: HomeUnitDepsConfig {
    let output: WeatherSearchUnitOutput
    let networkManager: NetworkWeatherProtocol
    let coreDataStorage: CoreDataWeatherProtocol
    let updateEventPublisher: AnyPublisher<HomeUnitEvent, Never>
    
    public init(
        output: WeatherSearchUnitOutput,
        networkManager: NetworkWeatherProtocol,
        coreDataStorage: CoreDataWeatherProtocol,
        updateEventPublisher: AnyPublisher<HomeUnitEvent, Never>
    ) {
        self.output = output
        self.networkManager = networkManager
        self.coreDataStorage = coreDataStorage
        self.updateEventPublisher = updateEventPublisher
    }
}
