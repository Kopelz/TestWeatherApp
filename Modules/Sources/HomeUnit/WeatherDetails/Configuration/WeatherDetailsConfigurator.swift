//
//  WeatherDetailsConfigurator.swift
//  Modules
//
//  Created by Nikita Gavrilov on 21.09.2024.
//

import UIKit

struct WeatherDetailsConfigurator: HomeUnitConfiguratorProtocol {
    let config: WeatherDetailsDepsConfig
    
    func configureController() -> UIViewController {
        
        let state = WeatherDetailsInteractor.State()
        state.cityData.send(config.cityData)
        
        let interactor = WeatherDetailsInteractor(state: state,
                                                  networkManager: config.networkManager)
        
        let router = WeatherDetailsRouter(output: config.output)
        
        let presenter = WeatherDetailsPresenter(interactor: interactor,
                                                router: router)
        
        let controller = WeatherDetailsViewController(presenter: presenter)
        
        return controller
    }
}
