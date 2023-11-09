//
//  CategoryDetailViewModel.swift
//  Meal Search Demo
//
//  Created by NeoSOFT on 08/11/23.
//

import Foundation
import PromiseKit
//
// MARK: - Abstraction for CategoryDetailViewModel
//
protocol CategoryDetailViewModelProtocol {
    func fetchData(selectedCategory: String)
    func getArrayCount() -> Int
    func getItem(at index: Int) -> Meals?
    var getLoadingState: ((CategoryDetailViewState) -> Void) { get set}
}
// MARK: - The view model responsible for CategoryDetailViewController
class CategoryDetailViewModel: CategoryDetailViewModelProtocol {
    
    private let mealRepoProtocol: MealRepoProtocol
    private var categoryDetailArray = [Meals]()
    var getLoadingState: ((CategoryDetailViewState) -> Void) = {_ in }
    
    init(useCaseProvider: MealRepoProtocol) {
        self.mealRepoProtocol = useCaseProvider
    }
    
    // MARK: - fetchData
    func fetchData(selectedCategory: String) {
        categoryDetailArray = [Meals]()
        loadData(selectedCategory: selectedCategory)
    }
}
// MARK: - return data for view
extension CategoryDetailViewModel {
    
    func getArrayCount() -> Int {
        let count = categoryDetailArray.count
        if count == 0 {
            self.getLoadingState(.empty)
        }
        return count
    }
    
    func getItem(at index: Int) -> Meals? {
        if categoryDetailArray.indices.contains(index) {
            return categoryDetailArray[index]
        } else {
            return nil
        }
    }
}
// MARK: - loadData from data source
extension CategoryDetailViewModel {
    
    private func loadData(selectedCategory: String) {
        self.getLoadingState(.populated)
        let requestParameters = CategoryDetailParameters(query: selectedCategory)
        mealRepoProtocol.getCategoryDetail(
            requestParameters: requestParameters
        ).done { response in
            self.setData(items: response.meals ?? [])}
        .catch { error in
            self.getLoadingState(.error(error))
        }
    }
    
    private func setData(items: [Meals]) {
        self.categoryDetailArray.append(contentsOf: items)
        self.getLoadingState(.populated)
    }
}
// MARK: - CategoryDetailViewState
enum CategoryDetailViewState {
    case error(Error)
    case empty
    case populated
}
