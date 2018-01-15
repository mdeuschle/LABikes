//
//  MapPopUpVC.swift
//  LABikes
//
//  Created by Matt Deuschle on 10/29/17.
//  Copyright © 2017 Matt Deuschle. All rights reserved.
//

import UIKit

class MapPopUpVC: UIViewController {

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var addressLabel: UILabel!
    @IBOutlet private weak var favoriteButton: UIButton!
    @IBOutlet private weak var favoriteLabel: UILabel!

    private var bike: Bike? {
        didSet {
            print("BIKE SET")
            guard let bike = bike else {
                return
            }
            configFavorite(isFavorite: bike.isFavorite)        }
    }

    var refreshMapPinsDelegate: RefreshMapPinsDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.layer.cornerRadius = 10
        view.shadow()
    }

    func config(bike: Bike) {
        nameLabel.text = bike.name                                              
        addressLabel.text = bike.addressStreet
        self.bike = bike
    }

    @IBAction private func buttonTapped(_ sender: UIButton) {
        guard let delegate = refreshMapPinsDelegate, let bike = bike else {
            return
        }
        let isFavorite = !bike.isFavorite
        configFavorite(isFavorite: isFavorite)
        var favorites = Dao.shared.unarchiveFavorites()
        if isFavorite {
            favorites.append(bike)
            Dao.shared.acrchiveFavorites(favoriteBikes: favorites)
        } else {
            if let index = bike.getFavoriteIndex(favorites: favorites) {
                favorites.remove(at: index)
                Dao.shared.acrchiveFavorites(favoriteBikes: favorites)
            }
        }
        delegate.refreshMapPins()
    }

    private func configFavorite(isFavorite: Bool) {
        if isFavorite {
            favoriteButton.setImage(#imageLiteral(resourceName: "redHeart"), for: .normal)
            favoriteLabel.textColor = Color.red.getColor()
            favoriteLabel.text = "Favorited"
        } else {
            favoriteButton.setImage(#imageLiteral(resourceName: "blueHeart"), for: .normal)
            favoriteLabel.textColor = Color.blue.getColor()
            favoriteLabel.text = "Favorite"
        }
    }

    @IBAction func directionsTapped(_ sender: UIButton) {
        if let lat = bike?.latitude, let lon = bike?.longitude {
            Direction.init(lat: lat, lon: lon).openMaps()
        }
    }
}






