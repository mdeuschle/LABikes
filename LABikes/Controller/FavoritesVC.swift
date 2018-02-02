//
//  FavoritesVC.swift
//  LABikes
//
//  Created by Matt Deuschle on 1/29/18.
//  Copyright © 2018 Matt Deuschle. All rights reserved.
//

import UIKit

class FavoritesVC: UIViewController {
    
    @IBOutlet weak var favoriteTableView: UITableView!

    private var favoriteBikes = Dao.shared.unarchiveFavorites()
    private var filteredFavorites = [Bike]()
    private var isFiltering = false

    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteTableView.delegate = self
        favoriteTableView.dataSource = self
        title = NavigationTitle.favorites.rawValue
        configureSearch()
        self.definesPresentationContext = true
        let nib = UINib(nibName: NibName.bikeCell.rawValue, bundle: nil)
        favoriteTableView.register(nib, forCellReuseIdentifier: ReusableCell.listCell.rawValue)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tabBarController?.tabBar.isHidden = false
        favoriteBikes = Dao.shared.unarchiveFavorites()
        favoriteTableView.reloadData()
    }

    private func configureSearch() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.delegate = self
        if #available(iOS 11.0, *) {
            navigationItem.searchController = searchController
            navigationItem.hidesSearchBarWhenScrolling = false
        } else {
            navigationItem.titleView = searchController.searchBar
        }
    }
}

extension FavoritesVC: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bikes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReusableCell.listCell.rawValue, for: indexPath) as? BikeCell else {
            return UITableViewCell()
        }
        let bike = bikes[indexPath.row]
        cell.config(bike: bike)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let bikeDetailVC = BikeDetailVC(nibName: NibName.bikeDetailView.rawValue, bundle: nil)
        let bike = bikes[indexPath.row]
        bikeDetailVC.bike = bike
        let detail = Detail(bike: bike)
        let details = detail.getDetails()
        bikeDetailVC.details = details
        navigationController?.pushViewController(bikeDetailVC, animated: true)
    }

    private var bikes: [Bike] {
        if isFiltering {
            return filteredFavorites
        } else {
            return favoriteBikes
        }
    }
}

extension FavoritesVC: UISearchResultsUpdating, UISearchControllerDelegate {

    func updateSearchResults(for searchController: UISearchController) {
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        if let text = searchController.searchBar.text, !text.isEmpty {
            isFiltering = true
            filteredFavorites = favoriteBikes.filter { $0.name.lowercased().contains(text.lowercased()) }
            favoriteTableView.reloadData()
        } else {
            isFiltering = false
            filteredFavorites = [Bike]()
            favoriteTableView.reloadData()
            view.endEditing(true)
        }
    }
}
