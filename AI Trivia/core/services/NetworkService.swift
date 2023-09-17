//
//  NetworkService.swift
//  AI Trivia
//
//  Created by Ifeanyi Onuoha on 15/09/2023.
//

import Foundation

protocol NetworkService {
    func request(_ endpoint: Endpoint) async throws -> (Data, URLResponse)
}
