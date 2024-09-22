//
//  BaseCoordinatorProtocol.swift
//  GavrilovWeatherApp
//
//  Created by Nikita Gavrilov on 21.09.2024.
//

protocol BaseCoordinatorProtocol: AnyObject {
    
    var router: RouterProtocol { get }
    
    func start()
}
