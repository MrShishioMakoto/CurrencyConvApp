//
//  CurrencyConvViewModelTests.swift
//  CurrencyConvAppTests
//
//  Created by GoncaloSAlmeida on 12/08/2024.
//

import XCTest
import Combine
@testable import CurrencyConvApp

final class CurrencyConvViewModelTests: XCTestCase {
    
    var viewModel: CurrencyConvViewModel!
    var mockNetworkService: MockNetworkService!
    
    override func setUp() {
        super.setUp()
        mockNetworkService = MockNetworkService()
        viewModel = CurrencyConvViewModel(mockNetworkService)
    }
    
    override func tearDown() {
        viewModel = nil
        mockNetworkService = nil
        super.tearDown()
    }
    
    func test_fetchRates_success() async {
        let mockRates = createMockRates()
        
        mockNetworkService.getClosure = { endpoint in
            return mockRates
        }
        
        await viewModel.fetchRates()
        
        XCTAssertEqual(viewModel.rates?.base, "USD")
        XCTAssertEqual(viewModel.rates?.rates["EUR"], 0.85)
        XCTAssertEqual(viewModel.rates?.rates["GBP"], 0.75)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.error)
    }
    
    func test_fetchRates_failure() async {
        mockNetworkService.getClosure = { endpoint in
            throw CustomError.failedToDecode
        }
        
        await viewModel.fetchRates()
        
        XCTAssertNil(viewModel.rates)
        XCTAssertEqual(viewModel.error?.localizedDescription ?? "", CustomError.failedToDecode.localizedDescription)
        XCTAssertFalse(viewModel.isLoading)
    }
    
    func test_convertCurrency_success() async {
        let mockRates = createMockRates()
        
        mockNetworkService.getClosure = { endpoint in
            return mockRates
        }
        
        await viewModel.convertCurrency(amount: 100, from: "USD", to: "EUR")
        
        XCTAssertEqual(viewModel.conversionResult, 0.85)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.error)
    }
    
    func test_convertCurrency_failure() async {
        mockNetworkService.getClosure = { endpoint in
            throw CustomError.failedToDecode
        }
        
        await viewModel.convertCurrency(amount: 100, from: "USD", to: "EUR")
        
        XCTAssertNil(viewModel.conversionResult)
        XCTAssertEqual(viewModel.error?.localizedDescription ?? "", CustomError.failedToDecode.localizedDescription)
        XCTAssertFalse(viewModel.isLoading)
    }
    
    func test_filteredRates() {
        let mockRates = createMockRates()
        viewModel.rates = mockRates
        
        viewModel.searchCurrency = "E"
        let filtered = viewModel.filteredRates
        
        XCTAssertEqual(filtered.count, 1)
        XCTAssertEqual(filtered.first?.currency, "EUR")
    }
    
    func test_sectionTitle() {
        let mockRates = createMockRates()
        viewModel.rates = mockRates
        
        let sectionTitle = viewModel.sectionTitle()
        
        XCTAssertEqual(sectionTitle, LocalizableKeys.exchangeRates + " - USD")
    }
}

extension CurrencyConvViewModelTests {
    func createMockRates(
        amount: Int = 1,
        base: String = "USD",
        date: String = "",
        rates: [String : Double] = ["EUR": 0.85, "GBP": 0.75]
    ) -> Rates {
        Rates(
            amount: amount,
            base: base,
            date: date,
            rates: rates
        )
    }
}
