//
//  WeatherMainConfigurator.swift
//  Modules
//
//  Created by Nikita Gavrilov on 21.09.2024.
//

import UIKit

struct WeatherMainConfigurator: HomeUnitConfiguratorProtocol {
    let config: WeatherMainDepsConfig
    
    func configureController() -> UIViewController {
        
        let interactor = WeatherMainInteractor(state: WeatherMainInteractor.State(),
                                               networkManager: config.networkManager,
                                               coreDataStorage: config.coreDataStorage)
        
        let router = WeatherMainRouter(output: config.output)
        
        let presenter = WeatherMainPresenter(interactor: interactor,
                                             router: router,
                                             updateEventPublisher: config.updateEventPublisher)
        
        let controller = WeatherMainViewController(presenter: presenter)
        
        return controller
    }
}
