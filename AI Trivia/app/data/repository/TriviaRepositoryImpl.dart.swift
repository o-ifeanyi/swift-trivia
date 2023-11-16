//
//  TriviaRepositoryImpl.dart.swift
//  AI Trivia
//
//  Created by Ifeanyi Onuoha on 29/10/2023.
//

import Foundation

struct TriviaResponse: Decodable {
    let results: [TriviaQuestionModel]
}

class TriviaRepositoryImpl: TriviaRepository {
    @Service private var networkService: NetworkService
    
    func generateTrivia(info: TriviaInfoModel) async -> Result<TriviaModel, Error> {
        do {
            let (data, _) = try await networkService.request(.trivia(data: info))

            let response: TriviaResponse = try JSONMapper.decode(data)
            
            return .success(TriviaModel(questions: response.results, createdAt: Date.now, triviaInfo: info))
        } catch {
            print("fail \(error)")
            return .failure(error)
        }
    }
}
