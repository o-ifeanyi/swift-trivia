//
//  AI_TriviaApp.swift
//  AI Trivia
//
//  Created by Ifeanyi Onuoha on 15/09/2023.
//

import SwiftUI

@main
struct AI_TriviaApp: App {
    
    init() {
        setupServiceContainer()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(Router())
                .environmentObject(TriviaViewModel())
                .environmentObject(SnackBarService.shared)
        }
    }
}

private extension AI_TriviaApp {
    
    func setupServiceContainer() {
        // Services
        ServiceContainer.register(type: URLSession.self, .shared)
        ServiceContainer.register(type: UserDefaults.self, .standard)
        ServiceContainer.register(type: NetworkService.self, NewtworkServiceImpl())
        
        // Repositories
        ServiceContainer.register(type: TriviaRepository.self, TriviaRepositoryImpl())
    }
}
