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
    var tableView: UITableView?
    var detail: Detail?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = NavigationTitle.stationDetails.rawValue
        tabBarController?.tabBar.isHidden = true
        tableView = UITableView()
        configTableView()
        if let bike = bike {
            detail = Detail(bike: bike)
        }
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
        return 3
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let detail = detail else {
            return 0
        }
        switch section {
        case 0:
            return detail.stationDetails().count
        case 1:
            return detail.statusDetails().count
        case 2:
            return detail.locationDetails().count
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "STATION"
        case 1:
            return "STATUS"
        case 2:
            return "LOCATION"
        default:
            return ""
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let stationCell = DetailCell()
            if let stationDetail = detail?.stationDetails()[indexPath.row] {
                stationCell.config(with: stationDetail)
            }
            return stationCell
        case 1:
            let statusCell = DetailCell()
            if let statusDetail = detail?.statusDetails()[indexPath.row] {
                statusCell.config(with: statusDetail)
            }
            return statusCell
        case 2:
            let locationCell = DetailCell()
            if let locationDetail = detail?.locationDetails()[indexPath.row] {
                locationCell.config(with: locationDetail)
            }
            return locationCell
        default:
            return UITableViewCell()
        }
    }
}






