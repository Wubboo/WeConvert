//
//  ContentView.swift
//  WeConvert
//
//  Created by Wubbo Boiten on 14/04/2026.
//

import SwiftUI

struct ContentView: View {
    
    @FocusState private var isInputActive: Bool
    @State private var selection: Selection = .cmToInch
    @State private var convertAmount: Double = 0
    
    var calc: Double {
        let inch = 0.393700787
        let foot = 3.2808399
        let mile = 0.621371192
        
        switch selection {
        case .cmToInch:
            return convertAmount * inch
        case .meterToFoot:
            return convertAmount * foot
        case .kilometersToMiles:
            return convertAmount * mile
        }
    }

    enum Selection: String, CaseIterable {
        case cmToInch = "cm to inch"
        case meterToFoot = "Meter to foot"
        case kilometersToMiles = "Kilometers to miles"
    }

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Pick a format")) {
                    Picker("Pick to convert", selection: $selection) {
                        ForEach(Selection.allCases, id: \.self) { option in
                            Text(option.rawValue)
                        }
                    }
                }
                
                Section(header: Text("Amount")) {
                    TextField("How much to convert?", value: $convertAmount, formatter: {
                        let f = NumberFormatter()
                        f.maximumFractionDigits = 2
                        return f
                    }())
                        .focused($isInputActive)
                        .keyboardType(.decimalPad)
                }
                
                Section(header: Text("Result:")) {
                    Text(calc.formatted(.number.precision(.fractionLength(2))))
                }
            }
            .navigationTitle("WeConvert")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        isInputActive = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
