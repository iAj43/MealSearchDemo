//
//  NetworkConstants.swift
//  Meal Search Demo
//
//  Created by NeoSOFT on 07/11/23.
//

import Foundation

enum NetworkConstants {
    private static var appEnvironment: Environment = .staging
    static let baseURL = appEnvironment.baseURL
    static let categories = "categories.php"
    static let filterCategory = "filter.php"
}

enum Environment {
    case staging
    case production
    var baseURL: String {
        switch self {
        case .staging:
        return "https://www.themealdb.com/api/json/v1/1/" // add staging URL here
        case .production:
            return "https://www.themealdb.com/api/json/v1/1/" // add production URL here
        }
    }
}
