//
//  LayerProvider.swift
//  GavrilovWeatherApp
//
//  Created by Nikita Gavrilov on 21.09.2024.
//

import NetworkLayer
import HomeUnit

typealias NetworkManagerProtocol = NetworkWeatherProtocol
typealias CoreDataManagerProtocol = CoreDataWeatherProtocol

final class LayerProvider: LayerProviderProtocol {
    
    var networkManager: NetworkManagerProtocol = NetworkManager()
    
    var coreDataManager: CoreDataManagerProtocol = CoreDataManager()
}
