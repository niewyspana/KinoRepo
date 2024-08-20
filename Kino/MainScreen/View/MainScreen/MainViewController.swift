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
    private var tableHeaderView = HeaderView.loadFromNib()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addHeaderView()
        addTableHeaderView()
        addTableView()
        setUpCollectionView()
        setUpTableView()
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
    
    private func addTableView() {
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [tableView.topAnchor.constraint(equalTo: tableHeaderView.bottomAnchor),
             tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
             tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
             tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)]
        )
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        refreshCollectionViewTopConstraint()
    }
    
    private func refreshCollectionViewTopConstraint() {
        collectionViewTopConstraint.constant = collectionHeaderView.frame.maxY
    }
    
    private func setUpCollectionView() {
        collectionView.register(NowShowingCollectionViewCell.nib(), forCellWithReuseIdentifier: NowShowingCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 144, height: 280)
        layout.scrollDirection = .horizontal
        collectionView.setCollectionViewLayout(layout, animated: true)
        
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
    }
    
    private func setUpTableView() {
        tableView.register(PopularTableViewCell.nib(), forCellReuseIdentifier: PopularTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
    }
}

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        print("You tapped me")
    }
}
extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NowShowingCollectionViewCell.identifier, for: indexPath) as! NowShowingCollectionViewCell
        
        let mainImage = UIImage(named: "image")!
        let starImage = UIImage(named: "star")!
        
        let movieTitle = "The Neverending Story\(indexPath.row + 1)"
        let rating = "9.8/10.0 IMDb"
        
        
        cell.configure(with: mainImage, star: starImage, title: movieTitle, rating: rating)
        return cell
    }
}

extension MainViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        12
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PopularTableViewCell.identifier, for: indexPath) as! PopularTableViewCell
        let mainImage = UIImage(named: "image")!
        let starImage = UIImage(named: "star")!
        
        let movieTitle = "The Neverending Story\(indexPath.row + 1)"
        let rating = "9.8/10.0 IMDb"
        let timetext = "1h 30m"
        let clockImage = UIImage(named: "clock")!
        cell.configure(with: mainImage, star: starImage, title: movieTitle, rating: rating, timeText: timetext, clockImage: clockImage, genres: ["Horror","COMEDY"])
        
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 136 // Высота ячейки + отступы (120 + 16)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let inset: CGFloat = 8 // Отступ сверху и снизу по 8 поинтов, итого 16 пунктов
        let maskLayer = CALayer()
        maskLayer.frame = CGRect(
            x: cell.bounds.origin.x,
            y: cell.bounds.origin.y + inset,
            width: cell.bounds.width,
            height: cell.bounds.height - 2 * inset
        )
        let maskView = UIView(frame: maskLayer.frame)
        maskView.layer.masksToBounds = true
        maskView.layer.cornerRadius = 10 // Закругленные углы (если нужно)
        maskView.backgroundColor = .white // Цвет фона ячейки (можно настроить)
        
        cell.backgroundView = maskView
        cell.backgroundColor = .clear // Прозрачный фон ячейки
        tableView.backgroundColor = UIColor.clear // Прозрачный фон таблицы (если нужно)
    }
}

