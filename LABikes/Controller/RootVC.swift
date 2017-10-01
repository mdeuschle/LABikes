//
//  RootVC.swift
//  LABikes
//
//  Created by Matt Deuschle on 9/30/17.
//  Copyright © 2017 Matt Deuschle. All rights reserved.
//

import UIKit

class RootVC: UIViewController {

    @IBOutlet weak var bikeTableView: UITableView!
    var bikes = [Bike]()

    override func viewDidLoad() {
        super.viewDidLoad()
        bikeTableView.delegate = self
        bikeTableView.dataSource = self
        let nib = UINib(nibName: ReusalbleCell.bike.rawValue, bundle: nil)
        bikeTableView.register(nib, forCellReuseIdentifier: ReusalbleCell.bike.rawValue)
        DataService.instance.getBikeData { (success, bikes) in
            DispatchQueue.main.async {
                if success {
                    if let bikes = bikes {
                        for bike in bikes {
                            self.bikes.append(bike)
                            self.bikeTableView.reloadData()
                        }
                    } else {
                        print("BIKES NIL")
                    }
                } else {
                    print("UNABLE TO DOWNLOAD DATA")
                }
            }
        }
    }
}

extension RootVC: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bikes.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReusalbleCell.bike.rawValue, for: indexPath) as? BikeCell else {
            return BikeCell()
        }
        let bike = bikes[indexPath.row]
        cell.configCell(bike: bike)
        return cell
    }
}




