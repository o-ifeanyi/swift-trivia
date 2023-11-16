//
//  TriviaScreen.swift
//  AI Trivia
//
//  Created by Ifeanyi Onuoha on 15/09/2023.
//

import SwiftUI
import Foundation


struct TriviaScreen: View {
    @EnvironmentObject private var triviaViewModel: TriviaViewModel
    @State private var questions: [TriviaQuestionModel] = []
    
    var body: some View {
        VStack {
            Spacer()
            
            ZStack(alignment: .center) {
                ForEach(questions.sorted(by: { first, second in
                    return first.zIndex! > second.zIndex!
                })) { question in
                    StackedCardView(
                        question: question,
                        front: {
                            Text("Front")
                                        .font(.title3)
                                        .fontWeight(.bold)
                                        .foregroundColor(Theme.onPrimary)
                        },
                        back: {
                            BackView(question: question)
                        }
                    ) { swiped in
                        questions[swiped.index!] = swiped
                        let right = questions.filter({ $0.direction == .right })
                        let left = questions.filter({ $0.direction == .left })

                        if (swiped.direction == .right && !left.isEmpty) || (swiped.direction == .left && !right.isEmpty)  {
                            for i in questions.indices {
                                switch swiped.direction {

                                case .left:
                                    if right.contains(where: { $0.index == questions[i].index }) {
                                        questions[i] = questions[i].copyWith(zIndex: questions[i].zIndex! - 1)
                                    } else {
                                        questions[i] = questions[i].copyWith(zIndex: questions[i].zIndex! + 1)
                                    }
                                case .right:
                                    if left.contains(where: { $0.index == questions[i].index }) {
                                        questions[i] = questions[i].copyWith(zIndex: questions[i].zIndex! - 1)
                                    } else {
                                        questions[i] = questions[i].copyWith(zIndex: questions[i].zIndex! + 1)
                                    }
                                case .none:
                                    return
                                }
                            }
                            print(questions)
                        }
                    }
                }
            }
            .frame(width: 260, height: 330)
            
            Spacer()
    
        }
        .padding()
        .onAppear {
            if let triviaQuestions = triviaViewModel.triviaState.trivia?.questions {
                for index in triviaQuestions.indices {
                    questions.append(triviaQuestions[index].copyWith(index: index, zIndex: index, direction: .left))
                }
            }
        }
    }
}
