//
//  NetworkServiceTests.swift
//  CurrencyConvAppTests
//
//  Created by GoncaloSAlmeida on 09/08/2024.
//

import XCTest
@testable import CurrencyConvApp

final class NetworkServiceTests: XCTestCase {
    
    func test_get_success() async throws {
        // Arrange
        let sut = makeSUT()
        let data = JSONMockResponse.data(using: .utf8)
        mockRequestHandler(with: data)
        
        // Act
        do {
            let rates: Rates = try await sut.get(endpoint: CurrencyConv.rates)
            // Assert
            XCTAssertNotNil(rates)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func test_invalidUrl() async {
        let sut = makeSUT(apiHost: "")
        
        do {
            let _: String = try await sut.get(endpoint: CurrencyConv.rates)
            XCTFail("Expected to throw invalidUrl error")
        } catch let error as CustomError {
            XCTAssertEqual(error, CustomError.invalidUrl)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }

    func test_decodingError() async {
        let sut = makeSUT()
        let data = "Invalid JSON".data(using: .utf8)
        mockRequestHandler(with: data)
        
        do {
            let _: Rates = try await sut.get(endpoint: CurrencyConv.rates)
            XCTFail("Expected to throw failedToDecode error")
        } catch let error as CustomError {
            XCTAssertEqual(error, CustomError.failedToDecode)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
}

extension NetworkServiceTests {
    private func makeSUT(apiHost: String = "api.frankfurter.app") -> NetworkService {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: config)
        
        return NetworkService(apiHost: apiHost, urlSession: session)
    }
    
    private func mockRequestHandler(with data: Data?, isInvalidUrl: Bool = false) {
        MockURLProtocol.requestHandler = { request in
            guard let url = request.url else {
                throw CustomError.invalidUrl
            }
            
            let response = HTTPURLResponse(
                url: isInvalidUrl ? URL(string: "")! : url,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            )!
            return (response, data)
        }
    }
}
