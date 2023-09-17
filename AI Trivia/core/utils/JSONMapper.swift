//
//  JSONMapper.swift
//  AI Trivia
//
//  Created by Ifeanyi Onuoha on 15/09/2023.
//

import SwiftUI

struct JSONMapper {
    static func decode<T: Decodable>(_ data: Data) throws -> T {
        // 1. Create a decoder
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        // 2. Create a property for the decoded data
        return try decoder.decode(T.self, from: data)
    }
    
    static func encode<T: Encodable>(_ data: T) throws -> Data {
        // 1. Create an encoder
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        
        // 2. Create a property for the encoded data
        return try encoder.encode(data)
    }
}
