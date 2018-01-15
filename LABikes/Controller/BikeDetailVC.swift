//
//  BikeDetailVC.swift
//  LABikes
//
//  Created by Matt Deuschle on 11/25/17.
//  Copyright © 2017 Matt Deuschle. All rights reserved.
//

import UIKit

class BikeDetailVC: UIViewController {

    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak private var isFavoriteSwitch: UISwitch!

    var bike: Bike?
    var delegate: RefreshBikeListDelegate?

    init(delegate: RefreshBikeListDelegate) {
        self.delegate = delegate
        super.init(nibName: "BikeDetailView", bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        if let bike = bike {
            isFavoriteSwitch.isOn = bike.isFavorite
        }
        title = bike?.name
        print("VDL")

    }
    
    @IBAction func favoriteSwitched(_ sender: UISwitch) {
        guard let bike = bike else {
            return
        }
        var favorites = Dao.shared.unarchiveFavorites()
        bike.adjustFavorite(isFavorite: sender.isOn)
        if sender.isOn {
            favorites.append(bike)
            Dao.shared.acrchiveFavorites(favoriteBikes: favorites)
        } else {
            if let index = bike.getFavoriteIndex(favorites: favorites) {
                favorites.remove(at: index)
                Dao.shared.acrchiveFavorites(favoriteBikes: favorites)
            }
        }
        delegate?.refreshBikeList()
    }
}
