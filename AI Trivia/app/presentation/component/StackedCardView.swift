//
//  StackedCardView.swift
//  AI Trivia
//
//  Created by Ifeanyi Onuoha on 05/11/2023.
//

import SwiftUI

struct StackedCardView<Front: View, Back: View> : View {
    let question: TriviaQuestionModel
    let front: Front
    let back: Back
    let updateIndex: (TriviaQuestionModel) -> Void
    
    init(question: TriviaQuestionModel, @ViewBuilder front: () -> Front, @ViewBuilder back: () -> Back, updateIndex: @escaping (TriviaQuestionModel) -> Void) {
        self.question = question
        self.front = front()
        self.back = back()
        self.updateIndex = updateIndex
    }
    
    @State private var flipped: Bool = false
    @State private var height: Double = 330
    @State private var width: Double = 260
    @State private var flippedHeight: Double = UIScreen.screenHeight * 0.7
    @State private var flippedWidth: Double = UIScreen.screenWidth
    @State private var offset: CGSize = .zero
    
    var body: some View {
        let i = question.zIndex!
        let isLeft = question.direction == .left
        
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .stroke(lineWidth: 0.5)
                
            if flipped {
                back
                    .rotation3DEffect(Angle(degrees: 180), axis: (x: 0.0, y: 1.0, z: 0.0))
            } else {
                front
            }
        }
        .background(Theme.primary.cornerRadius(25))
        .frame(width: flipped ? flippedWidth : CGFloat(width - Double(i * 25)), height: flipped ? flippedHeight : CGFloat(height - Double(i * 25)))
        .rotation3DEffect(.degrees(flipped ? 180 : 0), axis: (x: 0, y: 1, z: 0))
        .offset(x: isLeft ? CGFloat(offset.width - Double(i * (32 - (i * 2)))) : CGFloat(offset.width + Double(i * (32 - (i * 2)))), y: 0)
        .rotationEffect(.degrees(isLeft ? Double(offset.width / 15) - Double(i * 3) : Double(offset.width / 15) + Double(i * 3)))
        .onTapGesture {
            if i == 0 {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.8, blendDuration: 0)) {
                    flipped.toggle()
                }
            }
        }
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    if i == 0 && !flipped {
                        withAnimation(.spring()) {
                            offset = gesture.translation
                            height = 330 - min(50, abs(offset.width))
                            width = 260 - min(50, abs(offset.width))
                        }
                    }
                }
                .onEnded { gesture in
                    if i == 0 && !flipped  {
                        let distance = gesture.translation.width
                        let direction = distance > 80 ? .right : distance < -80 ? .left : question.direction
                        withAnimation(.spring()) {
                            height = 330
                            width = 260
                            offset = .zero
                            if abs(distance) > 100 {
                                updateIndex(question.copyWith(direction: direction))
                            }
                        }
                    }
                }
        )
        .animation(.spring(), value: offset)
    }
}

