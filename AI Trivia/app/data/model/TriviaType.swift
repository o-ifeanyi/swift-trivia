//
//  TriviaType.swift
//  AI Trivia
//
//  Created by Ifeanyi Onuoha on 29/10/2023.
//

import Foundation

struct TriviaType: Codable, Hashable, CustomStringConvertible {
    var description: String {
        return value
    }
    
    let id: String
    let value: String
}
