//
//  CommonRequestParameters.swift
//  Meal Search Demo
//
//  Created by NeoSOFT on 08/11/23.
//

import Foundation

// MARK: - MealCategoriesParameters
struct MealCategoriesParameters: Codable {}

// MARK: - CategoryDetailParameters
struct CategoryDetailParameters: Codable {

    let query: String?
    
    enum CodingKeys: String, CodingKey {
        case query = "c"
    }
    
    internal init(query: String? = nil) {
        self.query = query
    }
}
