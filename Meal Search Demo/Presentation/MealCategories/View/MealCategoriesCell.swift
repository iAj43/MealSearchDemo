//
//  MealCategoriesCell.swift
//  Meal Search Demo
//
//  Created by NeoSOFT on 07/11/23.
//

import UIKit
import SDWebImage

class MealCategoriesCell: UITableViewCell {
    
    // MARK: - setup variable
    var categorySubTitleLabelHeightConstraint: NSLayoutConstraint?
    var viewMoreButtonWidthConstraint: NSLayoutConstraint?
    var viewMoreButtonHeightConstraint: NSLayoutConstraint?
    
    // MARK: - setup UI
    let mainView: CustomSemiRoundView = {
        let view = CustomSemiRoundView()
        return view
    }()
    
    let categoryImageView: CustomThumbImageView = {
        let imageView = CustomThumbImageView(frame: .zero)
        imageView.layer.cornerRadius = 28
        return imageView
    }()
    
    let categoryTitleLabel: CustomHeadingTwoTitleLabel = {
        let label = CustomHeadingTwoTitleLabel()
        return label
    }()
    
    let categorySubTitleLabel: CustomHeadingThreeSubTitleLabel = {
        let label = CustomHeadingThreeSubTitleLabel()
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    let viewMoreButton: CustomPlainButton = {
        let button = CustomPlainButton()
        button.titleLabel?.textAlignment = .right
        button.isHidden = true
        return button
    }()
    
    //
    // MARK: - setterObj
    //
    var setterObj: Categories? {
        //
        didSet {
            //
            if let imageURL = setterObj?.categoryThumbStr {
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
            if let categoryTitleStr = setterObj?.categoryTitleStr,
               !categoryTitleStr.isEmpty {
                categoryTitleLabel.text = categoryTitleStr
            } else {
                categoryTitleLabel.text = nil
            }
            
            //
            if let categoryDescriptionStr = setterObj?.categoryDescriptionStr,
               !categoryDescriptionStr.isEmpty {
                categorySubTitleLabel.text = categoryDescriptionStr
                //
                if let isShowViewMoreButton = setterObj?.isShowViewMoreButton,
                   isShowViewMoreButton == true {
                    viewMoreButton.isHidden = false
                    viewMoreButtonHeightConstraint?.constant = 30
                } else {
                    viewMoreButton.isHidden = true
                    viewMoreButtonHeightConstraint?.constant = 0
                }
                //
                if let dynamicHeight = setterObj?.dynamicHeight {
                    if dynamicHeight > 36 {
                        viewMoreButton.setTitle("Hide", for: .normal)
                        categorySubTitleLabelHeightConstraint?.constant = categoryDescriptionStr.heightWithConstrainedWidth(MEAL_CATEGORIES_SUB_TITLE_PADDING, font: .systemFont(ofSize: 15, weight: .light)) ?? 0
                        categorySubTitleLabel.numberOfLines = 0
                        categorySubTitleLabel.lineBreakMode = .byWordWrapping
                        viewMoreButtonWidthConstraint?.constant = 42
                    } else {
                        viewMoreButton.setTitle("View More", for: .normal)
                        categorySubTitleLabelHeightConstraint?.constant = 36
                        categorySubTitleLabel.numberOfLines = 2
                        categorySubTitleLabel.lineBreakMode = .byTruncatingTail
                        viewMoreButtonWidthConstraint?.constant = 92
                    }
                }
            } else {
                categorySubTitleLabel.attributedText = nil
                viewMoreButton.isHidden = true
                viewMoreButtonHeightConstraint?.constant = 0
                viewMoreButtonWidthConstraint?.constant = 0
            }
        }
    }

    //
    // MARK: - init
    //
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupAutoLayout()
    }
    
    func setupViews() {
        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        contentView.addSubview(mainView)
        mainView.addSubview(categoryImageView)
        mainView.addSubview(categoryTitleLabel)
        mainView.addSubview(categorySubTitleLabel)
        mainView.addSubview(viewMoreButton)
    }
    
    func setupAutoLayout() {
        mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        mainView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
        
        categoryImageView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 12).isActive = true
        categoryImageView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 16).isActive = true
        categoryImageView.widthAnchor.constraint(equalToConstant: 56).isActive = true
        categoryImageView.heightAnchor.constraint(equalToConstant: 56).isActive = true
        
        categoryTitleLabel.leadingAnchor.constraint(equalTo: categoryImageView.trailingAnchor, constant: 12).isActive = true
        categoryTitleLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -16).isActive = true
        categoryTitleLabel.topAnchor.constraint(equalTo: categoryImageView.topAnchor, constant: 2).isActive = true
        categoryTitleLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true
        
        categorySubTitleLabel.leadingAnchor.constraint(equalTo: categoryTitleLabel.leadingAnchor).isActive = true
        categorySubTitleLabel.trailingAnchor.constraint(equalTo: categoryTitleLabel.trailingAnchor).isActive = true
        categorySubTitleLabel.topAnchor.constraint(equalTo: categoryTitleLabel.bottomAnchor, constant: 4).isActive = true
        categorySubTitleLabelHeightConstraint = categorySubTitleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 32)
        categorySubTitleLabelHeightConstraint?.isActive = true
        
        viewMoreButton.trailingAnchor.constraint(equalTo: categoryTitleLabel.trailingAnchor).isActive = true
        viewMoreButton.topAnchor.constraint(equalTo: categorySubTitleLabel.bottomAnchor).isActive = true
        viewMoreButtonWidthConstraint = viewMoreButton.widthAnchor.constraint(equalToConstant: 92)
        viewMoreButtonWidthConstraint?.isActive = true
        viewMoreButtonHeightConstraint = viewMoreButton.heightAnchor.constraint(equalToConstant: 30)
        viewMoreButtonHeightConstraint?.isActive = true
        viewMoreButton.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -10).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
