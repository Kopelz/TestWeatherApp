//
//  BaseCoordinatorFactory.swift
//  GavrilovWeatherApp
//
//  Created by Nikita Gavrilov on 21.09.2024.
//

import UIKit

final class BaseCoordinatorFactory {
    
    // MARK: Properties
    
    private let layerProvider: LayerProviderProtocol
    var router: RouterProtocol
    
    // MARK: Init
    
    init(
        router: RouterProtocol,
        layerProvider: LayerProviderProtocol
    ) {
        self.router = router
        self.layerProvider = layerProvider
    }
}

// MARK: - BaseCoordinatorFactoryProtocol

extension BaseCoordinatorFactory: BaseCoordinatorFactoryProtocol {
    func makeHomeCoordinator() -> BaseCoordinatorProtocol {
        HomeCoordinator(
            router: router,
            homeUnitFactory: HomeUnitFactory(layerProvider: layerProvider)
        )
    }
}
