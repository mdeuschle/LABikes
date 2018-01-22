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
    var details = [Detail]()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Station Details"
        tabBarController?.tabBar.isHidden = true
        tableView = UITableView()
        configTableView()
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
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return details.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = DetailCell(style: .subtitle, reuseIdentifier: "detailCell")
        cell.config(details: details, indexPathRow: indexPath.row)
        return cell
    }
}






