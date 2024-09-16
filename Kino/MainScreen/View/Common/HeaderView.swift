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
        addSwipeGesture()
        addTapGesture()
        addLongPressGesture()
    }
    
    private func setupButtonAppearance() {
        button.layer.borderColor = UIColor(named: "GrayE5E4EA")?.cgColor
        button.layer.borderWidth = 1.0
        button.layer.cornerRadius = button.frame.height / 2
        button.layer.masksToBounds = true
    }
    private func addSwipeGesture() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeRight(_:)))
        swipeRight.direction = .right
        self.addGestureRecognizer(swipeRight)
    }
    private func addTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        self.addGestureRecognizer(tapGesture)
        tapGesture.numberOfTapsRequired = 2
    }
    private func addLongPressGesture() {
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        longPressGesture.minimumPressDuration = 1
        self.addGestureRecognizer(longPressGesture)
    }
    
    @objc private func handleLongPress(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            self.backgroundColor = UIColor.systemYellow
        }
    }
    
    @objc private func handleTap(_ gesture: UITapGestureRecognizer) {
        self.backgroundColor = UIColor.systemPink
    }
    
    @objc private func handleSwipeRight(_ gesture: UISwipeGestureRecognizer) {
        self.backgroundColor = UIColor.systemTeal
    }
    
    @IBAction func seeMoreAction(_ sender: Any) {
        seeMoreClosure?()
    }
}
