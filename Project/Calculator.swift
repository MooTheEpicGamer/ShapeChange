//
//  Calculator.swift
//  Project
//
//  Created by Damian Myrda on 9/8/23.
//

import SwiftUI

struct Display: View {
    var body: some View {
        HStack {
            Spacer()
            Text("0")
                .font(.system(size: 75, weight: .semibold))
                .foregroundColor(.white)
                .padding(17.5)
        }
    }
}

enum Action {
    case clear
    case negate
    case modulus
}

struct ActionButton: View {
    var action: Action
    
    init(action: Action) {
        self.action = action
    }
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(Color(UIColor.lightGray))
            Text({ () -> String in
                switch self.action {
                case .clear:
                    return "AC"
                case .negate:
                    return "+/-"
                case .modulus:
                    return "%"
                }
            }())
                .foregroundColor(.black)
                .font(.system(size: 30, weight: .semibold))
        }
    }
}

enum Operation {
    case add
    case subtract
    case multiply
    case divide
    case evaluate
}

struct OperationButton: View {
    var operation: Operation
    
    init(operation: Operation) {
        self.operation = operation
    }
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(.orange)
            Text({ () -> String in
                switch self.operation {
                case .add:
                    return "+"
                case .subtract:
                    return "-"
                case .multiply:
                    // return "X"
                    return "*"
                case .divide:
                    // return "÷"
                    return "/"
                case .evaluate:
                    return "="
                }
            }())
                .foregroundColor(.white)
                .font(.system(size: 30, weight: .semibold))
        }
    }
}

enum Digit {
    case number(Int)
    case point
}

struct DigitButton: View {
    var digit: Digit
    
    init(digit: Digit) {
        self.digit = digit
    }
    
    var body: some View {
        ZStack {
            switch(self.digit) {
            case let .number(number):
                if number == 0 {
                    Capsule(style: .circular)
                        .foregroundColor(Color(.darkGray))
                    Text("0")
                        .foregroundColor(.white)
                        .font(.system(size: 30, weight: .semibold))
                        .frame(maxWidth: 115, alignment: .leading)
                } else {
                    Circle()
                        .foregroundColor(Color(.darkGray))
                    Text(String(number))
                        .foregroundColor(.white)
                        .font(.system(size: 30, weight: .semibold))
                }
            case .point:
                Circle()
                    .foregroundColor(Color(.darkGray))
                Text(".")
                    .foregroundColor(.white)
                    .font(.system(size: 30, weight: .semibold))
            }
        }
    }
}

struct Row<Content: View>: View {
    @ViewBuilder var content: () -> Content
    
    var body: some View {
        HStack(
            spacing: 10,
            content: self.content
        )
    }
}

struct Input: View {
    var body: some View {
        VStack(spacing: 10, content: {
            VStack {
                Row {
                    ActionButton(action: .clear)
                    ActionButton(action: .negate)
                    ActionButton(action: .modulus)
                    OperationButton(operation: .divide)
                }
                Row {
                    DigitButton(digit: .number(7))
                    DigitButton(digit: .number(8))
                    DigitButton(digit: .number(9))
                    OperationButton(operation: .multiply)
                }
                Row {
                    DigitButton(digit: .number(4))
                    DigitButton(digit: .number(5))
                    DigitButton(digit: .number(6))
                    OperationButton(operation: .subtract)
                }
                Row {
                    DigitButton(digit: .number(1))
                    DigitButton(digit: .number(2))
                    DigitButton(digit: .number(3))
                    OperationButton(operation: .add)
                }
                GeometryReader(content: { geometry in
                    Row {
                        DigitButton(digit: .number(0))
                            .frame(width: geometry.size.width / 2 - 5, height: geometry.size.height * 3/4)
                        DigitButton(digit: .point)
                        OperationButton(operation: .evaluate)
                    }
                })
            }
        })
    }
}

struct Calculator: View {
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                Spacer()
                Display()
                Input()
                    .frame(height: geometry.size.height * 2/3)
                Spacer()
                    .frame(height: 15)
            }
            .padding(.horizontal, 10)
        }
        .ignoresSafeArea(.all, edges: .bottom)
        .background(.black)
    }
}

struct Calculator_Preview: PreviewProvider {
    static var previews: some View {
        Calculator()
    }
}
