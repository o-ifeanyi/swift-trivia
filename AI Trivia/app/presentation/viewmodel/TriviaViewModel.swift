//
//  TriviaViewModel.swift
//  AI Trivia
//
//  Created by Ifeanyi Onuoha on 29/10/2023.
//

import Foundation

enum TriviaLoadingState { case idle, fetchingTrivia }

struct TriviaState {
    var state: TriviaLoadingState = .idle
    var trivia: TriviaModel?
}

final class TriviaViewModel: ObservableObject {
    @Service private var triviaRepository: TriviaRepository
    private var snackBarService: SnackBarService
    
    @Published private(set) var triviaState = TriviaState()
    
    init(_ snackBarService: SnackBarService = .shared) {
        self.snackBarService = snackBarService
    }
    
    @MainActor
    func generateTrivia(_ info: TriviaInfoModel, onSucess: @escaping () -> Void) async {
        triviaState.state = .fetchingTrivia
        
        defer { triviaState.state = .idle }
        
        let res = await triviaRepository.generateTrivia(info: info)
        switch res {
        case .success(let trivia):
            triviaState.trivia = trivia
            onSucess()
        case .failure(let failure):
            snackBarService.displayMessage(failure.localizedDescription)
        }
    }
}
