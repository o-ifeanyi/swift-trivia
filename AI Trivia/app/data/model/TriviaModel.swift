//
//  TriviaModel.swift
//  AI Trivia
//
//  Created by Ifeanyi Onuoha on 25/10/2023.
//

import Foundation

struct TriviaModel: Codable {
    let questions: [TriviaQuestionModel]
    let createdAt: Date?
    let triviaInfo: TriviaInfoModel?
}
