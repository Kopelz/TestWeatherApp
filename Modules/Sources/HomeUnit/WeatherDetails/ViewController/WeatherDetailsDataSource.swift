//
//  WeatherDetailsDataSource.swift
//  Modules
//
//  Created by Nikita Gavrilov on 21.09.2024.
//

enum WeatherDetailsItem {
    case dayDate(model: WeatherDayTableViewModel)
}

enum WeatherDetailsSection {
    case days
}

// MARK: - Hashable

extension WeatherDetailsItem: Hashable {
    
    private struct Itentifier: Hashable {
        let hashable: AnyHashable
    }
    
    private var itemId: any Hashable {
        switch self {
        case let .dayDate(model):
            return Itentifier(hashable: model.dayDate)
        }
    }
    
    func hash(into hasher: inout Hasher) {
        itemId.hash(into: &hasher)
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
}

extension WeatherDetailsItem {
    var section: WeatherDetailsSection {
        switch self {
        case .dayDate:
            return .days
        }
    }
}
