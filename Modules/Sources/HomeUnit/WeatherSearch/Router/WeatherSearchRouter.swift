//
//  WeatherSearchRouter.swift
//  Modules
//
//  Created by Nikita Gavrilov on 21.09.2024.
//

final class WeatherSearchRouter {
    
    // MARK: Properties
    
    let output: WeatherSearchUnitOutput
    
    // MARK: Init
    
    init(output: WeatherSearchUnitOutput) {
        self.output = output
    }
}

// MARK: - WeatherSearchRouterProtocol

extension WeatherSearchRouter: WeatherSearchRouterProtocol {
    func dismissSearch() {
        output.dismissSearch()
    }
}
