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
            } else {
                if viewModel.rates != nil {
                    List {
                        Section(viewModel.sectionTitle()) {
                            ForEach(viewModel.sortedRates, id: \.currency) { currency, rate in
                                RateRowView(currency: currency, rate: rate)
                            }
                        }
                    }
                } else {
                    Text(LocalizableKeys.noExchangeRates)
                        .foregroundColor(.gray)
                        .padding()
                }
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchRates()
            }
        }
    }
}

#Preview {
    RatesView(viewModel: CurrencyConvViewModel(NetworkService(apiHost: "api.frankfurter.app")))
}
