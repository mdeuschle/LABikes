//
//  BikeDetailVC.swift
//  LABikes
//
//  Created by Matt Deuschle on 11/25/17.
//  Copyright © 2017 Matt Deuschle. All rights reserved.
//

import UIKit

protocol RefreshFavoritesDelegate {
    func refreshFavorites()
}

class BikeDetailVC: UIViewController {

    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak private var isFavorite: UISwitch!
    var bike: Bike?
    private var favoriteIndex: Int?
    private var favoriteBikes = [Bike]()
    var refreshFavoritesDelegate: RefreshFavoritesDelegate?

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
        if let favoriteIndex = bike?.getFavoriteIndex(favorites: favoriteBikes) {
            isFavorite.isOn = true
            self.favoriteIndex = favoriteIndex
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        refreshFavoritesDelegate?.refreshFavorites()
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
