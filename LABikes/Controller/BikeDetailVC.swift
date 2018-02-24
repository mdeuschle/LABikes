//
//  BikeDetailVC.swift
//  LABikes
//
//  Created by Matt Deuschle on 11/25/17.
//  Copyright © 2017 Matt Deuschle. All rights reserved.
//

import UIKit

class BikeDetailVC: UIViewController {

    var bike: Bike?
    private var tableView: UITableView?
    private var detail: Detail?
    private var section: Section?
    private var favoriteCell: UITableViewCell?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = NavigationTitle.stationDetails.rawValue
        tableView = UITableView()
        configTableView()
        let nib = UINib(nibName: NibName.detailCell.rawValue, bundle: nil)
        tableView?.register(nib, forCellReuseIdentifier: ReusableCell.detailCell.rawValue)
        if let bike = bike {
            detail = Detail(bike: bike)
            section = Section(detail: detail!)
        }
        tableView?.rowHeight = UITableViewAutomaticDimension
        tableView?.estimatedRowHeight = 64
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        tableView?.reloadData()
    }

    private func configTableView() {
        guard let tableView = tableView else {
            return
        }
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

extension BikeDetailVC: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return section?.headers.count ?? 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.section?.configRowCount(section: section) ?? 0
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.section?.headers[section].rawValue
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell =  section?.configCell(tableView: tableView, indexPath: indexPath) as? DetailCell else {
            return UITableViewCell()
        }
        cell.favoriteSwtich.addTarget(self, action: #selector(favoriteSwitchIsSelected(_:)), for: .valueChanged)
        return cell
    }

    @objc private func favoriteSwitchIsSelected(_ sender: UISwitch) {
        if let bike = bike {
            bike.adjustFavorite(isFavorite: !bike.isFavorite)
            FavoritesService.shared.updateFavorites(bike: bike)
            tableView?.reloadData()
        }
    }
}








