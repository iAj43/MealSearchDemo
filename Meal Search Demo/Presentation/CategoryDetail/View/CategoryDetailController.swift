//
//  CategoryDetailController.swift
//  Meal Search Demo
//
//  Created by NeoSOFT on 07/11/23.
//

import UIKit
import Lightbox

class CategoryDetailController: UIViewController {
    
    // MARK: - setup variables
    var selectedCategory: String = ""
    
    // MARK: - setup UI
    lazy var categoryDetailCollectionView: UICollectionView = {
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        collectionView.register(CategoryDetailCell.self, forCellWithReuseIdentifier: categoryDetailCellID)
        return collectionView
    }()
    
    // MARK: - handle viewModel
    var viewModel: CategoryDetailViewModelProtocol
    
    init(viewModel: CategoryDetailViewModelProtocol) {
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
        viewModel.fetchData(selectedCategory: selectedCategory)
    }
    
    func setupViews() {
        title = selectedCategory
        view.backgroundColor = .white
        view.addSubview(categoryDetailCollectionView)
    }
    
    func setupAutoLayout() {
        categoryDetailCollectionView.fillConstraintSuperview(constant: 0)
    }
}
//
// MARK: - bind viewModel
//
extension CategoryDetailController {
    
    private func bindViewModel() {
        viewModel.getLoadingState = { state in
            switch state {
            case .error(let error):
                self.showAlertWithAutoDismiss(title: error.localizedDescription, message: "", time: 1.5)
                DispatchQueue.main.async {
                    self.categoryDetailCollectionView.reloadData()
                }
                break
            case .empty:
                // show empty view here
                break
            case .populated:
                DispatchQueue.main.async {
                    self.categoryDetailCollectionView.reloadData()
                }
            }
        }
    }
}
//
// MARK: - UICollectionView methods
//
extension CategoryDetailController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showLightbox(indexPath.row)
    }
    
    func showLightbox(_ index: Int) {
        let indexPath = IndexPath(item: index, section: 0)
        if let unwrappedCell = categoryDetailCollectionView.cellForItem(at: indexPath) as? CategoryDetailCell,
           let unwrappedImage = unwrappedCell.categoryImageView.image,
           let titleLabelText = unwrappedCell.categoryTitleLabel.text {
            let images = [
                LightboxImage(
                    image: unwrappedImage,
                    text: titleLabelText
                )
            ]
            let controller = LightboxController(images: images)
            controller.dynamicBackground = true
            controller.footerView.pageLabel.isHidden = true
            DispatchQueue.main.async {
                self.present(controller, animated: true, completion: nil)
            }
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getArrayCount()
    }
    
    // MARK: - handle cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let unwrappedCell = collectionView.dequeueReusableCell(withReuseIdentifier: categoryDetailCellID, for: indexPath) as? CategoryDetailCell else { return UICollectionViewCell() }
        unwrappedCell.setterObj = viewModel.getItem(at: indexPath.item)
        return unwrappedCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let equalCellWidthHeight = (UIScreen.main.bounds.width / 3.0) - 8.0
        return CGSize(width: equalCellWidthHeight, height: equalCellWidthHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
}
