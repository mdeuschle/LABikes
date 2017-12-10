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
    var favoriteIndex: Int?
    private var favoriteBikes = [Bike]()

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
        favoriteBikes = Dao().unarchiveFavorites()
        if let favoriteIndex = favoriteBikes.index(where: { $0.kioskId == bike?.kioskId }) {
            isFavorite.isOn = true
            self.favoriteIndex = favoriteIndex
        }
    }
    
    @IBAction func favoriteSwitched(_ sender: UISwitch) {
        guard let bike = bike else {
            return
        }
        if sender.isOn {
            favoriteBikes.append(bike)
            Dao().acrchiveFavorites(favoriteBikes: favoriteBikes)
        } else {
            if let index = favoriteIndex {
                favoriteBikes.remove(at: index)
                Dao().acrchiveFavorites(favoriteBikes: favoriteBikes)
            }
        }
    }
}
