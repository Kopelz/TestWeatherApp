//
//  HomeUnitConfiguration.swift
//  Modules
//
//  Created by Nikita Gavrilov on 21.09.2024.
//

import UIKit

public protocol HomeUnitConfigurationProtocol {
    func createWeatherMainConfigurator() throws -> HomeUnitConfiguratorProtocol
    func createWeatherSearchConfigurator() throws -> HomeUnitConfiguratorProtocol
    func createWeatherDetailsConfigurator() throws -> HomeUnitConfiguratorProtocol
}

public protocol HomeUnitConfiguratorProtocol {
    func configureController() -> UIViewController
}
