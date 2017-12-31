//
//  BikeDetailVC.swift
//  LABikes
//
//  Created by Matt Deuschle on 11/25/17.
//  Copyright © 2017 Matt Deuschle. All rights reserved.
//

import UIKit
import Lottie

class BikeDetailVC: UIViewController {

    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak private var isFavoriteSwitch: UISwitch!

    var bike: Bike?
    var refreshBikeListDelegate: RefreshBikeListDelegate?

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
        if let bike = bike {
            isFavoriteSwitch.isOn = bike.isFavorite
        }
        title = "LABikes"
        let lottieView = LottieView(frame: view.frame)
        lottieView.configure(view: view)
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
        refreshBikeListDelegate?.refreshBikeList()
    }
}
