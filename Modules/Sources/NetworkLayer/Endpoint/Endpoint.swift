//
//  Endpoint.swift
//  Modules
//
//  Created by Nikita Gavrilov on 21.09.2024.
//

import Foundation

protocol Endpoint {
    var scheme: String { get }
    var basePath: String { get }
    var path: String { get }
    var queryItems: [URLQueryItem] { get }
    var httpMethod: HTTPMethod { get }
    var apiKey: [String : APIKey]? { get }
}

extension Endpoint {
    var apiKey: [String : APIKey]? {
        nil
    }
    
    var scheme: String {
        "https"
    }
}
