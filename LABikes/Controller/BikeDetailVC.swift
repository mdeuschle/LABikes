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
    var tableView: UITableView!
    var detail: Detail!
    var details = [Detail]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        title = bike?.bikesAvailable.bikesString()
        tableView = UITableView(frame: view.frame)
        tableView.delegate = self
        tableView.dataSource = self
        if let tableView = tableView {
            view.addSubview(tableView)
        }
        detail = Detail(bike: bike!)
        details = detail.getDetails()
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
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        let detail = details[indexPath.row]
        cell.textLabel?.text = detail.label
        cell.detailTextLabel?.text = detail.detail
        return cell
    }
}






