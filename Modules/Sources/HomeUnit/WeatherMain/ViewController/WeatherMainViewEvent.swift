//
//  WeatherMainViewEvent.swift
//  Modules
//
//  Created by Nikita Gavrilov on 21.09.2024.
//

enum WeatherMainViewEvent {
    case viewLoaded
    case tappedAddCity
    case needOpenDetails(city: String)
    case needDelete(city: String)
}

extension WeatherMainViewEvent {
    enum Equals {
        case viewLoaded
        case tappedAddCity
    }
    
    var equals: Equals? {
        switch self {
        case .tappedAddCity:
            return .tappedAddCity
        case .viewLoaded:
            return .viewLoaded
        default:
            return nil
        }
    }
    
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
