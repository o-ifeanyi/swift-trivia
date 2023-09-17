//
//  TriviaScreen.swift
//  AI Trivia
//
//  Created by Ifeanyi Onuoha on 15/09/2023.
//

import SwiftUI
import Foundation

enum Direction {
    case left, right
}

struct Card: Identifiable {
    let id: UUID = UUID()
    let index: Int
    let zindex: Int
    let direction: Direction
    let color: Color
}

struct TriviaScreen: View {
    @EnvironmentObject private var snackBarService: SnackBarService
    @State private var cards: [Card] = [
        Card(index: 0, zindex: 0, direction: .left, color: .green),
        Card(index: 1, zindex: 1, direction: .left, color: .brown),
        Card(index: 2, zindex: 2, direction: .left, color: .blue),
        Card(index: 3, zindex: 3, direction: .left, color: .red),
        Card(index: 4, zindex: 4, direction: .left, color: .indigo),
        Card(index: 5, zindex: 5, direction: .left, color: .orange),
    ]

    
    var body: some View {
        VStack {
            HStack(spacing: 20) {
                Text("Browse")
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
                CircleView()
                CircleView()
            }
            
            Spacer()
            
            ZStack(alignment: .center) {
                ForEach(cards.sorted(by: { first, second in
                    return first.zindex > second.zindex
                })) { card in
                    StackedCard(card: card) { swiped in
                        cards[swiped.index] = swiped
                        let right = cards.filter({ $0.direction == .right })
                        let left = cards.filter({ $0.direction == .left })
                        
                        if (swiped.direction == .right && !left.isEmpty) || (swiped.direction == .left && !right.isEmpty)  {
                            for i in cards.indices {
                                switch swiped.direction {
                                    
                                case .left:
                                    if right.contains(where: { $0.id == cards[i].id }) {
                                        cards[i] = Card(index: cards[i].index, zindex: cards[i].zindex - 1, direction: cards[i].direction, color: cards[i].color)
                                    } else {
                                        cards[i] = Card(index: cards[i].index, zindex: cards[i].zindex + 1, direction: cards[i].direction, color: cards[i].color)
                                    }
                                case .right:
                                    if left.contains(where: { $0.id == cards[i].id }) {
                                        cards[i] = Card(index: cards[i].index, zindex: cards[i].zindex - 1, direction: cards[i].direction, color: cards[i].color)
                                    } else {
                                        cards[i] = Card(index: cards[i].index, zindex: cards[i].zindex + 1, direction: cards[i].direction, color: cards[i].color)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .frame(width: 260, height: 330)
            
            Spacer()
            
            HStack {
                CircleView()
                Spacer()
                CircleView()
                Spacer()
                CircleView()
                Spacer()
                CircleView()
            }
            .padding(.horizontal, 20)
        }
        .padding()
    }
}

struct StackedCard: View {
    let card: Card
    let updateIndex: (Card) -> Void
    @State private var flipped: Bool = false
    @State private var height: Double = 330
    @State private var width: Double = 260
    @State private var flippedHeight: Double = UIScreen.screenHeight * 0.7
    @State private var flippedWidth: Double = UIScreen.screenWidth
    @State private var offset: CGSize = .zero
    
    var body: some View {
        let i = card.zindex
        let isLeft = card.direction == .left
        
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .stroke(lineWidth: 0.5)
                
                
                
            if flipped {
                Text("Back")
                    .font(.title)
                    .fontWeight(.bold)
                    .rotation3DEffect(Angle(degrees: 180), axis: (x: 0.0, y: 1.0, z: 0.0))
            } else {
                Text("Front")
                    .font(.title3)
                    .fontWeight(.bold)
            }
        }
        .background(card.color.cornerRadius(25))
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
                            if abs(offset.width) <= 150 {
                                offset = gesture.translation
                            }
                            if abs(offset.width) <= 50 {
                                height = 330 - abs(offset.width)
                                width = 260 - abs(offset.width)
                            }
                        }
                    }
                }
                .onEnded { gesture in
                    if i == 0 && !flipped  {
                        let distance = gesture.translation.width
                        let direction = distance > 80 ? .right : distance < -80 ? .left : card.direction
                        withAnimation(.spring()) {
                            height = 330
                            width = 260
                            offset = .zero
                            if abs(distance) > 100 {
                                updateIndex(Card(index: card.index, zindex: card.zindex, direction: direction, color: card.color))
                            }
                        }
                    }
                }
        )
        .animation(.spring(), value: offset)
    }
}

struct CircleView: View {
    var body: some View {
        Circle()
            .frame(width: 20, height: 20)
            .foregroundColor(Theme.primary)
    }
}

struct TriviaScreen_Previews: PreviewProvider {
    static var previews: some View {
        TriviaScreen()
            .environmentObject(SnackBarService())
    }
}
