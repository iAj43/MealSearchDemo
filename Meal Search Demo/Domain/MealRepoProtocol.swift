//
//  MealRepoProtocol.swift
//  Meal Search Demo
//
//  Created by NeoSOFT on 09/11/23.
//

import Foundation
import PromiseKit
// MARK: - MealRepoProtocol
protocol MealRepoProtocol {

    func getMealCategories(requestParameters: MealCategoriesParameters)->Promise<CategoriesBaseModel>
    func getCategoryDetail(requestParameters: CategoryDetailParameters)->Promise<MealsBaseModel>
}
