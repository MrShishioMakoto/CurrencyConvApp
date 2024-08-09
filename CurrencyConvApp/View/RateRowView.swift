//
//  RateRowView.swift
//  CurrencyConvApp
//
//  Created by GoncaloSAlmeida on 09/08/2024.
//

import SwiftUI

struct RateRowView: View {
    let currency: String
    let rate: Double
    
    var body: some View {
        HStack {
            Text(currency)
            Spacer()
            Text(String(format: "%.3f", rate))
        }
    }
}
