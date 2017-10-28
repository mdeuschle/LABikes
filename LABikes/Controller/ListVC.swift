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
    var bikes = [Bike]()

    override func viewDidLoad() {
        super.viewDidLoad()
        bikeTableView.delegate = self
        bikeTableView.dataSource = self
        if let navController = tabBarController?.viewControllers?.first as? UINavigationController {
            if let rootVC = navController.viewControllers.first as? RootVC {
                DataService.shared.fetchBikeData(currentLocation: rootVC.currentLocation, completion: { (success, bikes) in
                    if success {
                        if let bikes = bikes {
                            self.bikes = bikes
                            self.bikeTableView.reloadData()
                        }
                    }
                })
            }
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReusableCell.bike.rawValue) as? BikeCell else {
            return BikeCell()
        }
        let bike = bikes[indexPath.row]
        cell.config(bike: bike)
        return cell
    }
}






