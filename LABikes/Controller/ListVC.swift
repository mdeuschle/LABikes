//
//  ListVC.swift
//  LABikes
//
//  Created by Matt Deuschle on 10/21/17.
//  Copyright © 2017 Matt Deuschle. All rights reserved.
//

import UIKit
import CoreLocation

class ListVC: UIViewController, FavoriteBikeDelegate {

    @IBOutlet weak var bikeTableView: UITableView!
    private let spinner = UIActivityIndicatorView()
    var bikes: [Bike] = [Bike]() {
        didSet {
            if let tableView = bikeTableView {
                tableView.reloadData()
            }
        }
    }

    fileprivate var filteredBikes = [Bike]()
    fileprivate var favoriteBikes = [Bike]()
    fileprivate var isFiltering = false

    override func viewDidLoad() {
        super.viewDidLoad()
        bikeTableView.delegate = self
        bikeTableView.dataSource = self
        title = NavigationTitle.laBikes.rawValue
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        if #available(iOS 11.0, *) {
            navigationItem.searchController = search
            navigationItem.hidesSearchBarWhenScrolling = false
        } else {
            navigationItem.titleView = search.searchBar
        }
        favoriteBikes = Dao().loadFavorites()
        for bike in favoriteBikes {
            print("BIKE: \(bike.kioskId)")
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }

    func favoriteBikeSelected(bike: Bike) {
        favoriteBikes.append(bike)
        Dao().saveFavorites(bikes: favoriteBikes)
    }
}

extension ListVC: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltering ? filteredBikes.count : bikes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReusableCell.bike.rawValue) as? BikeCell else {
            return BikeCell()
        }
        let bike = isFiltering ? filteredBikes[indexPath.row] : bikes[indexPath.row]
        cell.config(bike: bike)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let bikeDetailVC = BikeDetailVC()
        bikeDetailVC.bike = bikes[indexPath.row]
        bikeDetailVC.favoriteBikeDelegate = self
        navigationController?.pushViewController(bikeDetailVC, animated: true)
    }
}

extension ListVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text, !text.isEmpty {
            filteredBikes = bikes.filter { $0.name.lowercased().contains(text.lowercased()) }
            isFiltering = true
        } else {
            isFiltering = false
            filteredBikes = [Bike]()
        }
        bikeTableView.reloadData()
    }
}








