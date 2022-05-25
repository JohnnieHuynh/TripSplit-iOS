//
//  ContentView.swift
//  TripSplit
//
//  Created by Johnny Huynh on 5/25/22.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numOfPeople = 2
    @State private var tipPercent = 20
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [10, 15, 18, 20, 25]
    
    var subTotal: Double {
        //Calculate amount with tip, but no split
        let tipSelection = Double (tipPercent)
        let tipValue = checkAmount / 100 * tipSelection
        
        let subTotal_final = checkAmount + tipValue
        
        return subTotal_final
    }
    
    var totalPerPerson: Double {
        //Calculate total per person
        let peopleCount = Double(numOfPeople + 2)
        let tipSelection = Double(tipPercent)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var body: some View {
        NavigationView {
            Form {
                //Amount Enter Section
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of People", selection: $numOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                } header: {
                    Text("Amount")
                }
                
                //Tip Selection Section
                Section {
                    Picker("Tip Percentage", selection: $tipPercent) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Tip Percent")
                }
                
                //Subtotal Section
                Section {
                    Text(subTotal, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                } header: {
                    Text("SubTotal")
                }
                
                //Total Section
                Section {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                } header: {
                    Text("Total Per Person")
                }
            }
            .navigationTitle("TripSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
