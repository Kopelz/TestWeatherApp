//
//  WeatherMainViewEvent.swift
//  Modules
//
//  Created by Nikita Gavrilov on 21.09.2024.
//

enum WeatherMainViewEvent: Equatable {
    case viewLoaded
    case tappedAddCity
    case needOpenDetails(city: String)
    case needDelete(city: String)
}

extension WeatherMainViewEvent {
    var needOpenDetails: String? {
        switch self {
        case let .needOpenDetails(value):
            return value
        default:
            return nil
        }
    }
    
    var needDelete: String? {
        switch self {
        case let .needDelete(value):
            return value
        default:
            return nil
        }
    }
}
