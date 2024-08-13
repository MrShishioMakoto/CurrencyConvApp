//
//  LocalizableKeys.swift
//  CurrencyConvApp
//
//  Created by GoncaloSAlmeida on 08/08/2024.
//

import Foundation

enum LocalizableKeys{
    enum Nav {
        static let rates = "nav.rates.title".localized
    }
    
    enum Tabs {
        static let rates = "tab.actual.rates.title".localized
        static let converter = "tab.currency.converter.title".localized
    }
    
    enum Errors {
        static let url = "errors.invalid.url".localized
        static let decode = "errors.failed.to.decode".localized
    }
    
    enum Alert {
        static let title = "alert.title".localized
        static let message = "alert.message".localized
        static let button = "alert.button".localized
    }
    
    // Rates
    static let exchangeRates = "exchange.rates".localized
    static let noExchangeRates = "no.exchange.rates".localized
    
    // Convert
    static let amountToConv = "convert.amount.to.convert".localized
    static let amount = "convert.amount".localized
    static let fromCurrency = "convert.from.currency".localized
    static let toCurrency = "convert.to.currency".localized
    static let convert = "convert.convert".localized
    static let convertedAmount = "convert.converted.amount".localized
    static let convPlaceholder = "convert.placeholder".localized
    static let defaultFromCurr = "convert.default.from.currency".localized
    static let defaultToCurr = "convert.default.to.currency".localized
}
