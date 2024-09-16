//
//  MealsModel.swift
//  Meal Search Demo
//
//  Created by NeoSOFT on 07/11/23.
//

import Foundation
//
// MARK: - MealsBaseModel
//
struct MealsBaseModel : Codable {
    
    let meals : [Meals]?

    enum CodingKeys: String, CodingKey {
        case meals = "meals"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        meals = try values.decodeIfPresent([Meals].self, forKey: .meals)
    }
}
//
struct Meals : Codable {
    
    let mealID : String?
    let mealThumbStr : String?
    let mealStr : String?

    enum CodingKeys: String, CodingKey {
        case mealID = "idMeal"
        case mealThumbStr = "strMealThumb"
        case mealStr = "strMeal"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        mealID = try values.decodeIfPresent(String.self, forKey: .mealID)
        mealThumbStr = try values.decodeIfPresent(String.self, forKey: .mealThumbStr)
        mealStr = try values.decodeIfPresent(String.self, forKey: .mealStr)
    }
}
