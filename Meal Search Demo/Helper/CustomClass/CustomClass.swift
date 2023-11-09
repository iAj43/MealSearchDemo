//
//  CustomClass.swift
//  Meal Search Demo
//
//  Created by NeoSOFT on 08/11/23.
//

import UIKit
//
// MARK: - CustomSemiRoundView
//
class CustomSemiRoundView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 0.5
        layer.cornerRadius = 5.0
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
// MARK: - CustomThumbImageView
//
class CustomThumbImageView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .lightGray.withAlphaComponent(0.1)
        contentMode = .scaleAspectFill
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
// MARK: - CustomHeadingTwoTitleLabel
//
class CustomHeadingTwoTitleLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        textColor = .black
        font = .systemFont(ofSize: 17, weight: .medium)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
// MARK: - CustomHeadingThreeTitleLabel
//
class CustomHeadingThreeTitleLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        textColor = UIColor.darkGray
        font = .systemFont(ofSize: 14, weight: .medium)
        numberOfLines = 2
        lineBreakMode = .byWordWrapping
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
// MARK: - CustomHeadingThreeSubTitleLabel
//
class CustomHeadingThreeSubTitleLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        textColor = .darkGray
        font = .systemFont(ofSize: 15, weight: .light)
        numberOfLines = 0
        lineBreakMode = .byWordWrapping
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
// MARK: - CustomPlainButton
//
class CustomPlainButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        setTitleColor(.systemBlue, for: .normal)
        titleLabel?.font = .systemFont(ofSize: 15)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
// MARK: - CustomTapGestureRecognizer
//
class CustomTapGestureRecognizer: UITapGestureRecognizer {
    var index = Int()
}
