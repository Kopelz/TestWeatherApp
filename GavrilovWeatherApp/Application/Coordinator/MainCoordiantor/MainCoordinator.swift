//
//  MainCoordinator.swift
//  GavrilovWeatherApp
//
//  Created by Nikita Gavrilov on 21.09.2024.
//

final class MainCoordinator {
    
    var router: RouterProtocol
    var baseCoordinatorFactory: BaseCoordinatorFactoryProtocol
    
    var childCoordinators: [BaseCoordinatorProtocol] = []
    
    init(router: RouterProtocol, baseCoordinatorFactory: BaseCoordinatorFactoryProtocol) {
        self.router = router
        self.baseCoordinatorFactory = baseCoordinatorFactory
    }
}

// MARK: - MainCoordinatorProtocol
    
extension MainCoordinator: MainCoordinatorProtocol {
    
    func start() {
        let homeCoordinator = baseCoordinatorFactory.makeHomeCoordinator()
        addDependency(homeCoordinator)
        homeCoordinator.start()
    }
    
    func addDependency(_ coordinator: BaseCoordinatorProtocol) {
        guard !childCoordinators.contains(where: { $0 === coordinator }) else { return }
        childCoordinators.append(coordinator)
    }
    
    func removeDependency(_ coordinator: BaseCoordinatorProtocol?) {
        childCoordinators.removeAll { $0 === coordinator }
    }
}
