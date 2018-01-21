//
//  ListVC.swift
//  LABikes
//
//  Created by Matt Deuschle on 10/21/17.
//  Copyright © 2017 Matt Deuschle. All rights reserved.
//

import UIKit

class ListVC: UIViewController {

    @IBOutlet weak private var bikeTableView: UITableView!
    @IBOutlet weak private var favoritesSegmentedControl: UISegmentedControl!

    private var bikes = DataManager.shared.bikes
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
        tabBarController?.tabBar.items?[1].title = TabBarName.list.rawValue
        self.definesPresentationContext = true
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tabBarController?.tabBar.isHidden = false
        favoriteBikes = Dao.shared.unarchiveFavorites()
        bikeTableView.reloadData()
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

    @IBAction func favoritesSegmentedControlSelected(_ sender: UISegmentedControl) {
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
        let bikeDetailVC = BikeDetailVC(nibName: NibName.bikeDetailView.rawValue, bundle: nil)
        bikeDetailVC.bike = getBikesList()[indexPath.row]
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
            return DataManager.shared.bikes
        }
    }
}

extension ListVC: UISearchResultsUpdating, UISearchControllerDelegate {

    func updateSearchResults(for searchController: UISearchController) {
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        if let text = searchController.searchBar.text, !text.isEmpty {
            isFiltering = true
            if isFavorites {
                filteredFavorites = favoriteBikes.filter { $0.name.lowercased().contains(text.lowercased()) }
                bikeTableView.reloadData()
            } else {
                filteredBikes = DataManager.shared.bikes.filter { $0.name.lowercased().contains(text.lowercased()) }
                bikeTableView.reloadData()
            }
        } else {
            isFiltering = false
            filteredBikes = [Bike]()
            filteredFavorites = [Bike]()
            bikeTableView.reloadData()
            view.endEditing(true)
        }
    }
}








