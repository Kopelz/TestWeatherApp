//
//  APIKey.swift
//  Modules
//
//  Created by Nikita Gavrilov on 21.09.2024.
//

public enum APIKey {
    case weather
}

extension APIKey {
    var stringValue: String {
        switch self {
        case .weather:
            return "WeatherAPIKey"
        }
    }
}
