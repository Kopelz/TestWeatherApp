//
//  CoreDataAdapter.swift
//  GavrilovWeatherApp
//
//  Created by Nikita Gavrilov on 22.09.2024.
//

import HomeUnit

extension WeatherCityCoreData: CitySaved {
    public var name: String {
        nameCity ?? .init()
    }
}
