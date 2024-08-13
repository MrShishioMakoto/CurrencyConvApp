//
//  MockNetworkService.swift
//  CurrencyConvAppTests
//
//  Created by GoncaloSAlmeida on 12/08/2024.
//

import XCTest
@testable import CurrencyConvApp

class MockNetworkService: NetworkServiceProtocol {
    var getClosure: ((Endpoint) async throws -> Decodable)?
    
    func get<T: Decodable>(endpoint: Endpoint) async throws -> T {
        guard let getClosure = getClosure else {
            throw CustomError.invalidUrl
        }
        
        let result = try await getClosure(endpoint)
        
        guard let typedResult = result as? T else {
            throw CustomError.failedToDecode
        }
        
        return typedResult
    }
}

