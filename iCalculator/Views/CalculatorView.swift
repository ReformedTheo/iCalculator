//
//  ContentView.swift
//  iCalculator
//
//  Created by Theo Lopes on 13/11/2024.
//

import SwiftUI

struct CalculatorView: View {
    
    @StateObject private var ViewModel = CalculatorViewModel()
    // Define the layout of the calculator buttons
    let buttons: [[CalculatorButton]] = [
        [.clear, .negative, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.zero, .decimal, .equals]
    ]
    
    var body: some View {
        ZStack {
            // Set the background color
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                // Display screen
                displayView
                
                // Calculator buttons
                buttonPad
            }
            .padding()
        }
    }
    
    // Display View
    private var displayView: some View {
        HStack {
            Spacer()
            Text(ViewModel.displayText)
                .foregroundColor(.white)
                .font(.system(size: 72))
                .padding()
        }
    }
    
    // Button Pad View
    private var buttonPad: some View {
        ForEach(buttons, id: \.self) { row in
            HStack(spacing: 12) {
                ForEach(row, id: \.self) { button in
                    CalculatorButtonView(button: button, action: {
                        ViewModel.handleButtonPress(button)
                    })
                }
            }
            .padding(.bottom, 12)
        }
    }
}

// Separate View for Calculator Button
struct CalculatorButtonView: View {
    let button: CalculatorButton
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(button.title)
                .font(.system(size: 32))
                .frame(
                    width: buttonWidth(button: button),
                    height: buttonHeight()
                )
                .background(button.backgroundColor)
                .foregroundColor(.white)
                .cornerRadius(buttonWidth(button: button) / 2)
        }
    }
    
    // Calculate button width
    private func buttonWidth(button: CalculatorButton) -> CGFloat {
        if button == .zero {
            return (UIScreen.main.bounds.width - 5 * 12) / 4 * 2 + 12
        }
        return (UIScreen.main.bounds.width - 5 * 12) / 4
    }
    
    // Calculate button height
    private func buttonHeight() -> CGFloat {
        return (UIScreen.main.bounds.width - 5 * 12) / 4
    }
}

// Define calculator buttons and their properties
enum CalculatorButton: Hashable {
    case zero, one, two, three, four, five, six, seven, eight, nine
    case decimal, equals, add, subtract, multiply, divide
    case percent, negative, clear
    
    var title: String {
        switch self {
        case .zero:       return "0"
        case .one:        return "1"
        case .two:        return "2"
        case .three:      return "3"
        case .four:       return "4"
        case .five:       return "5"
        case .six:        return "6"
        case .seven:      return "7"
        case .eight:      return "8"
        case .nine:       return "9"
        case .decimal:    return "."
        case .equals:     return "="
        case .add:        return "+"
        case .subtract:   return "−"
        case .multiply:   return "×"
        case .divide:     return "÷"
        case .percent:    return "%"
        case .negative:   return "±"
        case .clear:      return "AC"
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .add, .subtract, .multiply, .divide, .equals:
            return .red
        case .clear, .negative, .percent:
            return Color(white: 0.65)
        default:
            return Color(white: 0.2)
        }
    }
}

#Preview {
    CalculatorView()
}

