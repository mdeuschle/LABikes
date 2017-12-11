//
//  BikeDetailVC.swift
//  LABikes
//
//  Created by Matt Deuschle on 11/25/17.
//  Copyright © 2017 Matt Deuschle. All rights reserved.
//

import UIKit

protocol AdjustFavoriteBikeDelegate {
    func addFavoriteBike(bike: Bike)
    func removeFavoriteBike(bike: Bike)
}

class BikeDetailVC: UIViewController {

    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak private var isFavoriteSwitch: UISwitch!
    var bike: Bike?
    var adjustFavoriteBikeDelegate: AdjustFavoriteBikeDelegate?

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
        if let favorite = bike?.isFavorite {
            isFavoriteSwitch.isOn = favorite
        }
    }
    
    @IBAction func favoriteSwitched(_ sender: UISwitch) {
        guard let bike = bike else {
            return
        }
        if sender.isOn {
            adjustFavoriteBikeDelegate?.addFavoriteBike(bike: bike)
        } else {
            adjustFavoriteBikeDelegate?.removeFavoriteBike(bike: bike)
        }
    }
}
