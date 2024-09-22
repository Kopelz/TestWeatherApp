//
//  HomeUnitDepsConfig.swift
//  Modules
//
//  Created by Nikita Gavrilov on 21.09.2024.
//

public protocol HomeUnitDepsConfig {}

public final class HomeUnitConfiguration: HomeUnitConfigurationProtocol {
    let config: HomeUnitDepsConfig
    
    public init(config: HomeUnitDepsConfig) {
        self.config = config
    }
    
    public func createWeatherMainConfigurator() throws -> HomeUnitConfiguratorProtocol {
        guard let mainConfig = config as? WeatherMainDepsConfig else {
            throw HomeUnitError.invalidConfig
        }
        return WeatherMainConfigurator(config: mainConfig)
    }
    
    public func createWeatherSearchConfigurator() throws -> HomeUnitConfiguratorProtocol {
        guard let mainConfig = config as? WeatherSearchDepsConfig else {
            throw HomeUnitError.invalidConfig
        }
        return WeatherSearchConfigurator(config: mainConfig)
    }
    
    public func createWeatherDetailsConfigurator() throws -> HomeUnitConfiguratorProtocol {
        guard let mainConfig = config as? WeatherDetailsDepsConfig else {
            throw HomeUnitError.invalidConfig
        }
        return WeatherDetailsConfigurator(config: mainConfig)
    }
}

enum HomeUnitError: Error {
    case invalidConfig
}
