//
//  WeatherView.swift
//  LABikes
//
//  Created by Matt Deuschle on 1/2/18.
//  Copyright © 2018 Matt Deuschle. All rights reserved.
//

import UIKit

class WeatherView: UIView {

    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var weatherTempLabel: UILabel!
    @IBOutlet var weatherView: UIView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        Bundle.main.loadNibNamed(NibName.weatherVC.rawValue, owner: self, options: nil)
        addSubview(weatherView)
        weatherView.frame = self.bounds
        weatherView.layer.cornerRadius = 5
        weatherView.autoresizingMask = [.flexibleHeight, .flexibleHeight]
    }
    
    func downloadWeather() {
        APIManager.shared.performAPICall(urlString: APIManager.Router.weather.path) { (success, data) in
            if success {
                if let temp = DataManager.shared.convertDataToTemperature(data: data!) {
                    DispatchQueue.main.async {
                        self.weatherTempLabel.text = temp
                    }
                }
                if let url = DataManager.shared.convertDataToIconURL(data: data!) {
                    APIManager.shared.performAPICall(urlString: url, handler: { (iconSuccess, iconData) in
                        if iconSuccess {
                            DispatchQueue.main.async {
                                self.weatherImageView.image = UIImage(data: iconData!)
                            }
                        }
                    })
                }
            }
        }
    }
}
