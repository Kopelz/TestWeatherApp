//
//  NetworkManager.swift
//  Modules
//
//  Created by Nikita Gavrilov on 21.09.2024.
//

import Combine
import Foundation

public final class NetworkManager {
    public init() {}
}

// MARK: - Private methods

private extension NetworkManager {
    func getAPIKey(_ typeKey: APIKey) -> String? {
        if let path = Bundle.main.path(forResource: "Keys", ofType: "plist"),
           let dictionary = NSDictionary(contentsOfFile: path) as? [String: Any],
           let apiKey = dictionary[typeKey.stringValue] as? String {
            return apiKey
        }
        return nil
    }
    
    func perform<T: Decodable>(endPoint: Endpoint) -> AnyPublisher<T, Error> {
        var urlComponents = URLComponents()
        urlComponents.scheme = endPoint.scheme
        urlComponents.host = endPoint.basePath
        urlComponents.path = endPoint.path
        
        var queryItems = endPoint.queryItems
        
        if let endPointKey = endPoint.apiKey?.first,
           let apiKey = getAPIKey(endPointKey.value) {
            
            queryItems.append(.init(name: endPointKey.key, value: apiKey))
        }
        
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endPoint.httpMethod.rawValue

        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}

// MARK: - NetworkWeatherProtocol

extension NetworkManager: NetworkWeatherProtocol {
    public func geocode(from city: String) -> AnyPublisher<[GeocodeCityData], Error> {
        perform(endPoint: WeatherAPI.geocode(city: city)).eraseToAnyPublisher()
    }
    
    public func getWeather(lat: Double, lon: Double) -> AnyPublisher<WeatherCity, Error> {
        perform(endPoint: WeatherAPI.weather(latitude: lat, longitude: lon)).eraseToAnyPublisher()
    }
    
    public func getWeatherForecast(lat: Double, lon: Double) -> AnyPublisher<WeatherForecast, Error> {
        perform(endPoint: WeatherAPI.forecast(latitude: lat, longitude: lon)).eraseToAnyPublisher()
    }
}
