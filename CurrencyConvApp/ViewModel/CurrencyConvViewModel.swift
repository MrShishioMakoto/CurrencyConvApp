//
//  CurrencyConvViewModel.swift
//  CurrencyConvApp
//
//  Created by GoncaloSAlmeida on 08/08/2024.
//

import Foundation
import Combine

class CurrencyConvViewModel: ObservableObject {
    @Published var rates: Rates? = nil
    @Published private(set) var isLoading = true
    
    private let networkService: NetworkServiceProtocol
    
    var sortedRates: [(currency: String, rate: Double)] {
        return rates?.rates
            .sorted(by: { $0.key < $1.key })
            .map { (currency: $0.key, rate: $0.value) }
        ?? []
    }
    
    init(_ networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    @MainActor
    func fetchRates() async {
        do{
            rates = try await networkService.get(endpoint: CurrencyConv.rates)
        } catch {
            //TODO
        }
        
        isLoading = false
    }
    
    func sectionTitle() -> String {
        guard let baseCoin = rates?.base else { return "" }
        return LocalizableKeys.exchangeRates + " - " + baseCoin
    }
}
