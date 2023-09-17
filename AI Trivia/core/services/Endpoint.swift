//
//  Endpoint.swift
//  AI Trivia
//
//  Created by Ifeanyi Onuoha on 15/09/2023.
//

import SwiftUI

enum Endpoint {
    case trivia(data: Data)
}

extension Endpoint {
//    var host: String {
//        switch self {
//        case .token:
//            return "accounts.spotify.com"
//        default:
//            return "api.spotify.com"
//        }
//    }
    
    var path: String {
        switch self {
        case .trivia:
            return "/api/token"
        }
    }
    
    var queryItems: [String: String] {
        switch self {
        default:
            return [:]
        }
    }
}

extension Endpoint {
    enum MethodType {
        case get
        case post(data: Data?)
    }
}


extension Endpoint {
    var url: URL? {
        var urlComponent = URLComponents()
        urlComponent.scheme = "https"
        urlComponent.host = "api.spotify.com"
        urlComponent.path = path
        
        if !queryItems.isEmpty {
            urlComponent.queryItems = queryItems.compactMap { item in
                URLQueryItem(name: item.key, value: item.value)
            }
        }
        
        return urlComponent.url
    }
    
    var type: MethodType {
        switch self {
        case .trivia(let data):
            return .post(data: data)
        }
    }
    
    var request: URLRequest {
        var request: URLRequest
        
        request = URLRequest(url: url!)
        request.timeoutInterval = 20.0
        
        @Service var userDefaults: UserDefaults
        let token = userDefaults.string(forKey: Constants.token) ?? ""
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        
        
        switch type {
            
        case .get:
            request.httpMethod = "GET"
        case .post(let data):
            request.httpMethod = "POST"
            if let data = data {
                request.httpBody = data
                return request
            }
        }
        
        return request
    }
}
