//
//  UIView+Extension.swift
//  Kino
//
//  Created by Viktoriya Polozova on 09/09/2024.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
}
