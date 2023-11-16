//
//  TriviaRepository.swift
//  AI Trivia
//
//  Created by Ifeanyi Onuoha on 29/10/2023.
//

import Foundation

protocol TriviaRepository {
    func generateTrivia(info: TriviaInfoModel) async -> Result<TriviaModel, Error>
}
