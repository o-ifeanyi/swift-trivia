//
//  Debouncer.swift
//  AI Trivia
//
//  Created by Ifeanyi Onuoha on 15/09/2023.
//

import Foundation

final class Debouncer {
    
    private let delay: TimeInterval
    
    private var timer: Timer?
    
    init(delay: TimeInterval) {
        self.delay = delay
    }
    
    func call(function: @escaping () -> Void) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: delay, repeats: false, block: { timer in
            guard timer.isValid else {
                return
            }
            
            function()
        })
    }
}
