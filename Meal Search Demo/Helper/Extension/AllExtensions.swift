//
//  AllExtensions.swift
//  Meal Search Demo
//
//  Created by NeoSOFT on 07/11/23.
//

import Foundation
import UIKit
//
// MARK: - extension Encodable
//
extension Encodable {
    
    func toJSON() -> [String: Any] {
        let encoder = JSONEncoder()
        return (try? JSONSerialization.jsonObject(with: encoder.encode(self), options: .allowFragments)) as? [String: Any] ?? [:]
    }
}

//
// MARK: - extension String
//
extension String {
    
    func heightWithConstrainedWidth(_ width: CGFloat, font: UIFont) -> CGFloat? {
        let constraintRect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(
            with: constraintRect,
            options: NSStringDrawingOptions.usesLineFragmentOrigin,
            attributes: [NSAttributedString.Key.font: font],
            context: nil
        )
        return ceil(boundingBox.height)
    }
}

//
// MARK: - extension UIViewController
//
extension UIViewController {
    
    func showAlertWithAutoDismiss(title: String, message: String, time: CGFloat) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        present(alertController, animated: true) {
            DispatchQueue.main.asyncAfter(deadline: .now() + time) {
                alertController.dismiss(animated: true, completion: nil)
            }
        }
    }
}

//
// MARK: - extension UIView
//
extension UIView {
    
    func fillConstraintSuperview(constant: CGFloat = 0) {
        guard let superview = superview else {
            return
        }
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
                leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: constant),
                trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: constant),
                topAnchor.constraint(equalTo: superview.topAnchor, constant: constant),
                bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: constant)
            ]
        )
    }
}

//
// MARK: - extension UIView
//
extension UIView {
    
    // MARK: - set Layout Direction LTR and RTL
    func setLayoutDirectionLTRandRTL() {
        var languageCode = ""
        if #available(iOS 16.0, *) {
            if let language = NSLocale.current.language.languageCode {
                languageCode = language.identifier
            }
        } else {
            if let language = NSLocale.current.languageCode {
                languageCode = language
            }
        }
        if (languageCode.lowercased() == "ar") {
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
        } else {
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
        }
    }
}
