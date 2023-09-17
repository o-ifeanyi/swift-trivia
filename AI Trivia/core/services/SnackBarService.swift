//
//  SnackbarService.swift
//  AI Trivia
//
//  Created by Ifeanyi Onuoha on 15/09/2023.
//

import SwiftUI

struct SnackBarState: Identifiable, Equatable {
    static func == (lhs: SnackBarState, rhs: SnackBarState) -> Bool {
        lhs.id == rhs.id
    }
    
    let id = UUID()
    let messasge: String
    let isError: Bool
}

class SnackBarService: ObservableObject {
    static let shared = SnackBarService()
    
    @Published private (set) var snackBarState: SnackBarState?
    
    @MainActor
    func displayMessage(_ messasge: String, isError: Bool = true) {
        snackBarState = SnackBarState(messasge: messasge, isError: isError)
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0, execute: {
            withAnimation(.easeOut(duration: 0.3)) {
                self.snackBarState = nil
            }
        })
    }
}
