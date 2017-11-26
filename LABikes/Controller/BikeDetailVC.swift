//
//  BikeDetailVC.swift
//  LABikes
//
//  Created by Matt Deuschle on 11/25/17.
//  Copyright © 2017 Matt Deuschle. All rights reserved.
//

import UIKit

class BikeDetailVC: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var isFavorite: UISwitch!
    var bike: Bike?

    init() {
        super.init(nibName: "BikeDetailVC", bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        nameLabel.text = bike?.name
    }
    
    @IBAction func favoriteSwitched(_ sender: UISwitch) {
    }
}
