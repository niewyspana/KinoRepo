//
//  MainViewController.swift
//  Kino
//
//  Created by Viktoriya Polozova on 15/08/2024.
//

import UIKit

class MainViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var collectionViewTopConstraint: NSLayoutConstraint!
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Public variables
    var viewModel: MainScreenViewModel!
    
    // MARK: - Private variables
    private var collectionHeaderView = HeaderView.loadFromNib()
    private var tableHeaderView = HeaderView.loadFromNib()
    
    // MARK: - View controller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addHeaderView()
        addTableHeaderView()
        addTableView()
        setUpCollectionView()
        setUpTableView()
        bindViewModel()
        viewModel.loadNowShowingMovies()
        viewModel.loadPopularMovies()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        refreshCollectionViewTopConstraint()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.layoutIfNeeded()
        navigationController?.navigationBar.tintColor = .blue
    }
    
    // MARK: - Private methods
    
    private func bindViewModel() {
        viewModel.onNowShowingMoviesLoaded = { [weak self] in
            self?.collectionView.reloadData()
        }
        viewModel.onPopularMoviesLoaded = { [weak self] in
            self?.tableView.reloadData()
        }
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
        
        collectionHeaderView.seeMoreClosure = { [weak self] in
            self?.viewModel.seeMorePressed()
        }
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
        
        tableHeaderView.seeMoreClosure = { [weak self] in
            self?.viewModel.seeMorePressed()
        }
    }
    
    private func addTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [tableView.topAnchor.constraint(equalTo: tableHeaderView.bottomAnchor),
             tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
             tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
             tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)]
        )
    }
    
    private func refreshCollectionViewTopConstraint() {
        collectionViewTopConstraint.constant = collectionHeaderView.frame.minY + collectionHeaderView.frame.height
    }
    
    private func setUpCollectionView() {
        collectionView.register(NowShowingCollectionViewCell.nib, forCellWithReuseIdentifier: NowShowingCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 144, height: 280)
        layout.scrollDirection = .horizontal
        collectionView.setCollectionViewLayout(layout, animated: true)
        
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    private func setUpTableView() {
        tableView.register(PopularTableViewCell.nib, forCellReuseIdentifier: PopularTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        viewModel.didSelectNowShowing(at: indexPath)
    }
}

// MARK: - UICollectionViewDataSource
extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.nowShowingMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NowShowingCollectionViewCell.identifier, for: indexPath) as! NowShowingCollectionViewCell
        
        cell.configure(movieInfo: viewModel.nowShowingMovies[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.popularMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PopularTableViewCell.identifier, for: indexPath) as! PopularTableViewCell
        
        cell.configure(movieInfo: viewModel.popularMovies[indexPath.row])
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectPopular(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let inset: CGFloat = 8
        let maskLayer = CALayer()
        maskLayer.frame = CGRect(
            x: cell.bounds.origin.x,
            y: cell.bounds.origin.y + inset,
            width: cell.bounds.width,
            height: cell.bounds.height - 2 * inset
        )
        let maskView = UIView(frame: maskLayer.frame)
        maskView.layer.masksToBounds = true
        maskView.layer.cornerRadius = 10
        maskView.backgroundColor = .white
        
        cell.backgroundView = maskView
        cell.backgroundColor = .clear
        tableView.backgroundColor = UIColor.clear
    }
}
