//
//  MealCategoriesViewModel.swift
//  Meal Search Demo
//
//  Created by NeoSOFT on 08/11/23.
//

import Foundation
import PromiseKit
//
// MARK: - Abstraction for MealCategoriesViewModel
//
protocol MealCategoriesViewModelProtocol {
    func fetchData()
    func getArrayCount() -> Int
    func getItem(at index: Int) -> Categories?
    func updateArray(at index: Int)
    var getLoadingState: ((MealCategoriesViewState) -> Void) { get set}
}
// MARK: - The view model responsible for MealCategoriesViewController
class MealCategoriesViewModel: MealCategoriesViewModelProtocol {
    
    private let mealRepoProtocol: MealRepoProtocol
    private var mealCategoriesArray = [Categories]()
    var getLoadingState: ((MealCategoriesViewState) -> Void) = {_ in }
    
    init(useCaseProvider: MealRepoProtocol) {
        self.mealRepoProtocol = useCaseProvider
    }
    
    // MARK: - fetchData
    func fetchData() {
        mealCategoriesArray = [Categories]()
        loadData()
    }
}
// MARK: - return data for view
extension MealCategoriesViewModel {
    
    func getArrayCount() -> Int {
        let count = mealCategoriesArray.count
        if count == 0 {
            self.getLoadingState(.empty)
        }
        return count
    }
    
    func getItem(at index: Int) -> Categories? {
        if mealCategoriesArray.indices.contains(index) {
            return mealCategoriesArray[index]
        } else {
            return nil
        }
    }
    
    func updateArray(at index: Int) {
        if mealCategoriesArray.indices.contains(index),
           let unwrappedDynamicHeight = mealCategoriesArray[index].dynamicHeight {
            if unwrappedDynamicHeight == 36 {
                if let categoryDescriptionStr = mealCategoriesArray[index].categoryDescriptionStr,
                   let height = categoryDescriptionStr.heightWithConstrainedWidth(MEAL_CATEGORIES_SUB_TITLE_PADDING, font: .systemFont(ofSize: 15, weight: .light)) {
                    mealCategoriesArray[index].dynamicHeight = Int(ceil(height))
                }
            } else {
                mealCategoriesArray[index].dynamicHeight = 36
            }
        }
    }
}
// MARK: - loadData from data source
extension MealCategoriesViewModel {
    
    private func loadData() {
        self.getLoadingState(.populated)
        let requestParameters = MealCategoriesParameters()
        mealRepoProtocol.getMealCategories(
            requestParameters: requestParameters
        ).done { response in
            var categoriesArray = response.categories ?? []
            for (index, _) in categoriesArray.enumerated() {
                if let categoryDescriptionStr = categoriesArray[index].categoryDescriptionStr,
                   let height = categoryDescriptionStr.heightWithConstrainedWidth(MEAL_CATEGORIES_SUB_TITLE_PADDING, font: .systemFont(ofSize: 15, weight: .light)) {
                    if height > 36 {
                        categoriesArray[index].isShowViewMoreButton = true
                    } else {
                        categoriesArray[index].isShowViewMoreButton = false
                    }
                    categoriesArray[index].dynamicHeight = 36
                }
            }
            self.setData(items: categoriesArray)
        }.catch { error in
            self.getLoadingState(.error(error))
        }
    }
    
    private func setData(items: [Categories]) {
        self.mealCategoriesArray.append(contentsOf: items)
        self.getLoadingState(.populated)
    }
}
// MARK: - MealCategoriesViewState
enum MealCategoriesViewState {
    case error(Error)
    case empty
    case populated
}
