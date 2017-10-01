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

    override func viewDidLoad() {
        super.viewDidLoad()
        bikeTableView.delegate = self
        bikeTableView.dataSource = self
        let nib = UINib(nibName: ReusalbleCell.bike.rawValue, bundle: nil)
        bikeTableView.register(nib, forCellReuseIdentifier: ReusalbleCell.bike.rawValue)
    }
}

extension RootVC: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReusalbleCell.bike.rawValue, for: indexPath) as? BikeCell else {
            return BikeCell()
        }
        return cell
    }
}




