//
//  CustomError.swift
//  CurrencyConvApp
//
//  Created by GoncaloSAlmeida on 09/08/2024.
//

import Foundation

enum CustomError: LocalizedError {
    case invalidUrl
    case failedToDecode
    
    var errorDescription: String? {
        switch self {
        case .invalidUrl:
            return LocalizableKeys.Errors.url
        case .failedToDecode:
            return LocalizableKeys.Errors.decode
        }
    }
}
