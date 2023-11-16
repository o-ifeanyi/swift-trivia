//
//  PreTriviaScreen.swift
//  AI Trivia
//
//  Created by Ifeanyi Onuoha on 25/10/2023.
//

import SwiftUI

struct PreTriviaScreen: View {
    @EnvironmentObject private var triviaViewModel: TriviaViewModel
    @EnvironmentObject private var snackBarService: SnackBarService
    @EnvironmentObject private var router: Router
    @State private var triviaInfo: TriviaInfoModel = TriviaInfoModel()
    var body: some View {
        let state = triviaViewModel.triviaState.state
        VStack {
            ScrollView {
                VStack(spacing: 15) {
                    ChoiceChipView(hearder: "Number of questions", choice: triviaInfo.amount, choices: kAmountOptions) { item in
                        triviaInfo.amount = item
                    }
                    ChoiceChipView(hearder: "Difficulty", choice: triviaInfo.difficulty, choices: kDifficultyOptions) { item in
                        triviaInfo.difficulty = item
                    }
                    ChoiceChipView(hearder: "Type", choice: triviaInfo.type, choices: kTriviaTypes) { item in
                        triviaInfo.type = item
                    }
                    ChoiceChipView(hearder: "Category", choice: triviaInfo.category, choices: kTriviaCategories) { item in
                        triviaInfo.category = item
                    }
                }
                .padding()
            }
            if state == .fetchingTrivia {
                ProgressView()
            } else {
                Button("Continue") {
                    Task {
                        let isValid = triviaInfo.validate()
                        if !isValid {
                            snackBarService.displayMessage("Missing required fields")
                            return
                        }
                        await triviaViewModel.generateTrivia(triviaInfo) {
                            router.pushReplacement(.trivia)
                        }
                    }
                }
            }
        }
    }
}

struct PreTriviaScreen_Previews: PreviewProvider {
    static var previews: some View {
        PreTriviaScreen()
    }
}
