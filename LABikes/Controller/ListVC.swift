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

    override func viewDidLoad() {
        super.viewDidLoad()
        bikeTableView.delegate = self
        bikeTableView.dataSource = self
    }
}

extension ListVC: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}




