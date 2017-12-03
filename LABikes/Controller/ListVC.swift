//
//  ListVC.swift
//  LABikes
//
//  Created by Matt Deuschle on 10/21/17.
//  Copyright © 2017 Matt Deuschle. All rights reserved.
//

import UIKit
import CoreLocation

class ListVC: UIViewController {

    @IBOutlet weak var bikeTableView: UITableView!
    @IBOutlet weak var favoritesSegmentedControl: UISegmentedControl!
    private let spinner = UIActivityIndicatorView()
    var bikes: [Bike] = [Bike]() {
        didSet {
            if let tableView = bikeTableView {
                tableView.reloadData()
            }
        }
    }

    fileprivate var isFavorites = false
    fileprivate var isFiltering = false

    fileprivate var favoriteBikes = [Bike]()
    fileprivate var filteredBikes = [Bike]()
    fileprivate var filteredFavorites = [Bike]()

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
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }

    @IBAction func favoritesSegmentedControlSelected(_ sender: UISegmentedControl) {
        bikeTableView.reloadData()
        if sender.selectedSegmentIndex == 0 {
            isFavorites = false
        } else {
            isFavorites = true
        }
    }
}

extension ListVC: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getBikesList().count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReusableCell.bike.rawValue) as? BikeCell else {
            return BikeCell()
        }
        let bike = getBikesList()[indexPath.row]
        cell.config(bike: bike)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let bikeDetailVC = BikeDetailVC()
        bikeDetailVC.bike = bikes[indexPath.row]
        navigationController?.pushViewController(bikeDetailVC, animated: true)
    }

    private func getBikesList() -> [Bike] {
        let stateTuple = (isFiltering, isFavorites)
        switch stateTuple {
        case (true, true):
            return filteredFavorites
        case (true, false):
            return filteredBikes
        case (false, true):
            return favoriteBikes
        default:
            return bikes
        }
    }
}

extension ListVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text, !text.isEmpty {
            isFiltering = true
            if isFavorites {
                filteredFavorites = favoriteBikes.filter { $0.name.lowercased().contains(text.lowercased()) }
            } else {
                filteredBikes = bikes.filter { $0.name.lowercased().contains(text.lowercased()) }
            }
        } else {
            isFiltering = false
            filteredBikes = [Bike]()
            filteredFavorites = [Bike]()
        }
        bikeTableView.reloadData()
    }
}








