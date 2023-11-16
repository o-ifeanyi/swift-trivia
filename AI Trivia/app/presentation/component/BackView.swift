//
//  BackView.swift
//  AI Trivia
//
//  Created by Ifeanyi Onuoha on 05/11/2023.
//

import SwiftUI

struct BackView: View {
    let question: TriviaQuestionModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 25) {
                Text(question.question)
                    .font(.title)
                    .foregroundColor(Theme.onPrimary)
                    .multilineTextAlignment(.leading)
                    .fontWeight(.bold)
                
                VStack {
                    ForEach(question.options, id: \.self) { option in
                        Button(option) {
                            
                        }
                        .buttonStyle(BackButtonStyle(selected: option == "True"))
                        .padding(.vertical, 4)
                    }
                }
                Spacer()
            }
            .padding()
        }
    }
}

struct BackButtonStyle: ButtonStyle {
    let selected: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            Spacer()
        }
        .padding(15)
        .background(selected ? Theme.tertiary : Theme.background)
        .foregroundStyle(selected ? Theme.onTertiary : Theme.onBackground)
        .cornerRadius(15)
        .scaleEffect(configuration.isPressed ? 0.9 : 1)
        .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

