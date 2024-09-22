//
//  WeatherForecast.swift
//  Modules
//
//  Created by Nikita Gavrilov on 22.09.2024.
//

public struct WeatherForecast: Decodable {
    public let list: [WeatherForecastList]
}

public struct WeatherForecastList: Decodable {
    
    public let date: String
    public let main: CurrentWeather
    
    enum CodingKeys: String, CodingKey {
        case date = "dt_txt"
        case main
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        date = try container.decode(String.self, forKey: .date)
        main = try container.decode(CurrentWeather.self, forKey: .main)
    }
}
