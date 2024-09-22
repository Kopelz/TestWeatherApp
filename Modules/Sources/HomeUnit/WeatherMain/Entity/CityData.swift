//
//  CityData.swift
//  Modules
//
//  Created by Nikita Gavrilov on 22.09.2024.
//

public struct CityData {
    let name: String
    let lat: Double
    let lon: Double
    let temp: Double
    
    init(
        name: String = .init(),
        lat: Double = .init(),
        lon: Double = .init(),
        temp: Double = .init()
    ) {
        self.name = name
        self.lat = lat
        self.lon = lon
        self.temp = temp
    }
}
