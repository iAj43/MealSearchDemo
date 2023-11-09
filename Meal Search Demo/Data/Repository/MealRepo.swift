//
//  MealRepo.swift
//  Meal Search Demo
//
//  Created by NeoSOFT on 09/11/23.
//

import Foundation
import PromiseKit
// MARK: - MealRepo which conform MealRepoProtocol Protocol
class MealRepo: MealRepoProtocol {
    
    private var apiHandler: NetworkManagerProtocol

    init(apiHandler: NetworkManagerProtocol = NetworkManager.shared) {
        self.apiHandler = apiHandler
    }
   
    func getMealCategories(requestParameters: MealCategoriesParameters)-> Promise<CategoriesBaseModel> {
        return Promise { seal in
            let request = MealCategoriesEndpoint.fetchMealCategories(requestParameters)
            apiHandler.fetchData(request: request)
                .done { response in
                    seal.fulfill(response)}
                .catch { error in
                    seal.reject(error)}
        }
    }
    
    func getCategoryDetail(requestParameters: CategoryDetailParameters)-> Promise<MealsBaseModel> {
        return Promise { seal in
            let request = MealCategoriesEndpoint.fetchCategoryDetail(requestParameters)
            apiHandler.fetchData(request: request)
                .done { response in
                    seal.fulfill(response)}
                .catch { error in
                    seal.reject(error)}
        }
    }
}
