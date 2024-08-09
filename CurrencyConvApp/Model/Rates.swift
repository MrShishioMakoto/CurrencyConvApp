//
//  Rates.swift
//  CurrencyConvApp
//
//  Created by GoncaloSAlmeida on 08/08/2024.
//

import Foundation

struct Rates: Codable {
    let amount: Int
    let base, date: String
    let rates: [String: Double]
    
    enum CodingKeys: String, CodingKey {
        case amount, base, date, rates
    }
}
