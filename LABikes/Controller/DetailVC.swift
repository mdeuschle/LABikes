//
//  DetailVC.swift
//  LABikes
//
//  Created by Matt Deuschle on 10/8/17.
//  Copyright © 2017 Matt Deuschle. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {

    @IBOutlet weak var detailTableView: UITableView!
    
    var selectedBike: Bike?

    override func viewDidLoad() {
        super.viewDidLoad()
        detailTableView.delegate = self
        detailTableView.dataSource = self
        let nib = UINib(nibName: ReusableCell.map.rawValue, bundle: nil)
        detailTableView.register(nib, forCellReuseIdentifier: ReusableCell.map.rawValue)
        if let bike = selectedBike {
            title = bike.name
        }
    }
    func didSelectBike(bike: Bike) {
        title = bike.name
    }
}

extension DetailVC: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 260
        case 1:
            return 100
        default:
            return 100
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let mapCell = tableView.dequeueReusableCell(withIdentifier: ReusableCell.map.rawValue) as? MapCell else {
            return MapCell()
        }
        switch indexPath.row {
        case 0:
            return mapCell
        default:
            return UITableViewCell()
        }
    }
}



















