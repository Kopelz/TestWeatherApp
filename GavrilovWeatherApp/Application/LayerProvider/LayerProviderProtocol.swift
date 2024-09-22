//
//  LayerProviderProtocol.swift
//  GavrilovWeatherApp
//
//  Created by Nikita Gavrilov on 21.09.2024.
//

import NetworkLayer

protocol LayerProviderProtocol {
    var networkManager: NetworkManagerProtocol { get set }
    var coreDataManager: CoreDataManagerProtocol { get set }
}
