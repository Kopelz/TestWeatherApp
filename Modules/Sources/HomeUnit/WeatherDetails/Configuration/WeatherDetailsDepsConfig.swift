//
//  WeatherDetailsDepsConfig.swift
//  Modules
//
//  Created by Nikita Gavrilov on 21.09.2024.
//

import NetworkLayer

public struct WeatherDetailsDepsConfig: HomeUnitDepsConfig {
    let output: WeatherDetailsUnitOutput
    let networkManager: NetworkWeatherProtocol
    let cityData: CityData
    
    public init(
        output: WeatherDetailsUnitOutput,
        networkManager: NetworkWeatherProtocol,
        cityData: CityData
    ) {
        self.output = output
        self.networkManager = networkManager
        self.cityData = cityData
    }
}
