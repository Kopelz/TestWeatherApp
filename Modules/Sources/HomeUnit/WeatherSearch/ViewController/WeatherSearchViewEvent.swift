//
//  WeatherSearchViewEvent.swift
//  Modules
//
//  Created by Nikita Gavrilov on 21.09.2024.
//

enum WeatherSearchViewEvent: Equatable {
    case selectedSuggestCity(_ id: String)
    case searchTextChanged(_ text: String)
}

extension WeatherSearchViewEvent {
    var selectedSuggestCity: String? {
        switch self {
        case let .selectedSuggestCity(value):
            return value
        default:
            return nil
        }
    }
    
    var searchTextChanged: String? {
        switch self {
        case let .searchTextChanged(value):
            return value
        default:
            return nil
        }
    }
}
