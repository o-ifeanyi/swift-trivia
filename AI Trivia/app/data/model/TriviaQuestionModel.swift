//
//  TriviaQuestionModel.swift
//  AI Trivia
//
//  Created by Ifeanyi Onuoha on 25/10/2023.
//

import Foundation

enum Direction: Codable { case left, right }

struct TriviaQuestionModel: Codable, Identifiable {
    var id: UUID {
        return UUID()
    }
    
    let question: String
    let correctAnswer: String
    let incorrectAnswers: [String]
    let index: Int?
    let zIndex: Int?
    let direction: Direction?
    let selectedAnswer: String?
    
    var options: [String] {
        return (incorrectAnswers + [correctAnswer]).shuffled()
    }
    
    func copyWith(index: Int? = nil, zIndex: Int? = nil, direction: Direction? = nil) -> TriviaQuestionModel {
        TriviaQuestionModel(question: question, correctAnswer: correctAnswer, incorrectAnswers: incorrectAnswers, index: index ?? self.index, zIndex: zIndex ?? self.zIndex, direction: direction ?? self.direction, selectedAnswer: selectedAnswer)
    }
}
