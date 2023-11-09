//
//  Errors.swift
//  Meal Search Demo
//
//  Created by NeoSOFT on 07/11/23.
//

import Foundation

struct ErrorModel: Codable {
    let status: String?
    let code: String?
    let message: String?
}
