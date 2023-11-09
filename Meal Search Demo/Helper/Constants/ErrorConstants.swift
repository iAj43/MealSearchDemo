//
//  ErrorConstants.swift
//  Meal Search Demo
//
//  Created by NeoSOFT on 07/11/23.
//

import Foundation
//
// MARK: - ErrorConstants
//
enum ErrorHandler: Error {
    case generalError
    case custom(String)
    var message: String {
        switch self {
        case .generalError:
            return "Something went wrong, please try again"
        case .custom(let message):
            return message
        }
    }
}
