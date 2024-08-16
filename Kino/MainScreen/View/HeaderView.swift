//
//  HeaderView.swift
//  Kino
//
//  Created by Viktoriya Polozova on 15/08/2024.
//

import UIKit

class HeaderView: UIView {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!
    
    // Метод для загрузки из XIB
    static func loadFromNib() -> HeaderView {
            let nib = UINib(nibName: "HeaderView", bundle: nil)
            return nib.instantiate(withOwner: self, options: nil).first as! HeaderView
        }
    
    func configure(with text: String, buttonTitle: String?) {
            label.text = text
            if let title = buttonTitle {
                button.setTitle(title, for: .normal)
        }
    }
}
