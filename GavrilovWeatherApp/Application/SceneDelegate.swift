//
//  SceneDelegate.swift
//  GavrilovWeatherApp
//
//  Created by Nikita Gavrilov on 21.09.2024.
//

import UIKit

class SceneDelegate: UIResponder {
    private let mainFactory: MainCoordinatorFactoryProtocol = MainCoordinatorFactory()
    private var mainCoordinator: MainCoordinatorProtocol?
    
    var window: UIWindow?
}

// MARK: - UIWindowSceneDelegate

extension SceneDelegate: UIWindowSceneDelegate {
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let main = mainFactory.makeMainCoordinator()
        mainCoordinator = main.coordinator
        
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = main.view.toPresent()
        window.makeKeyAndVisible()
        self.window = window
        
        mainCoordinator?.start()
    }
}
