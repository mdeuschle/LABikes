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
    fileprivate var bikes = [Bike]()
    fileprivate var filteredBikes = [Bike]()
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
    }

    func loadBikeData() {
        if let navControllers = tabBarController?.viewControllers {
            if let navController = navControllers.first as? UINavigationController {
                if let rootVC = navController.topViewController as? RootVC {
                    bikes = rootVC.bikes
                }
            }
        }
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








