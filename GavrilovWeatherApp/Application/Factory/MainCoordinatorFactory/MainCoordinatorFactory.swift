//
//  MainCoordinatorFactory.swift
//  GavrilovWeatherApp
//
//  Created by Nikita Gavrilov on 21.09.2024.
//

import UIKit

final class MainCoordinatorFactory {
    private let navigationViewController = UINavigationController()
    
    private lazy var router = Router(navigationController: navigationViewController)
    private var layerProvider: LayerProviderProtocol = LayerProvider()
}

// MARK: - MainCoordinatorFactoryProtocol

extension MainCoordinatorFactory: MainCoordinatorFactoryProtocol {
    func makeMainCoordinator() -> (coordinator: MainCoordinatorProtocol, view: PresentableProtocol) {

        let coordinator = MainCoordinator(
            router: router,
            baseCoordinatorFactory: BaseCoordinatorFactory(router: router,
                                                           layerProvider: layerProvider)
        )
        
        return (coordinator, navigationViewController)
    }
}
