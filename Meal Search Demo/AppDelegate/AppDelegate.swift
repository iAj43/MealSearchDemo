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
        let rootViewController = UINavigationController(rootViewController: mealCategoriesController)
        let navigationController = setupNavigationBar(rootViewController)
        window?.rootViewController = navigationController
        return true
    }
    
    func setupNavigationBar(_ navigationController: UINavigationController) -> UINavigationController {
        UIBarButtonItem.appearance().tintColor = .systemBlue // update here UIBarButtonItem tint color
        // NAVIGATION BAR CUSTOMIZATION
        navigationController.navigationBar.prefersLargeTitles = false
        navigationController.navigationBar.tintColor = UIColor.white
        navigationController.navigationBar.isTranslucent = false
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithDefaultBackground()
            appearance.backgroundColor = UIColor.white
            appearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
            appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
            navigationController.navigationBar.standardAppearance = appearance
            navigationController.navigationBar.scrollEdgeAppearance = appearance
            navigationController.navigationBar.compactAppearance = appearance
        } else {
            navigationController.navigationBar.barTintColor = UIColor.white
            navigationController.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
            navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        }
        // NAVIGATION BAR SHADOW
        navigationController.navigationBar.layer.masksToBounds = false
        navigationController.navigationBar.layer.shadowColor = UIColor.lightGray.cgColor
        navigationController.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 0.5)
        navigationController.navigationBar.layer.shadowRadius = 2
        navigationController.navigationBar.layer.shadowOpacity = 0.5
        //
        return navigationController
    }
}
