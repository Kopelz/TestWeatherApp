//
//  MainCoordinatorFactoryProtocol.swift
//  GavrilovWeatherApp
//
//  Created by Nikita Gavrilov on 21.09.2024.
//

protocol MainCoordinatorFactoryProtocol {
    func makeMainCoordinator() -> (coordinator: MainCoordinatorProtocol, view: PresentableProtocol)
}
