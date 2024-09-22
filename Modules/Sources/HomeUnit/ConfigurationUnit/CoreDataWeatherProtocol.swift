//
//  CoreDataWeatherProtocol.swift
//  GavrilovWeatherApp
//
//  Created by Nikita Gavrilov on 22.09.2024.
//

public protocol CoreDataWeatherProtocol {
    func addCity(_ name: String, lat: Double, lon: Double)
    func fetchCities() -> [CitySaved]
    func deleteCity(_ name: String)
}
