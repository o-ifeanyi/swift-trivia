//
//  Router.swift
//  AI Trivia
//
//  Created by Ifeanyi Onuoha on 15/09/2023.
//

import SwiftUI

final class Router: ObservableObject {
    @Published var routes = [Route]()
    
    func push(_ screen: Route) {
        routes.append(screen)
    }
    
    func pushReplacement(_ screen: Route) {
        if routes.isEmpty {
            routes.append(screen)
        } else {
            routes[routes.count - 1] = screen
        }
    }
    
    func pop() {
        routes.removeLast()
    }
    
    func popUntil(predicate: (Route) -> Bool) {
        if let last = routes.popLast() {
            guard predicate(last) else {
                popUntil(predicate: predicate)
                return
            }
        }
    }
    
    func reset() {
        routes = []
    }
}
