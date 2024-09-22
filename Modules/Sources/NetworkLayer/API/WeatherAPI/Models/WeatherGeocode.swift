//
//  WeatherGeocode.swift
//  Modules
//
//  Created by Nikita Gavrilov on 21.09.2024.
//

public struct GeocodeCityData: Decodable {
    public let name: String
    public let lat: Double
    public let lon: Double
}
