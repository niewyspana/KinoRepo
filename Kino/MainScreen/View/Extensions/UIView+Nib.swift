//
//  UIView+Nib.swift
//  Kino
//
//  Created by Viktoriya Polozova on 22/08/2024.
//

import UIKit

extension UIView {
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
}
