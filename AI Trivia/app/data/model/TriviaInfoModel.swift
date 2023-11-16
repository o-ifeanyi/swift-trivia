//
//  TriviaInfoModel.swift
//  AI Trivia
//
//  Created by Ifeanyi Onuoha on 25/10/2023.
//

import Foundation

struct TriviaInfoModel: Codable {
    var amount: String? = nil
    var category: TriviaCategory? = nil
    var type: TriviaType? = nil
    var difficulty: String? = nil
    
    func validate() -> Bool {
        return amount != nil && category != nil && type != nil && difficulty != nil
    }
}

