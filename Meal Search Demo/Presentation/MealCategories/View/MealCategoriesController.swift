//
//  MealCategoriesController.swift
//  Meal Search Demo
//
//  Created by NeoSOFT on 07/11/23.
//

import UIKit

class MealCategoriesController: UIViewController {
    
    // MARK: - setup variables
    private let navigationBarTitle: String = "Meal Categories"

    // MARK: - setup UI
    lazy var mealCategoriesTableView: UITableView = {
        
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = CGFloat.leastNormalMagnitude
        tableView.sectionFooterHeight = CGFloat.leastNormalMagnitude
        tableView.estimatedSectionFooterHeight = UITableView.automaticDimension
        tableView.register(MealCategoriesCell.self, forCellReuseIdentifier: mealCategoriesCellID)
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0.0
        } else {
            // Fallback on earlier versions
        }
        return tableView
    }()
    
    // MARK: - handle viewModel
    var viewModel: MealCategoriesViewModelProtocol
    
    init(viewModel: MealCategoriesViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //
    // MARK: - viewDidLoad
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupAutoLayout()
        //
        bindViewModel()
        viewModel.fetchData()
    }
    
    func setupViews() {
        title = navigationBarTitle
        view.backgroundColor = .white
        view.addSubview(mealCategoriesTableView)
    }
    
    func setupAutoLayout() {
        mealCategoriesTableView.fillConstraintSuperview(constant: 0)
    }
}
//
// MARK: - bind viewModel
//
extension MealCategoriesController {
    
    private func bindViewModel() {
        viewModel.getLoadingState = { state in
            switch state {
            case .error(let error):
                self.showAlertWithAutoDismiss(title: error.localizedDescription, message: "", time: 1.5)
                DispatchQueue.main.async {
                    self.mealCategoriesTableView.reloadData()
                }
                break
            case .empty:
                // show empty view here
                break
            case .populated:
                DispatchQueue.main.async {
                    self.mealCategoriesTableView.reloadData()
                }
            }
        }
    }
}
//
// MARK: - UITableView methods
//
extension MealCategoriesController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let unwrappedSelectedCategory = viewModel.getItem(at: indexPath.row)?.categoryTitleStr {
            let categoryDetailViewModel = CategoryDetailViewModel(useCaseProvider: MealRepo())
            let categoryDetailController = CategoryDetailController(viewModel: categoryDetailViewModel)
            categoryDetailController.selectedCategory = unwrappedSelectedCategory
            navigationController?.pushViewController(categoryDetailController, animated: true)
        } else {
            showAlertWithAutoDismiss(title: ErrorHandler.generalError.message, message: "", time: 1.5)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getArrayCount()
    }
    
    // MARK: - handle cell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let unwrappedCell = tableView.dequeueReusableCell(withIdentifier: mealCategoriesCellID, for: indexPath) as? MealCategoriesCell else { return UITableViewCell() }
        unwrappedCell.viewMoreButton.tag = indexPath.row
        unwrappedCell.viewMoreButton.addTarget(self, action: #selector(handleViewMoreButton), for: .touchUpInside)
        unwrappedCell.setterObj = viewModel.getItem(at: indexPath.row)
        return unwrappedCell
    }
    
    @objc func handleViewMoreButton(_ sender: UIButton) {
        viewModel.updateArray(at: sender.tag)
        DispatchQueue.main.async {
            self.mealCategoriesTableView.reloadData()
        }
    }
    
    // MARK: - handle header
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    // MARK: - handle footer
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
}
