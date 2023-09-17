//
//  SnackbarView.swift
//  AI Trivia
//
//  Created by Ifeanyi Onuoha on 15/09/2023.
//

import SwiftUI

struct SnackBarView: View {
    @State private var isAnimating: Bool = false
    @State var text: String
    @State var isError: Bool = true
    
    var body: some View {
        HStack {
            Text(text)
                .foregroundColor(.white)
                .lineLimit(1...2)
                .multilineTextAlignment(.leading)
                .padding()
            
            Spacer()
        }
        .background(isError ? .red : .green)
        .cornerRadius(10)
        .padding()
        .opacity(isAnimating ? 1 : 0)
        .offset(y: isAnimating ? 20 : -20)
        .onAppear {
            withAnimation(.easeOut(duration: 0.3)) {
                isAnimating.toggle()
            }
        }
    }
}

struct SnackbarView_Previews: PreviewProvider {
    static var previews: some View {
        SnackBarView(text: "authViewModel.authState.gettingTokenErr more error becasue why not")
    }
}
