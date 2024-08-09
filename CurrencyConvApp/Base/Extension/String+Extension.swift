//
//  String+Extension.swift
//  CurrencyConvApp
//
//  Created by GoncaloSAlmeida on 08/08/2024.
//

import Foundation

extension String {
    func localizableString() -> String {
        NSLocalizedString(self, comment: "")
    }
}
