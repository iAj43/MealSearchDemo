//
//  CategoryDetailCell.swift
//  Meal Search Demo
//
//  Created by NeoSOFT on 07/11/23.
//

import UIKit

class CategoryDetailCell: UICollectionViewCell {
    
    //
    // MARK: - setup UI
    //
    let mainView: CustomSemiRoundView = {
        let view = CustomSemiRoundView()
        return view
    }()
    
    let categoryImageView: CustomThumbImageView = {
        let imageView = CustomThumbImageView(frame: .zero)
        imageView.layer.cornerRadius = CATEGORY_DETAIL_THUMB_IMAGEVIEW_WIDTH / 2.0
        return imageView
    }()
    
    let categoryTitleLabel: CustomHeadingThreeTitleLabel = {
        let label = CustomHeadingThreeTitleLabel()
        label.textAlignment = .center
        return label
    }()
    
    //
    // MARK: - setterObj
    //
    var setterObj: Meals? {
        //
        didSet {
            //
            if let imageURL = setterObj?.mealThumbStr {
                categoryImageView.sd_setImage(with: URL(string: imageURL), placeholderImage: nil, completed: { (image, error, type, url) in
                    if image != nil {
                        self.categoryImageView.image = image
                    } else {
                        self.categoryImageView.image = nil
                    }
                })
            } else {
                self.categoryImageView.image = nil
            }
            
            //
            if let mealStr = setterObj?.mealStr,
               !mealStr.isEmpty {
                categoryTitleLabel.text = mealStr
            } else {
                categoryTitleLabel.text = nil
            }
        }
    }
    
    //
    // MARK: - init
    //
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupAutoLayout()
    }
    
    func setupViews() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        contentView.addSubview(mainView)
        mainView.addSubview(categoryImageView)
        mainView.addSubview(categoryTitleLabel)
    }
    
    func setupAutoLayout() {
        mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true
        mainView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
        
        categoryImageView.centerXAnchor.constraint(equalTo: mainView.centerXAnchor).isActive = true
        categoryImageView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 8).isActive = true
        categoryImageView.widthAnchor.constraint(equalToConstant: CATEGORY_DETAIL_THUMB_IMAGEVIEW_WIDTH).isActive = true
        categoryImageView.heightAnchor.constraint(equalToConstant: CATEGORY_DETAIL_THUMB_IMAGEVIEW_WIDTH).isActive = true
        
        categoryTitleLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 4).isActive = true
        categoryTitleLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -4).isActive = true
        categoryTitleLabel.topAnchor.constraint(equalTo: categoryImageView.bottomAnchor, constant: 4).isActive = true
        categoryTitleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 16).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
