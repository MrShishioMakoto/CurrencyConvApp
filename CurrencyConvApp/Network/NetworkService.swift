//
//  NetworkService.swift
//  CurrencyConvApp
//
//  Created by GoncaloSAlmeida on 08/08/2024.
//

import Foundation

protocol NetworkServiceProtocol {
    func get<T: Decodable>(endpoint: Endpoint) async throws -> T
}

class NetworkService: NetworkServiceProtocol {
    private let apiHost: String
    private let urlSession: URLSession
    
    init(apiHost: String, urlSession: URLSession = .shared) {
        self.apiHost = apiHost
        self.urlSession = urlSession
    }
    
    func get<T: Decodable>(endpoint: Endpoint) async throws -> T {
        return try await makeRequest(endpoint: endpoint, method: "GET")
    }
    
    private func makeRequest<T: Decodable>(endpoint: Endpoint, method: String) async throws -> T {
        let url = try makeUrl(for: endpoint)
        let request = URLRequest(url: url)
        let (data, _) = try await urlSession.data(for: request)
        do { return try JSONDecoder().decode(T.self, from: data) }
        catch { throw CustomError.failedToDecode }
    }
    
    private func makeUrl(for endpoint: Endpoint) throws -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = apiHost
        components.path = "/\(endpoint.path)"
        components.queryItems = endpoint.queryItems
        guard let url = components.url else {
            throw CustomError.invalidUrl
        }
        return url
    }
}
