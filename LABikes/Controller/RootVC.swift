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

class RootVC: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var bikeTableView: UITableView!
    @IBOutlet weak var bikeMapView: MKMapView!

    var bikes = [Bike]()
    var locationManager: CLLocationManager!
    var currentLocation = CLLocation()

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager = CLLocationManager()
        bikeTableView.delegate = self
        bikeTableView.dataSource = self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        let nib = UINib(nibName: ReusalbleCell.bike.rawValue, bundle: nil)
        bikeTableView.register(nib, forCellReuseIdentifier: ReusalbleCell.bike.rawValue)
        downloadBikeData()
    }

    func downloadBikeData() {
        DataService.instance.getBikesData { (success, bikes) in
            DispatchQueue.main.async {
                if success {
                    if let bikes = bikes {
                        for bike in bikes {
                            if let coordinatesDic = bike["geometry"] as? [String: Any],
                                let propertiesDic = bike["properties"] as? [String: Any] {
                                let bike = Bike(coordinatesDic: coordinatesDic, propertiesDic: propertiesDic, currentLocation: self.currentLocation)
                                self.bikes.append(bike)
                                self.bikeTableView.reloadData()
                            } else {
                                print("Bike Dics are NIL")
                            }
                        }
                    } else {
                        print("Bike Object NIL")
                    }
                } else {
                    print("Unable to download data")
                }
            }
        }
    }

    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, 2000, 2000)
        bikeMapView.setRegion(coordinateRegion, animated: true)
    }

    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        if let location = userLocation.location {
            centerMapOnLocation(location: location)
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let currentLoc = locations.first {
            currentLocation = currentLoc
            if currentLoc.verticalAccuracy < 1000 && currentLoc.horizontalAccuracy < 1000 {
                locationManager.stopUpdatingLocation()
                centerMapOnLocation(location: currentLocation)
            }
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }

}

extension RootVC: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bikes.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReusalbleCell.bike.rawValue, for: indexPath) as? BikeCell else {
            return BikeCell()
        }
        let bike = bikes[indexPath.row]
        cell.configCell(bike: bike)
        return cell
    }
}





