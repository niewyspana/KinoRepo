//
//  MainViewController.swift
//  Kino
//
//  Created by Viktoriya Polozova on 15/08/2024.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    
    private var collectionHeaderView = HeaderView.loadFromNib()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addHeaderView()
        addTableHeaderView()
    }
    
    private func addHeaderView() {
        collectionHeaderView.configure(with: "Now Showing", buttonTitle: "See more")
        view.addSubview(collectionHeaderView)
        
        collectionHeaderView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [collectionHeaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
             collectionHeaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
             collectionHeaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
             collectionHeaderView.heightAnchor.constraint(equalToConstant: 44)]
        )
    }
    
    private func addTableHeaderView() {
        let tableHeaderView = HeaderView.loadFromNib()
        tableHeaderView.configure(with: "Popular", buttonTitle: "See more")
        view.addSubview(tableHeaderView)
        
        tableHeaderView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [tableHeaderView.topAnchor.constraint(equalTo: collectionView.bottomAnchor),
             tableHeaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
             tableHeaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
             tableHeaderView.heightAnchor.constraint(equalToConstant: 44)]
        )
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        refreshCollectionViewTopConstraint()
    }
    
    private func refreshCollectionViewTopConstraint() {
        collectionViewTopConstraint.constant = collectionHeaderView.frame.maxY
    }
}
