//
//  CurrencyConvViewModel.swift
//  CurrencyConvApp
//
//  Created by GoncaloSAlmeida on 08/08/2024.
//

import Foundation
import Combine

final class CurrencyConvViewModel: ObservableObject {
    @Published var rates: Rates? = nil
    @Published var searchCurrency: String = ""
    @Published var hasError = false
    @Published private(set) var conversionResult: Double? = nil
    @Published private(set) var isLoading = true
    @Published private(set) var error: CustomError? = nil
    
    private let networkService: NetworkServiceProtocol
    
    var sortedRates: [(currency: String, rate: Double)] {
        var allRates = rates?.rates ?? [:]
        if let base = rates?.base {
            allRates[base] = 1
        }
        return allRates
            .sorted(by: { $0.key < $1.key })
            .map { (currency: $0.key, rate: $0.value) }
    }
    
    var filteredRates: [(currency: String, rate: Double)] {
        if searchCurrency.isEmpty {
            return sortedRates
        } else {
            return sortedRates.filter { $0.currency.lowercased().contains(searchCurrency.lowercased()) }
        }
    }
    
    init(_ networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    @MainActor
    func fetchRates() async {
        isLoading = true
        do{
            rates = try await networkService.get(endpoint: CurrencyConv.rates)
        } catch {
            self.error = error as? CustomError
        }
        
        isLoading = false
    }
    
    @MainActor
    func convertCurrency(amount: Double, from: String, to: String) async {
        isLoading = true
        conversionResult = nil
        do {
            let endpoint = CurrencyConv.converter(amount: amount, from: from, to: to)
            let conversionRates: Rates = try await networkService.get(endpoint: endpoint)
            conversionResult = conversionRates.rates[to]
        } catch {
            self.error = error as? CustomError
        }
        isLoading = false
    }
    
    func sectionTitle() -> String {
        guard let baseCoin = rates?.base else { return "" }
        return LocalizableKeys.exchangeRates + " - " + baseCoin
    }
}
