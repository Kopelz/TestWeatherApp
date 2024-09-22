//
//  MainCoordinatorProtocol.swift
//  GavrilovWeatherApp
//
//  Created by Nikita Gavrilov on 21.09.2024.
//

import UIKit

protocol MainCoordinatorProtocol: BaseCoordinatorProtocol {
    
    var childCoordinators: [BaseCoordinatorProtocol] { get set }
    
    func addDependency(_ coordinator: BaseCoordinatorProtocol)
    
    func removeDependency(_ coordinator: BaseCoordinatorProtocol?)
}
