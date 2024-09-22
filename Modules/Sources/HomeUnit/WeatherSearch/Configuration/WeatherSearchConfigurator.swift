//
//  WeatherSearchConfigurator.swift
//  Modules
//
//  Created by Nikita Gavrilov on 21.09.2024.
//

import UIKit

struct WeatherSearchConfigurator: HomeUnitConfiguratorProtocol {
    let config: WeatherSearchDepsConfig
    
    func configureController() -> UIViewController {
        
        let interactor = WeatherSearchInteractor(state: WeatherSearchInteractor.State(),
                                                 networkManager: config.networkManager,
                                                 coreDataStorage: config.coreDataStorage)
        
        let router = WeatherSearchRouter(output: config.output)
        
        let presenter = WeatherSearchPresenter(interactor: interactor,
                                               router: router,
                                               updateEventPublisher: config.updateEventPublisher)
        
        let controller = WeatherSearchViewController(presenter: presenter)
        
        return controller
    }
}
