//
//  DetailVC.swift
//  LABikes
//
//  Created by Matt Deuschle on 10/7/17.
//  Copyright © 2017 Matt Deuschle. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {

    @IBOutlet weak var detailMapView: MKMapView!
    @IBOutlet weak var detailTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        detailTableView.delegate = self
        detailTableView.dataSource = self

    }
}

extension DetailVC: UITableViewDelegate, UITableViewDataSource {

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



