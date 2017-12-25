//
//  MapPopUpVC.swift
//  LABikes
//
//  Created by Matt Deuschle on 10/29/17.
//  Copyright © 2017 Matt Deuschle. All rights reserved.
//

import UIKit

class MapPopUpVC: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!

    private var bike: Bike?

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

    func downloadWeather() {
        APIManager.shared.performAPICall(urlString: APIManager.Router.weather.path) { (success, data) in
            if success {
                if let temp = DataHelper.shared.convertDataToTemperature(data: data!) {
                    DispatchQueue.main.async {
                        self.tempLabel.text = temp
                    }
                }
                if let url = DataHelper.shared.convertDataToIconURL(data: data!) {
                    APIManager.shared.performAPICall(urlString: url, handler: { (iconSuccess, iconData) in
                        if iconSuccess {
                            DispatchQueue.main.async {
                                self.weatherIcon.image = UIImage(data: iconData!)
                            }
                        }
                    })
                }
            }
        }
    }
    
    @IBAction func directionsTapped(_ sender: UIButton) {
        
    }
}
