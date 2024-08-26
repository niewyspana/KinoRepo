//
//  HeaderView.swift
//  Kino
//
//  Created by Viktoriya Polozova on 15/08/2024.
//

import UIKit

class HeaderView: UIView {
    
    @IBOutlet private weak var label: UILabel!
    @IBOutlet private weak var button: UIButton!
    
    var seeMoreClosure: (() -> Void)?
    
    static func loadFromNib() -> HeaderView {
        let nib = UINib(nibName: "HeaderView", bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first as! HeaderView
    }
    
    func configure(with title: String, buttonTitle: String) {
        label.text = title
        let buttonTitleWithSpaces = "   " + buttonTitle + "   "
        button.setTitle(buttonTitleWithSpaces, for: .normal)
        setupButtonAppearance()
    }
    
    private func setupButtonAppearance() {
        button.layer.borderColor = UIColor(named: "GrayE5E4EA")?.cgColor
        button.layer.borderWidth = 1.0
        button.layer.cornerRadius = button.frame.height / 2
        button.layer.masksToBounds = true
    }
    
    @IBAction func seeMoreAction(_ sender: Any) {
        seeMoreClosure?()
    }
}
