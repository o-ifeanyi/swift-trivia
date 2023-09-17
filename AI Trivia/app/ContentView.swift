//
//  ContentView.swift
//  AI Trivia
//
//  Created by Ifeanyi Onuoha on 15/09/2023.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var router: Router
    @EnvironmentObject private var snackBarService: SnackBarService
    var body: some View {
        ZStack(alignment: .bottom) {
            NavigationStack(path: $router.routes) {
                VStack {
                    Button("Start Trivia") {
                        router.push(.trivia)
                    }
                }
                .padding()
                .navigationDestination(for: Route.self, destination: { $0 })
            }
        }
        .overlay(alignment: .top) {
            if (snackBarService.snackBarState != nil) {
                let state = snackBarService.snackBarState!
                SnackBarView(text: state.messasge, isError: state.isError)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(Router())
            .environmentObject(SnackBarService())
    }
}
