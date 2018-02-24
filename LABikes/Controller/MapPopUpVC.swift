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
    @IBOutlet private weak var milesLabel: UILabel!
    @IBOutlet private weak var _milesLabel: UILabel!
    @IBOutlet private weak var bikesAvailableLabel: UILabel!
    @IBOutlet private weak var _bikesAvailableLabel: UILabel!

    private var bike: Bike?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layer.cornerRadius = 10
        view.addShadow()
    }

    func configBike(bike: Bike) {
        self.bike = bike
        nameLabel.text = bike.name                                              
        addressLabel.text = bike.addressStreet
        milesLabel.text = bike.miles
        _milesLabel.text = Double(bike.miles) == 1.0 ? "Mile" : "Miles"
        bikesAvailableLabel.text = String(bike.bikesAvailable)
        bikesAvailableLabel.textColor = bike.bikesAvailable <= 0 ? .customRed : .customBlue
        _bikesAvailableLabel.textColor = bike.bikesAvailable <= 0 ? .customRed : .customBlue
        _bikesAvailableLabel.text = bike.bikesAvailable == 1 ? "Bike" : "Bikes"
    }

    @IBAction private func buttonTapped(_ sender: UIButton) {
        if let bike = bike {
            bike.adjustFavorite(isFavorite: !bike.isFavorite)
            FavoritesService.shared.updateFavorites(bike: bike)
            configFavorite(isFavorite: bike.isFavorite)
        }
    }
    
    func configFavorite(isFavorite: Bool) {
        if isFavorite {
            favoriteButton.setImage(#imageLiteral(resourceName: "redHeart"), for: .normal)
            favoriteLabel.textColor = .customRed
            favoriteLabel.text = "Favorited"
        } else {
            favoriteButton.setImage(#imageLiteral(resourceName: "blueHeart"), for: .normal)
            favoriteLabel.textColor = .customBlue
            favoriteLabel.text = "Favorite"
        }
    }

    @IBAction func directionsTapped(_ sender: UIButton) {
        if let lat = bike?.latitude, let lon = bike?.longitude {
            Direction.init(lat: lat, lon: lon).openMaps()
        }
    }
}






