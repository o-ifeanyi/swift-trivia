//
//  NewtworkServiceImpl.swift
//  AI Trivia
//
//  Created by Ifeanyi Onuoha on 15/09/2023.
//

import Foundation

final class NewtworkServiceImpl: NetworkService {
    @Service private var urlSession: URLSession
    
    func request(_ endpoint: Endpoint) async throws -> (Data, URLResponse) {
        let (data, response) =  try await urlSession.data(for: endpoint.request)
        
        print("\(endpoint.path) ==> \((response as? HTTPURLResponse)?.statusCode ?? -1)")
        print(String(decoding: data, as: UTF8.self))
        
        if let response = response as? HTTPURLResponse, (200...300) ~= response.statusCode {
            // do stuff
        }
        
        return (data, response)
    }
}
