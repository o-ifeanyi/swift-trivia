//
//  Endpoint.swift
//  AI Trivia
//
//  Created by Ifeanyi Onuoha on 15/09/2023.
//

import SwiftUI

enum Endpoint {
    case trivia(data: TriviaInfoModel)
}

extension Endpoint {
    var path: String {
        switch self {
        case .trivia:
            return "/api.php"
        }
    }
    
    var queryItems: [String: String] {
        switch self {
        case .trivia(let data):
            return [
                "amount": data.amount ?? "",
                "category": "\(data.category!.id)",
                "difficulty": data.difficulty!.lowercased(),
                "type": data.type!.id,
            ]
        }
    }
}

extension Endpoint {
    enum MethodType {
        case get
        case post(data: Encodable?)
    }
}


extension Endpoint {
    var url: URL? {
        var urlComponent = URLComponents()
        urlComponent.scheme = "https"
        urlComponent.host = "opentdb.com"
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
        case .trivia:
            return .get
        }
    }
    
    var request: URLRequest {
        var request: URLRequest
        
        request = URLRequest(url: url!)
        request.timeoutInterval = 20.0
        
        switch type {
            
        case .get:
            request.httpMethod = "GET"
        case .post(let data):
            request.httpMethod = "POST"
            if let data = data {
                request.httpBody = try? JSONMapper.encode(data)
                return request
            }
        }
        
        return request
    }
}
