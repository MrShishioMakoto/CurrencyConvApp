//
//  CurrencyConv.swift
//  CurrencyConvApp
//
//  Created by GoncaloSAlmeida on 08/08/2024.
//

import Foundation

enum CurrencyConv: Endpoint {
    case rates
    case converter
    
    var path: String {
        switch self {
        case .rates:
            "latest"
        case .converter:
            ""
        }
    }
    var queryItems: [URLQueryItem]? {
        switch self {
        case .rates:
            return nil
        case .converter:
            return []
        }
    }
}
