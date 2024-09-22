//
//  WeatherSearchDataSource.swift
//  Modules
//
//  Created by Nikita Gavrilov on 21.09.2024.
//

import UIKit

enum WeatherSearchItem {
    case city(model: SuggestCityTableViewModel)
}

enum WeatherSearchSection {
    case cities
}

// MARK: - Hashable

extension WeatherSearchItem: Hashable {
    
    private struct Itentifier: Hashable {
        let hashable: AnyHashable
    }
    
    private var itemId: any Hashable {
        switch self {
        case let .city(model):
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

extension WeatherSearchItem {
    var section: WeatherSearchSection {
        switch self {
        case .city:
            return .cities
        }
    }
}
