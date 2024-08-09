//
//  Endpoint.swift
//  CurrencyConvApp
//
//  Created by GoncaloSAlmeida on 08/08/2024.
//

import Foundation

protocol Endpoint {
    var path: String { get }
    var queryItems: [URLQueryItem]? { get }
}
