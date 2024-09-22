//
//  BaseCoordinatorFactoryProtocol.swift
//  GavrilovWeatherApp
//
//  Created by Nikita Gavrilov on 21.09.2024.
//

protocol BaseCoordinatorFactoryProtocol {
    var router: RouterProtocol { get }
    
    func makeHomeCoordinator() -> BaseCoordinatorProtocol
}
