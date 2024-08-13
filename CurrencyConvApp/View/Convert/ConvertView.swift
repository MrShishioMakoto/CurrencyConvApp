//
//  ConvertView.swift
//  CurrencyConvApp
//
//  Created by GoncaloSAlmeida on 12/08/2024.
//

import SwiftUI

struct ConvertView: View {
    @ObservedObject var viewModel: CurrencyConvViewModel
    @State private var amount: String = ""
    @State private var fromCurrency: String = LocalizableKeys.defaultFromCurr
    @State private var toCurrency: String = LocalizableKeys.defaultToCurr
    
    var body: some View {
        VStack {
            Form {
                Section(LocalizableKeys.amountToConv) {
                    TextField(LocalizableKeys.amount, text: $amount)
                        .keyboardType(.decimalPad)
                }
                
                Section(LocalizableKeys.fromCurrency) {
                    Picker(LocalizableKeys.fromCurrency, selection: $fromCurrency) {
                        ForEach(viewModel.sortedRates.map({ $0.currency }), id: \.self) { currency in
                            Text(currency).tag(currency)
                        }
                    }
                }
                
                Section(LocalizableKeys.toCurrency) {
                    Picker(LocalizableKeys.toCurrency, selection: $toCurrency) {
                        ForEach(viewModel.sortedRates.map({ $0.currency }), id: \.self) { currency in
                            Text(currency).tag(currency)
                        }
                    }
                }
            }
            
            if let amountValue = Double(amount) {
                Button(action: {
                    Task {
                        await viewModel.convertCurrency(amount: amountValue, from: fromCurrency, to: toCurrency)
                    }
                }) {
                    Text(LocalizableKeys.convert)
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding()
            }
            
            Section(LocalizableKeys.convertedAmount) {
                if viewModel.isLoading {
                    ProgressView()
                        .padding()
                } else if let conversionResult = viewModel.conversionResult {
                    Text("\(amount) \(fromCurrency) = \(String(format: "%.3f", conversionResult)) \(toCurrency)")
                        .font(.title2)
                        .padding()
                } else {
                    Text(LocalizableKeys.convPlaceholder)
                        .foregroundColor(.gray)
                        .padding()
                }
            }
        }
        .navigationTitle(LocalizableKeys.Tabs.converter)
        .onAppear {
            fromCurrency = viewModel.rates?.base ?? LocalizableKeys.defaultFromCurr
        }
    }
}

#Preview {
    ConvertView(viewModel: CurrencyConvViewModel(NetworkService(apiHost: "api.frankfurter.app")))
}
