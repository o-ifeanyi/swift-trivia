//
//  ChoiceChip.swift
//  AI Trivia
//
//  Created by Ifeanyi Onuoha on 29/10/2023.
//

import SwiftUI
struct ChoiceChipView<T> : View where T: CustomStringConvertible, T: Hashable {
    let hearder: String
    let choice: T?
    let choices: [T]
    let onSelected: (T) -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(hearder)
                .font(.title3)
                .fontWeight(.semibold)
            WrappingHStack(horizontalSpacing: 10) {
                ForEach(choices, id: \.self) { item in
                    Button(item.description) {
                        onSelected(item)
                    }
                    .buttonStyle(ChipStyle(selected: item == choice))
                }
            }
        }
    }
}

struct ChipStyle: ButtonStyle {
    let selected: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            if selected {
                Symbols.check
                    .font(.caption2)
            }
            configuration.label
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 10)
        .background(selected ? Theme.tertiary : Theme.background)
        .foregroundStyle(selected ? Theme.onTertiary : Theme.onBackground)
        .cornerRadius(15)
        .scaleEffect(configuration.isPressed ? 0.9 : 1)
        .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

struct ChoiceChipView_Previews: PreviewProvider {
    static var previews: some View {
        ChoiceChipView(hearder: "Category", choice: nil, choices: kTriviaCategories, onSelected: { item in })
    }
}
