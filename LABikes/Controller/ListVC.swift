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

    private var filteredBikes = [Bike]()
    private var isFiltering = false

    override func viewDidLoad() {
        super.viewDidLoad()
        bikeTableView.delegate = self
        bikeTableView.dataSource = self
        title = NavigationTitle.laBikes.rawValue
        configureSearch()
        tabBarController?.tabBar.items?[1].title = TabBarName.list.rawValue
        self.definesPresentationContext = true
        let nib = UINib(nibName: NibName.bikeCell.rawValue, bundle: nil)
        bikeTableView.register(nib, forCellReuseIdentifier: ReusableCell.listCell.rawValue)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tabBarController?.tabBar.isHidden = false
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
}

extension ListVC: UITableViewDelegate, UITableViewDataSource {

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

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let bikeDetailVC = BikeDetailVC(nibName: NibName.bikeDetailView.rawValue, bundle: nil)
        let bike = bikes[indexPath.row]
        bikeDetailVC.bike = bike
        navigationController?.pushViewController(bikeDetailVC, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    private var bikes: [Bike] {
        if isFiltering {
            return filteredBikes
        } else {
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
            filteredBikes = DataManager.shared.bikes.filter { $0.name.lowercased().contains(text.lowercased()) }
            bikeTableView.reloadData()
        } else {
            isFiltering = false
            filteredBikes = [Bike]()
            bikeTableView.reloadData()
            view.endEditing(true)
        }
    }
}










