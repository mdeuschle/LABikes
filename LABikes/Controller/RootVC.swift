//
//  RootVC.swift
//  LABikes
//
//  Created by Matt Deuschle on 9/30/17.
//  Copyright © 2017 Matt Deuschle. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class RootVC: UIViewController, BikeDataDisplay {

    let locationManager = CLLocationManager()
    var service: FetchBikeDataServiceContract?

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        requestAuthorization()
        service = DataService(bikeDataDisplayDelegate: self)
    }

    func displayBikeData(bikes: [Bike]) {
        print("Bikes")
    }
}

extension RootVC: CLLocationManagerDelegate {

    func requestAuthorization() {
        let status = CLLocationManager.authorizationStatus()
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            return
        case .denied, .restricted:
            print("Permission denied")
        default:
            locationManager.requestWhenInUseAuthorization()
        }
    }

}






