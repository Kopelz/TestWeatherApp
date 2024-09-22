//
//  Router.swift
//  GavrilovWeatherApp
//
//  Created by Nikita Gavrilov on 21.09.2024.
//

import UIKit

final class Router {
    private weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
}

// MARK: - RouterProtocol

extension Router: RouterProtocol {
    func present(_ module: PresentableProtocol) {
        guard let viewController = module.toPresent() else { return }
        
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func dismissLastPresented() {
        guard !(navigationController?.viewControllers.isEmpty ?? true) else { return }
        
        navigationController?.popViewController(animated: true)
    }
}
