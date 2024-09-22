//
//  WeatherMainDataSource.swift
//  Modules
//
//  Created by Nikita Gavrilov on 21.09.2024.
//

enum WeatherMainItem {
    case weatherCity(model: WeatherCityTableViewModel)
}

enum WeatherMainSection {
    case weatherCities
}

// MARK: - Hashable

extension WeatherMainItem: Hashable {
    
    private struct Itentifier: Hashable {
        let hashable: AnyHashable
    }
    
    private var itemId: any Hashable {
        switch self {
        case let .weatherCity(model):
            return Itentifier(hashable: model.cityName)
        }
    }
    
    func hash(into hasher: inout Hasher) {
        itemId.hash(into: &hasher)
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
}

extension WeatherMainItem {
    var section: WeatherMainSection {
        switch self {
        case .weatherCity:
            return .weatherCities
        }
    }
}
