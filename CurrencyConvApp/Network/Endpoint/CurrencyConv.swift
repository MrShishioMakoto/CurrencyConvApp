//
//  CurrencyConv.swift
//  CurrencyConvApp
//
//  Created by GoncaloSAlmeida on 08/08/2024.
//

import Foundation

enum CurrencyConv: Endpoint {
    case rates
    case converter(amount: Double, from: String, to: String)
    
    var path: String {
        switch self {
        case .rates, .converter: 
            return "latest"
        }
    }
    var queryItems: [URLQueryItem]? {
        switch self {
        case .rates:  return nil
        case .converter(let amount, let from, let to):
            return [
                URLQueryItem(name: "amount", value: String(amount)),
                URLQueryItem(name: "from", value: from),
                URLQueryItem(name: "to", value: to)
            ]
        }
    }
}
