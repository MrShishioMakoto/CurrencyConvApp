//
//  RatesView.swift
//  CurrencyConvApp
//
//  Created by GoncaloSAlmeida on 08/08/2024.
//

import SwiftUI

struct RatesView: View {
    @ObservedObject var viewModel: CurrencyConvViewModel
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView()
                    .padding()
            } else {
                if viewModel.rates != nil {
                    List {
                        Section(viewModel.sectionTitle()) {
                            ForEach(viewModel.filteredRates, id: \.currency) { currency, rate in
                                RateRowView(currency: currency, rate: rate)
                            }
                        }
                    }
                    .searchable(text: $viewModel.searchCurrency)
                } else {
                    Text(LocalizableKeys.noExchangeRates)
                        .foregroundColor(.gray)
                        .padding()
                }
            }
        }
        .navigationTitle(LocalizableKeys.Tabs.rates)
        .onAppear {
            Task {
                await viewModel.fetchRates()
            }
        }
        .alert(isPresented: $viewModel.hasError) {
            Alert(
                title: Text(LocalizableKeys.Alert.title),
                message: Text(viewModel.error?.localizedDescription ?? LocalizableKeys.Alert.message),
                dismissButton: .default(
                    Text(LocalizableKeys.Alert.button)) {
                        Task {
                            await viewModel.fetchRates()
                        }
                    }
            )
        }
    }
}

#Preview {
    RatesView(viewModel: CurrencyConvViewModel(NetworkService(apiHost: "api.frankfurter.app")))
}
