//
//  LocalizableKeys.swift
//  CurrencyConvApp
//
//  Created by GoncaloSAlmeida on 08/08/2024.
//

import Foundation

enum LocalizableKeys{
    enum Nav {
        static let rates = "nav.rates.title".localizableString()
    }
    
    enum Tabs {
        static let rates = "tab.actual.rates.title".localizableString()
        static let converter = "tab.currency.converter.title".localizableString()
    }
    
    enum Errors {
        static let url = "errors.invalid.url".localizableString()
        static let decode = "errors.failed.to.decode".localizableString()
    }
    
    static let exchangeRates = "exchange.rates".localizableString()
    static let noExchangeRates = "no.exchange.rates".localizableString()
}
