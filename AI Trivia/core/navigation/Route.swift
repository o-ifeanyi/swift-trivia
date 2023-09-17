//
//  Route.swift
//  AI Trivia
//
//  Created by Ifeanyi Onuoha on 15/09/2023.
//

import SwiftUI

enum Route {
    case home
    case trivia
}

extension Route: View {
    var body: some View {
        switch self {
        case .home:
            ContentView()
        case .trivia:
            TriviaScreen()
        }
    }
}

extension Route: Hashable {
    static func == (lhs: Route, rhs: Route) -> Bool {
        return lhs.compareString == rhs.compareString
    }
    
    var compareString: String {
        switch self {
        case .home:
            return "home"
        case .trivia:
            return "trivia"
        }
    }
}
