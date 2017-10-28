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

class RootVC: UIViewController {

    let locationManager = CLLocationManager()
    var currentLocation = CLLocation()

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        requestAuthorization()
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

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            currentLocation = location
        }
    }
}






