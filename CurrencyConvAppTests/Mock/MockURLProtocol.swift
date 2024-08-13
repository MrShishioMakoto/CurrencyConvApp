//
//  MockURLProtocol.swift
//  CurrencyConvAppTests
//
//  Created by GoncaloSAlmeida on 12/08/2024.
//

import Foundation
@testable import CurrencyConvApp

final class MockURLProtocol: URLProtocol {
    static var requestHandler: ((URLRequest) async throws -> (HTTPURLResponse, Data?))?
    
    override class func canInit(with request: URLRequest) -> Bool {
        true
    }
    
    override class func canonicalRequest(for request: URLRequest)
    -> URLRequest {
        request
    }
    
    override func startLoading()
    {
        Task {
            guard let handler = MockURLProtocol.requestHandler else {
                fatalError()
            }
            
            do {
                let (response, data) = try await handler(request)
                client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
                
                
                if let data {
                    client?.urlProtocol(self, didLoad: data)
                }
                
                client?.urlProtocolDidFinishLoading(self)
            } catch {
                client?.urlProtocol(self, didFailWithError:
                                        error)
            }
        }
    }
    
    override func stopLoading()
    { }
}
