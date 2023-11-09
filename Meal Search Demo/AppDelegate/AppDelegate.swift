//
//  AppDelegate.swift
//  Meal Search Demo
//
//  Created by NeoSOFT on 07/11/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: - window
    var window: UIWindow?

    //
    // MARK: - application didFinishLaunchingWithOptions
    //
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // MARK: - setup window & rootViewController here
        window?.frame = UIScreen.main.bounds
        window?.makeKeyAndVisible()
        let mealCategoriesViewModel = MealCategoriesViewModel(useCaseProvider: MealRepo())
        let mealCategoriesController = MealCategoriesController(viewModel: mealCategoriesViewModel)
        window?.rootViewController = UINavigationController(rootViewController: mealCategoriesController)
        return true
    }
}
