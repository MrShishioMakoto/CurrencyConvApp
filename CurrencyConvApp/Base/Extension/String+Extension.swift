//
//  String+Extension.swift
//  CurrencyConvApp
//
//  Created by GoncaloSAlmeida on 08/08/2024.
//

import Foundation

extension String {
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
}
