//
//  WeatherMainRouter.swift
//  Modules
//
//  Created by Nikita Gavrilov on 21.09.2024.
//

final class WeatherMainRouter {
    
    // MARK: Properties
    
    let output: WeatherMainUnitOutput
    
    // MARK: Init
    
    init(output: WeatherMainUnitOutput) {
        self.output = output
    }
}

// MARK: - WeatherMainRouterProtocol

extension WeatherMainRouter: WeatherMainRouterProtocol {
    func openWeatherDetails(_ city: CityData) {
        output.openWeatherDetails(city)
    }
    
    func openWeatherSearch() {
        output.openWeatherSearch()
    }
}
