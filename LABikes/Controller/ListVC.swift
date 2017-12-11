//
//  ListVC.swift
//  LABikes
//
//  Created by Matt Deuschle on 10/21/17.
//  Copyright © 2017 Matt Deuschle. All rights reserved.
//

import UIKit
import CoreLocation

class ListVC: UIViewController, AdjustFavoriteBikeDelegate {

    @IBOutlet weak private var bikeTableView: UITableView!
    @IBOutlet weak private var favoritesSegmentedControl: UISegmentedControl!

    var location: CLLocation?
    var bikes = [Bike]()
    private var favoriteBikes = [Bike]()
    private var filteredBikes = [Bike]()
    private var filteredFavorites = [Bike]()

    private var isFavorites = false
    private var isFiltering = false

    override func viewDidLoad() {
        super.viewDidLoad()
        bikeTableView.delegate = self
        bikeTableView.dataSource = self
        navigationController?.view.backgroundColor = .white
        title = NavigationTitle.laBikes.rawValue
        configureSearch()
        favoriteBikes = Dao().unarchiveFavorites()
    }

    private func configureSearch() {
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        if #available(iOS 11.0, *) {
            navigationItem.searchController = search
            navigationItem.hidesSearchBarWhenScrolling = false
        } else {
            navigationItem.titleView = search.searchBar
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }

    func addFavoriteBike(bike: Bike) {
        bike.adjustFavorite(isFavorite: true)
        favoriteBikes.append(bike)
        Dao().acrchiveFavorites(favoriteBikes: favoriteBikes)
        refreshBikes()
    }

    func removeFavoriteBike(bike: Bike) {
        bike.adjustFavorite(isFavorite: false)
        if let index = bike.getFavoriteIndex(favorites: favoriteBikes) {
            favoriteBikes.remove(at: index)
            Dao().acrchiveFavorites(favoriteBikes: favoriteBikes)
            refreshBikes()
        }
    }

    private func refreshBikes() {
        if let location = location {
            DataService.shared.fetchBikeData(currentLocation: location, completion: { (success, bikes) in
                if success {
                    if let unwrappedBikes = bikes {
                        self.bikes = unwrappedBikes
                        self.bikeTableView.reloadData()
                    }
                }
            })
        }
    }

    @IBAction func favoritesSegmentedControlSelected(_ sender: UISegmentedControl) {
        favoriteBikes = Dao().unarchiveFavorites()
        if sender.selectedSegmentIndex == 0 {
            isFavorites = false
        } else {
            isFavorites = true
        }
        bikeTableView.reloadData()
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
        bikeDetailVC.bike = getBikesList()[indexPath.row]
        bikeDetailVC.adjustFavoriteBikeDelegate = self
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








