//
//  CategoriesModel.swift
//  Meal Search Demo
//
//  Created by NeoSOFT on 07/11/23.
//

import Foundation
//
// MARK: - CategoriesBaseModel
//
struct CategoriesBaseModel : Codable {
    
    var categories : [Categories]?

    enum CodingKeys: String, CodingKey {

        case categories = "categories"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        categories = try values.decodeIfPresent([Categories].self, forKey: .categories)
    }
}
//
struct Categories : Codable {
    
    var categoryID : String?
    var categoryThumbStr : String?
    var categoryTitleStr : String?
    var categoryDescriptionStr : String?
    var isShowViewMoreButton: Bool?
    var dynamicHeight: Int?
    
    enum CodingKeys: String, CodingKey {
        
        case categoryID = "idCategory"
        case categoryThumbStr = "strCategoryThumb"
        case categoryTitleStr = "strCategory"
        case categoryDescriptionStr = "strCategoryDescription"
        case isShowViewMoreButton = "isShowViewMoreButton"
        case dynamicHeight = "dynamicHeight"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        categoryID = try values.decodeIfPresent(String.self, forKey: .categoryID)
        categoryThumbStr = try values.decodeIfPresent(String.self, forKey: .categoryThumbStr)
        categoryTitleStr = try values.decodeIfPresent(String.self, forKey: .categoryTitleStr)
        categoryDescriptionStr = try values.decodeIfPresent(String.self, forKey: .categoryDescriptionStr)
        isShowViewMoreButton = try values.decodeIfPresent(Bool.self, forKey: .isShowViewMoreButton)
        dynamicHeight = try values.decodeIfPresent(Int.self, forKey: .dynamicHeight)
    }
}
