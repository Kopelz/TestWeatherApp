//
//  WeatherDetailsRouter.swift
//  Modules
//
//  Created by Nikita Gavrilov on 21.09.2024.
//

final class WeatherDetailsRouter {
    
    // MARK: Properties
    
    let output: WeatherDetailsUnitOutput
    
    // MARK: Init
    
    init(output: WeatherDetailsUnitOutput) {
        self.output = output
    }
}

// MARK: - WeatherDetailsRouterProtocol

extension WeatherDetailsRouter: WeatherDetailsRouterProtocol {

}
