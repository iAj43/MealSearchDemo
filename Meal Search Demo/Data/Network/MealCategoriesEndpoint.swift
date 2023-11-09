//
//  MealCategoriesEndpoint.swift
//  Meal Search Demo
//
//  Created by NeoSOFT on 09/11/23.
//

import Foundation
import Alamofire

enum MealCategoriesEndpoint {
    case fetchMealCategories(MealCategoriesParameters)
    case fetchCategoryDetail(CategoryDetailParameters)
}

extension MealCategoriesEndpoint: APIRequest {
    
    var baseURL: String {
        return NetworkConstants.baseURL
    }
    
    var path: String {
        switch self {
        case .fetchMealCategories:
            return NetworkConstants.categories
        case .fetchCategoryDetail:
            return NetworkConstants.filterCategory
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .fetchMealCategories:
            return .get
        case .fetchCategoryDetail:
            return .get
        }
    }
    
    var parameters: [String : Any] {
        switch self {
        case .fetchMealCategories(let params):
            return params.toJSON()
        case .fetchCategoryDetail(let params):
            return params.toJSON()
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
        case .fetchMealCategories(_):
            return nil
        case .fetchCategoryDetail(_):
            return nil
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .fetchMealCategories:
            return URLEncoding.default
        case .fetchCategoryDetail:
            return URLEncoding.default
        }
    }
}
