//
//  ProjectApp.swift
//  Project
//
//  Created by Damian Myrda on 9/8/23.
//

import SwiftUI

enum Challenge: View {
    case StackViewChallenge
    case ShapeChallenge
    
    mutating func flip() {
        switch self {
        case .StackViewChallenge:
            self = .ShapeChallenge
        case .ShapeChallenge:
            self = .StackViewChallenge
        }
    }
    
    var body: some View {
        switch self {
        case .StackViewChallenge:
            Calculator()
        case .ShapeChallenge:
            Shapes()
        }
    }
}

@main
struct Project: App {
    @State var challenge: Challenge = .ShapeChallenge
    
    var body: some Scene {
        WindowGroup {
            self.challenge
            Button(action: {
                self.challenge.flip()
            }) {
                Text("Switch")
            }
        }
    }
}
